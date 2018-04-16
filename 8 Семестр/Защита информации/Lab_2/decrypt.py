
# Функция дешифровки
def subWords(a, b, alp):
	l = min(len(a), len(b))
	if (l <= 1):
		return ""
	out = ""
	for i in range(l):
		ind = (( alp.index(a[i]) - alp.index(b[i])  ) + 30) % 30
		out += alp[ind - 1]

	return out

# Функция шифрования
def sumWords(a, b, alp):
	l = min(len(a), len(b))
	if (l <= 1):
		return ""
	out = ""
	for i in range(l):
		ind = (alp.index(a[i]) + alp.index(b[i]) + 2) % 30
		out += alp[ind - 1]

	return out

alp = list("АБВГДЕЖЗИКЛМНОПРСТУФХЦЧШЩЬЫЭЮЯ")
msg1 = "ЮПТЦАРГШАЛЖЖЕВЦЩЫРВУУ"
msg2 = "ЮПЯТБНЩМСДТЛЖГПСГХСЦЦ"
word = "КОРАБЛИ"

msgKeys = []
for i in range(len(msg1)):
	msgKeys.append(subWords(msg1[i:], word, alp))

for i in range(len(msg2)):
	decrypWord = subWords(msg2[i:], msgKeys[i], alp)
	print("Text = {}; Key = {}; pos = {}".format(decrypWord, msgKeys[i], i))

msgKeys = []
for i in range(len(msg2)):
	msgKeys.append(subWords(msg2[i:], word, alp))

for i in range(len(msg1)):
	decrypWord = subWords(msg1[i:], msgKeys[i], alp)
	print("Text = {}; Key = {}; pos = {}".format(decrypWord, msgKeys[i], i))

key = "УАОСЯБРОООООООМЛЛПАЗК"
print(subWords(msg1, key, alp))
print(subWords(msg2, key, alp))

word = "КОГДАОТПЛЫВАЮТ"

print(subWords(msg1, word, alp))
key = subWords(msg1, word, alp) + "МЛЛПАЗК"

print(subWords(msg1, key, alp))
print(subWords(msg2, key, alp))