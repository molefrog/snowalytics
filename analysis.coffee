Instagram 	= require "instagram-node-lib"
_ 			= require "lodash"
qs 			= require "querystring"
moment  	= require "moment"
async 		= require "async"
fs          = require "fs"

data = require "./data.json"


phrases = [
	"снег"
	"снеж"
	"snow"
]

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

# r = _.map grouped, (d, k) -> 
# 	representative = _.sample d, (a) -> a.likes.count

# 	text =
# 	[k,  d.length,  representative.caption.text,  representative.link] 

x =  _.groupBy grouped[16], (d) ->
	d.likes.count





console.log x[73][0].link

# console.log r
console.log data.length, statuses.length




