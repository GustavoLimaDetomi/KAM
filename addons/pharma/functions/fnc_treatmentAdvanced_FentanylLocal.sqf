#include "script_component.hpp"
/*
 * Author: MiszczuZPolski edited by Miss Heda 
 *
 * Arguments:
 * 0: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * -
 *
 * Public: No
 */


/// ChromAberration effect
[
    { 
        params ["_patient"];

        ["ChromAberration", 200, [ 0.04, 0.04, true ], _patient] spawn {

            params["_name", "_priority", "_effect", "_patient"];
            private "_handle";
            while {
                _handle = ppEffectCreate[_name, _priority];
                _handle < 0
            } do {
                _priority = _priority + 1;
            };
            _handle ppEffectEnable true;
            _handle ppEffectAdjust _effect;
            _handle ppEffectCommit 660; /// Wearoff after 13m (after injection)

            [
				{ 	params ["_handle"];
					ppEffectCommitted _handle;
				},
				{	params ["_handle"];
					_handle ppEffectEnable false;
					ppEffectDestroy _handle;
				},
				[_handle, _patient]
            ] call CBA_fnc_waitUntilAndExecute;
        };
    },
[_patient],120] call CBA_fnc_waitAndExecute; /// chroma start 2m