class ArtworkCollection < ApplicationController

  def index
    user = User.find(params[:collector_id])
      users_collections = user.collections
    
      render json: users_collections
  end

end