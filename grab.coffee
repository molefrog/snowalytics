Instagram 	= require "instagram-node-lib"
_ 			= require "lodash"
qs 			= require "querystring"
moment  	= require "moment"
async 		= require "async"
fs          = require "fs"

##
# Config file
##
config   = require "nconf"
config.argv()
	.env()

config.defaults 
	"config-file" : "config.json"

config.file({ file: config.get "config-file" })

##
# Setting up instagram client
##
Instagram.set "client_id", 		config.get "instagram:id"
Instagram.set "client_secret", 	config.get "instagram:secret"

##
# These coordinates represent almost the center of 
# Rostov-na-Donu, Russia
##
latitude  = 47.259738
longidute = 39.699655

parallelRequests = 25

# Function gets recent media items from Instagram 
# that have been created in between timeSlice
fetchInstagram = (timeSlice, cb) ->
	Instagram.media.search
		lat : latitude
		lng : longidute

		min_timestamp : timeSlice.start
		max_timestamp : timeSlice.end

		distance : 10000 # 10km
		complete : (data) ->
			cb null, data
		error : (err) ->
			cb err


# The begging of today
startTime = moment().hours(0).minutes(0).seconds(0).subtract("hours", 1)

# Generate time slices for requests
timeSlices = _.map [0...24*60], (i) ->
	start : moment(startTime).add("minutes", i).unix()
	end   : moment(startTime).add("minutes", i+1).unix()


async.mapLimit timeSlices, parallelRequests, fetchInstagram, (err, result) ->
	# Merge results
	reduced = _.flatten result, true

	fs.writeFileSync "data.json", JSON.stringify(reduced)



