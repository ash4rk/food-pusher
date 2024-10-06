extends Node

class_name Utilities

# TODO: Log it
## Return array of files matching the filter
static func get_files_by_filter(dir_path: String, extension_filter: String) -> Array:
	var res: Array = []
	var dir = DirAccess.open(dir_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(extension_filter):
				var file_path = dir_path + '/' + file_name
				res.push_back(file_path)
			file_name = dir.get_next()
	else:
		push_error("An error occurred when trying to access the path.")
	return res
