#include "script_component.hpp"
/*
 * Author: DiGii
 * This cant be called manualy!
 * Handles the Gas effect for the AI
 * 
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Module <Logic>
 * 2: Position <Position>
 * 3: Radius <NUMBER>
 * 4: GasTyoe <STRING>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [] call kat_chemical_fnc_gasAI;
 *
 * Public: No
*/

params ["_unit","_logic","_pos","_radius_max","_gastype"];
[
	{
		params["_args","_handler"];
		_args params ["_logic","_unit"];
		if(!(_logic getVariable[QGVAR(gas_active),false]) || !(alive _unit) || isNull _unit) then {
			_unit setVariable[QGVAR(enteredPoisen),false,true];
			[_handler] call CBA_fnc_removePerFrameHandler;
		};
	},
	3,
	[_logic,_unit]
]call CBA_fnc_addPerFrameHandler;
private _skill = _unit skill "aimingAccuracy";
while{_logic getVariable [QGVAR(gas_active), false] && !(isNull _logic) && alive _unit && !(_unit getVariable ["ACE_isUnconscious",false])} do { 
	_pos = _logic getVariable [QGVAR(gas_pos),[0,0,0]];
	if((_unit distance _pos) <= _radius_max && !(_unit getVariable[QGVAR(enteredPoisen),false])) then {
		_unit setVariable[QGVAR(enteredPoisen),true,true];
		private _fnc_afterwait = {
			params["_unit","_gastype","_pos","_skill"];
			if !(goggles _unit in KAT_AVAIL_GASMASK) exitWith {
				if(_gastype isEqualTo "CS") then {
					while{_unit distance _pos < 10 && _unit getVariable[QGVAR(enteredPoisen),false]} do {
						_unit say3D "cough_1";
						_unit setSkill ["aimingAccuracy",0.001];
						[
							{
								params["_unit","_skill"];
								_unit setSkill ["aimingAccuracy",_skill];
							},
							[_unit, _skill],
							2
						] call CBA_fnc_waitAndExecute;
						
					};
				}else{
					if(ace_medical_statemachine_AIUnconsciousness) then {
						for "_i" from 0 to 10 step 1 do {
							[
								{
									params["_unit"];
									//[_unit, "RightArm", "PoisenBP"] call FUNC(medicationLocal);
								},
								[_unit],
								5
							] call CBA_fnc_waitAndExecute;
						};
					} else {
						[{private _unit = _this select 0;  _unit setDamage 1;},[_unit], 20]call CBA_fnc_waitAndExecute;
					};
				};
			};
		};
		private _timeleft = 30;
		for "_i" from 0 to 1 step 0 do {
			_timeleft = _timeleft - 1;
			if(_timeleft <= 0) exitWith {
				[_unit,_gastype,_pos,_skill] spawn _fnc_afterwait;
				_i = 2;
			};
			if(_gastype isEqualTo "CS") exitWith {
				[_unit,_gastype,_pos,_skill] spawn _fnc_afterwait;
				_i = 2;
			};
			_pos = _logic getVariable [QGVAR(gas_pos),[0,0,0]];
			if ( _unit distance _pos > _radius_max || !(_logic getVariable[QGVAR(gas_active),false]) || isNull _logic ) exitWith {
				_unit setVariable[QGVAR(enteredPoisen),false,true];
				_i = 2;
			};
			uiSleep 1;
		};
	};


	uiSleep 5;
};