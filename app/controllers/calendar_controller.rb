class CalendarController < ApplicationController
	
  def index
    render :json => File.read("#{Rails.root}/events.json")
  end
  
  def show
    json_hash = JSON.parse(File.read("#{Rails.root}/events.json"))
  	dates_in_month = []
      json_hash.keys.each do |date|
        parsed_date = date.split('-')
  	  if(parsed_date[0].eql?(params[:year]) and parsed_date[1].eql?(params[:month]))
  	    dates_in_month << date
  	  end
  	end
  	render :json => json_hash.select{|date, event| dates_in_month.include?(date)}.to_json
  end
	
  def update
    file_name = "#{Rails.root}/events.json"
    json_hash = JSON.parse(File.read("#{Rails.root}/events.json"))
  	event_hash = {}
  	event_hash[:event] = params[:event]
    event_hash[:eventDetails] = params[:eventDetails]
    if json_hash.has_key?(params[:date])
      json_hash[params[:date]][:event]=params[:event]
      json_hash[params[:date]][:eventDetails]=params[:eventDetails]
      File.open(file_name, 'w') do |f|
          f.write json_hash.to_json
      end
    #   #find the hash do file handling and replace the content
      #json_hash.gsub(/#{params[:date]:\{"event:"[a-zA-Z0-9]","eventDetails":"[a-zA-Z0-9])"\}}/,'#{event_hash}') 
      #json_hash.to_json.gsub(/#{params[:date]}\:\\\{\"[a-zA-Z0-9]\"\,\"eventDetails\"\:\"[a-zA-Z0-9]\"\}}/,'#{event_hash}')

      #{}"2014-09-10":{"event":"third","eventDetails":"world"}
      #(/(#{params[:date]}:{"event:"[a-zA-Z0-9]","eventDetails":"[a-zA-Z0-9]"})/,'#{event_hash}')
    else
      json_hash[params[:date]] = event_hash
      File.open(file_name, 'w') do |f|
          f.write json_hash.to_json
      end
    end
    render :json => File.read(file_name)
  end

end
