class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Sucesso em realizar login!'
    else
      flash.now[:alert] = 'Email ou senha inválidos, verifique seus dados.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Sucesso em realizar logout!'
  end
end
