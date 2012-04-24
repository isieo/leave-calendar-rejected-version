class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :name
  field :name
  field :in_department, :type => Array
  field :department_head_of, :type => Array
  field :authority_level
  
  has_many :requests
  embeds_many :leave_infos
  belongs_to :organization
  
  validates :email, :presence => true
  validates :name, :presence => true
  validates :in_department, :presence => true
  validates :authority_level, :presence => true
end
