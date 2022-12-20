class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def show
    # on va chercher la liste
    @list = List.find(params[:id])
    # on va chercher le formulaire du new bookmarks de la liste
    @bookmark = Bookmark.new
    # on va chercher le formulaire du new review de la liste
    @review = Review.new(list: @list)
  end

  def new
    @list = List.new
  end

  def create
    # on va créer une liste
    @list = List.new(list_params)
    # si on peut sauvegarder la liste
    if @list.save
      # on redirige vers la liste
      redirect_to list_path(@list)
    else
      # sinon on affiche le formulaire
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # on va chercher la liste
    @list = List.find(params[:id])
    # on va détruire la liste
    @list.destroy
    # on redirige vers toutes les listes
    redirect_to lists_path(@list), status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
