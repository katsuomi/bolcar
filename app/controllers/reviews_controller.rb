class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @meeting = Meeting.find(params[:meeting_id])
    @review = @meeting.reviews.build(student_id: current_student) if current_student
    @review = @meeting.reviews.build(instructor_id: current_instructor) if current_instructor
    render "new"
  end

  def new
    @meeting = Meeting.find(params[:meeting_id])
    redirect_to_meetings
    if !@meeting.finished?
      redirect_to meetings_path, alert: "この面談はまだ終了していません"
    end
    @review = @meeting.reviews.build(student_id: current_student) if current_student
    @review = @meeting.reviews.build(instructor_id: current_instructor) if current_instructor
  end

  def create
    @meeting = Meeting.find(params[:meeting_id])
    @review = @meeting.reviews.build(review_params)
    if @review.save
      redirect_to meetings_path, notice: "ご利用ありがとうございました"
    else
      render "new"
    end
  end

  private
  def review_params
    if current_student
      params.require(:review).permit(:content, :safety).merge(student_id: current_student.id)
    else
      params.require(:review).permit(:content, :safety).merge(instructor_id: current_instructor.id)
    end
  end

  def redirect_to_meetings
    if @meeting.instructor != current_instructor && !@meeting.students.find{|s| s == current_student}
      redirect_to meetings_path, alert: "不正なアクセスです"
    end
  end

end
