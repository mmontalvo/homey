class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[ new ]

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params.merge(user: current_user))

    respond_to do |format|
      if @message.save
        ::Events::Messages::Create.publish(message_id: @message.id, project_id: @message.project_id, user_id: current_user.id)
        format.html { redirect_to @message.project, notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :project_id)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
end
