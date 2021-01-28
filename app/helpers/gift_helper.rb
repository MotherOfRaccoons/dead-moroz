module GiftHelper
  def gift_creator(gift)
    gift.added_by ? gift.added_by.first_name : '[removed]'
  end
end
