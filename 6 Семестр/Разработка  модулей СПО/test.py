def hash(a):
	h = 0
	for i, elem in enumerate(a):
		h += elem << i
		print(elem << i)
	return h

a = [
	[0, 1, 2, 3],
	[1, 0, 2, 3],
	[0, 2, 1, 3],
	[0, 1, 3, 2],
	[2, 1, 0, 3],
	[0, 3, 2, 1],
	[3, 1, 2, 0]]


# for elem in a:
# 	print(hash(elem))

print(hash(a[0]))