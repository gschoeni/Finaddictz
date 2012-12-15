class UserMailer < ActionMailer::Base
  default from: "info@finaddictz.com"

  def welcome_email(user)
    @user = user
    @url  = "http://www.finaddictz.com/users/confirm/#{@user.id}/#{Digest::SHA1.hexdigest(@user.email)}"
    mail(:to => user.email, :subject => "Welcome to Finaddictz")
  end

  def new_password(user, password)
  	@user = user
  	@password = password
  	mail(:to => user.email, :subject => "Finaddictz Password Recovery")
  end
end
