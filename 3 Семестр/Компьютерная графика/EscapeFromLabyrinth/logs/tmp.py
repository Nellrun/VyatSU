# player -  это главный герой, 
# он может выполнять разнообразные действия
# Например сделать шаг вправо: 
# player.moveRight()
# или вверх player.moveUp()
# вниз player.moveDown()
# он может проверить: есть ли рядом с ним 
# блок
# Есть ли слева блок? player.isWallLeft()

# Ваша задача: добраться до зеленого портала 
#на следующий уровень

while not player.isWallRight():
   player.moveRight()

while not player.isWallDown():
   player.moveDown()

