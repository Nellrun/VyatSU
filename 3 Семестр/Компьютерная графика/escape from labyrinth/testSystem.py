import os
import sys

class Player(object):

    """Класс описывающий игрока"""

    x = 0
    y = 0
    stepCount = 0

    def __init__(self):
        super(object).__init__()
        for y, l in enumerate(loc):
            for x, block in enumerate(l):
                if block == 2:
                    self.x = x
                    self.y = y
                    break

    def isWallLeft(self):
        if self.x == 0:
            return True
        if loc[self.y][self.x - 1] == 1:
            return True
        return False

    def isWallRight(self):
        if self.x == len(loc[self.y]) - 1:
            return True
        if loc[self.y][self.x + 1] == 1:
            return True
        return False

    def isWallUp(self):
        if self.y == 0:
            return True
        if loc[self.y - 1][self.x] == 1:
            return True
        return False

    def isWallDown(self):
        if self.y == len(loc) - 1:
            return True
        if loc[self.y + 1][self.x] == 1:
            return True
        return False

    def moveLeft(self):
        if not self.isWallLeft():
            self.x -= 1
            self.stepCount += 1
            logs.write('2')
            return True
        return False

    def moveRight(self):
        if not self.isWallRight():
            self.x += 1
            self.stepCount += 1
            logs.write('0')
            return True
        return False

    def moveUp(self):
        if not self.isWallUp():
            self.y -= 1
            self.stepCount += 1
            logs.write('3')
            return True
        return False

    def moveDown(self):
        if not self.isWallDown():
            self.y += 1
            self.stepCount += 1
            logs.write('1')
            return True
        return False

    def getBlock(self):
        return loc[self.y][self.x]

    def getPosition(self):
        return (self.x, self.y)

class Member(object):
    """Участник рейтинга"""
    def __init__(self, name, level, result):
        super(Member, self).__init__()
        self.name = name
        self.level = level
        self.result = result

def loadMap(path):
    loc = []
    mapFile = open(path, 'r')
    for line in mapFile.readlines():
        loc.append([int(i) for i in line.rstrip().split(' ')])
    return loc

loc = loadMap('maps/1.map')

files = sys.argv[1::]

if not files:
    files = list(filter(lambda x: x.endswith('.py') , os.listdir('bots')))
    files = ['bots/' + i for i in files]

locations = list(filter(lambda x: x.endswith('.map') , os.listdir('maps')))
topList = []

for mapFile in locations:
    loc = loadMap('maps/' + mapFile)
    for file in files:
        self = Player()
        logs = open('logs/' + mapFile + file + '.log', 'w')
        logs.write(mapFile + '\n')
        try:
            exec(open(file, 'r').read())
        except Exception as err:
            logs.write('\n' + str(err))
        if self.getBlock() == 3:
            topList.append(Member(file, mapFile, self.stepCount))
            logs.write('\n3')
        else:
            topList.append(Member(file, mapFile, float('infinity')))
        logs.close()

topList.sort(key = lambda x: x.level and x.result)

print('NAME : LEVEL : RESULT')
for i in topList:
    print(i.name, ': ', i.level, ' : ', i.result)