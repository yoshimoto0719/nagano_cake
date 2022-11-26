class Admin::GenresController < ApplicationController
  
  def index
    @genre = Genre.new
    @genres = Genre.all
  end
  
  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    genre = Genre.find(params[:id])
    genre.update(genre_params)
    redirect_to genre_path(genre.id) 
  end
  
  #ストロングパラメータ
  private
  def genre_params
    params.require(:genre).permit(:name, :is_enabled)
  end
  
end
