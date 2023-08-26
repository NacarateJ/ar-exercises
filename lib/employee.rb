class Employee < ActiveRecord::Base
  belongs_to :store

  validates :first_name, :last_name, presence: true
  validates :hourly_rate, numericality: { greater_than_or_equal_to: 40, less_than_or_equal_to: 200, only_integer: true }

  before_create :generate_password

  private
  # Making this method provate adheres to the principles of encapsulation and information hiding
  def generate_password
    self.password = SecureRandom.hex(4)  # Generate a random 8-character password
    # save -> uncommment if using after_create to save the generated password to the record
  end
end

=begin
before_create: The callback runs only (once) before the record is created and saved to the database.

after_create: The callback runs only after the record is created and saved to the database.
The password wouldn't be available immediately after calling create.
Instead, we would need to access it after the record is saved.

before_save: This callback runs before both new records are created and existing records are updated.
Ex:
employee = Employee.find_by(first_name: "Alice")
employee.update(hourly_rate: 60)

We want to update the hourly rate but if we are using before_save,
the callback will be triggered, regenerating and updating the password even though
we didn't explicitly change the password-related attributes.
=end
