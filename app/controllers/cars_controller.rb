class CarsController < ApplicationController
  def new_car
    if (!params.has_key?(:make) || params[:make].strip.empty?) && (!params.has_key?(:model_year) || params[:model_year].strip.empty?) && (!params.has_key?(:color) || params[:color].strip.empty?)
      render "new_car"
    else
      car = Car.new(params[:make], params[:model_year], params[:color], params[:desc])
      session[:car] = car.to_yaml
      redirect_to "/simulator/do"
    end
  end
end
