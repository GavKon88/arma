/*
*Author: Gavinkon88
*GaRDS - Gavin's ace Random Damage System
*Last modified: 10 / 29 / 23
*
*Allows for random assigning of damage with ace medical per wound type
*@parameter _object the human object in question (object)
*@parameter _type the type of damage (accepted: bullet, stab, explosive, crash, fall) (string)
*@parameter _amount the amount of hits that _object should take (integer)
*@parameter _severity the severity of the wound(s) (0-1)
*@parameter _uncon whether or not _object should be guaranteed uncon post-hit (boolean)
*@parameter _unconTime time for which the uncon should take place while not stable (pass 0 if not uncon). will wake up if stable at end of time (integer)
*
*for example: 
*[player, "bullet", 2, 0.7, false, 0] execVM "Scripts\GaRDS.sqf"; 
*would result in 2 random bullet wounds with a severity of 70% with no guaranteed unconsciousness
*whereas:
*[player, "stab", 149, 1, true, 120] execVM "Scripts\GaRDS.sqf"; 
*would result in 149 random stab wounds with a severity of 100% with a guaranteed unconsciousness of at least 120 seconds
*/


params ["_object", "_type", "_amount", "_severity", "_uncon", "_unconTime"]; 

_bodyPart = ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];



//defaulting and error catching

_strObject = (str _object);

if(_severity > 1) then{
    _severity = 1;
    hintSilent (["Fix the severity on your GaRDS call for object '", _strObject,  "'. Err: _severity below 0."] joinString "");
};

if(_severity < 0) then{
    _severity = 0;
    hintSilent (["Fix the severity on your GaRDS call for object '", _strObject,  "'. Err: _severity below 0."] joinString "");
};

if(_amount < 0) then{
    _amount = 0;
    hintSilent (["Fix the amount on your GaRDS call for object '", _strObject,  "'. Err: _amount below 0."] joinString "");
};




//assigning damage and unconsciousness

for "_i" from 1 to _amount do {
    [_object, _severity, _bodyPart # ([0 , 5] call BIS_fnc_randomInt), _type] call ace_medical_fnc_addDamageToUnit
};

if(_uncon) then {
     [_object, true, _unconTime, true] call ace_medical_fnc_setUnconscious;
};