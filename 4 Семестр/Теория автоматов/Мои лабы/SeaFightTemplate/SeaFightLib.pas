library SeaFight;

uses SeaFightImpl;

type
	IntegerPtr = ^Integer;
	IntegerPtrPtr = ^IntegerPtr;
	

procedure getMapProxy(result: IntegerPtrPtr); stdcall;	
var
	getMapRes: GameMap;
	i, j: Integer;
begin
	getMapRes := getMap();
	
	result^ := getMem(sizeof(Integer) * 100);
	for i := 0 to 9 do begin
		for j := 0 to 9 do begin
			result^[i * 10 + j] := getMapRes[i, j];
		end;
	end;
end;

procedure shootProxy(result: IntegerPtrPtr); stdcall;	
var	
	shootRes: Coords;
begin
	shootRes := shoot();
	
	result^ := getMem(sizeof(Integer) * 2);
	result^[0] := shootRes[0];
	result^[1] := shootRes[1];
end;

procedure shootResultProxy(resultCode: integer); stdcall;	
begin
	shootResult(resultCode);
end;

procedure rivalShootProxy(point: coords); stdcall;	
begin
	rivalShoot(point);
end;

procedure setParamsProxy(gamesPerSet: integer); stdcall;	
begin
	setParams(gamesPerSet);
end;

procedure onCurrentGameSetEndProxy; stdcall;	
begin
	onCurrentGameSetEnd();
end;

procedure onCurrentGameEndProxy; stdcall;	
begin
	onCurrentGameEnd();
end;

procedure clearMemProxy(ptrPtr: IntegerPtrPtr); stdcall;
begin
	freeMem(ptrPtr^);
end;

exports 
	getMapProxy, shootProxy, shootResultProxy, rivalShootProxy, setParamsProxy, onCurrentGameSetEndProxy, onCurrentGameEndProxy, clearMemProxy;

end.