class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contact = Contact.new(student_id: current_student.id) if current_student
    @contact = Contact.new(instructor_id: current_instructor.id) if current_instructor
    render "new"
  end

  def new
    @contact = Contact.new(student_id: current_student.id) if current_student
    @contact = Contact.new(instructor_id: current_instructor.id) if current_instructor
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_contact_notification(@contact).deliver_later
      redirect_to_top("送信完了しました")
    else
      render "new"
    end
  end

  private
  def contact_params
    if current_student
      params.require(:contact).permit(:content).merge(student_id: current_student.id)
    else
      params.require(:contact).permit(:content).merge(instructor_id: current_instructor.id)
    end
  end

end
