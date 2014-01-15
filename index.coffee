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

fetchInstagram = (timeSlice, cb) ->
	console.log timeSlice.start

	Instagram.media.search
		lat : 47.259738
		lng : 39.699655

		min_timestamp : timeSlice.start
		max_timestamp : timeSlice.end

		distance : 10000
		complete : (data) ->
			cb null, data
		error : (err) ->
			cb err


startTime = moment().hours(0).minutes(0).seconds(0).subtract("hours", 1)

timeSlices = _.map [0...24*60], (i) ->
	start : moment(startTime).add("minutes", i).unix()
	end   : moment(startTime).add("minutes", i+1).unix()


async.mapLimit timeSlices, 25, fetchInstagram, (err, result) ->
	reduced = _.flatten result, true


	fs.writeFileSync "data.json", JSON.stringify(reduced)



