class Store < ActiveRecord::Base
  has_many :employees

  validates :name, length: { minimum: 3 }
  validates :annual_revenue, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validate :must_carry_apparel

  before_destroy :check_for_employees

  private

  def must_carry_apparel
    if mens_apparel.blank? && womens_apparel.blank?
      errors.add(:base, "Must carry at least one type of apparel")
    end
  end

  def check_for_employees
    if employees.any?
      errors.add(:base, "Cannot destroy a store with employees")
      throw(:abort)
    end
  end
end