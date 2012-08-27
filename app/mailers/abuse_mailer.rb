class AbuseMailer < ActionMailer::Base
  default from: "admin@finaddictz.com"
end

  def abuse_email
    mail(:to => "slynch00@gmail.com", :subject => "Abuse Report")
  end
