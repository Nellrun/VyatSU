import math
import random

def isPrime(num):
	if num <= 1:
		return False

	for i in range(2, math.ceil(num**0.5)):
		if num % i == 0:
			return False

	return True

def genPrime(start, end, count = 1):
	candidates = []
	for i in range(start, end + 1):
		# print(i)
		if isPrime(i):
			candidates.append(i)


	if len(candidates) < count:
		return None

	return random.sample(candidates, count)

def genKeys(stop = 999, start = 100, fast=False):
	p, q = genPrime(start, stop, 2)
	n = p * q
	f = (p-1) * (q-1)

	eList = []

	for i in range(f):
		if isPrime(i) and f % i != 0:
			eList.append(i)

			if fast:
				break

	e = random.choice(eList)

	d = 1
	while (d * e) % f != 1:
		d += 1

	return (d, n), (e, n)

def encrypt(publicKey, message = ""):
	out = []
	for ch in message:
		out.append(chr((ord(ch) ** publicKey[0]) % publicKey[1]))

	return "".join(out)

def decrypt(privateKey, message = ""):
	out = []
	for ch in message:
		out.append(chr((ord(ch) ** privateKey[0]) % privateKey[1]))

	return "".join(out)


def test():
	public, private = genKeys(fast=True)
	print("public key = {}".format(public))
	print("private key = {}".format(private))

	msg = "Shchesnyak D.S."
	enc = encrypt(public, msg)

	print("Message = {}\nEncoded = {}".format(msg, enc))
	print("Decoded = {}".format(decrypt(private, enc)))


if __name__ == "__main__":
	test()