//#include "modules/players/cmds/weapon/header.pwn"

CMD:weapon(playerid, params[])
{
	new weaponid, mun;
	if(sscanf(params, "ii", weaponid, mun)) return SendClientMessage(playerid, -1, "{FF0000} [ERROR] {FFFFFF} /weapon <id> <muni>");
	if(mun < 1 || mun > 999) return SendClientMessage(playerid, -1, "{FF0000} [ERROR] {FFFFFF} max mum: 0 - 999");
	if(weaponid == WEAPON_MINIGUN || weaponid == WEAPON_ROCKETLAUNCHER && PlayerAdmin[playerid][LEVEL] < 1)
		return SendClientMessage(playerid, -1, "{FF0000} [ERROR] {FFFFFF} voce precisa ser admin para pegar essas armas.");

	GivePlayerWeapon(playerid, weaponid, mun);
	SendClientMessage(playerid, COLOR_SUCCESS, "arma entregue.");
	return 1;
}
forward ForbiddenDamageWithWeapon(playerid, weaponid);
public ForbiddenDamageWithWeapon(playerid, weaponid) {
	if(weaponid == WEAPON_MINIGUN 
		|| weaponid == WEAPON_ROCKETLAUNCHER 
		&& !PlayerAdmin[playerid][LEVEL]) return 1;
	return 0;
}