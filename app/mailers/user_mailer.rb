class UserMailer < ActionMailer::Base
  default from: 'notifications@commoncast.com'

  def welcome(user, password)
    @user = user
    @password = password
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def newsletter(user, posts)
    @user = user
    @posts = posts
    mail(to: @user.email, subject: 'commoncast weekly')
  end
end
