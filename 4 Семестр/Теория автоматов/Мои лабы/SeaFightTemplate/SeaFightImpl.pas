unit SeaFightImpl;

interface

type
	GameMap = array[0..9, 0..9] of Integer; 
	Coords = array[0..1] of Integer;

const
	// Промах
	EMPTY = 0;
	
	// Клетка с живой частью корабля
	BLOCK = 1;
	
	// Ранен
	DAMAGE = 2;
	
	// Убит
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
	Вызывается один раз перед началом игры, чтобы
	получить расстановку кораблей.
	Возвращаемое значение - матрица 10х10, в которой 
	0 - пустая клетка, 1 - клетка корабля
}	
function getMap: GameMap;
begin
end;

{
	Выстрел по полю противника. Результат выстрела
	будет возвращен черещ shootResult;
	Возвращаемое значение - массив 1х2, в котором 
	первая клетка - координата по У, вторая - по Х.
	Начало координат - левый верхний угол.
}
function shoot: Coords;
begin
end;

{
	Вызывается после shoot, передается информация о
	результате последнего выстрела:
	0 - промах;
	2 - ранен;
	3 - убит.
}
procedure shootResult(resultCode: Integer);
begin
end;

{
	Используется для передачи информации о том,
	в какое место нашего поля стрелял противник.
	Параметры:
	point - массив 1х2, где в виде (y, x) содержатся
		координаты клетки
}
procedure rivalShoot(point: Coords);
begin
end;

{
	Вызывается один раз перед началом всех игр.
	Параметры:
	gamesPerSet - количество игр между двумя игроками в одном сете.
}
procedure setParams(gamesPerSet: integer);
begin
end;

{
	Вызывается после заврешения одной игры.
}
procedure onCurrentGameEnd;
begin
end;

{
	Вызывается после заврешения сета игр с текущим игроком.
}
procedure onCurrentGameSetEnd;
begin
end;

end.