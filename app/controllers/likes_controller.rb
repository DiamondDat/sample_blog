class LikesController < ApplicationController

  #respond_to :js

  def create
    @micropost = Micropost.find(params[:id])
    @like = @micropost.likes.create(user_id: user.id)
    render :toggle
  end

  def destroy
    like = Like.find(params[:id]).destroy
    @micropost = like.micropost
    render :toggle
  end
end
