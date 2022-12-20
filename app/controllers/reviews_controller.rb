class ReviewsController < ApplicationController

  # pas nécessaire -> dans lists_controller
    # def new
    #   @review = Review.new
    # end

  def create
    # on va créer une review
    @review = Review.new(review_params)
    # on va chercher la liste
    @list = List.find(params[:list_id])
    # on associe la review à la liste
    @review.list = @list
    # si on peut sauvegarder la review
    if @review.save
      # on redirige vers la liste
      redirect_to list_path(@list)
    else
      # sinon on affiche la liste
      @bookmark = Bookmark.new
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    # on va chercher la review
    @review = Review.find(params[:id])
    # on va détruire la review
    @review.destroy
    # on redirige vers la liste
    redirect_to list_path(@review.list), status: :see_other
  end
end

private

def review_params
  # on va chercher les params de la review
  params.require(:review).permit(:comment, :rating)
end
