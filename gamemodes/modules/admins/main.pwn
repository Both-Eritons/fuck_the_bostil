#include "modules/admins/header.pwn"


public LoadPlayerAdmin(playerid) {
	new query[256];
	mysql_format(mysql, query, sizeof(query), "SELECT * from playeradmin WHERE pUsername = '%s'", GetNick(playerid));
	mysql_pquery(mysql, query, "ContinueLoadPlayerAdmin", "i", playerid);
}

public ContinueLoadPlayerAdmin(playerid) {
	if(!cache_num_rows()) {
		//todo anything...
		return 0;
	}
	new str[128];
	cache_get_value_index_int(0, 0, PlayerAdmin[playerid][USERNAME]);
	//cache_get_value_index_int(0, 1, PlayerAdmin[playerid][SKIN]);
	cache_get_value_index_int(0, 1, PlayerAdmin[playerid][LEVEL]);
	//cache_get_value_index_int(0, 3, PlayerAdmin[playerid][CARGO]);
	format(str, sizeof(str), "o ADMINISTRADOR {FF0000}%s[%d] {FFFFFF} entrou no {FF0000}servidor.", GetNick(playerid), playerid);
	SendClientMessageToAll(-1, str);
	format(str, sizeof(str),"seja bem-vindo, {FF0000} Administrador level {FFFFFF}%i", PlayerAdmin[playerid][LEVEL]);
	SendClientMessage(playerid, -1, str);
	//LoadPlayerAdminInfos(playerid);
	return 1;
}


/*public LoadPlayerAdminInfos(playerid) {
	return 1;
}*/
public CreatePlayerAdmin(playerid, username[]) {
	new query[400];
	if(!PlayerAdmin[playerid][LEVEL]) return 0;
	mysql_format(mysql, query, sizeof(query), "INSERT INTO playeradmin(pUsername, pAdminLevel) SELECT * FROM (SELECT '%s', '%i') AS tmp WHERE NOT EXISTS (SELECT pUsername FROM playeradmin WHERE pUsername = '%s')",
		username, PlayerAdmin[playerid][LEVEL], username);
	mysql_pquery(mysql, query);
	printf("--------------------[ CRIANDO ADMIN ]-------------------------");
	printf("o player %s[%i] era admin e foi inserido no banco de dados.", username, playerid);
	//printf("%s", query);
	printf("--------------------[ FIM CRIANDO ADMIN ]-------------------------");
	return 1;
}
public SavingPlayerAdmin(playerid) {
	new query[256];
	mysql_format(mysql, query, sizeof(query), "UPDATE playeradmin SET pUsername = '%s', pAdminLevel = '%i' WHERE pUsername = '%s'",
		GetNick(playerid), PlayerAdmin[playerid][LEVEL], GetNick(playerid));
	mysql_pquery(mysql, query, "FinishSavingPlayerAdmin", "iss", playerid, GetNick(playerid), query);
	return 1;
}
public FinishSavingPlayerAdmin(playerid, username[], query[]) {
	if(cache_affected_rows()) return 1;
	printf("erro ao salvar player admin %s [modules/admins/main.pwn] \n query: %s", GetNick(playerid), query);
	CreatePlayerAdmin(playerid, username);
	return 0;
}
CMD:admin(playerid, params[])
{
	PlayerAdmin[playerid][LEVEL]++;
	return 1;
}

CMD:level(playerid, params[])
{
	new str[128];
	format(str, sizeof(str), "level de admin: %i", PlayerAdmin[playerid][LEVEL]);
	SendClientMessage(playerid, -1, str);
	return 1;
}
CMD:trabalhar(playerid, params[])
{
	
	if(PlayerAdmin[playerid][LEVEL] < 1) return SendClientMessage(playerid, -1, "voce precisa ser admin");
	PlayerAdmin[playerid][WORKING] = !PlayerAdmin[playerid][WORKING];
	new str[128];
	if(PlayerAdmin[playerid][WORKING]) {
		format(str, sizeof(str), "o admin {FF0000}%s[%i] {FFFFFF}entrou em modo {1CDC1C}trabalho.", GetNick(playerid), playerid);
		SendClientMessageToAll(-1, str);
		//LoadPlayerAdminInfos(playerid);
	}
	else{
		format(str, sizeof(str), "o admin {FF0000}%s[%i] {FFFFFF}Saiu em modo {1CDC1C}trabalho.", GetNick(playerid), playerid);
		SendClientMessageToAll(-1, str);
		//LoadPlayerAdminInfos(playerid);
	}
	return 1;
}