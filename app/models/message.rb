class Message < ApplicationRecord
  belongs_to :user

  after_create :broadcast_message

  private

  def broadcast_message
    ActionCable.server.broadcast("messages_channel", 
      {
        body: "POTATAT",
        user_email: 'mike@test.com'
      }
    )
  end

  def rendered_message
    {
      body:,
      user_email: user.email
    }
    # ApplicationController.renderer.render(
    #   partial: "messages/message",
    #   locals: { message: self }
    # )
  end

end
