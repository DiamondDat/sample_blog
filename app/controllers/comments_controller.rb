class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :destroy]
  before_action :correct_user, only: :destroy
  def create
    # Get the parent micropost
    @micropost = Micropost.find(params[:micropost_id])

    # Build the associated model through the parent
    @comment = @micropost.comments.build(comment_params)

    # Assign the user directly
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Comment created."
      redirect_back(fallback_location: user_path(current_user))
    else
      render 'static_pages/home'
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments
  end

  # def edit
  # end

  # def update
  #   @micropost = Micropost.find(params[:post_id])
  #   @comment = @micropost.comments.find(params[:id])

  #   if @comment.update(comments_params)
  #     redirect_to microposts_path(@micropost)
  #   else
  #     render 'edit'
  #   end
  # end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted."
    redirect_to request.referer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
