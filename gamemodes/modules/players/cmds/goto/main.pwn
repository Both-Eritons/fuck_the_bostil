
CMD:goto(playerid, params[])
{
	new giveplayerid,Float:x, Float:y, Float:z, str[256];
	if(sscanf(params, "i", giveplayerid)) return SendClientMessage(playerid, -1, "como usar: /goto [playerid]");
	if(!IsPlayerConnected(giveplayerid) && giveplayerid != INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "este player nao esta online");

	GetPlayerPos(giveplayerid, x, y, z);
	SetPlayerPos(playerid, x, y, z);

	format(str, sizeof(str), "o Player {ff0000}%s[%d] {ffffff}foi ate voce.", GetNick(playerid), playerid);
	SendClientMessage(giveplayerid, -1, str);

	format(str, sizeof(str), "o voce foi ate o player {ff0000}%s[%d]", GetNick(giveplayerid), giveplayerid);
	SendClientMessage(playerid, -1, str);
	return 1;
}