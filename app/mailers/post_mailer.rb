class PostMailer < ApplicationMailer
  default from: "no-reply@blogfull.com"

  def send_email(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: "Nova postagem no Blog Full")
  end

end
