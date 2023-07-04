require_relative './base_controller.rb'

class DogsController < BaseController

  # GET /dogs
  #
  def index
    @title = "So many dogs"
    @dogs = Dog.all
    build_response render_template
  end

  # GET /dogs/:id
  #
  def show
    @dog = Dog.find(params[:id])
    @title = "#{@dog.name}'s page"
    build_response render_template
  end

  # GET /dogs/new
  #
  def new
    @title = "More dogs please"
    build_response render_template
  end


  # POST /dogs
  def create
    dog = Dog.new(name: params['dog']['name'])
    dog.save
    redirect_to "dogs/#{dog.id}"
  end

end