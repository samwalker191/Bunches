class BunchesController < ApplicationController
  before_action :require_logged_in, only: [:create, :update, :destroy, :edit]

  def index
    @seller = User.find_by(id: params[:user_id])
    @bunches = @seller.bunches_to_sell

    render :index
  end

  def show
    bunche = Bunche.find_by(id: params[:id])

    if bunche
      render :show
    else
      render json: "Bunche not found", status: 404
    end
  end

  def new

  end

  def create
    bunche = Bunche.new(bunche_params)
    bunche.seller_id = params[:user_id]

    if bunche.save
      render json: bunche
    else
      render json: bunche.errors.full_messages, status: 422
    end
  end

  def edit
    @bunche = Bunche.find_by(id: params[:id])
    render :edit
  end

  def update
    @bunche = current_user.bunches_to_sell.find_by(id: params[:id])

    if @bunche
      if @bunche.update(bunche_params)
        render json: @bunche
      else
        render json: @bunche.errors.full_messages, status: 422
      end
    else
      flash[:errors] = ["Bunche not found"]
      render :something
    end
  end

  def destroy
    bunche = Bunche.find_by(id: params[:id])

    if bunche
      bunche.destroy
      render json: bunche
    else
      flash[:errors] = ["Bunche not found"]
      redirect_to somewhere
    end
  end

  private

  def bunche_params
    params.require(:bunche).permit(:cost, :ripeness, :quantity)
  end
end
