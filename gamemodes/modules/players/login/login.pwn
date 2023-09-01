
public PrepareLogin(playerid, password[]) {
	new query[BCRYPT_HASH_LENGTH+128];

	SendClientMessage(playerid, -1, "logando...");
	mysql_format(mysql, query, sizeof(query), "SELECT pPassword FROM `accounts` WHERE pUsername = '%s'", GetNick(playerid));
	mysql_pquery(mysql, query, "ContinueLogin", "is", playerid, password);
}

public ContinueLogin(playerid, password[]) {
	new hashPass[150];
	cache_get_value_index(0, 0, hashPass);
	bcrypt_check(password, hashPass, "FinishLogin", "i", playerid);
}

public FinishLogin(playerid) {
	if(bcrypt_is_equal()) {
		SendClientMessage(playerid, COLOR_SUCCESS, "logado!");
		SpawnPlayerIn(playerid);
		playerLogged[playerid] = 1;
		return 1;
	}
	if(loginTries[playerid] >= MAX_LOGIN_TRIES) Kick(playerid);
	loginTries[playerid]++;
	SendClientMessage(playerid, COLOR_ERR, "senha errada, tente novamente");
	ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "senha errada", "tente novamente", "Logar", "");

	return 1;
}