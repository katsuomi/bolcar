class ReservationMailer < ApplicationMailer

  def send_reservation_notification(instructor)
    @instructor = instructor
    mail(
      subject: "面談の予約が入りました",
      to: @instructor.email
    )
  end

  def send_meeting_notification(schedule, student)
    @schedule = schedule
    @student = student
    mail(
      subject: "面談情報が送信されました",
      to: @student.email
    )
  end

end
