//#include "modules/players/cmds/teleport/header.pwn"

new Float:teleports[MAX_TELEPORTS][3] = {
	{1932.7288,-1410.9829,13.570},
	{1916.6799,-1222.7249,18.7051},
	{1371.1453,-915.5679,34.3267},
	{1365.4110,-1278.9141,13.5469}
};
new teleportsName[MAX_TELEPORTS][0] = {
	{"Pista de Skate"},
	{"Park Gleen"},
	{"winehood"},
	{"loja de armas"}

};

CMD:teleports(playerid, params[])
{
	new msg[300];
	for(new i = 0; i < MAX_TELEPORTS; i++) {
		new done[256];
		format(done, sizeof(done), "%s\n", teleportsName[i][0]);
		strcat(msg, done);
	}

	ShowPlayerDialog(playerid, DIALOG_TELEPORTS, DIALOG_STYLE_LIST, "Teleports", msg, "ir", "cancelar");
	return 1;
}

CMD:skate(playerid, params[])
{
	new str[128];
	format(str, sizeof(str), "O Player {D50606}%s[%d] {FFFFFF} foi para a {D50606} %s", GetNick(playerid), playerid, teleportsName[0][0]);
	SendClientMessageToAll(-1, str);
	SetPlayerPos(playerid, teleports[0][0],teleports[0][1], teleports[0][2]);
	return 1;
}


forward TeleportDialogResponse(playerid, response, listitem);
public TeleportDialogResponse(playerid, response, listitem) {
	if(response) {
		new msg[300];
		for(new i = 0; i < MAX_TELEPORTS; i++) {
			new done[256];
			format(done, sizeof(done), "%s\n", teleportsName[i][0]);
			strcat(msg, done);
			if(listitem == i) {
				new str[128];
				format(str, sizeof(str), "O Player {D50606}%s[%d] {FFFFFF} foi para a {D50606} %s", GetNick(playerid), playerid, teleportsName[i][0]);
				SendClientMessageToAll(-1, str);
				SetPlayerPos(playerid, teleports[i][0],teleports[i][1], teleports[i][2]);
			}
		}
	}
}