#define SIGLA "FTB"
#define BCRYPT_COST 12
#define AUTO_MESSAGE_TIME 300000 // 300.000 = 5m




/*
 MYSQL
*/
#include "../utils/max_values.pwn"
#include "../utils/initial_values.pwn"
#include "../utils/mysql.pwn"
#include "../utils/colors.pwn"
#include "../utils/dialog.pwn"

/*
	AUXILIAR stocks
*/
stock GetNick(playerid) {
	new name[24];
	GetPlayerName(playerid, name, 24);
	return name;
}

forward SpawnPlayerIn(playerid);
forward SetPlayerRandSpawn(playerid);

public SpawnPlayerIn(playerid) {
	TogglePlayerSpectating(playerid, false);
	SetSpawnInfo(playerid, 0, 0, 2046.0411,863.4160,6.7345,0.9833, 0, 0, 0, 0, 0,0);
	SpawnPlayer(playerid);
	SetPlayerRandSpawn(playerid);
	return 1;
}
public SetPlayerRandSpawn(playerid) {
	new Float:spawn[][4] = {
		{2046.0411,863.4160,6.7345,0.9833},
		{1456.9958,2384.6772,10.8203,17.6334},
		{1824.2128,975.8451,8.4649,171.0574},
		{1654.6965,-1051.6921,23.8984,78.8288}
	};

	new rand = random(sizeof(spawn));

	SetPlayerPos(playerid, spawn[rand][0], spawn[rand][1], spawn[rand][2]);
	SetPlayerFacingAngle(playerid, spawn[rand][3]);

	return 1;
}