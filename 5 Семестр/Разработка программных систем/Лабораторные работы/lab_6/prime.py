import random

def getNext(i):
    i += 1
    while not isPrime(i):
        i += 1
    return i

def isPrime(i):
    for x in range(2, int(i**0.5) + 1):
        if i % x == 0:
            return False
    return True

def getRandomPrime():
    return getNext(random.randint(2, 10**9))

def getRandomArray(length):
    return [getRandomPrime() for i in range(length)]
