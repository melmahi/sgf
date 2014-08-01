with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;
with ada.float_text_io; use ada.float_text_io;
with p_arbren;

Package body p_sys is

-----------------------------------------------------------------------
procedure lire_chaine(chaine: out string; l_ch: out integer; l_max: 
in integer) is
begin
	Get_line(chaine, l_ch);
	for i in l_ch+1 .. l_max loop
		chaine(i):=' ';
	end loop;
end lire_chaine;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- la procedure ecrire_txt:
procedure ecrire_txt(a: in repertoire) is
a_aux: fich;
decal: integer;
begin
decal:=4;
a_aux:= new fichiers;
put("--------");put(a.nom_du_repertoire);
-- si le repertoire ne contient pas de fichiers.
	if a.fichiers_du_repertoire=null then null;
	else
-- sinon si le repertoire contient des fichiers.
			put(" : ");
-- ecrire le nom du premier fichier
put(a.fichiers_du_repertoire.all.nom_du_fichier);
put(".");
put(a.fichiers_du_repertoire.all.extension);
a_aux:=a.fichiers_du_repertoire.all.suivant;
--ecrire le nom des suivants
while a_aux/=null loop
	put (" / ");
	put(a_aux.all.nom_du_fichier);
	put(".");
	put(a_aux.all.extension);
	a_aux:=a_aux.all.suivant;
end loop;
	end if;
end ecrire_txt;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- la fonction egalite valeur
function egalite_repertoire(a: in repertoire; b: in repertoire)
return boolean is

begin
return a.nom_du_repertoire=b.nom_du_repertoire;
end egalite_repertoire;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- La première fonctionnalité: insérer un fichier dans le répertoire
-- courant.
procedure creer_fichier(a0: in out arbren;nom_fichier: in string;
contenu_fichier: in string; extension_du_fichier: in string) is
v: repertoire;
f: fich;
begin
f:= new fichiers;
v:=an_valeur(a0);

f.all.nom_du_fichier:=nom_fichier;
f.all.contenu_du_fichier:= contenu_fichier;
f.all.extension := extension_du_fichier;
f.all.suivant:=v.fichiers_du_repertoire;
v.fichiers_du_repertoire:=f;
An_changer_valeur(a0,v);

end creer_fichier;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
function contenu_fichier(f: in fich) return string is

begin
put_line("*********************************");
put_line(" Le contenu de votre fichier est: ");
return(f.all.contenu_du_fichier);
end contenu_fichier;

-----------------------------------------------------------------------
-----------------------------------------------------------------------
procedure Afficher_rep_fich(a: in arbren) is
begin
an_afficher(a);
end Afficher_rep_fich;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
function changer_repertoire(arbre_total: in arbren;
nom_rep_cible: in string) return arbren is
f: fich;
a: arbren;
v: repertoire;
rep_cour: repertoire;
begin
f:= new fichiers;

v.nom_du_repertoire:=nom_rep_cible;
v.fichiers_du_repertoire:= null;

a:=An_rechercher(arbre_total,v);
	if an_vide(a) then
		 put(" le repertoire cible n'existe pas " );
	else rep_cour:= An_valeur(a);
	end if;
--Afficher_rep_fich(a);
return a;
end changer_repertoire;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
function recherche_fichier(a: in arbren; nom: string;ext: string)
return fich is
f: fich;
f1: fich;
v: repertoire;
begin
v:=An_valeur(a);
f:= new fichiers;
f1:=new fichiers;
f:=v.fichiers_du_repertoire;
	
	while f.all.nom_du_fichier /= nom 
	and then f.all.suivant/=null loop
		f:=f.all.suivant;
	end loop;
	if f/=null and then f.all.nom_du_fichier=nom
	and then f.all.extension=ext then
		f1.all.nom_du_fichier:=f.all.nom_du_fichier;
		f1.all.extension:=f.all.extension;
		f1.all.contenu_du_fichier:=f.all.contenu_du_fichier;
		f1.all.suivant:=null;
       else put_line("le fichier n'existe pas ds le repertoire source");
       end if;
return f1;
end recherche_fichier;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
function copie_fichier(a0:in arbren;a:in arbren;nom_fichier:in string;
nom_rep_d : in string ;ext: in string) return arbren is

f: fich;
c: arbren;

begin
f:=new fichiers;
f := recherche_fichier (a, nom_fichier, ext);
c:=changer_repertoire (a0, nom_rep_d);
creer_fichier(c,f.all.nom_du_fichier,f.all.contenu_du_fichier,
f.all.extension);
new_line;
return c;
end copie_fichier ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
procedure supprimer_fichier(a:in arbren;nom:in string;ext:in string) is
--f: fich;
p : fich;
Begin
p:=new fichiers;
p := an_valeur(a).fichiers_du_repertoire;
if An_Vide (a) then raise arbre_vide;
else
	while p.all.nom_du_fichier /= nom and then p/= null loop
--and then p.all.suivant.all.suivant/=null loop
        p := p.all.suivant;
        end loop;
-- si le fichier n est pas trouve
if p.all.nom_du_fichier/=nom and then p.all.extension/=ext 
then put( " fichier inexistant " );
-- sinon si le fichier est l avant dernir:
else if p.all.nom_du_fichier=nom and then p.all.extension=ext 
and then p.all.suivant/=null 
and then p.all.suivant.all.suivant=null 
then p.all.nom_du_fichier:=p.all.suivant.all.nom_du_fichier;
p.all.contenu_du_fichier:=p.all.suivant.all.contenu_du_fichier;
p.all.extension:=p.all.suivant.all.extension;p.all.suivant:=null;
-- sinon si c est  dernier
else if p.all.nom_du_fichier=nom and then p.all.extension=ext 
and then p.all.suivant=null then p.all.nom_du_fichier:="          ";
p.all.contenu_du_fichier:="          "&"          "&"          "&
"          "&"          "&"          "&"          "&"          "&
"          "&"          ";p.all.extension:="   ";p:=null;

	else 	
	p.all.nom_du_fichier := p.all.suivant.all.nom_du_fichier;
        p.all.contenu_du_fichier:=p.all.suivant.all.contenu_du_fichier;
	p.all.extension:=p.all.suivant.all.extension;
	p.all.suivant:=p.all.suivant.all.suivant;
	        end if;
	    end if;
	end if;
end if;
exception
when constraint_error => put (" fichier inexistant ");

end supprimer_fichier ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
procedure supprimer_repertoire(a: in out arbren;numero1: in integer) is

begin
An_supprimer_fils(a,numero1);
end supprimer_repertoire;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
procedure changer_nom_rep (a:in out arbren; nouveau_nom : in string) is
b: arbren;
c: repertoire;
begin
b:=a;
c:= An_valeur(b);
c.nom_du_repertoire := nouveau_nom;

an_changer_valeur (a,c) ;

end changer_nom_rep;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
procedure renommer_fichier(a0: in out arbren ; 
nom_repertoire_courant: in string; nom_fichier_a_renommer : in string; 
nouveau_nom_fichier : in string; ext1: in string; ext2: in string) is

f: fich;
c: arbren;
begin


f:= new fichiers;
c:= changer_repertoire(a0,nom_repertoire_courant);
f:=recherche_fichier(c,nom_fichier_a_renommer,ext1);
creer_fichier(c,nouveau_nom_fichier,f.all.contenu_du_fichier,ext2);
supprimer_fichier (c,nom_fichier_a_renommer,ext1);

end renommer_fichier;

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------RECHERCHE FICHIERS------------------------

FUNCTION Contient (Chaine_Contenu:IN String;L_Contenu: IN Integer ;
Chaine_Rech: IN String;L_Rech:IN Integer) RETURN Boolean IS
      I:Integer ;
      Chaine2:String(1..Nmax) ;
   BEGIN
  --verifier si chaine_rech a plus de caractere auquel on retourne faux
      IF L_Contenu<L_Rech THEN
         RETURN False ;
      ELSE
         I:=1;
         --calculer le nbre d'elts sont en commun entre 
	 -- les 2 chaines dans la meme position
         WHILE Chaine_Contenu(I)=Chaine_Rech(I) LOOP
            I:=I+1 ;
         END LOOP ;
         IF I>=L_Rech THEN
            RETURN True ;

         --verifier à nouveau en decalant la recherche d'un caractere
         ELSE FOR M IN 2..L_contenu LOOP
               Chaine2(M):=Chaine_Contenu(M) ;
            END LOOP ;
            FOR M IN 1..L_Contenu-1 LOOP
               Chaine2(M):=Chaine2(M+1) ;
            END LOOP;
            RETURN Contient(Chaine2,L_Contenu-1,Chaine_Rech,L_Rech);
         END IF ;
      END IF ;

   END Contient ;
-----------------------------------------------------------------------
PROCEDURE Recherche_Fichiers(A:IN Arbren ; Chaine:IN String ;
J : IN Integer ) IS
      Arbre:Arbren ;
      I:Integer ;
      Inter:fich ;
   BEGIN

      Inter:=An_Valeur(A).fichiers_du_repertoire ;
      WHILE Inter/=NULL LOOP
         -- afficher tous les fichiers qui dans leur contenu il y'a la
	 -- chaine recherchee
         IF Contient(Inter.All.Contenu_du_fichier,Nmax,Chaine,J) THEN
            Put(Inter.All.Nom_du_fichier) ;
	    new_line;
         ELSE
            --sinon rien
            NULL ;
         END IF ;
         Inter:=Inter.All.Suivant ;
      END LOOP ;
      I:=1;
      --on relance la recherche dans les fichiers des sous repertoire
    WHILE An_Nombre_Fils(A)<I and then NOT(An_Vide(An_Fils(A,I))) LOOP
         Arbre:=An_Fils(A,I) ;
         Recherche_Fichiers(Arbre,Chaine,J) ;
         I:=I+1;
      END LOOP;

   END Recherche_Fichiers ;
-----------------------------------------------------------------------

end p_sys;
