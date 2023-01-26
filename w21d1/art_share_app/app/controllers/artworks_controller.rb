class ArtworksController < ApplicationController
  def index
    user = User.find(params[:user_id])
    users_artworks = (user.artworks + user.shared_artworks)
    
    render json: users_artworks
  end
  
  def show
     render json: Artwork.find(params[:id])
  end 
  
  def create
    artwork = Artwork.new(artwork_params)

    if artwork.save
      render json: artwork
    else 
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    artwork = Artwork.find(params[:id])

    if artwork.update(artwork_params)
      render json: artwork
    else 
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artwork = Artwork.find(params[:id])

    if artwork.destroy
      render json: artwork
    else 
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def like 
    like = Like.new(likeable_type: 'Artwork', likeable_id: params[:id], user_id: params[:user_id])
    if like.save
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def unlike
    like = Like.find_by(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Artwork')
    
    if like.destroy
      render json: like
    else 
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def comment
    comment = Comment.new(artwork_id: params[:id], body: 'this is a comment', user_id: 9)
    if comment.save 
      render json: comment
    else 
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end


  def favorite
    artwork = Artwork.find_by(id: params[:id], artist_id: params[:user_id])
    artwork.is_favorited = true
    artwork.save
    render json: artwork
  end

  def unfavorite
    artwork = Artwork.find_by(id: params[:id], artist_id: params[:user_id])
    artwork.is_favorited = false
    artwork.save
    render json: artwork
  end

  def add_to_collection
    listing = ArtListing.new(artwork_id: params[:id], collection_id: params[:collection_id])
    if listing.save
      collection = ArtworkCollection.find_by(id: params[:collection_id], name: params[:name])
      render json: collection.artworks
    else 
      render json: listing.errors.full_messages, status: :unprocessable_entity
    end
    #artwork_id
    #collection_id
  end


  #add to collection

  private 
  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id) 
  end

end