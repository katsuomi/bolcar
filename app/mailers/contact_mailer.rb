class ContactMailer < ApplicationMailer

  def send_contact_notification(contact)
    @contact = contact
    if @contact.instructor
      @user = @contact.instructor
      @status = "講師"
    elsif @contact.student
      @user = @contact.student
      @status = "学生"
    end  
    mail(
      subject: "お問い合わせ",
      to: ENV["CONTACT_ADDRESS"]
    )
  end

end
