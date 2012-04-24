class Request
  include Mongoid::Document
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime
  field :type, :type => String
  field :comment, :type => String
  field :status, :type => String
  
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :type, :presence => true
  validates :comment, :presence => true
  validates :status, :presence => true
  
  validate :start_or_end_date_cannot_be_in_the_past
  validate :cannot_be_same_date
  validate :enough_leave_to_take_or_not
  
  belongs_to :organization
  belongs_to :user
  attr_accessible :cancel
  
  def start_or_end_date_cannot_be_in_the_past
    if !start_date.blank? and (start_date < Date.today or end_date < Date.today )
      errors.add(:start_date, "Can't be in the past")
      errors.add(:end_date, "Can't be in the past")
    end
  end
    
  def cannot_be_same_date
    if !start_date.blank? and start_date == end_date
      errors.add(:start_date, "Can't be same day")
      errors.add(:end_date, "Can't be same day")
    end
  end
  
  def enough_leave_to_take_or_not
    user_remaining_leave = self.user.leave_infos.where(:leave_type => self.type).all.first.remaining_leave
    if !start_date.blank? and (end_date-start_date) > user_remaining_leave
      errors.add(:start_date, "You do not have enough remaining leave")
      errors.add(:end_date, "You do not have enough remaining leave")
    end
  end
    
end
