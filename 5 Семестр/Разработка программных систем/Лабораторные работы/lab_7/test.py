mult = lambda x, y: sum(map(lambda x, y: x * y, x, y))
getColumn = lambda x, n: [i[n] for i in x]
multRow = lambda x, y, row = 0: [mult(x[row], getColumn(y, i)) for i in range(len(y[0]))]
multMatrix = lambda x, y: [multRow(x, y, i) for i in range(len(x))]

sumMatrix = lambda x, y: [list(map(lambda x, y : x + y, x[i], y[i])) for i in range(len(x))]

x = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

# y = [
#     [1, 2],
#     [4, 5],
#     [7, 8]
# ]

y = x

# print(multMatrix(x, y))
print(sumMatrix(x, y))
