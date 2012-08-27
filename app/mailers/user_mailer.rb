class UserMailer < ActionMailer::Base
  default from: "finaddictz@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/users/confirm/#{@user.id}/#{Digest::SHA1.hexdigest(@user.email)}"
    mail(:to => user.email, :subject => "Welcome to Finaddictz")
  end
