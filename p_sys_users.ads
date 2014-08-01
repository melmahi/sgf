WITH P_Arbren ;
PACKAGE P_Sys_Users IS

-- types necessites pour ce paquetage
   Nmax:CONSTANT Integer:=100;
   Kmax:CONSTANT Integer:=14;

-- Les types de droits, j'ai choisi une énumération.
type droit is (lecture,ecriture);

-- j'ai fixé dans mon exemple le nombre d'utilisateurs a 3
type utilisateur is(u1,u2,u3);

-- liste chainee d'utilisateur
type util;
type p_util is access util
type util is record
	user: utilisateur;
	next: p_util;
end record;

-- fichiers d un repertoire
type fichiers_users;
type fich_users is access fichiers;
type fichiers_users is record
	nom_du_fichier: string(1..kmax);
	extension: string(1..emax);
	contenu_du_fichier: string(1..cmax);
	droit_lec: p_util;
	droit_ecr: p_util;
	proprietaire: utilisateur;
	suivant: fich;
end record; 

-- repertoires
type repertoire_users
type prep is record repertoire_users;
type repertoire_users is record
	Nom; string(1..kmax);
	proprietaire: utilisateur;
	droit_lec:p_util;
	droit_ecr: p_util;
	fichier_util: fichiers_users;
end record;

--exeptions

   repertoire_null :EXCEPTION ;
   Fichier_Inexistant:EXCEPTION;
   Pas_De_Fichier:EXCEPTION ;

-- instanciation du paquetage generique
PROCEDURE Ecrire_Rep(Fich:IN Repertoire_Users) ;
FUNCTION Correspond_Rep(Data1:IN Repertoire_Users;
Data2:IN Repertoire_Users) RETURN Boolean ;
PACKAGE P_Arbren_Users IS NEW 
P_Arbren(Repertoire_Users,Ecrire_Rep,Correspond_Rep);
USE P_Arbren_Users ;

--fonctions du paquetage
-----------------------------------------------------------------------
--egalite : verifie si 2 chaines de caracteres sont egales
--param : chaine1 :string (*D*), chaine2:string (*D*)
--pre : aucune
--post : renvoie vrai si les chaines sont egales
--exeption : aucune
FUNCTION Egalite(Chaine1:IN String;Chaine2: IN String) RETURN Boolean;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--insere_liste : insere un elt dans une liste chainee
--param : u:utilisateur (*D*), l:liste_util (*D/R*)
--pre : aucune
--post: liste avec un elt en plus
--exeption : aucune
PROCEDURE Insere_Liste(U:IN Utilisateur;L:IN OUT Liste_Util ) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--appartient_liste : teste si un elt appartient a la liste
--param : u: utilisateur (*D*), l: liste_util (*D*)
--pre : aucune
--post : retourne vrai si elt appartient a la liste
--exeption : aucune
FUNCTION Appartient_Liste(U:IN Utilisateur ;L:IN Liste_Util)
RETURN Boolean ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--supprime_liste : supprime un elt de la liste chainee
--param : u:utilisateur(*D*), l:liste_util (*D/R*)
--pre : aucune
--post : liste avec elt en moins
--exeption : aucune
PROCEDURE Supprime_Liste(U:IN Utilisateur ; L :IN OUT Liste_Util) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--octroyer_rep  : donne a un utilisateur le droit sur un repertoire
--param : a:arbren (*D*), nom_rep:string (*D*), u_proprio:utilisateur,
--        (*D*), u: utilisateur (*D*),d:droit (*D*)
--pre : aucune
--post : aucune
--exeption : aucune
PROCEDURE Octroyer_Rep(A:IN Arbren ;Nom_Rep:IN String ;U_Proprio:
IN Utilisateur ; U:IN Utilisateur;D:IN Droit);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--octroyer_fich : donne a un utilisateur le droit sur un fichier
--param : param : a:arbren (*D*), nom_rep:string (*D*), 
-- u_proprio:utilisateur(*D*), u: utilisateur (*D*),d:droit (*D*)
--pre : aucune
--post: aucune
--exeption: aucune
PROCEDURE Octroyer_Fich(A:IN Arbren ;Nom_Fich:IN String ;
U_Proprio:IN Utilisateur ; U:IN Utilisateur;D:IN Droit);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--retirer_rep : retire a un utilisateur le droit sur un repertoire
--param : param : a:arbren (*D*), nom_rep:string (*D*),
-- u_proprio:utilisateur(*D*), u: utilisateur (*D*),d:droit (*D*)
--pre : aucune
--post : aucune
--exeption : aucune
PROCEDURE Retirer_Rep(A:IN Arbren ;Nom_Rep:IN String ;
U_Proprio:IN Utilisateur ; U:IN Utilisateur;D:IN Droit);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--retirer_fich : retire a un utilisateur le droit sur un fichier
--param : param : a:arbren (*D*), nom_rep:string (*D*), 
-- u_proprio:utilisateur(*D*), u: utilisateur (*D*),d:droit (*D*)
--pre : aucune
--post : aucune
--exeption : aucune
PROCEDURE Retirer_Fich(A:IN Arbren ;Nom_Fich:IN String ;
U_Proprio:IN Utilisateur ; U:IN Utilisateur;D:IN Droit);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--creer_users: cree un fichier dans le repertoire courant
--param : a:arbren (*D*), nom_fich:string(1..Kmax) (*D*) ,
--         contenu_fich:string(1..Nmax) (*D*),u_p:utilisateur(*D*)
--pre:taille du nom_fich inferieur a Kmax, contenu_fich inferieur a 100
--post : aucune
--exeption : aucune
 PROCEDURE Creer_Users(A: IN Arbren ;Nom_Fich: IN String ;
Contenu_Fich :IN String;U_P:IN Utilisateur );
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--afficher_users : affiche le contenu d'un fichier
--param :  fichiers (*D*),u_courant :utilisateur(*D*)
--pre : aucune
--post :aucune
--exeption : si le fichier n'existe pas (pas_de_fichier)
PROCEDURE Afficher_Contenu_aux_Users(Fich:IN Fichiers_Users;
U_Courant:IN Utilisateur )  ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--afficher_nieme_contenu_users : affiche le contenu du nieme fichier
-- param : a:arbren (*D*), nom_fich:string(1..Kmax) (*D*),
-- u_courant :utilisateur(*D*).
-- pre : aucune
-- post : aucune
-- exeption : aucune
PROCEDURE Afficher_Contenu_Users(A:IN Arbren ; Nom_fich: IN string;
U_Courant:IN Utilisateur  ) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--afficher_nom_fichiers_users : affiche le nom de tous les fichiers du 
-- repertoire courant.
-- param : a: arbren (*D*),u_courant :utilisateur(*D*)
-- pre : aucune
-- post : aucune
-- exeption : arbre vide
PROCEDURE Afficher_Nom_Fichiers_Users(A:IN Arbren;
U_Courant:IN Utilisateur );
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--afficher_nom_repertoire_users : affiche le nom du repertoire courant
-- param : a:arbren (*D*),u_courant :utilisateur(*D*)
-- pre : aucune
-- post : aucune
-- exeption :  arbre vide
PROCEDURE Afficher_Nom_Repertoire_Users(A:IN Arbren;
U_Courant:IN Utilisateur);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--afficher_tous_users : affiche la liste des repertoires et fichiers 
-- du repertoire courant.
--param : a:arbren (*D*), u_courant :utilisateur(*D*)
--pre : aucune
--post : aucune
--exeption : arbre vide (i.e repertoire vide)
PROCEDURE Afficher_Tous_Users(A:IN Arbren;U_Courant:IN Utilisateur ) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--changement_users : change le repertoire vers un autre repertoire
-- param : a: arbren (*D*), nom_rep:string(1..Kmax) (*D*), 
-- rep_courant: arbren (*R*), u_courant :utilisateur(*D*)
-- pre : taille des chaines de caracteres inferieur a Kmax
-- post:on change de repertoire s'il existe,sinon on reste
-- dans l'actuel.
-- exeption : arbre vide
PROCEDURE Changement_Users (A: IN Arbren;Nom_Rep:IN String;
Rep_Courant:OUT Arbren;U_Courant:IN Utilisateur) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--copie_users : copier un fichier du repertoire actuel vers un autre 
-- repertoire
-- param : a:arbren (*D*), nom_rep_nouveau: string(1..Kmax) (*D*),
--         nom:string(1..Kmax) (*D*),u_courant :utilisateur(*D*)
-- pre : taille des chaines de caracteres inferieur a Kmax
-- post : copie du fichier s'il existe sinon rien
-- exeption : fichier inexistant
PROCEDURE Copie_Users(A: IN Arbren ; Nom_Rep_Nouveau: IN String ;
Nom : IN String;U_Courant:IN Utilisateur ) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- supprime_users : supprime un repertoire ou un fichier dans
-- le repertoire courant
-- param : a:arbren (*D*), nom_elt: string(1..Kamx) (*D*),
-- u_courant :utilisateur(*D*)
-- pre : aucune
-- post : supprime l'elt sauf s'il n'existe pas
-- exeption : arbre vide
PROCEDURE Supprime_Users(A:IN OUT Arbren ; Nom_Elt:IN String;
U_Courant:IN Utilisateur ) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--renomme_users : change le nom d'un repertoire ou d'un fichier dans
-- le repertoire courant.
-- param : a:arbren (*D*), nom_anc:string(1..Kmax) (*D*),
--      nom_nouveau:string(1..Kmax) (*D*), u_courant :utilisateur(*D*)
-- pre : taille des chaines de caracteres inferieur a Kmax
-- post : renomme l elt s'il existe
-- exeption : arbre vide
PROCEDURE Renommer_Users(A: IN Arbren ; Nom_Anc: IN String ;
Nom_Nouveau : IN String;U_Courant:IN Utilisateur ) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--contient_users : verifie si une chaine de caractere est contenu dans 
-- une autre chaine .
-- param : chaine et sa taille :string+integer , la chaine recherchee
--         et sa taille :string+integer
-- pre : aucune
-- post : retourne vrai si elle y est
-- exeption : aucune
FUNCTION Contient_Users (Chaine_Contenu:IN String;L_Contenu:IN Integer;
Chaine_Rech: IN String;J:IN Integer) RETURN Boolean ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--recherche_fichiers_users : recherche les fichiers du repertoire
-- courant et de ses sous-repertoires qui contiennent une chaine
-- de caracteres donnee
-- param : a: arbren (*D*), chaine:string (*D*), J:integer (*D*)
--         u_courant :utilisateur(*D*)
-- pre : aucune
-- post : retourne les noms des fichiers concernes , rien sinon
-- exeption : aucune
PROCEDURE Recherche_Fichiers_Users(A:IN Arbren ; Chaine:IN String ;
J : IN Integer ;U_Courant: IN Utilisateur)  ;
-----------------------------------------------------------------------

END P_Sys_Users ;
