class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @meeting = Meeting.find(params[:meeting_id])
    redirect_to @meeting
  end

  def create
    @meeting = Meeting.find(params[:meeting_id])
    @message = @meeting.messages.build(message_params)
    @messages = @meeting.messages
    if @message.save
      @messages = @messages << @message
    else
      render "error"
    end
  end

  private
  def message_params
    if current_student
      params.require(:message).permit(:content).merge(student_id: current_student.id)
    else
      params.require(:message).permit(:content).merge(instructor_id: current_instructor.id)
    end
  end

end
