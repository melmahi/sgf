with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;
with ada.float_text_io; use ada.float_text_io;
with p_sys; use p_sys;
with p_arbren;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_Io, Ada.Integer_Text_Io, Ada.Strings.Unbounded,
Ada.Strings.Unbounded.Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io, Ada.Strings.Unbounded,
Ada.Strings.Unbounded.Text_Io;

procedure sgf is
use  p_arbren_test;


-----------------------------------------------------------------------
-- Declarations des variables:
-----------------------------------------------------------------------
-- Entiers pour le menu et le choix
choix, number : integer;
-- Chaines de caracteres illimitee: Choix d'implantation
chaine1: Unbounded_String;
-- Variables dans lesquelles je stockerai des noms de fichiers
-- et de répertoires. kmax = 10 . Voir p_sys.ads
nom_fichier,nomrep, nomfichier, nom: String(1..kmax);
nom_repertoire_destination, nom_repertoire_source: string(1..kmax);
nom_fichier_a_renommer: string(1..kmax);
nouveau_nom, nm_cible: string(1..kmax);
-- Variables dans lesquelles je stockerai le contenu de fichiers
-- cmax est la taille maximale de ce contenu, egale a 100
contenu_fichie:string(1..cmax);
-- Variables dans lesquelles je stockerai l extension de fichiers
ext, ext1 : string(1..emax);
-- chaine recherchee
Chaine_rech:string(1..nmax);
-- Repertoires
v,v1,v2,re: repertoire;
-- arbren
b, h, a0, c, d  : arbren;
repertoire_contenant_fichier: arbren;
a1,a2,e,g,k,l,r,nouveau_repertoire,repertoire_destination,w,ss:arbren;
-- fich
f,ff,f1,f2,f3,f4,f5,f11,f12,f21,f22,f23,f24: fich;
chaine: string:="";
Arb,Arb1,Arb2,Arb3,Arb_Ins,Rep_Courant:Arbren;
L_Rech: Integer; --longueur des differentes chaines de caracteres
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Procedures qui permet de lire une chaine de caractere et de remplir
-- par des espaces si le nombre de caraccteres est inferieur a la 
-- taille maximale
PROCEDURE Lire_Chaine2(Chaine: OUT String ; L_Ch : OUT Integer ; 
L_Max: IN Integer) IS
   BEGIN
      Get_Line(Chaine,L_Ch);
      FOR I IN L_Ch+1..L_Max LOOP
         Chaine(I):=' ';
      END LOOP ;
   END Lire_Chaine2 ;

PROCEDURE Lire_Chaine IS
	Chaine: Unbounded_String;
   BEGIN
      chaine:= get_line;
   END Lire_Chaine ;
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Debut du programme
-----------------------------------------------------------------------
begin
-- creation d un repertoire ne contenant aucun fichier.
re.nom_du_repertoire:="repertoire";
re.fichiers_du_repertoire:=null;
r:=An_creer_feuille(re);

-- creation de l arbre principal surlequel les tests seront effectues
f:= new fichiers;
f1:= new fichiers;
f2:= new fichiers;
f3:= new fichiers;
f4:= new fichiers;
f5:= new fichiers;
f11:= new fichiers;
f12:= new fichiers;
f21:= new fichiers;
f22:= new fichiers;
f23:= new fichiers;
f24:= new fichiers;

-- fichiers
f.all.nom_du_fichier:="document1 ";
f.all.extension:="odt";
f.all.contenu_du_fichier:=" cours sur la programmation imperative "&
"                                                             ";
f.all.suivant:=f1;
f1.all.nom_du_fichier:="document2 ";
f1.all.extension:="doc";
f1.all.contenu_du_fichier:=" cours d algebre lineaire et de topologie"&
"                                                           ";
f1.all.suivant:=f2;
f2.all.nom_du_fichier:="document3 ";
f2.all.extension:="odt";
f2.all.contenu_du_fichier:=" cours d analyse fonctionnelle du besoin"&
" dans le marche                                             ";
f2.all.suivant:=f3;
f3.all.nom_du_fichier:="programme ";
f3.all.extension:="ada";
f3.all.contenu_du_fichier:="with adatextio use ada textio            "&
"  begin    instructions end programme                      ";
f3.all.suivant:=f4;
f4.all.nom_du_fichier:="coursAda  ";
f4.all.extension:="odt";
f4.all.contenu_du_fichier:="Notions sur les pointeurs                "&
"                                                           ";
f4.all.suivant:=f5;
f5.all.nom_du_fichier:="coursOcaml";
f5.all.extension:="odt";
f5.all.contenu_du_fichier:="Notions sur les arbres                   "&
"                                                           ";
f5.all.suivant:=null;



f11.all.nom_du_fichier:="photo1    ";
f11.all.extension:="png";
f11.all.contenu_du_fichier:="ici ma photo                            "&
"                                                            ";
f11.all.suivant:=f12;
f12.all.nom_du_fichier:="photo2    ";
f12.all.extension:="png";
f12.all.contenu_du_fichier:=" paysage                                "&
"                                                            ";
f12.all.suivant:=null;




f21.all.nom_du_fichier:="dounibatma";
f21.all.extension:="mp3";
f21.all.contenu_du_fichier:="Paroles de la chanson ...               "&
"                                                            ";
f21.all.suivant:=f22;
f22.all.nom_du_fichier:="nancyajram";
f22.all.extension:="mp3";
f22.all.contenu_du_fichier:="Paroles de la chanson ...               "&
"                                                            ";
f22.all.suivant:=f23;
f23.all.nom_du_fichier:="amrdiab   ";
f23.all.extension:="mp3";
f23.all.contenu_du_fichier:="Paroles de la chanson ...               "&
"                                                            ";
f23.all.suivant:=f24;
f24.all.nom_du_fichier:="celinedion";
f24.all.extension:="mp3";
f24.all.contenu_du_fichier:="Paroles de la chanson ...               "&
"                                                            ";
f24.all.suivant:=null;

-- repertoires
v.nom_du_repertoire:="racine    ";
v.fichiers_du_repertoire:=f;

v1.nom_du_repertoire:="images    ";
v1.fichiers_du_repertoire:=f11;

v2.nom_du_repertoire:="musique   ";
v2.fichiers_du_repertoire:=f21;

-- relations entre les repertoires
a0:=an_creer_feuille(v);
a1:=an_creer_feuille(v1);
a2:=an_creer_feuille(v2);
an_inserer_fils(a0,a1);
an_inserer_fils(a0,a2);

new_line;
-- affichage de l arbre initialise
an_afficher(a0);

-- menu:
new_line;
put_line("                         menu                       ");
put_line(" 1- Pour creer un fichier dans le répertoire courant ");
put_line(" 2- Pour afficher le contenu d un fichier ");
put_line(" 3- Pour afficher la liste des repertoires et fichiers du repertoire courant ");
put_line(" 4- Pour passer du repertoire courant vers un autres repertoire ");
put_line(" 5- Pour copier un fichier du repertoire courant vers un autre repertoire ");
put_line(" 6- Supprimer un fichier dans le repertoire courant ");
put_line(" 7- Supprimer un repertoire dans le repertoire courant ");
put_line(" 8- Changer le nom d un repertoire dans le repertoire courant ");
put_line(" 9- Changer le nom d un fichier dans le repertoire courant ");
put_line(" 10- Rechercher tous les fichiers du repertoire courant et de ses sous repertoires qui contiennent une chaine de caractere donnee ");
put_line(" 0- Pour sortir du programme ");


loop
new_line;
put(" Veuillez choisir une fonctionnalite parmi celles qui figurent sur le menu ");
get(choix);
	case choix is
		when 0 => Put(" Le programme est desormais ferme, pour le relancer tapez la commande: ./sgf dans votre terminal ");
		-- Pour créer un fichier dans le repertoire courant.
		when 1 => Lire_chaine;
			  put(" Donner le nom du fichier a ajouter taille maximale de 10 caracteres ");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "            ";
			  nom_fichier:=(To_String(chaine1)(1..10));

 			  put(" Donnez le contenu de votre fichier taille maximale de 100 caracteres ");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "                                                                                                    ";
			  contenu_fichie:=(To_String(chaine1)(1..cmax));

			  put(" Donnez l extension du fichier que vous voulez creer ");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "   ";
			  ext:=(To_String(chaine1)(1..emax));

			  put(" Donnez le repertoire dans lequel vous voulez creer le fichier. (Revient a se placer dans le repertoire courant)");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "          ";
			  nm_cible:=(To_String(chaine1)(1..kmax));

			  b:=changer_repertoire(a0,nm_cible);
			  creer_fichier(b,nom_fichier,contenu_fichie,ext);
			  new_line;
			  an_afficher(b);
			  new_line;
				
		when 2 => Lire_chaine;
			  Put(" Quel est le nom du repertoire courant ou vous voulez vous placer? ");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "            ";
			  nomrep:=(To_String(chaine1)(1..10));

			  h:=changer_repertoire(a0,nomrep);

			  Put(" Quel est le nom du fichier pour lequel vous voulez afficher le contenu? ");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "            ";
			  nomfichier:=(To_String(chaine1)(1..10));

 			  Put(" Quel est l'extension du fichier pour lequel vous voulez afficher le contenu? ");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "            ";
			  ext:=(To_String(chaine1)(1..3));

			  ff := recherche_fichier (h, nomfichier,ext);			
		    	  put(contenu_fichier(ff));

		when 3 => Lire_chaine;
			  Put("Quel est le nom de votre repertoire courant ?");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "            ";
			  nomrep:=(To_String(chaine1)(1..10));

			  e:=Changer_repertoire(a0,nomrep);

			  put(" La liste des répertoires et des fichiers du répertoire courant est: ");
		          new_line;
			  afficher_rep_fich(e);
			  new_line;		  

		when 4 => Lire_chaine;
			  put(" Quelle est le nom du repertoire cible que vous voulez atteindre? ");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "            ";
			  nomrep:=(To_String(chaine1)(1..10));
			  c:=changer_repertoire(a0,nomrep);
			  new_line;	
		          An_afficher(c);
		 
			
		when 5 => Lire_chaine;
			put(" Donnez le nom du répertoire contenant le fichier que vous voulez copier. (revient a se placer dans le repertoire courant) ");
 			chaine1:= get_line;
			chaine1:=chaine1 & "            ";
			nom_repertoire_source:=(To_String(chaine1)(1..10));

			put(" Donnez le nom du fichier que vous voulez copier ");
			chaine1:= get_line;
			chaine1:=chaine1 & "            ";
			nom:=(To_String(chaine1)(1..10));

			put("Donnez l extension du fichier que vous vooulez copier");
			chaine1:= get_line;
			chaine1:=chaine1 & "   ";
			ext:=(To_String(chaine1)(1..3));

			put(" Quel est le nom du répertoire ou vous voulez copier le fichier ? ");
			chaine1:= get_line;
			chaine1:=chaine1 & "            ";
			nom_repertoire_destination:=(To_String(chaine1)(1..10));

			repertoire_contenant_fichier:=changer_repertoire(a0, nom_repertoire_source);
			d:=copie_fichier(a0,repertoire_contenant_fichier,nom,nom_repertoire_destination,ext);
			new_line;
			An_afficher(a0);

		when 6 => Lire_chaine;
			Put ("Dans quel répertoire vous voulez supprimer votre fichier?");
			chaine1:= get_line;
			chaine1:=chaine1 & "            ";
			nom:=(To_String(chaine1)(1..10));

    		        c:=changer_repertoire (a0, nom);
       	                Put ("Quel est le nom du fichier que vous souhaitez supprimer ? ");
			chaine1:= get_line;
			chaine1:=chaine1 & "            ";
			nomfichier:=(To_String(chaine1)(1..10));

       	                Put ("Quel est l extension du fichier que vous souhaitez supprimer ? ");
			chaine1:= get_line;
			chaine1:=chaine1 & "   ";
			ext:=(To_String(chaine1)(1..3));


	                supprimer_fichier (c, nomfichier,ext);
	                new_line;
 	                an_afficher(a0);



		when 7 => lire_chaine;
			Put(" Quel est le nom du repertoire ou vous voulez vous placer? (repertoire courant) ");
			chaine1:= get_line;
			chaine1:=chaine1 & "            ";
			nomrep:=(To_String(chaine1)(1..10));

			c:=changer_repertoire(a0,nomrep);

			Put(" Quel est le numero du repertoire que vous voulez supprimer? ");
			get(number);
			Supprimer_repertoire(c,number);
			new_line;
			an_afficher(c);
			new_line;

	
		when 8 => Lire_chaine;
			  Put(" Quel est le nom du repertoire courant? (cad le repertoire pour lequel vous voulez changer de nom) ");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "          ";
			  nomrep:=(To_String(chaine1)(1..10));

			  c:=changer_repertoire(a0,nomrep);

			  put(" Quel le nouveau nom que vous voulez attribuer à ce repertoire ? maximum 10 caracteres ");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "            ";
			  nom:=(To_String(chaine1)(1..10));
			  changer_nom_rep(c,nom);
			  An_Afficher(c);
			  new_line;

		when 9 => Lire_chaine;
			  Put(" Quel est le nom du repertoire dans lequel vous voulez vous placer? ");
 			  chaine1:= get_line;
			  chaine1:=chaine1 & "            ";
			  nomrep:=(To_String(chaine1)(1..10));

			  put( " Quel est le nom du fichier que vous voulez renommer ? " );
			  chaine1:= get_line;
			  chaine1:=chaine1 & "            ";
			  nom_fichier_a_renommer:=(To_String(chaine1)(1..10));

			  put("Quelle est l'extension du fichier que vous voulez renommer");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "   ";
			  ext:=(To_String(chaine1)(1..3));

			  put( " Quel est le nouveau nom que vous voulez donner a ce fichier ? " );
			  chaine1:= get_line;
			  chaine1:=chaine1 & "            ";
			  nouveau_nom:=(To_String(chaine1)(1..10));

			  put("nouvelle extension");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "   ";
			  ext1:=(To_String(chaine1)(1..3));

			  renommer_fichier (a0,nomrep,nom_fichier_a_renommer,nouveau_nom,ext, ext1);
			  An_Afficher(a0);
			  new_line;


		when 10 => Lire_chaine;
			  put(" Quel est le nom du repertoire dans lequel vous voulez vous placez afin de chercher un certain contenu ");
			  chaine1:= get_line;
			  chaine1:=chaine1 & "          ";
			  nomrep:=(To_String(chaine1)(1..10));
			  c:=changer_repertoire(a0,nomrep);
			  put_line(" Quelle est la chaine que vous cherchez ");
			  Lire_Chaine2(Chaine_Rech,L_Rech,Nmax);
			  put_line("La liste des fichiers contenant cette chaine de caracteres est ");
                          Recherche_Fichiers(c,Chaine_Rech,L_Rech);

		when others => put_line(" Faites un autre choix qui figure sur le menu ");
	end case;

exit when choix=0; 
end loop;

end sgf;
