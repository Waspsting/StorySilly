class_name Settings
extends Resource
var options = {
	"volume": 1,
	"fullscreen": false}

var savepath = "user://data.ini"
func savedata ():
	var config_file = ConfigFile.new()
	config_file.set_value("options","volume", options["volume"])
	config_file.set_value("options","fullscreen", options["fullscreen"])
	var error = config_file.save(savepath)
	if error: 
		print(error)

func loaddata ():
	var config_file = ConfigFile.new()
	var error = config_file.load(savepath)
	if error: 
		print(error)
		return
	options["volume"] = config_file.get_value("options", "volume", 1)
	options["fullscreen"] = config_file.get_value("options", "fullscreen", false)
