#pragma compat 1

#include <a_samp>
#include <a_mysql>
#include <bcrypt>
#include <Pawn.CMD>
#include <sscanf2>

/*
	MySQL VARIABLE
*/
new MySQL:mysql;

/* 
	PLAYERS VAR
*/
new playerLogged[MAX_PLAYERS];
new loginTries[MAX_PLAYERS];

/*
 Modules in: /gamemodes/modules/
*/
#include "../utils/utils.pwn"
#include "modules/mysql/main.pwn"
#include "modules/players/player.pwn"
#include "modules/messages/message.pwn"


main()
{
	print("\n----------------------------------");
	print(" tenha um bom dia!");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	ShowPlayerMarkers(0);
	DisableInteriorEnterExits();
	UsePlayerPedAnims();
	ConnectDatabase(SIGLA);
	SetTimerEx("SendAutoMessageToAll", AUTO_MESSAGE_TIME, 1, "");
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 2051.9111,795.6282,62.0097);
	SetPlayerCameraPos(playerid, 2051.9111,795.6282,62.0097);
	SetPlayerCameraLookAt(playerid, 2051.9111,795.6282,62.0097);
	return 1;
}

public OnPlayerConnect(playerid)
{
	playerLogged[playerid] = 0;
	loginTries[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(playerLogged[playerid]) {
		SavingPlayerInfo(playerid);
		SavingPlayerCombat(playerid, GetNick(playerid));
		playerLogged[playerid] = 0;
		loginTries[playerid] = 0;

		if(PlayerAdmin[playerid][LEVEL]) {
			SavingPlayerAdmin(playerid);
			return 1;
		}
		return 1;
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	LoadInfo(playerid);
	if(playerLogged[playerid]) {
		LoadPlayerAdmin(playerid);
		LoadPlayerCombat(playerid);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	PlayerDeathMessage(playerid, killerid);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags) {
	if(!playerLogged[playerid]) {
		SendClientMessage(playerid, COLOR_ERR, "Voce precisa estar logado para usar comandos.");
		return 0;
	}
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
  if (result == -1)
  {
    SendClientMessage(playerid, COLOR_ERR, "Este Comando nao existe.");
    return 0;
  }

  return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	if(ForbiddenDamageWithWeapon(playerid, weaponid))
		{
			new Float:x, Float:y, Float:z;
			ResetPlayerWeapons(playerid);
			GetPlayerPos(playerid, x,y,z);
			SetPlayerPos(playerid, x,y,z+20);
			SetPlayerHealth(damagedid, 100.0);
			return 0;
		}
	return 1;
}