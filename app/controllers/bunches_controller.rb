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
      render json: bunche
    else
      render json: "Bunche not found", status: 404
    end
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

  def update
    bunche = Bunche.find_by(id: params[:id])

    if bunche
      if bunche.update(bunche_params)
        render json: bunche
      else
        render json: bunche.errors.full_messages, status: 422
      end
    else
      render json: "Bunche not found", status: 404
    end
  end

  def destroy
    bunche = Bunche.find_by(id: params[:id])

    if bunche
      bunche.destroy
      render json: bunche
    else
      render json: "Bunche not found", status: 404
    end
  end

  private

  def bunche_params
    params.require(:bunche).permit(:cost, :ripeness, :quantity)
  end
end
