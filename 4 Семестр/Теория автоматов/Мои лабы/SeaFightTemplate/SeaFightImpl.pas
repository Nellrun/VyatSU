unit SeaFightImpl;

interface

type
	GameMap = array[0..9, 0..9] of Integer; 
	Coords = array[0..1] of Integer;

const
	// ������
	EMPTY = 0;
	
	// ������ � ����� ������ �������
	BLOCK = 1;
	
	// �����
	DAMAGE = 2;
	
	// ����
	KILL = 3;

function getMap: gameMap;	
function shoot: coords;
procedure shootResult(resultCode: Integer);
procedure rivalShoot(point: coords);
procedure setParams(gamesPerSet: Integer);
procedure onCurrentGameEnd;
procedure onCurrentGameSetEnd;


implementation

function getEmptyMap() : GameMap;
var i, j : integer;
begin
	for i := 0 to 9 do begin
		for j := 0 to 9 do begin
			getEmptyMap[i, j] := 0;
		end;
	end;
end;

function sumMaps(var a, b : gameMap) : gameMap;
var i, j: byte;
begin
	for i := 0 to 9 do begin
		for j := 0 to 9 do begin
			sumMaps[i, j] := a[i, j] + b[i, j];
		end;
	end;
end;

function canPutShip(var map : gameMap; x, y: integer;  size : integer) : boolean;
var left, right, top, bottom, i : byte;
begin
	left := 0;
	right := 0;
	top := 0;
	bottom := 0;

	if map[y, x] <> 0 then begin
		canPutShip := False;
		exit()
	end;

 	while (left < size) and (x - left >= 0) and (map[y, x - left] = 0) do begin
 		inc(left);
 	end;

 	while (right < size) and (x + right < 10) and (map[y, x + right] = 0) do begin
 		inc(right);
 	end;

 	while (top < size) and (y - top >= 0) and (map[y - top, x] = 0) do begin
 		inc(top);
 	end;

 	while (bottom < size) and (y + bottom < 10) and (map[y + bottom, x] = 0) do begin
 		inc(bottom);
 	end;

 	if (left + right - 1 >= size) or (top + bottom - 1 >= size) then canPutShip := True
 	else canPutShip := False;

end;

{
	���������� ���� ��� ����� ������� ����, �����
	�������� ����������� ��������.
	������������ �������� - ������� 10�10, � ������� 
	0 - ������ ������, 1 - ������ �������
}	
function getMap: GameMap;
begin
end;

{
	������� �� ���� ����������. ��������� ��������
	����� ��������� ����� shootResult;
	������������ �������� - ������ 1�2, � ������� 
	������ ������ - ���������� �� �, ������ - �� �.
	������ ��������� - ����� ������� ����.
}
function shoot: Coords;
begin
end;

{
	���������� ����� shoot, ���������� ���������� �
	���������� ���������� ��������:
	0 - ������;
	2 - �����;
	3 - ����.
}
procedure shootResult(resultCode: Integer);
begin
end;

{
	������������ ��� �������� ���������� � ���,
	� ����� ����� ������ ���� ������� ���������.
	���������:
	point - ������ 1�2, ��� � ���� (y, x) ����������
		���������� ������
}
procedure rivalShoot(point: Coords);
begin
end;

{
	���������� ���� ��� ����� ������� ���� ���.
	���������:
	gamesPerSet - ���������� ��� ����� ����� �������� � ����� ����.
}
procedure setParams(gamesPerSet: integer);
begin
end;

{
	���������� ����� ���������� ����� ����.
}
procedure onCurrentGameEnd;
begin
end;

{
	���������� ����� ���������� ���� ��� � ������� �������.
}
procedure onCurrentGameSetEnd;
begin
end;

end.