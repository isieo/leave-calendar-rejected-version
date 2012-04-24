class LeaveInfo
  include Mongoid::Document
  field :leave_type, :type => String
  field :granted_leave, :type => Integer
  field :remaining_leave, :type => Integer
  embedded_in :user
end
