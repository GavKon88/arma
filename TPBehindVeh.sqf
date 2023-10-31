params ["_veh", "_dist", "_objects", "_distBetwObjs","_zCoordSetZero"];

private _tpDir = (getDir _veh + 180) % 360;

private _totalDist = 0;

{
	_totalDist = _dist + (_distBetwObjs * _forEachIndex);

	_x action ["Eject", vehicle _x];

	_x setDir _tpDir;

	if(_zCoordSetZero) then {
		
		_x setPos [(getPos _x # 0) + (_totalDist * cos ((getDir _veh + 180) % 360)), (getPos _x # 1) + (_totalDist * sin ((getDir _veh + 180) % 360)), 50000];

		_x setPos [getPos _x # 0, getPos _x # 1, 0];

	} else {
		
		_x setPos [(getPos _x # 0) + (_totalDist * cos ((getDir _veh + 180) % 360)), (getPos _x # 1) + (_totalDist * sin ((getDir _veh + 180) % 360)), getPos _x # 2];

		hintSilent (str (getPos _x));
	}

} forEach _objects;

