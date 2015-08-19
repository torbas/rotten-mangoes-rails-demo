class MoviesController < ApplicationController

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
     @movies =  @movies.where('lower(title) like ?', "%#{params[:title].downcase}%") 
    end

    unless params[:director].empty?
      @movies = @movies.where('lower(director) like ?', "%#{params[:director].downcase}%")  
    end

    unless params[:runtime_in_minutes].empty?

      case params[:runtime_in_minutes]
      when "short"
        @movies = @movies.where('runtime_in_minutes < 90')  
      when "medium"
        @movies = @movies.where('runtime_in_minutes >= 90 AND runtime_in_minutes <= 120')  
      when "long"
        @movies = @movies.where('runtime_in_minutes > 120')  
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