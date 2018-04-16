import random
import math 

class Gost(object):
	"""docstring for Gost"""
	def __init__(self, key, sbox):
		super(Gost, self).__init__()
		self.key = key
		self.sbox = sbox

		self.subkeys = []
		for i in range(8):
			self.subkeys.append((key >> i*32) & 0xFFFFFFFF)

	def _f(self, data, key):
		temp = data ^ key

		out = 0
		for i in range(8):
			out |= (self.sbox[i][(temp >> (4 * i)) & 0xF]) << (4 * i)

		# return out
		return ((out >> 11) | (out << (32 - 11))) & 0xFFFFFFFF

	def encrypt(self, msg):

		BLOCK_SIZE = 3

		# Приведение сообщения в числовой вид
		msgBin = []
		for i in range(math.ceil(len(msg) / BLOCK_SIZE)):
			tmp = 0
			for j in range(BLOCK_SIZE):
				if (i*BLOCK_SIZE + j) <= len(msg):
					tmp |= ord(msg[i*BLOCK_SIZE + j]) << (j * 16)
			msgBin.append(tmp)
		# Шифрование
		res = []
		for elem in msgBin:
			# print(elem)
			a = elem & 0xFFFFFFFF
			b = elem >> 32

			for i in range(24):
				a, b = b ^ self._f(a, self.subkeys[i % 8]), a

			for i in range(8):
				a, b = b ^ self._f(a, self.subkeys[7 - i]), a

			enc = (a << 32) | b
			res.append(enc)

		return res


	def decrypt(self, msg):
		res = []

		for elem in msg:
			a = elem & 0xFFFFFFFF
			b = elem >> 32

			for i in range(8):
				a, b = b ^ self._f(a, self.subkeys[i]), a 

			for i in range(24):
				a, b = b ^ self._f(a, self.subkeys[7 - (i % 8)]), a

			enc = (a << 32) | b
			# print(enc)

			text = ""
			for i in range(3):
				text += chr( (enc >> (i*16)) & 0xFFFF ) 
			res.append(text)

		return "".join(res)



def test():
	sbox = (
		(5, 15, 0, 12, 8, 4, 14, 2, 13, 11, 3, 6, 10, 1, 9, 7),
		(12, 13, 8, 14, 7, 5, 1, 6, 2, 3, 11, 0, 15, 9, 10, 4),
		(1, 10, 13, 9, 12, 0, 6, 3, 8, 15, 11, 2, 14, 4, 7, 5),
		(6, 9, 4, 2, 3, 13, 8, 14, 1, 11, 15, 7, 0, 10, 5, 12),
		(11, 0, 9, 10, 1, 2, 8, 12, 15, 3, 6, 4, 7, 5, 14, 13),
		(5, 15, 2, 1, 7, 14, 8, 6, 0, 10, 3, 9, 4, 13, 12, 11),
		(1, 0, 13, 4, 3, 2, 6, 11, 8, 5, 7, 14, 9, 10, 15, 12),
		(4, 5, 9, 11, 10, 1, 6, 13, 7, 2, 3, 0, 12, 14, 15, 8)
	)

	msg = "Hello, world"
	key = 5

	gost = Gost(key, sbox)
	encryptedMsg = gost.encrypt(msg)
	print(encryptedMsg)
	print(gost.decrypt(encryptedMsg))
	



if __name__ == "__main__":
	test()
