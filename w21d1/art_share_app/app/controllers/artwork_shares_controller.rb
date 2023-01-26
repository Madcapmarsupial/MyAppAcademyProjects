class ArtworkSharesController < ApplicationController

  def create
    artwork_share = ArtworkShare.new(artwork_share_params)

    if artwork_share.save
      render json: artwork_share
    else
      render json: artwork_share.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artwork_share = ArtworkShare.find(params[:id])

    if artwork_share.destroy
      render json: artwork_share
    else 
      render json: artwork_share.errors.full_messages, status: :unprocessable_entity
    end
  end

  def favorite
    artshare = ArtworkShare.find_by(id: params[:id], viewer_id: params[:user_id])    
    artshare.is_favorited = true
    if artshare.save
      render json: artshare  
    else 
      render json: artshare.errors.full_messages, status: :unprocessable_entity
    end
  end

  def unfavorite
    share = ArtworkShare.find_by(id: params[:id], viewer_id: params[:user_id]) 
    share.is_favorited = false
    if share.save
      render json: share    
    else 
      render json: share.errors.full_messages, status: :unprocessable_entity
    end

  end

  private
    def artwork_share_params
      params.require(:artwork_share).permit(:viewer_id, :artwork_id)
    end
end