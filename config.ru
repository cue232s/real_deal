# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application


#http://www.zillow.com/webservice/GetChart.htm?zws-id=X1-ZWz1be2tw2tfd7_1wtus&unit-type=percent&zpid=2967945&width=300&height=150

#Below is an example of calling the API for the address for the exact address match "2114 Bigelow Ave", "Seattle, WA": 
#http://www.zillow.com/webservice/GetSearchResults.htm?zws-id=X1-ZWz1be2tw2tfd7_1wtus&address=4922+WISE+Ave&citystatezip=63110	

#http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?zws-id=X1-ZWz1be2tw2tfd7_1wtus&zpid=2967945