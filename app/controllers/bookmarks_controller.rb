class BookmarksController < ApplicationController
  # def index
  #   @bookmarks = Bookmark.all
  # end

  # def show
  #   @bookmark = Bookmark.find(params[:id])
  # end

  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
    # @movies = Movie.all
  end

  def create
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:bookmark][:movie])
    @bookmark = Bookmark.new(comment: bookmark_params[:comment])
    @bookmark.movie = @movie
    @bookmark.list = @list
    if @bookmark.save!
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie, :list)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    redirect_to lists_path
  end
end
