class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:sign_in, :sign_up]
  before_action :redirect_to_top, only: [:sign_in, :sign_up]

  def sign_in
  end

  def sign_up
  end

  private
  def redirect_to_top
    if current_student || current_instructor
      redirect_to instructors_path
    end
  end
end
