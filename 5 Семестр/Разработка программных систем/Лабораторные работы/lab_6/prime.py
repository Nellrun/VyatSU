import random

getNext = lambda i: getNext(i + 1) if not isPrime(i + 1) else i + 1
isPrime = lambda i: len(list(filter(lambda x: i % x == 0, range(2, int(i**0.5) + 1)))) == 0
# isPrime = lambda i, x = 2: True if x > (i**0.5) else False if i % x == 0 else isPrime(i, x + 1)
getRandomPrime = lambda: getNext(random.randint(2, 10**9))
getRandomArray = lambda length: [getRandomPrime() for i in range(length)]
