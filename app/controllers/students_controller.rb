class StudentsController < UsersController

  def show
    redirect_to_edit
    @student = Student.find(params[:id])
  end

  private
  def redirect_to_edit
    if current_student && !current_student&.name
      redirect_to edit_student_registration_path
    end
  end
end
