#include "modules/players/mc_info/header.pwn"

public LoadInfo(playerid) {
	//printf("carregando informações do: %s...", GetNick(playerid));
	new query[256];
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM playerinfo WHERE pUsername = '%s'", GetNick(playerid));
	mysql_pquery(mysql, query, "ContinueLoadInfo", "i", playerid);

	return 1;
}

public ContinueLoadInfo(playerid) {
	//printf("cache num rows: %b", cache_num_rows());
	if(cache_num_rows()) {
		cache_get_value_index_int(0, 1, PlayerInfo[playerid][SKIN]);
		cache_get_value_index_int(0, 2, PlayerInfo[playerid][LEVEL]);
		cache_get_value_index_int(0, 3, PlayerInfo[playerid][MONEY]);
		//printf("carregando informacoes do: %s", GetNick(playerid));
		LoadPlayerInfo(playerid);
		return 1;
	}

	new query[256];
	//printf("criando informacoes do: %s", GetNick(playerid));
	mysql_format(mysql, query, sizeof(query), "INSERT INTO playerinfo(pUsername, pSkin, pLevel, pMoney) SELECT * FROM (SELECT '%s','%i', '%i', '%i') AS tmp WHERE NOT EXISTS (SELECT pUsername FROM playerinfo WHERE pUsername = '%s')", 
		GetNick(playerid), INITIAL_SKIN, INITIAL_LEVEL, INITIAL_MONEY, GetNick(playerid));
	mysql_pquery(mysql, query);
	LoadInfo(playerid);
	return 1;
}

public SavingPlayerInfo(playerid) {
	new query[256], skin, money, level;

	skin = GetPlayerSkin(playerid); 
	money = GetPlayerMoney(playerid);
	level = GetPlayerScore(playerid);

	mysql_format(mysql, query, sizeof(query), "UPDATE `playerinfo` SET pSkin = '%i', pLevel = '%i', pMoney = '%i' WHERE pUsername = '%s'",
			skin, level, money, GetNick(playerid));
	mysql_pquery(mysql, query, "FinishSavingPlayerInfo", "iss", playerid, GetNick(playerid), query);
	return 1;
}

public FinishSavingPlayerInfo(playerid, username[], query[]) {
	if(cache_affected_rows()) return 1;
	printf("erro ao salvar mc %s [modules/players/mc_info/main.pwn] \n query: %s", GetNick(playerid), query);
	return 0;
}


public LoadPlayerInfo(playerid) {
	SetPlayerSkin(playerid, PlayerInfo[playerid][SKIN]);
	SetPlayerScore(playerid, PlayerInfo[playerid][LEVEL]);
	GivePlayerMoney(playerid, PlayerInfo[playerid][MONEY]);
	return 1;
}