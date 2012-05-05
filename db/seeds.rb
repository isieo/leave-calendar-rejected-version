# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
orga = Organization.find_or_create_by(name: "Alpha Melon")
orga.subdomain = "alphamelon"
orga.department = ["Marketing","IT","Admin"]
puts orga.save

user = orga.users.find_or_create_by(name: "David Blaine")
user.email = "spree@example.com"
user.password = "spree123"
user.in_department = ["IT"]
user.department_head_of = ["IT"]
user.authority_level = "Admin"
puts user.save

user_leave_info = user.leave_infos.find_or_create_by(leave_type: "Annual")
user_leave_info.granted_leave = 14
user_leave_info.remaining_leave = 13
puts user_leave_info.save

user_leave_info = user.leave_infos.find_or_create_by(leave_type: "Medical")
user_leave_info.granted_leave = 21
user_leave_info.remaining_leave = 9
puts user_leave_info.save

user_request = user.requests.find_or_create_by(comment: "Vacation in Genting")
user_request.organization = orga
user_request.start_date = "2012-06-03"
user_request.end_date = "2012-06-06"
user_request.comment = "Taking a break in Genting"
user_request.type = "Annual"
user_request.status = "Pending"
puts user_request.save

user_request = user.requests.find_or_create_by(comment: "Vacation in Osaka")
user_request.organization = orga
user_request.start_date = "2012-07-04"
user_request.end_date = "2012-07-09"
user_request.comment = "Business Trip in Osaka"
user_request.type = "Annual"
user_request.status = "Pending"
puts user_request.save
