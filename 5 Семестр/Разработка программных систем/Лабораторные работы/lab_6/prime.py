import random

def getNext(i):
    while not isPrime(i):
        i += 1
    return i

def isPrime(i):
    for x in range(2, i**0.5):
        if i % x == 0:
            return False
    return True

def getRandomPrime():
    return getNext(random.randInt(2, 10**9))

def getRandomArray(length):
    return [getRandomPrime for i in range(length)]
