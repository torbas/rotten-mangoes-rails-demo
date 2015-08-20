class MoviesController < ApplicationController
  before_filter :restrict_access, :except => [:index, :show]
  
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def search
    @movies = Movie.all

    unless params[:title].empty?
     @movies =  @movies.with_title(params[:title])
    end

    unless params[:director].empty?
      @movies = @movies.with_director(params[:director].downcase) 
    end

    unless params[:runtime_in_minutes].empty?

      case params[:runtime_in_minutes]
      when "short"
        @movies = @movies.short_running_time 
      when "medium"
        @movies = @movies.medium_running_time
      when "long"
        @movies = @movies.long_running_time 
      end
    
    end

    render :index
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster, :description
    )
  end

end