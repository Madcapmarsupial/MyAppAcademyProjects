class UsersController < ApplicationController
  def index
    if params[:username]
      input_str = params[:username].split('').map {|letter| "'#{letter}%'" }  
      .join(" OR username ILIKE ")

      sql_query = "
        SELECT *
        FROM users
        WHERE username ILIKE #{input_str}
      "
      users = ActiveRecord::Base.connection.execute(sql_query)
    else
      users = User.all
    end
      render json: users
  end

  def create
    user = User.new(user_params)
    if user.save
      #redirect to show
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    user = User.find(params[:id])
    if user.valid?
      render json: user
    else 
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end 
  end

  def destroy
    user = User.find(params[:id])

    if user.destroy
      render json: user
    else
      render plain: "no obj"
    end 
  end

  def create_collection
    collection = ArtworkCollection.new(name: params[:name], collector_id: params[:id])
    if collection.save
      render json: collection
    else 
      render json: collection.errors.full_messages, status: :unprocessable_entity
    end
  end


  private 
    def user_params 
      params.require(:user).permit(:username)
    end
end

