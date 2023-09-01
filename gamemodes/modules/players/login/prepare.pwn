#include <YSI_Coding\y_hooks>

#include "modules/players/mc_info/main.pwn"
#include "modules/players/login/forwards.pwn"
#include "modules/players/login/register.pwn"
#include "modules/players/login/login.pwn"

public PrepareAccountCheck(playerid) {
	new query[128];
	mysql_format(mysql,query, sizeof(query), "SELECT COUNT(*) FROM `accounts` WHERE pUsername = '%s'", GetNick(playerid));
	mysql_pquery(mysql, query, "FinishAccountCheck", "i", playerid);
}

public FinishAccountCheck(playerid) {
	new isPlayer, title[256], desc[256];
	cache_get_value_index_int(0, 0, isPlayer);

	if(isPlayer) {
		format(title, 64, "Bem-vindo de volta %s", GetNick(playerid));
		format(desc, 64, "digite sua senha para logar na conta: %s", GetNick(playerid));
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, title, desc, "Logar", "");
		return 1;
	}

	format(title, 64, "Bem-vindo %s", GetNick(playerid));
	format(desc, 64, "digite sua senha para registrar: %s", GetNick(playerid));
	ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, title, desc, "Registrar", "");
	return 1;
}

