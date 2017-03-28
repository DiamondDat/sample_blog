class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :destroy]
  before_action :correct_user, only: :destroy
  before_action :find_commentable
  def create
    # Build the associated model through the parent
    if params[:micropost_id]
      # @commentable = Micropost.find(params[:micropost_id])
      @comment = @commentable.comments.create(comment_params)
    else
      # @commentable = Comment.find(params[:comment_id])
      @comment = @commentable.replies.create(comment_params)
    end

    # Assign the user directly
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Comment created."
      redirect_back(fallback_location: user_path(current_user))
    else
      redirect_back(fallback_location: user_path(current_user))
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments
  end

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

  def find_commentable
    @commentable = Comment.find(params[:comment_id])     if params[:comment_id]
    @commentable = Micropost.find(params[:micropost_id]) if params[:micropost_id]
  end

end
