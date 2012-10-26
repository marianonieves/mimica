package data
{
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class DataManager
	{
		//
		// SIMPLE QUERIES
		//
		public const Q_GET_ALL_MOVIES:String = "SELECT * FROM movies";
		public const Q_GET_ALL_DIFFERENT_GENRES:String = "SELECT DISTINCT genres FROM movies";
		public const Q_GET_RANDOM_MOVIE:String = "SELECT * FROM movies ORDER BY RANDOM() LIMIT 1";
		public const Q_GET_ALL_TEAMS:String = "SELECT * FROM teams";
		public const Q_GET_ALL_PLAYERS:String = "SELECT * FROM players";
				
		//
		// COMPOSED QUERIES, eg: doSQLcall(Q_GET_ALL_PLAYERS_BY_TEAM_ID,{teamId:1});
		//
		public const Q_GET_ALL_PLAYERS_BY_TEAM_ID:String = "SELECT * FROM players WHERE teamId = <teamId>";
		public const Q_ADD_NEW_MOVIE:String = "INSERT INTO Movies (title_es,title_en,genres,year,code_imdb) VALUES ('<title_es>', '<title_en>', '<genres>', '<year>', '<code_imdb>')";

		// Singleton instance.
		protected static var instance:DataManager;
		public function DataManager(enforcer:AccessRestriction)
		{
			if (enforcer == null)
				throw new Error("Error enforcer input param is undefined" );
		}
		
		/**
		 * Method function to retrieve instance of the class
		 *  
		 * @return The same instance of the class
		 * 
		 */
		public static function getInstance():DataManager
		{
			if( instance == null )
				instance = new  DataManager(new AccessRestriction());
			
			return instance;
		}
				
		public function initialize(callback:Function):void
		{
			SQLiteManager.getInstance().initialize(callback);
		}
		
		public function getRandomMovie(callback:Function):void
		{
			SQLiteManager.getInstance().doSQLcall(Q_GET_RANDOM_MOVIE,null,callback);
		}

/*
		*****
		** CODE TO ADD MORE CONTENT
		*****
		nextMovieFromRaw();
		
		private var moviesRaw:Array = ["tt0111161;The Shawshank Redemption;Sueños de libertad;1994","tt0068646;The Godfather;El padrino;1972","tt0071562;The Godfather: Part II;El padrino II;1974","tt0110912;Pulp Fiction;Tiempos Violents;1994","tt0060196;The Good,the Bad and the Ugly;El bueno, el malo y el feo;1966","tt0050083;12 Angry Men;Doce hombres en pugna;1957","tt0108052;Schindler&#x27;s List;La lista de Schindler;1993","tt0468569;The Dark Knight;Batman - El caballero de la noche;2008","tt0167260;The Lord of the Rings: The Return of the King;El señor de los anillos: El retorno del rey;2003","tt0137523;Fight Club;El club de la pelea;1999","tt0080684;Star Wars: Episode V - The Empire Strikes Back;El imperio contraataca;1980","tt0073486;One Flew Over the Cuckoo&#x27;s Nest;Atrapado sin salida;1975","tt0120737;The Lord of the Rings: The Fellowship of the Ring;El señor de los anillos: La comunidad del anillo;2001","tt1375666;Inception;El origen;2010","tt0099685;Goodfellas;Buenos muchachos;1990","tt0076759;Star Wars;La guerra de las galaxias;1977","tt0047478;Seven Samurai;Los siete samuráis;1954","tt0133093;The Matrix;Matrix;1999","tt0109830;Forrest Gump;Forrest Gump;1994","tt0317248;City of God;Ciudad de Dios;2002","tt0167261;The Lord of the Rings: The Two Towers;El señor de los anillos: Las dos torres;2002","tt0064116;Once Upon a Time in the West;Érase una vez en el Oeste;1968","tt0034583;Casablanca;Casablanca;1942","tt0114369;Se7en;Pecados capitales;1995","tt0102926;The Silence of the Lambs;El silencio de los inocentes;1991","tt0082971;Raiders of the Lost Ark;Los cazadores del arca perdida;1981","tt0114814;The Usual Suspects;Los sospechosos de siempre;1995","tt0047396;Rear Window;La ventana indiscreta;1954","tt1345836;The Dark Knight Rises;Batman: El caballero de la noche asciende;2012","tt0054215;Psycho;Psicosis;1960","tt0038650;It&#x27;s a Wonderful Life;Que bella vida;1946","tt0110413;L&#xE9;on: The Professional;El perfecto asesino;1994","tt0043014;Sunset Blvd.;El ocaso de una vida;1950","tt0209144;Memento;Memento, recuerdos de un crimen;2000","tt0120586;American History X;América X;1998","tt0078788;Apocalypse Now;Apocalipsis now;1979","tt0103064;Terminator 2: Judgment Day;Terminator 2: el juicio final;1991","tt0057012;Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb;Dr. Insólito o: Como aprendí a dejar de preocuparme y amar la bomba;1964","tt0120815;Saving Private Ryan;Rescatando al soldado Ryan;1998","tt0078748;Alien;Alien - El octavo pasajero;1979","tt0053125;North by Northwest;Intriga internacional;1959","tt0021749;City Lights;Luces de la ciudad;1931","tt0245429;Spirited Away;El viaje de Chihiro;2001","tt0033467;Citizen Kane;El ciudadano;1941","tt0081505;The Shining;El resplandor;1980","tt0027977;Modern Times;Tiempos modernos;1936","tt0169547;American Beauty;Belleza Americana;1999","tt0052357;Vertigo;Vértigo;1958","tt0075314;Taxi Driver;Taxi Driver;1976","tt0088763;Back to the Future;Volver al futuro;1985","tt0253474;The Pianist;El pianista;2002","tt0407887;The Departed;Los infiltrados;2006","tt0022100;M;El vampiro negro;1931","tt0435761;Toy Story 3;Toy Story 3;2010","tt0050825;Paths of Glory;La patrulla infernal;1957","tt0036775;Double Indemnity;Pacto de sangre;1944","tt0090605;Aliens;Aliens: El regreso;1986","tt0118799;Life Is Beautiful;La vida es bella;1997","tt0910970;WALL&#xB7;E;WALL&#xB7;E;2008","tt0405094;The Lives of Others;La vida de los otros;2006","tt0066921;A Clockwork Orange;La naranja mecánica;1971","tt0211915;Am&#xE9;lie;Amélie;2001","tt0172495;Gladiator;Gladiador;2000","tt0056592;To Kill a Mockingbird;Matar a un ruiseñor;1962","tt0056172;Lawrence of Arabia;Lawrence de Arabia;1962","tt0120689;The Green Mile;Milagros inesperados;1999","tt0482571;The Prestige;El gran truco;2006","tt0032553;The Great Dictator;El gran dictador;1940","tt0105236;Reservoir Dogs;Perros de la calle;1992","tt1675434;The Intouchables;Amigos intocables;2011","tt0082096;Das Boot;El barco;1981","tt0180093;Requiem for a Dream;Réquiem para un sueño;2000","tt0041959;The Third Man;El tercer hombre;1949","tt0338013;Eternal Sunshine of the Spotless Mind;Eterno resplandor de una mente sin recuerdos;2004","tt0040897;The Treasure of the Sierra Madre;El tesoro de la Sierra Madre;1948","tt0095765;Cinema Paradiso;Cinema Paradiso;1988","tt0071315;Chinatown;Barrio chino;1974","tt0087843;Once Upon a Time in America;Érase una vez en América;1984","tt0119488;L.A. Confidential;Los Ángeles al desnudo;1997","tt0093058;Full Metal Jacket;Nacido para matar;1987","tt0086190;Star Wars: Episode VI - Return of the Jedi;El regreso del Jedi;1983","tt0110357;The Lion King;El rey león;1994","tt0071853;Monty Python and the Holy Grail;Los caballeros de la mesa cuadrada;1975","tt0112573;Braveheart;Corazón valiente;1995","tt0045152;Singin&#x27; in the Rain;Cantando bajo la lluvia;1952","tt0053291;Some Like It Hot;Una Eva y dos Adanes;1959","tt0364569;Oldboy;Oldboy: Cinco días para vengars;2003","tt0086879;Amadeus;Amadeus;1984","tt0017136;Metropolis;Metrópolis;1927","tt0042876;Rashomon;Rashomon;1950","tt0040522;Bicycle Thieves;Ladrones de bicicletas;1948","tt0105695;Unforgiven;Los imperdonables;1992","tt0042192;All About Eve;La malvada;1950","tt0062622;2001: A Space Odyssey;2001: Odisea del espacio;1968","tt0053604;The Apartment;Piso de soltero;1960","tt0081398;Raging Bull;Toro salvaje;1980","tt0097576;Indiana Jones and the Last Crusade;Indiana Jones y la última cruzada;1989","tt0050212;The Bridge on the River Kwai;El puente sobre el río Kwai;1957","tt0070735;The Sting;El golpe;1973","tt0119698;Princess Mononoke;La princesa Mononoke;1997","tt1832382;A Separation;La separación;2011","tt0095016;Die Hard;Duro de matar;1988","tt0457430;Pan&#x27;s Labyrinth;El laberinto del fauno;2006","tt0051201;Witness for the Prosecution;Testigo de cargo;1957","tt0372784;Batman Begins;Batman inicia;2005","tt0363163;Downfall;La caída;2004","tt0095327;Grave of the Fireflies;La tumba de las luciérnagas;1988","tt0031679;Mr. Smith Goes to Washington;Caballero sin espada;1939","tt0057115;The Great Escape;El gran escape;1963","tt0055630;Yojimbo;Yojimbo;1961","tt0059578;For a Few Dollars More;Por unos pocos dólares más;1965","tt0361748;Inglourious Basterds;Bastardos sin gloria;2009","tt0208092;Snatch.;Cerdos y diamantes;2000","tt1049413;Up;Up - Una aventura de altura;2009","tt0080678;The Elephant Man;El hombre elefante;1980","tt0047296;On the Waterfront;Nido de ratas;1954","tt0848228;The Avengers;The Avengers: Los Vengadores;2012","tt0050976;The Seventh Seal;El séptimo sello;1957","tt0033870;The Maltese Falcon;El halcón maltés;1941","tt0113277;Heat;Fuego contra fuego;1995","tt0114709;Toy Story;Toy story;1995","tt0017925;The General;El general;1926","tt1205489;Gran Torino;Gran Torino;2008","tt0032976;Rebecca;Rebeca, una mujer inolvidable;1940","tt0083658;Blade Runner;Blade Runner;1982","tt0050986;Wild Strawberries;Cuando huye el día;1957","tt0116282;Fargo;Fargo;1996","tt0012349;The Kid;El chico;1921","tt0052311;Touch of Evil;Sed de mal;1958","tt0118715;The Big Lebowski;El gran Lebowski;1998","tt0086250;Scarface;Caracortada;1983","tt0089881;Ran;Ran;1985","tt0077416;The Deer Hunter;El Francotirador;1978","tt0061512;Cool Hand Luke;La leyenda del indomable;1967","tt0401792;Sin City;La ciudad del pecado;2005","tt0044079;Strangers on a Train;Extraños en el tren;1951","tt0015864;The Gold Rush;La quimera del oro;1925","tt0073195;Jaws;Tiburón;1975","tt0477348;No Country for Old Men;Sin lugar para los débiles;2007","tt0025316;It Happened One Night;Lo que sucedió aquella noche;1934","tt0395169;Hotel Rwanda;Hotel Rwanda;2004","tt0044706;High Noon;A la hora señalada;1952","tt0120735;Lock,Stock and Two Smoking Barrels;Juegos, trampas y dos armas humeantes;1998","tt0167404;The Sixth Sense;El sexto sentido;1999","tt0091763;Platoon;Pelotón;1986","tt0084787;The Thing;La cosa;1982","tt0064115;Butch Cassidy and the Sundance Kid;Butch Cassidy and the Sundance Kid;1969","tt0032138;The Wizard of Oz;El mago de Oz;1939","tt0117951;Trainspotting;Trainspotting;1996","tt0112641;Casino;Casino;1995","tt0266697;Kill Bill: Vol. 1;Kill Bill, la venganza: Volumen I;2003","tt1291584;Warrior;La última pelea;2011/I","tt0038787;Notorious;Tuyo es mi corazón;1946","tt0075686;Annie Hall;Dos extraños amantes;1977","tt1305806;The Secret in Their Eyes;El secreto de sus ojos;2009","tt1504320;The King&#x27;s Speech;El discurso del rey;2010","tt0031381;Gone with the Wind;Lo que el viento se llevó;1939","tt0032551;The Grapes of Wrath;Viñas de ira;1940","tt0758758;Into the Wild;Hacia rutas salvajes;2007","tt0119217;Good Will Hunting;En busca del destino;1997","tt0079470;Life of Brian;La vida de Brian;1979","tt0266543;Finding Nemo;Buscando a Nemo;2003","tt0892769;How to Train Your Dragon;Cómo entrenar a tu dragón;2010","tt0947798;Black Swan;El cisne;2010","tt0434409;V for Vendetta;V de venganza;2005","tt0038355;The Big Sleep;Al borde del abismo;1946","tt0096283;My Neighbor Totoro;Mi vecino Totoro;1988","tt0052618;Ben-Hur;Ben-Hur;1959","tt0046912;Dial M for Murder;La llamada fatal;1954","tt0088247;The Terminator;Terminator;1984","tt0074958;Network;Poder que mata;1976","tt0246578;Donnie Darko;Donnie Darko;2001","tt0405159;Million Dollar Baby;Million Dollar Baby;2004","tt0048424;The Night of the Hunter;La noche del cazador;1955","tt0092005;Stand by Me;Cuenta conmigo;1986","tt0469494;There Will Be Blood;Petróleo sangriento;2007","tt0107048;Groundhog Day;Hechizo del tiempo;1993","tt0072890;Dog Day Afternoon;Tarde de perros;1975","tt0114746;Twelve Monkeys;12 monos;1995","tt0245712;Amores Perros;Amores Perros;2000","tt0440963;The Bourne Ultimatum;Bourne: El ultimátum;2007","tt0061722;The Graduate;El graduado;1967","tt1655442;The Artist;El artista;2011/I","tt0978762;Mary and Max;Mary and Max;2009","tt0053198;The 400 Blows;Los 400 golpes;1959","tt0083987;Gandhi;Gandhi;1982","tt0060827;Persona;Persona;1966","tt0049406;The Killing;Casta de malditos;1956","tt1010048;Slumdog Millionaire;Slumdog millionaire - ¿Quién quiere ser millonario?;2008","tt0056801;8&#xBD;;Fellini 8½;1963","tt0093779;The Princess Bride;La princesa prometida;1987","tt0347149;Howl&#x27;s Moving Castle;El increíble castillo vagabundo;2004","tt0061184;Who&#x27;s Afraid of Virginia Woolf?;¿Quién le teme a Virginia Woolf?;1966","tt0056218;The Manchurian Candidate;El embajador del miedo;1962","tt0047528;La Strada;La strada;1954","tt0054997;The Hustler;El audaz;1961","tt0065214;The Wild Bunch;La pandilla salvaje;1969","tt0075148;Rocky;Rocky;1976","tt0268978;A Beautiful Mind;Una mente brillante;2001","tt0046359;Stalag 17;Traidor en el infierno;1953","tt0052561;Anatomy of a Murder;Anatomía de un asesinato;1959","tt0070047;The Exorcist;El exorcista;1973","tt1136608;District 9;Sector 9;2009","tt0072684;Barry Lyndon;Barry Lyndon;1975","tt0040746;Rope;La soga;1948","tt0056217;The Man Who Shot Liberty Valance;Un tiro en la noche;1962","tt0079944;Stalker;La zona;1979","tt0382932;Ratatouille;Ratatouille;2007","tt0338564;Infernal Affairs;Asuntos infernales;2002","tt0046250;Roman Holiday;La princesa que quería vivir;1953","tt0120382;The Truman Show;The Truman Show;1998","tt0401383;The Diving Bell and the Butterfly;La escafandra y la mariposa;2007","tt1220719;Ip Man;Ip Man;2008","tt0325980;Pirates of the Caribbean: The Curse of the Black Pearl;La maldición del Perla Negra;2003","tt1201607;Harry Potter and the Deathly Hallows: Part 2;Harry Potter y las reliquias de la muerte - Parte 2;2011","tt0044081;A Streetcar Named Desire;Un tranvía llamado deseo;1951","tt0058461;A Fistful of Dollars;Por un puñado de dólares;1964","tt0796366;Star Trek;Star Trek - El futuro comienza;2009","tt1125849;The Wrestler;El luchador;2008","tt0198781;Monsters;Inc.;Monsters, Inc.;2001","tt0063522;Rosemary&#x27;s Baby;El bebé de Rosemary;1968","tt0101414;Beauty and the Beast;La bella y la bestia;1991","tt0042546;Harvey;El invisible Harvey;1950","tt0107207;In the Name of the Father;En el nombre del padre;1993","tt0087544;Nausica&#xE4; of the Valley of the Wind;Nausicaä del Valle del Viento;1984","tt0029947;Bringing Up Baby;La adorable revoltosa;1938","tt0020629;All Quiet on the Western Front;Sin novedad en el frente;1930","tt0113247;La Haine;El odio;1995","tt0374546;Spring;Summer;Fall;Winter... and Spring;Primavera, verano, otoño, invierno... y otra vez primavera;2003","tt0095953;Rain Man;Rain Man;1988","tt0079522;Manhattan;Manhattan;1979","tt0013442;Nosferatu;Nosferatu;1922","tt1130884;Shutter Island;La isla siniestra;2010","tt0036342;Shadow of a Doubt;La sombra de una duda;1943","tt0327056;Mystic River;Río místico;2003","tt1139797;Let the Right One In;Criatura de la noche;2008","tt0319061;Big Fish;El gran pez;2003","tt0092067;Castle in the Sky;El castillo en el cielo;1986","tt0061811;In the Heat of the Night;Al calor de la noche;1967","tt0107688;The Nightmare Before Christmas;El extraño mundo de Jack;1993","tt0094226;The Untouchables;Los intocables;1987","tt0036613;Arsenic and Old Lace;Arsénico y encaje antiguo;1944","tt0070511;Papillon;Papillon;1973","tt0049730;The Searchers;Más corazón que odio;1956","tt0107290;Jurassic Park;Jurassic Park;1993","tt0118694;In the Mood for Love;Con ánimo de amar;2000","tt0053221;Rio Bravo;Río Bravo;1959","tt0024216;King Kong;King Kong;1933","tt1187043;3 Idiots;tres idiotas;2009","tt0053779;La Dolce Vita;La dolce vita;1960"]
		private var counterRaw:int=-1;
		private var recordMovie:Object;
		private var record_temp:Array;
			
		public function nextMovieFromRaw(o:*=null):void
		{
			counterRaw++;
			
			record_temp = String(moviesRaw[counterRaw]).split(";");
			
			recordMovie = {
				code_imdb:record_temp[0],
				title_en:record_temp[1],
				title_es:record_temp[2],
				genres:"N/A",
				year:record_temp[3]
			}
			
			SQLiteManager.getInstance().doSQLcall(Q_ADD_NEW_MOVIE,recordMovie,nextMovieFromRaw);
		}
*/
		
	}
}

class AccessRestriction {}