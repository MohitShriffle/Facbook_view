class LikeMailer < ApplicationMailer
  def like_email
    @user=params[:user]
    # debugger
    mail(to: @user.email, subject: "Welcome To My Webside!")
  end
end
