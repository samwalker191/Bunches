class UsersController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]

  def index
    # GET /users
    # gives all things of this resource
    if params[:query]
      users = User.where(ripeness_preference: params[:query])
    else
      users = User.all
    end

    render json: users
  end

  def show
    # GET /users/:id
    # gimme specific user
    user = User.find_by(id: params[:id])

    if user
      render json: user
    else
      render json: "User not found", status: 404
    end

  end

  def new
    render :new
  end

  def create
    # POST /users
    user = User.new(user_params) # { username: 'waht', ripe: 'wat' }

    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  def update
    # PATCH /users/:id
    user = User.find_by(id: params[:id])

    if user
      if user.update(user_params)
        render json: user
      else
        render json: user.errors.full_messages, status: 422
      end
    else
      render json: "User not found", status: 404
    end
  end

  def destroy
    # DELETE /users/:id
    user = User.find_by(id: params[:id])

    if user
      user.destroy
      render json: user
    else
      render json: "User not found", status: 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :ripeness_preference)
  end
end
