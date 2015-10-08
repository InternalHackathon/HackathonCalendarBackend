class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :add_http_headers
  
  def add_http_headers
    #headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
    #headers['Pragma'] = 'no-cache'
    #headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
	headers['Access-Control-Allow-Origin'] = '*'
	#headers['Access-Control-Allow-Headers'] = 'origin, x-requested-with, content-type'
	#headers['Access-Control-Allow-Headers'] = 'PUT, GET, POST, DELETE, OPTIONS'
  end
  
end
