class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ApplicationRecord


  validates :first_name, presence: true , length: { in: 2..60 }
  validates :last_name, presence: true , length: { in: 2..60 }
  validates :username, presence: true , length: { in: 2..20 } , uniqueness: true
  validates :email, presence: true , uniqueness: true, email: true , confirmation: true
  validates :email_confirmation, presence: true
  validates :password, presence: true, length: { minimum: 8 } , 
                      format: { with: /\d+/, message: "must contain at least one number" }
  validates :password_confirmation, presence: true ,confirmation: true
  validates :password_hint, length: { maximum: 100 }
  before_create :capitalize_names


  def full_name
    "#{first_name} #{last_name}"
  end

  def capitalize_names
    self.first_name = first_name.downcase.camelcase
    nocaps = ["de", "la", "del"]
    self.last_name =last_name.downcase.split.map { |word| nocaps.include?(word) ? word : word.capitalize }.join(" ")
  end
  
end
