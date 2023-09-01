new Messages[][0] = {
	{"Servidor Sendo criado por {FF0000}Eriton"},
	{"{00FF00}[FTB] {FFFFFF}Use {FF0000} /teleports {FFFFFF}para ir a outros locais."},
	{"Respeite as {FF0000}Minoria{FFFFFF}, mesmo que a {FF0000}maioria{FFFFFF} das {FF0000}minorias nao merecem isso."},
	{"{FF0000}Funk nao eh musica, {FFFFFF}se colocar vai ser {FF0000}proibido {FFFFFF}de usar o comandos de musica."},
	{"{FF0000} Megadeth {FFFFFF} eh melhor que {FF0000}metallica"}
};

stock SendAutoMessageToAll();
public SendAutoMessageToAll() {
	new rand = random(sizeof(Messages));
	SendClientMessageToAll(-1, Messages[rand][0]);
	return 1;
}