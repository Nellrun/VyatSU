import sys
import lxml.html
import pickle

class Word(object):
	"""docstring for Word"""
	def __init__(self, id, word, translate, sentense):
		super(Word, self).__init__()
		self.id = id
		self.word = word
		self.translate = translate
		self.sentense = sentense

def wordExtract(path):
	global wordBase
	f = open(path, "r")

	ids = set(elem.id for elem in wordBase)
	# l = []

	for line in f.readlines():
		if (line[0] == "<"):
			doc = lxml.html.document_fromstring(line)
			sentense = doc.text_content()
			for elem in doc.cssselect("span"):
				id = elem.get("data-word_id")
				translate = elem.get("data-tooltip")
				word = elem.text_content().lower()
				if (id != "") and (translate != "") and not (id in ids):
					print(word, translate, sentense, sep='\t')
					ids.add(id)
					# l.append(Word(id, elem.text_content(), translate, sentense))
					# if (len(input()) < 1):
					# 	wordBase.append(Word(id, word, translate, sentense))
	f.close()

	# with open("wordBase.pck", "wb") as f:
	# 	pickle.dump(wordBase, f)

wordBase = []
try:
	with open("wordBase.pck", "rb") as f:
		wordBase = pickle.load(f)
except:
	pass

# for elem in wordBase:
# 	print(elem.word)

if len(sys.argv) > 1:
	for path in sys.argv[1:]:
		print(wordExtract(path))
else:
	print("please, give some args")