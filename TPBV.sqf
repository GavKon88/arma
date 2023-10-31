/*
*Author: Gavinkon88
*TPBV - Teleport behind vehicle
*Last modified: 10 / 30 / 23
*/

/*
*Teleports a set of players directly behind a vehicle they are contained within at set distances and intervals
*@parameter _veh - Object | the vehicle that the players are contained within
*@parameter _dist - Integer | the distance the first object should be from the center of mass of the vehicle - can be negative to eject out front of the vehicle
*@parameter _objects - Object/Array | the set of players that need ejected from the vehicle - if only 1 player, just put them in brackets: [<object name>]
*@parameter _distBetwObjs - Integer | the distance between multiple players that are ejected from a vehicle (change between each iteration) - can be negative (i guess?)
*@parameter _zCoordSetZero - Boolean | whether or not the players should be reset to zero altitude or maintain current altitude of the vehicle
*/

/*
*for example: 
*[vehicle1, 2, [man1, man2], 2, true] execVM "Scripts\TPBV.sqf"; 
*would result in man1 and man2 being ejected 2 meters from the center of mass of vehicle1, 2 meters apart, and at z = 0
*
*whereas:
*[vehicle2, 15, [man1, man2], 4, false] execVM "Scripts\TPBV.sqf"; 
*would result in man1 and man2 being ejected 15 meters from the center of mass of vehicle2, 4 meters apart, and at the vehicles altitude
*/

params ["_veh", "_dist", "_objects", "_distBetwObjs","_zCoordSetZero"];

private _tpDir = getDir _veh + 180;

private _totalDist = 0;

{
	_totalDist = _dist + (_distBetwObjs * _forEachIndex);

	_x action ["Eject", vehicle _x];

	_x setDir _tpDir;

	if(_zCoordSetZero) then {
		
		_x setPos [(getPos _x # 0) + (_totalDist * sin ((getDir _veh + 180) % 360)), (getPos _x # 1) + (_totalDist * cos ((getDir _veh + 180) % 360)), 50000];

		_x setPos [getPos _x # 0, getPos _x # 1, 0];

	} else {
		
		_x setPos [(getPos _x # 0) + (_totalDist * sin ((getDir _veh + 180) % 360)), (getPos _x # 1) + (_totalDist * cos ((getDir _veh + 180) % 360)), getPos _x # 2];

	}

} forEach _objects;

