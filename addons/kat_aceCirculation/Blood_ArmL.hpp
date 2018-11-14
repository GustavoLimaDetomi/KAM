class BloodIV;
class BloodIV_O: BloodIV {
	displayName = $STR_KAT_aceCirculation_Action_BloodIV_O;
	condition = "[_player, _target, 'hand_l', 'BloodIV_O'] call ace_medical_fnc_canTreatCached";
	statement = "[_player, _target, 'hand_l', 'BloodIV_O'] call ace_medical_fnc_treatment";
};
class BloodIV_A: BloodIV {
	displayName = $STR_KAT_aceCirculation_Action_BloodIV_A;
	condition = "[_player, _target, 'hand_l', 'BloodIV_A'] call ace_medical_fnc_canTreatCached";
	statement = "[_player, _target, 'hand_l', 'BloodIV_A'] call ace_medical_fnc_treatment";
};
class BloodIV_B: BloodIV {
	displayName = $STR_KAT_aceCirculation_Action_BloodIV_B;
	condition = "[_player, _target, 'hand_l', 'BloodIV_B'] call ace_medical_fnc_canTreatCached";
	statement = "[_player, _target, 'hand_l', 'BloodIV_B'] call ace_medical_fnc_treatment";
};
class BloodIV_AB: BloodIV {
	displayName = $STR_KAT_aceCirculation_Action_BloodIV_AB;
	condition = "[_player, _target, 'hand_l', 'BloodIV_AB'] call ace_medical_fnc_canTreatCached";
	statement = "[_player, _target, 'hand_l', 'BloodIV_AB'] call ace_medical_fnc_treatment";
};
