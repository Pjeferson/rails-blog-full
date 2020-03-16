class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check
  before_action :check_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.where(:user_id => current_user.following).order('created_at DESC')
  end

  def show
  end

  def new
    @post = Post.new
  end
  
  def edit
  end
  
  def create
    @post = Post.new(post_params)
    
    if @post.save
      current_user.followers.each do |follower|
        PostMailer.send_email(follower, @post).deliver
      end
      redirect_to @post, notice: 'Postagem criada com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível realizar a postagem. Verifique os dados da mesma.'
      render :new 
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Postagem atualizada com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível atualizar a postagem. Verifique os dados da mesma.'
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Postagem removida com sucesso!'
  end

  private
    def set_post
      @post = Post.joins(:user).find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body).merge(user_id: current_user.id)
    end

    def check_post
      if @post.user.id != current_user.id
          redirect_to @post
      end
    end
end
