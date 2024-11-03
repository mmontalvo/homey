# frozen_string_literal: true

module Events
  class Event < RailsEventStore::Event
    extend EventStore

    def display
      data[:message] || "No message to display for #{self.class.name}, with data:#{data.inspect}"
    end

    class << self
      # Creates a stream per company per date, eg "company_<uid>$transactions$2020-08-31"
      def stream_name(user_uid, timestamp, type)
        if timestamp.nil?
          "homey_#{user_uid}$#{type}"
        else
          format(
            "homey_#{user_uid}$#{type}$%4d-%02d-%02d",
            timestamp.year, timestamp.month, timestamp.day
          )
        end
      end
    end
  end
end
