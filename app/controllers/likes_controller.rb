class LikesController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @micropost.likes.create
    # respond_to do |format|
    #   format.html { redirect_to @micropost, notice: "Like was successfully created." }
    #   format.js {}
    # end
    redirect_back(fallback_location: user_path(current_user))
  end
end
