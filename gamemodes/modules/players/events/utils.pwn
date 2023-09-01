
forward PlayerDeathMessage(playerid, killerid);
public PlayerDeathMessage(playerid, killerid) {
	new str[128];
	PlayerCombat[killerid][KILL] += 1;
	PlayerCombat[playerid][DEATH] += 1;
	format(str, sizeof(str), "Voce foi morto pelo jogador: {D50606} %s", GetNick(killerid));
	SendClientMessage(playerid, -1, str);
	format(str, sizeof(str), "Voce matou o jogador: {12D920} %s", GetNick(playerid));
	SendClientMessage(killerid, -1, str);
	SpawnPlayer(playerid);
	SetPlayerRandSpawn(playerid);
	return 1;
}