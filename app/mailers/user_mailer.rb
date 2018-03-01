class UserMailer < ActionMailer::Base
    default from: "no-reply@foodery.com"

    def welcome user_id, password
      @user = User.find user_id
      @password = password
      mail to: @user.email, subject: "Congratulations you in foodery"
    end
end
