class CommentsController < ApplicationController

  def index

    if params[:artwork_id]
      art = Artwork.find(params[:artwork_id])
      data = art.comments
    end

    if params[:user_id]
      user = User.find(params[:user_id])
      data = user.comments
    end
    
    if data == nil
      render json: 'a user_id or artwork_id must be present', status: :unprocessable_entity
    else
      render json: data
    end
  end

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end

  end

  def destroy
    comment = Comment.find(params[:id])

    if comment.destroy
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end

  end

  private

    def comment_params
      params.require(:comment).permit([:body, :user_id, :artwork_id])
    end

end