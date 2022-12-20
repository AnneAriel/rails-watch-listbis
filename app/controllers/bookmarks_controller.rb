class BookmarksController < ApplicationController
  before_action :set_bookmark, only: :destroy
  before_action :set_list, only: [:new, :create]

  def new
    @bookmark = Bookmark.new
  end

  def create
    #on va chercher la liste
    # @list = List.find(params[:list_id])
    # on va créer un bookmark
    @bookmark = Bookmark.new(bookmark_params)
    # on associe le bookmark à la liste
    @bookmark.list = @list
    # si on peut sauvegarder le bookmark
    if @bookmark.save
      # on redirige vers la liste
      redirect_to list_path(@list)
      # sinon on affiche le formulaire
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
