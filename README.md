The Snowalytics Project
-----------------------
One-day-only project that is intended to show how environmental changes are being reflected in
social networks. 

![](https://raw.github.com/molefrog/snowalytics/master/result/snow-mentions.png)
## How it works?
The `data.json` file represents data about all Instagram photos taken near Rostov-on-Don, Russia 14th Janhuary 2014. This data was observed using the output of `grad.coffee` script. The script simply fetches portions of photos meta-information (since Instagram doesn't support normal search pagination) and stores it into single JSON file.  

Another script was used to calculate statistics of how often the '#snow' tag was mentioned in these data. It also calculates class representatives - the most liked photos of every hour. 

The resulting plot indeed shows that there was a slash at 4pm, almost exactly when the snow started to fall.

## How to use?
 * Install node.js, NPM and CoffeeScript:

```
npm install -g coffee-script
```
 * Create `config.json` file where the Instagram API keys are stored:

```json
{
	"instagram" : {
		"id"      : "YOUR_API_KEY",
		"secret"  : "YOUR_API_SECRET"
	}
}
```
 * Run `grab.coffee` to fetch the data:

```
coffee grab.coffee
```
 * Run `analyse.coffee` to analyse the data:

```
coffee analyze.coffee
``` 
 

