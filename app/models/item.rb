class Item < ApplicationRecord
  include ActiveModel::Dirty	
  belongs_to :user
  has_many :orders, :dependent => :delete_all
  has_many :comments, :dependent => :delete_all

  has_one_attached :item_img

  define_attribute_methods 
  # after_update :send_email_to_user
  after_update :send_email_to_user

  validates :name, presence: true, length: { in: 2..40 }
  validates :price, presence: true
  validates :quantity, presence: true
  validates_numericality_of :quantity, :only_integer => true, :greater_than_or_equal_to => 0

  def send_email_to_user
  	UserMailer.item_update(self.user,self).deliver
  end

  def item_img_url
    if self.item_img.attachment
      self.item_img.attachment.service_url
    end
  end

end
