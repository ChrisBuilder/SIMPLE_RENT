class UnitsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :new]
  before_action :set_shop, only: [:new, :create]

  def index
    @units = policy_scope(Unit)
    @unit = Unit.new
    if params[:query].present?
      @units = @units.where("units.title ILIKE ?", "%#{params[:query]}%")
    end
  end

  def new
    @unit = Unit.new
    authorize @unit
  end

  def create
    @unit = Unit.new(unit_params)
    @unit.shop = @shop
    authorize @unit
    if @unit.save
      redirect_to shop_path(@unit.shop), notice: "Unit added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @shop = Shop.find(params[:shop_id])
    @unit = Unit.find(params[:id])
    @bookings = Booking.all
    authorize @unit
  end

  private

  def unit_params
    params.require(:unit).permit(:title, :price, :description, :photo)
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end
end
