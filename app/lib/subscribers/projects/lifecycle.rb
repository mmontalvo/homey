# # frozen_string_literal: true

module Subscribers
  module Projects
    class Lifecycle
      include Sidekiq::Worker
      prepend RailsEventStore::AsyncHandler

      def perform(event)
        case event
        when Events::Projects::StatusUpdate then process_project_status_update(event)
        end
      end

      private

      def process_project_status_update(event)
        project_id = event.data.fetch(:project_id)
        user_id    = event.data.fetch(:user_id)
        message    = event.data.fetch(:message)
        changes    = event.data.fetch(:changes)
        user       = User.find(user_id)
        comment    = "Project updated"

        audit = Audit.create(
          project_id: project_id,
          audited_changes: format_changes(changes),
          action: 'create',
          user_id: user_id,
          comment: message
        )

        ActionCable.server.broadcast("audits_channel", 
          {
            user_email: user.email,
            comment:,
            changes: audit.audited_changes
          }
        )
      end

      def format_changes(changes)
        changes.except("updated_at").values.map{|val| "from: #{val.first} to: #{val.last}"}.join(', ')
      end
    end
  end
end
