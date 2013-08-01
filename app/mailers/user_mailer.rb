class UserMailer < ActionMailer::Base
  default from: 'commoncast <community@commoncast.com>'

  def welcome(user, password)
    @user = user
    @password = password
    mail(to: @user.email, subject: 'Your Password (and 2 tips to make commoncast awesome!)')
  end

  def newsletter(user, posts)
    @user = user
    @posts = posts
    @date = DateTime.now.strftime("%B %-d, %Y")
    mail(to: @user.email, subject: "Commoncast Weekly (#{@date})")
  end
end
