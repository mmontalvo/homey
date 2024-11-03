# frozen_string_literal: true

module Subscribers
  module Messages
    class Lifecycle
      include Sidekiq::Worker
      prepend RailsEventStore::AsyncHandler

      def perform(event)
        case event
        when Events::Messages::Create then process_messages_creation(event)
        end
      end

      private

      def process_messages_creation(event)
        project_id = event.data.fetch(:project_id)
        message_id = event.data.fetch(:message_id)
        user_id    = event.data.fetch(:user_id)
        user       = User.find(user_id)
        message    = Message.find(message_id)
        comment    = "Message created"

        audit = Audit.create(
          project_id:,
          associated_id: message_id,
          associated_type: 'Message',
          audited_changes: message.body,
          action: 'create',
          user_id:,
          comment:
        )

        ActionCable.server.broadcast("audits_channel", 
          {
            user_email: user.email,
            comment:,
            changes: audit.audited_changes
          }
        )
      end
    end
  end
end
