extends Node
class_name WordManager

var words_by_length := {}

func load_words():
	var file = FileAccess.open("res://oxford_5000.txt", FileAccess.READ)
	while not file.eof_reached():
		var word = file.get_line().strip_edges().to_lower()
		if word.length() < 3 or word.length() > 8:
			continue
		if not words_by_length.has(word.length()):
			words_by_length[word.length()] = []
		words_by_length[word.length()].append(word)
		
