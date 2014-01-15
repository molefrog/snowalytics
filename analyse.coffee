Instagram 	= require "instagram-node-lib"
_ 			= require "lodash"
qs 			= require "querystring"
moment  	= require "moment"
async 		= require "async"
fs          = require "fs"
Table       = require "cli-table"

# Load data 
data = require "./data.json"

phrases = [ "снег", "снеж", "snow" ]

c = _(data)
	.compact()
	.filter (d) -> 
		if not d?.caption?.text?
			return false

		text = d.caption.text

		_.some phrases, (phrase) ->
			text.toLowerCase().indexOf( phrase ) != -1
	.value()


statuses = _.map c, (d) -> d.caption.text

grouped = _.groupBy c, (d) ->
	time = moment.unix( d.created_time )
	return time.hours() + 1

result = _.map grouped, (v, k) ->
	sortedSamples = _.sortBy v, (d) -> -d.likes.count

	samples = _.map sortedSamples, (d) ->
		"#{d.likes.count} likes - #{d.link}"

	hour    : k
	count   : v.length
	samples : _.first samples


resultTable = new Table
	head: [ "Hour", "Count", "Samples" ]

result.forEach (item) ->
	resultTable.push [ item.hour, item.count, item.samples ]

console.log resultTable.toString() 





