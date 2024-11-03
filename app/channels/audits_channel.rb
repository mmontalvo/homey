class AuditsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "audits_channel"
  end

  def unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("audits_channel", data)
  end
end
