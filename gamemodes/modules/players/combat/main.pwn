#include "modules/players/combat/header.pwn"

public LoadPlayerCombat(playerid) {
	new query[150];
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM playercombat WHERE pUsername = '%s'", GetNick(playerid));
	mysql_pquery(mysql, query, "ContinueLoadPlayerCombat", "i", playerid);
	return 1;
}
public ContinueLoadPlayerCombat(playerid) {
	if(cache_num_rows()) {
		cache_get_value_index_int(0, 1, PlayerCombat[playerid][DEATH]);
		cache_get_value_index_int(0, 2, PlayerCombat[playerid][KILL]);
		cache_get_value_index_int(0, 3, PlayerCombat[playerid][GIVE_DAMAGE]);
		cache_get_value_index_int(0, 4, PlayerCombat[playerid][TAKE_DAMAGE]);
		cache_get_value_index_int(0, 5, PlayerCombat[playerid][GIVE_HEADSHOT]);
		cache_get_value_index_int(0, 6, PlayerCombat[playerid][TAKE_HEADSHOT]);
		return 1;
	}
	new query[400];
	//mysql_format(mysql, query, sizeof(query), "INSERT INTO playercombat(pUsername, pDeath, pKill, pGiveDamage, pTakeDamage, pGiveHeadShot, pTakeHeadShot) VALUES('%s', '%i', '%i', '%i', '%i', '%i', '%i')",
	mysql_format(mysql, query, sizeof(query), "INSERT INTO playercombat(pUsername) SELECT * FROM (SELECT '%s') AS tmp WHERE NOT EXISTS (SELECT pUsername FROM playercombat WHERE pUsername = '%s')",
		GetNick(playerid), GetNick(playerid));
	printf("\n-----------------------------\n");
	printf("%s", query);
	printf("\n-----------------------------\n");
	mysql_pquery(mysql, query);
	
	LoadPlayerCombat(playerid);
	return 1;
}

public SavingPlayerCombat(playerid, username[]) {
	new query[200];
	mysql_format(mysql, query, sizeof(query), "UPDATE `playercombat` SET pUsername = '%s', pDeath = '%i', pKill = '%i', pGiveDamage = '%i', pTakeDamage = '%i', pGiveHeadShot = '%i', pTakeHeadShot = '%i' WHERE pUsername = '%s'",
		GetNick(playerid), PlayerCombat[playerid][DEATH], PlayerCombat[playerid][KILL], PlayerCombat[playerid][GIVE_DAMAGE],
		PlayerCombat[playerid][TAKE_DAMAGE], PlayerCombat[playerid][GIVE_HEADSHOT], PlayerCombat[playerid][TAKE_DAMAGE], GetNick(playerid));
	mysql_pquery(mysql, query, "FinishSavingPlayerCombat", "iss", playerid, username, query);
	return 1;
}

public FinishSavingPlayerCombat(playerid, username[], query[]) {
	if(cache_affected_rows()) return 1;
	printf("erro ao salvar a conta: %s[%i] \n query:   %s", GetNick(playerid), username, playerid, query);
	return 0;
}