module ApplicationHelper



  def my_calendar(options)
    fdom = options[:first_date_of_month]
    wc = options[:weeks_count]
    dc = options[:days_count]
    eom = options[:end_of_month]
    db = options[:date_buffer]
 

    calendar = '<div id="calendar">'
    calendar += "<h2 id='month'>"
    calendar += link_to "<", :month => (fdom.beginning_of_month-1).strftime("%Y-%m-01")
    calendar += h fdom.strftime("%B %Y")
    calendar += link_to ">", :month => (fdom.end_of_month+1).strftime("%Y-%m-01")
    calendar += "</h2>"
    
    calendar += '<table>
      <thead>
        <tr>
          <th class ="sunday">Sunday</th>
          <th class ="weekday">Monday</th>
          <th class ="weekday">Tuesday</th>
          <th class ="weekday">Wednesday</th>
          <th class ="weekday">Thursday</th>
          <th class ="weekday">Friday</th>
          <th class ="saturday">Saturday</th>
        </tr>
      </thead>
      <tbody>'
    
    current_date = fdom.beginning_of_week(:sunday)
    for row in (1..wc)
      calendar += "<tr>"
        for col in (1..dc)
          col_classes =(current_date.month != fdom.month) ? 'notmonth ' : ''
          col_classes +=(current_date == Date.today) ? 'today ' : ''
          calendar += "<td class='"+col_classes+"'>"
          calendar +=     current_date.day.to_s
          calendar +=     "<ul>"
          Request.where(:status=>"Approved").each do |request|
            if request.start_date.to_date <= current_date && current_date <= request.end_date.to_date 
              calendar +=     "<li>"+request.user.name+"</li>"
            end
          end
          calendar +=      "</ul>"
          calendar += "</td>"
          current_date = current_date.next_day
        end
      calendar += "</tr>"
    end
    calendar += "      </tbody>
        </table>
      </div>"
      return calendar.html_safe
  end
  
  def my_calendar_overall(params)
    date = params[:date]
    calendar2 = "<div id='calendar2'>"
    calendar2 += "<H2>All User Leaves</H2>"
    calendar2 += '<h3 id="month">'
    calendar2 += link_to "<", :month => (date.beginning_of_month-1).strftime("%Y-%m-01")
    calendar2 += h date.strftime("%B %Y")
    calendar2 += link_to ">", :month => (date.end_of_month+1).strftime("%Y-%m-01")
    calendar2 += "</h3>"
    i=1
    calendar2 += '<table class="table table-striped table-bordered table-condensed">'
    calendar2 += "<tr>"
    calendar2 += "<td>&nbsp</td>"
    while i != date.end_of_month.day+1
      calendar2 += "<td>" + i.to_s + "</td>"
      i = i + 1
    end
    calendar2 += "</tr>"
    
    User.all.each do |u|
      i = 1
      calendar2 += "<tr>"
      calendar2 += "<td>" + u.name + "</td>"
      while i != date.end_of_month.day+1
        checker = 0
        u.requests.each do |ul|
          if ul.start_date.year == date.year && ul.start_date.month == date.month && ul.start_date.day == i
            while checker != (ul.end_date.day+1 - ul.start_date.day)
            if ul.status == "Approved"
              calendar2 += '<td bgcolor="#FF0000"></td>'
              checker = checker + 1
            elsif ul.status == "Pending"
              calendar2 += '<td bgcolor="#0000FF"></td>'
              checker = checker + 1
            end
            end
          end
        end
        if checker == 0
          calendar2 += "<td></td>"
          checker = 1
        end
        i = i + checker
        checker = 0
      end
    end
      calendar2 += "</tr>"
      calendar2 += "</table>"
      calendar2 +="</div>"
      calendar2 += "<table>"
      calendar2 += "<th>Legend<th>"
      calendar2 += "<tr><td bgcolor='#FF0000'></td><td>Approved</td></tr>"
      calendar2 += "<tr><td bgcolor='#0000FF'></td><td>Pending</td></tr></table>"
      calendar2.html_safe
  end
  
end
