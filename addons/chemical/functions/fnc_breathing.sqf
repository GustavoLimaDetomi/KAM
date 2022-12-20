#include "script_component.hpp"

/*
 * Author: DiGii
 * 
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call kat_chemical_fnc_breathing;
 *
 * Public: No
*/
params ["_unit"];

[
	{
		params ["_unit"];
		goggles _unit in KAT_AVAIL_GASMASK
	},
	{
		params ["_unit"];
		[
		{
			params["_args","_handler"];
			_args params ["_unit"];
			if !(goggles _unit in KAT_AVAIL_GASMASK || !(alive player) || _unit getVariable["ace_medical_heartrate",80] <= 0) then {
				[_handler] call CBA_fnc_removePerFrameHandler;
				[_unit] spawn FUNC(breathing);
			} else {
				if(GET_PAIN_PERCEIVED(_unit) >= 0.4 || _unit getVariable["ace_medical_heartrate",80] >= 105) then {
					_unit say3D "mask_breath_heavy";
				} else {
					private _random = selectRandom["mask_breath_1","mask_breath_2"];
					_unit say3D _random;
				};
			};
		},
		5,
		[_unit]
		]call CBA_fnc_addPerFrameHandler;
	},
	[_unit]
] call CBA_fnc_waitUntilAndExecute;
