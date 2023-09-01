
enum MAIN_PLAYER {
	SKIN,
	LEVEL,
	MONEY,
}

new PlayerInfo[MAX_PLAYERS][MAIN_PLAYER];


forward LoadInfo(playerid);
forward ContinueLoadInfo(playerid);
forward SavingPlayerInfo(playerid);
forward FinishSavingPlayerInfo(playerid, username[], query[]);
forward LoadPlayerInfo(playerid);