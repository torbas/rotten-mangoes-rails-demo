class UserMailer < ActionMailer::Base
  default from: 'notifications@example.com'
 
  def delete_notification(user)
    @user = user
    mail(to: @user.email,
         content_type: "text/html",
         subject: "Account deleted")
  end
end
