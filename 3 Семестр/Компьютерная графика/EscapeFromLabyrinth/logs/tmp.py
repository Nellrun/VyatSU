# player -  ��� ������� �����, 
# �� ����� ��������� ������������� ��������
# �������� ������� ��� ������: 
# player.moveRight()
# ��� ����� player.moveUp()
# ���� player.moveDown()
# �� ����� ���������: ���� �� ����� � ��� 
# ����
# ���� �� ����� ����? player.isWallLeft()

# ���� ������: ��������� �� �������� ������� 
#�� ��������� �������

while not player.isWallRight():
   player.moveRight()

while not player.isWallDown():
   player.moveDown()

