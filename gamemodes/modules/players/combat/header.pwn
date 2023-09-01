
enum PLAYER_COMBAT {
	KILL,
	DEATH,
	GIVE_DAMAGE,
	TAKE_DAMAGE,
	GIVE_HEADSHOT,
	TAKE_HEADSHOT
};
new PlayerCombat[MAX_PLAYERS][PLAYER_COMBAT];

forward LoadPlayerCombat(playerid);
forward ContinueLoadPlayerCombat(playerid);
forward SavingPlayerCombat(playerid, username[]);
forward FinishSavingPlayerCombat(playerid, username[], query[]);