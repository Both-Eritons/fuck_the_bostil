
enum ADMIN_PLAYER {
	USERNAME,
	LEVEL,
	bool:WORKING
}

new PlayerAdmin[MAX_PLAYERS][ADMIN_PLAYER];

forward LoadPlayerAdmin(playerid);
forward ContinueLoadPlayerAdmin(playerid);
forward LoadPlayerAdminInfos(playerid);
forward CreatePlayerAdmin(playerid, username[]);
forward SavingPlayerAdmin(playerid);
forward FinishSavingPlayerAdmin(playerid, username[], query[]);
