class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check, except: [:new, :create]
  before_action :check_user,only: [:edit, :update, :destroy]

  def index
    @users =User.where.not(:id => current_user.following).where.not(:id => current_user.id)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to signin_path, notice: 'Cadastro realizado com sucesso!' }
       else
        flash.now[:alert] = 'Não foi possível realizar o cadastro. Verifique seus dados.'
        format.html { render :new }
       end
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Cadastro atualizado com sucesso!'
     else
      flash.now[:alert] = 'Não foi possível atualizar o cadastro. Verifique seus dados.'
      render :edit
     end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
     end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def check_user
      if @user.id != current_user.id
        redirect_to @user
      end
    end
end
