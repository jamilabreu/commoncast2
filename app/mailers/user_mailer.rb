class UserMailer < ActionMailer::Base
  default from: 'Commoncast <community@commoncast.com>'

  def welcome(user, password)
    @user = user
    @password = password
    mail(to: @user.email, subject: 'Your Commoncast Password')
  end

  def newsletter(user, posts)
    @user = user
    @posts = posts
    mail(to: @user.email, subject: 'commoncast weekly')
  end
end
