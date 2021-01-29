module UserHelper
  def reviewer(review)
    review.reviewer ? review.reviewer.first_name : '[removed]'
  end

  def assessor(assessment)
    assessment.author ? assessment.author.first_name : '[removed]'
  end
end
