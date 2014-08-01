with text_io; use text_io;
with p_arbren;
 


procedure test_p_arbren is

procedure ecrire_int ( a: in integer);
function egalite_int(a: in integer; b: in integer) return boolean;
-- instanciation du paquetage arbre_nr

package test1 is new p_arbren(integer,ecrire_int,egalite_int);
use test1;
package entier is new integer_io(integer);
use entier;

-- la procedure ecrire_int:
procedure ecrire_int(a: in integer) is

begin
put("|--------");put(a,2);
end ecrire_int;

function egalite_int(a: in integer; b: in integer) return boolean is
begin
return (a=b);
end egalite_int;





a0:arbren;
a: arbren;
b:arbren;
d: arbren;
a1: arbren;
a2: arbren;
a11:arbren;
a12: arbren;
a21:arbren;
a22: arbren;
b1: arbren;
b2: arbren;
b11:arbren;
b12: arbren;
b21:arbren;
b22: arbren;

d1: arbren;
d2: arbren;
d11:arbren;
d12: arbren;
d21:arbren;
d22: arbren;

c:arbren;





choix: integer;
element: integer;
number: integer;
elementachercher: integer;
nouveau: integer;
numerofils: integer;
numerofrere: integer;

begin
a0:=An_Creer_Feuille(0); 
a:=An_Creer_Feuille(3); 
b:=An_Creer_Feuille(7); 
d:=An_Creer_Feuille(15); 

a1:=An_Creer_Feuille(5); 
a2:=An_Creer_Feuille(17);
a11:=An_Creer_Feuille(6); 
a12:=An_Creer_Feuille(18); 
a21:=An_Creer_Feuille(32); 
a22:=An_Creer_Feuille(77); 


b1:=An_Creer_Feuille(74); 
b2:=An_Creer_Feuille(94);
b11:=An_Creer_Feuille(12); 
b12:=An_Creer_Feuille(1); 
b21:=An_Creer_Feuille(2); 
b22:=An_Creer_Feuille(87); 

d1:=An_Creer_Feuille(9); 
d2:=An_Creer_Feuille(67);
d11:=An_Creer_Feuille(15); 
d12:=An_Creer_Feuille(18); 
d21:=An_Creer_Feuille(12); 
d22:=An_Creer_Feuille(27); 


An_Inserer_Fils (a0,a);
An_Inserer_Fils (a0,b);
An_Inserer_Fils (a0,d);

An_Inserer_Fils (a,a1);
An_Inserer_Fils (a,a2);
An_Inserer_Fils (b,b1);
An_Inserer_Fils (b,b2);
An_Inserer_Fils (d,d1);
An_Inserer_Fils (d,d2);


An_Inserer_Fils (a1,a11);
An_Inserer_Fils (a1,a12);
An_Inserer_Fils (a2,a21);
An_Inserer_Fils (a2,a22);
An_Inserer_Fils (b1,b11);
An_Inserer_Fils (b1,b12);
An_Inserer_Fils (b2,b21);
An_Inserer_Fils (b2,b22);
An_Inserer_Fils (d1,d11);
An_Inserer_Fils (d1,d12);
An_Inserer_Fils (d2,d21);
An_Inserer_Fils (d2,d22);


c:=An_Creer_Feuille(45); 








-----------------------------------------------------------------

An_Afficher(a0);

-- menu:
new_line;
put_line("                         menu                       ");
put_line(" 1- Detecter si un arbre n aire est vide ou pas ");
put_line(" 2- Creer un arbre n aire vide ");
put_line(" 3- Retourner la valeur rangee a la racine d'un arbre  n aire ");
put_line(" 4- Indiquer si un arbre n aire est une feuille (Pas de fils)");
put_line(" 5- Creer un arbre n aire avec une valeur mais sans fils ni frere ni pere ");
put_line(" 6- Retourner l arbre n aire pere d un arbre n aire ");
put_line(" 7- Retourner le n ieme fils de a ");
put_line(" 8- Retourner le n ieme frere d un arbre n aire ");
put_line(" 9- Afficher le contenu complet d'un arbre n aire ");
put_line(" 10- Rechercher la premiere occurence d une valeur dans un arbre n aire ");
put_line(" 11- Indiquer si un arbre n aire est sans pere ");
put_line(" 12- Changer la valeur rangee a la racine d un arbre n aire ");
put_line(" 13- Inserer un arbre n aire sans frere en position de premier fils d un arbre n aire a ");
put_line(" 14- Inserer un arbre n aire sans frere en position de premier fils d un arbre n aire a ");
put_line(" 15- Supprimer le n ieme fils d un arbre n aire ");
put_line(" 16- Supprimer le n ieme frere d un arbre n aire ");
put_line(" 0- Pour sortir du programme ");


loop
new_line;
put(" Veuillez choisir une fonctionnalite parmi celles qui figurent sur le menu ");
get(choix);
	case choix is
		when 0 => Put(" Le programme est desormais ferme, pour le relancer tapez la commande: ./test_p_arbren dans votre terminal ");
		when 1 => if An_Vide(a0) then 
			put(" l arbre est vide ");
			else Put(" l arbre n est pas vide ");
			end if;
			new_line;
		when 2 => An_Afficher(An_Creer_Vide);
			Put(" l'arbre vide est cree ");
			new_line;

		when 3 => Put(" La valeur stockee dans la racine de cet arbre n aire est: ");
			put(An_Valeur(a0),2);
			new_line;

		when 4 => if An_Est_Feuille(a0) then
			 Put(" l arbre est bien une feuille, donc n a pas de fils ");
			 else put(" l'arbre n est pas une feuille, il a par consequent au moins un fils ");
			 end if;
			new_line;

		when 5 => Put(" Quelle est la valeur que vous voulez stocker dans votre arbre n aire (sans fils, ni pere ni frere) ");
			get(element);
			Put(" la feuille que vous voulez representer est: ");
			An_Afficher(An_Creer_Feuille(element));
			new_line;



		when 6 => An_Afficher(An_pere(a0));
			new_line;

		when 7 => Put(" Quel est le numero du fils de l arbre a que vous voulez retourner ");
			  get(number);
			  An_Afficher(An_fils (a0,number));
			  new_line;

		when 8 => Put(" Quel est le numero du frere de l arbre a que vous voulez retourner ");
			  get(number);
			  An_Afficher(An_frere (a,number));
			  new_line;

		when 9 => An_Afficher(a0);

		when 10 => Put(" Quel est l element que vous voulez rechercher dans l arbre? ");
			  get(elementachercher);
			  An_Afficher( An_Rechercher (a0,elementachercher));
			  new_line;

		when 11 => if An_Est_Racine(a0) then Put(" L arbre est sans pere ");
			   else put(" L arbre admet un pere ");
			   new_line;
			   end if;


		when 12 => Put(" Quel est la valeur que vous voulez mettre a la racine de l arbre ");
			   get(nouveau);
			   An_Changer_Valeur (a0,nouveau);
			   An_Afficher(a0);
			   new_line;

		when 13 => Put(" le nouvel arbre obtenu en inserant un arbre en position de premier fils est: ");
			   An_Inserer_Fils (a0,c) ;
			   An_Afficher(a0);
			   new_line;

		when 14 => Put(" le nouvel arbre obtenu en inserant un arbre en position de premier fils est: ");
			   An_Inserer_Frere (a0,c) ;
			   An_Afficher(a0);
			   new_line;

		when 15 => Put(" Quel est le numero du fils que vous voulez supprimer? ");
			   get(numerofils);
			   An_Supprimer_fils (a0,numerofils);
		     	   An_Afficher(a0);
			   new_line;

		when 16 => Put(" Quel est le numero du frere que vous voulez supprimer? ");
			   get(numerofrere);
			   An_Supprimer_frere (a0,numerofrere);
		     	   An_Afficher(a0);
			   new_line;

		when others => put_line(" Faites un autre choix qui figure sur le menu ");
	end case;

exit when choix=0; 
end loop;


end test_p_arbren;
