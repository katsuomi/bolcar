class StudentsController < UsersController
  def show
    if !current_student.name
      redirect_to edit_student_registration_path
    end
    @student = Student.find(params[:id])
  end
end
