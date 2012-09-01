class AbuseMailer < ActionMailer::Base
  default from: "finaddictz@gmail.com"

  def abuse_email
    mail(:to => "slynch00@gmail.com", :subject => "Abuse Report")
    #mail(:to => "greg.schoeninger@gmail.com", :subject => "Abuse Report")
  end
end