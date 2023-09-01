
public PrepareRegister(playerid, username[], password[]) {
	if(strlen(password)>MAX_PASSWORD_LEN||strlen(password)==0) {
		SendClientMessage(playerid, COLOR_ERR, "a senha deve ter entre 1 a 20 caracteres.");
		ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_PASSWORD,"senha invalida!","{FFFFFF} A senha deve conter entre entre 1 a 20 caracteres.","Registrar"," ");
		return 1;
	}
	printf("criando a conta: %s[%i]", username, playerid);
	SendClientMessage(playerid, COLOR_SUCCESS, "criando sua conta...");
	bcrypt_hash(password, BCRYPT_COST, "ContinueRegister", "iss", playerid, username, password);
	return 1;
}

public ContinueRegister(playerid, username[], password[]) {
	new query[256], hashPass[BCRYPT_HASH_LENGTH];
	bcrypt_get_hash(hashPass);
	printf("%s %s %s", username, password, hashPass);
	SendClientMessage(playerid, COLOR_SUCCESS, "quase la...");
	mysql_format(mysql,query, sizeof(query), "INSERT INTO `accounts`(`pUsername`, `pPassword`) VALUES ('%s', '%s')", username, hashPass);
	mysql_pquery(mysql, query, "FinishRegister", "i", playerid);
}

public FinishRegister(playerid){
	printf("A conta %s[%d] foi criada com sucesso",GetNick(playerid),playerid);
    SendClientMessage(playerid,COLOR_SUCCESS,"conta criada!");
    PrepareAccountCheck(playerid);
}

