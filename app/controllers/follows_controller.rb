class FollowsController < ApplicationController
  before_action :set_follow, only: [:create, :destroy]

  def create

    if @follow
      flash[:alert] = 'Não foi possível seguir este usuário.'
    else
      @follow = Follow.create(follow_params)
    end
    redirect_to @follow.following
  end

  def destroy
    if !@follow
      flash[:alert] = 'Não foi possível deixar de seguir este usuário.'
    else
      @follow.destroy
    end
    redirect_to @follow.following
  end

  private
    def set_follow
      @follow = Follow.find_by(follow_params)
    end

    def follow_params
      params.permit(:follower_id, :following_id)
    end
end
