#include "script_component.hpp"
/*
 * Author: DiGii
 * 
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [player] call kat_chemical_fnc_chemDetector;
 *
 * Public: No
*/
params ["_unit"];

"KAT_CHEM_DETECTOR" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];
private _ui = GETUVAR(RscWeaponChemicalDetector,displayNull);
private _obj = _ui displayCtrl 101;

if(!(_unit getVariable [QGVAR(enteredPoison),false])) then {
    _obj ctrlAnimateModel ["Threat_Level_Source", 0, true];
};

[
    {
        params["_unit"];
        _unit getVariable [QGVAR(enteredPoison), false]
    },
    {
        params["_unit", "_obj"];
        [
            {
                params["_args", "_pfhHandler"];
                _args params ["_unit", "_obj"];
                
                private _percent = _unit getVariable [QGVAR(gasPercentage),0];
                private _thread = parseNumber (_percent toFixed 1);
                if (_thread < 0) then { _thread = 0};
                if (_thread > 1) then { _thread = 1};
                _obj ctrlAnimateModel ["Threat_Level_Source", _thread, true];

                if (!("ChemicalDetector_01_watch_F" in (assigneditems _unit)) || !(_unit getVariable[QGVAR(enteredPoison),false])) exitWith {
                    [_pfhHandler] call CBA_fnc_removePerFrameHandler;
                    [_unit] call FUNC(chemDetector);
                };
            }, 
        1, [_unit, _obj]] call CBA_fnc_addPerFramehandler;
        [
            {
                params["_args", "_pfhHandler"];
                _args params ["_unit"];

                if (_unit getVariable [QGVAR(chemDetectorState), false] && _unit getVariable [QGVAR(gasPercentage), 0] >= 0.1 && "ChemicalDetector_01_watch_F" in (assigneditems _unit)) then {
                    playSound3D [QPATHTOF(audio\chemDetector.ogg), _unit, false, getPosASL _unit, 4, 1, 10];
                };

                if (!("ChemicalDetector_01_watch_F" in (assigneditems _unit)) || !(_unit getVariable[QGVAR(enteredPoison),false])) exitWith {
                    [_pfhHandler] call CBA_fnc_removePerFrameHandler;
                };

            },
        6, [_unit]] call CBA_fnc_addPerFramehandler;
    },
    [_unit, _obj]
] call CBA_fnc_waitUntilAndExecute;

