# # frozen_string_literal: true

module Events
  module Projects
    class StatusUpdate < Event
      class << self
        def publish(project_id:, user_id:, changes:)
          event_store.publish(
            new(
              data: {
                project_id:,
                user_id:,
                changes:,
                action: :update,
                message: "Project status updated"
              }
            ),
            stream_name: 'projects_actions'
          )
        end
      end
    end
  end
end
