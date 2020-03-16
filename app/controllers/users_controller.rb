class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    # TODO: Melhorar algorítimo
    @users =User.where.not(:id => current_user.following).where.not(:id => current_user.id)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    #Código repetido
    if @user.id != current_user.id
      redirect_to @user
    end
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
       else
        format.html { render :new }
       end
    end
  end

  def update
    #Código repetido
    if @user.id != current_user.id
      redirect_to @user
    end
    
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
     else
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
end
