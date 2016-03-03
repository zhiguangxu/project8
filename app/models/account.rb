class Account < ActiveRecord::Base
  enum role: [:Buyer, :Seller, :Admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :Buyer
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :accountable, polymorphic: true
end
