class BookmarksController < ApplicationController
  before_action :set_list, only: [ :new, :create ]

  def new
    @bookmark = Bookmark.new
    @movies = Movie.all
  end

  def create
    # Criamos o bookmark associado à lista atual
    @bookmark = @list.bookmarks.build(bookmark_params)

    if @bookmark.save
      redirect_to list_path(@list), notice: "Movie successful added!"
    else
      @movies = Movie.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), notice: "Movie removed.", status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
