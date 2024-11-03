# frozen_string_literal: true

module Events
  module Messages
    class Create < Event
      class << self
        def publish(project_id:, message_id:, user_id:)
          event_store.publish(
            new(
              data: {
                project_id:,
                message_id:,
                user_id:,
                action: :create,
                message: "New message created"
              }
            ),
            stream_name: 'messages_actions'
          )
        end
      end
    end
  end
end
