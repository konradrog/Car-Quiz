class CarsController < ApplicationController
  def index
    @cars = Car.all.order(:brand).paginate(page: params[:page], per_page: 6)
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.create(car_params)

    if @car.new_record?
      render "new"
    else
      redirect_to car_path(@car)
    end
  end

  def show
    @car = Car.find(params[:id])
  end

  def edit
    @car = Car.find(params[:id])
  end

  def update
    @car = Car.find(params[:id])

    if @car.update(car_params)
      redirect_to @car
    else
      render "edit"
    end
  end

  def destroy
    car = Car.find(params[:id])
    car.destroy

    redirect_to cars_path
  end

  private

  def car_params
    params.require(:car).permit(:brand, :model, :year, :body_style, :segment, :image)
  end
end
