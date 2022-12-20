class ReviewsController < ApplicationController
  # pas nécessaire
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
    if @review.save
      redirect_to list_path(@list)
    else
      # @bookmark = Bookmark.new
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to list_path(@review.list), status: :see_other
  end
end

private

def review_params
  params.require(:review).permit(:comment, :rating)
end
