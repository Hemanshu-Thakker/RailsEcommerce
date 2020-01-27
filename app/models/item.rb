class Item < ApplicationRecord
  include ActiveModel::Dirty	
  belongs_to :user
  has_many :orders, :dependent => :delete_all
  has_many :comments, :dependent => :delete_all

  has_one_attached :item_img

  define_attribute_methods 
  # after_update :send_email_to_user
  after_update :send_email_to_user

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true

  def send_email_to_user
  	UserMailer.item_update(self.user,self).deliver
  end

end
