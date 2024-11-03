# frozen_string_literal: true

module Events
  module EventStore
    def event_store
      Rails.configuration.event_store
    end
  end
end
