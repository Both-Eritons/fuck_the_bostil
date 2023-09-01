#include <YSI_Coding\y_hooks>


#include "modules/players/login/prepare.pwn"
#include "modules/admins/main.pwn"
#include "modules/players/cmds/main.pwn"
#include "modules/players/combat/main.pwn"
#include "modules/players/events/utils.pwn"

hook OnPlayerConnect(playerid)
{
	TogglePlayerSpectating(playerid, true);
	new str[128];
	format(str, sizeof str, "{F00E0E}[%s] {FFFFFF} Welcome to the mato {1CDC1C}%s", SIGLA, GetNick(playerid));
	SendClientMessage(playerid, COLOR_SUCCESS, str);
	PrepareAccountCheck(playerid);
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	if(dialogid == DIALOG_TELEPORTS) {
		TeleportDialogResponse(playerid, response, listitem);
	}
	if(dialogid == DIALOG_REGISTER) {
		PrepareRegister(playerid, GetNick(playerid), inputtext);
	}

	if(dialogid == DIALOG_LOGIN){
		PrepareLogin(playerid, inputtext);
	}
	
	return 1;
}

hook OnPlayerText(playerid, text[]) {
	if(!playerLogged[playerid]) {
		SendClientMessage(playerid, COLOR_ERR, "Voce nao tem permissão.");
		return 0;
	}

	return 1;
}

/*hook OnPlayerDisconnect(playerid, reason) {
	if(playerLogged[playerid]) {
		SavingPlayerInfo(playerid);
		return 1;
	}

	return 1;
}*/