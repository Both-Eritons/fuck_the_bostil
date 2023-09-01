forward ConnectDatabase(const sigla[]);
public ConnectDatabase(const sigla[]) {
	new MySQLOpt:option_id = mysql_init_options();
	mysql_set_option(option_id, AUTO_RECONNECT, true);
	mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB, option_id);

	printf("[%s] TENTANDO se conectar ao database: %s ...", sigla, MYSQL_DB);

	if(mysql_errno(mysql)) {

		printf("[%s] FALHA ao tentar conectar ao mysql", sigla);
		SendRconCommand("exit");
	}
	 else printf("[%s] SUCESSO ao conectar ao MYSQL", sigla);
}