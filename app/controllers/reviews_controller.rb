class ReviewsController < ApplicationController
  before_action :set_product

  def create
    @review = @product.reviews.create(review_params)
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to @product, notice: 'Review was successfully created.' }
        format.json { render :show, location: @review }
      else
        format.html { render :create }
        format.json { render json: @review.errors, status: :unprocesssable_entity }
      end
    end
  end

  def destroy
    @review = Review.find_by(id: params[:id])

    if @review
      @review.destroy
      respond_to do |format|
        format.html { redirect_to @review.product, notice: 'Review was successfully removed.'}
        format.json { head :no_content}
      end
    else
      redirect_to @review.product
    end
  end


  private

    def set_product
      @product = Product.find(params[:product_id])
    end

    def review_params
      params.require(:review).permit(:description, :rating, :destroy)
    end
end
