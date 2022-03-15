class MealOrder < ApplicationRecord
  belongs_to :meal
  belongs_to :order
  has_many :reviews, dependent: :destroy


  validates :quantity_ordered, :total_price_cents, :pick_up, presence: true
  monetize :total_price_cents


  before_validation :calculate_total

  def stripe_line_item
    {
      name: meal.name,
      images: [meal.picture_url],
      amount: meal.price_cents,
      currency: 'aud',
      quantity: quantity_ordered
    }
  end

  private

  def calculate_total
    self.total_price_cents = meal.price * quantity_ordered
  end

  def update_quantity
    @meal_order.update_attribute(:quantity_ordered)
  end
end
