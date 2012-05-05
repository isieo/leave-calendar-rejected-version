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
  
  before_validation :check_authority_level
  before_destroy  :check_remaining_admin
   
  has_many :requests
  embeds_many :leave_infos
  belongs_to :organization
  
  validates :email, :presence => true
  validates :name, :presence => true
  #validates :in_department, :presence => true
  validates :authority_level, :presence => true
  
  protected
  def check_authority_level
    if self.authority_level == nil && self.organization == nil
      self.authority_level = "Admin"
    end
  end
  
  def check_remaining_admin
    errors.add(:authority_level, "Can't delete, You are the only admin in the organization")
  end
  
end
