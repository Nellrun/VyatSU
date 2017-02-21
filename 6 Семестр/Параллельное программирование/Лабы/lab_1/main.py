import numpy as np

def makeMatrix(h, w):
	m = np.arange(1, h*w)
	np.random.shuffle(m)
	m = np.append(m, 0)
	return np.reshape(m, [h, w])


print(makeMatrix(3, 4))