# frozen_string_literal: true

class RailsEventStoreSidekiqScheduler
  # Hands event off to Sidekiq
  def call(klass, serialized_event)
    klass.perform_async(serialized_event.serialize(YAML).to_h.stringify_keys)
  end

  def verify(subscriber)
    subscriber.is_a?(Class) && subscriber.respond_to?(:perform_async)
  end
end

# Dispatch async after transaction commit
event_store = RailsEventStore::Client.new(
  dispatcher: RubyEventStore::ComposedDispatcher.new(
    RailsEventStore::AfterCommitAsyncDispatcher.new(
      scheduler: RailsEventStoreSidekiqScheduler.new
    ),
    RubyEventStore::Dispatcher.new
  )
)

Rails.configuration.to_prepare do
  Rails.configuration.event_store = event_store

  event_store.subscribe(
    Subscribers::Messages::Lifecycle,
    to: [
      Events::Messages::Create
    ]
  )

  event_store.subscribe(
    Subscribers::Projects::Lifecycle,
    to: [
      Events::Projects::StatusUpdate
    ]
  )
end
