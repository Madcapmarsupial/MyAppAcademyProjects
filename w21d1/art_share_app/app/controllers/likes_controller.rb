class Likes_controller < ApplicationController
   def create
    like = Like.new(like_params)

    if like.save
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    like = Like.find(params[:id])

    if like.destroy
      render json: like
    else 
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end 

  private
    def like_params
      params.require(:like).permit(:likeable_id, :likeable_type)
    end
end