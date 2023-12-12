class ReviewsController < ApplicationController
  before_action :find_unit

  def create
    @review = @unit.reviews.build(review_params)
    if @review.save
      redirect_to @unit, notice: 'Review was successfully created.'
    else
      render 'units/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def find_unit
    @unit = Unit.find(params[:unit_id])
  end
end