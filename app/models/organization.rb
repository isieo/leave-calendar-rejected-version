class Organization
  include Mongoid::Document
  field :name
  field :subdomain
  field :domain
  field :department
  
  has_many :users
end
