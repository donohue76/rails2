class SimulatorController < ApplicationController
  def do
      @car = YAML.load(session[:car])
  end

  def toggle
    @car = YAML.load(session[:car])
    @car.toggleLights
    session[:car] = @car.to_yaml
    redirect_to "/simulator/do"
  end

  def accelerate
    @car = YAML.load(session[:car])
    @car.accelerate
    session[:car] = @car.to_yaml
    redirect_to "/simulator/do"
  end

  def brake
    @car = YAML.load(session[:car])
    @car.brake
    session[:car] = @car.to_yaml
    redirect_to "/simulator/do"
  end

  def parking_brake
    @car = YAML.load(session[:car])
    @car.parking_brake
    session[:car] = @car.to_yaml
    redirect_to "/simulator/do"
  end

  def color
    @car = YAML.load(session[:car])
    @car.color
    session[:car] = @car.to_yaml
    redirect_to "/simulator/do"
  end

end
