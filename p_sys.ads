with p_arbren;

package p_sys is


Nmax:constant Integer:=100;
kmax: integer :=10; -- taille maximale du nom.
emax: integer :=3; -- taille de l'extension.
cmax: integer :=100; -- taille maximale du contenu.

-----------------------------------------------------------------------
-- Déclaration du type fichier.
type fichiers;
type fich is access fichiers;
type fichiers is record
	nom_du_fichier: string(1..kmax);
	extension: string(1..emax);
	contenu_du_fichier: string(1..cmax);
	suivant: fich;
end record; 
-----------------------------------------------------------------------
-----------------------------------------------------------------------
type repertoire is record
	nom_du_repertoire: string(1..kmax);
	fichiers_du_repertoire: fich;
end record;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- SPECIFICATION
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- la procedure generique ecrire_txt.
procedure ecrire_txt(a: in repertoire);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- La fonction générique égalité.
function egalite_repertoire(a: in repertoire; b: in repertoire) return
boolean;
-----------------------------------------------------------------------

package p_arbren_test is new p_arbren(repertoire,ecrire_txt,
egalite_repertoire);
use p_arbren_test;

-----------------------------------------------------------------------
-----------------------------------------------------------------------
--creer: cree un fichier dans le repertoire courant
--param : a:arbren (*D*), nom_fich:string(1..Kmax) (*D*) ,
--         contenu_fich:string(1..Nmax) (*D*)
--pre:taille du nom_fich inferieur a Kmax,contenu_fich inferieur a 100
--post : aucune
--exeption : aucune
procedure creer_fichier(a0: in out arbren;nom_fichier: in string;
contenu_fichier: in string; extension_du_fichier: in string);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--contenu_fichier : affiche le contenu d un fichier
--param :  fichiers (*D*)
--pre : aucune
--post :aucune
--exeption: fichier inexistant
function contenu_fichier(f: in fich) return string;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- 3' Pour l'affichage de la liste des repertoires et fichiers du 
-- repertoire courant.
-- Semantique: afficher la liste des repertoires et fichiers du
-- repertoire courant.
-- Parametres: v valeur (dans laquelle est stocke le nom du repertoire
-- courant ainsi que les fichiers du repertoire).
-- Pre-conditions: Le repertoire n est pas le repertoire vide.
-- Post-conditions: La liste des repertoires et fichiers du repertoire
-- courant est affichee.
procedure Afficher_rep_fich(a: in arbren);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- 4' Pour le changement d'un repertoire courant vers un autre 
--repertoire.
-- Semantique: changer le repertoire courant vers un autre repertoire.
-- Parametres: Le repertoire courant(in/out valeur) et le repertoire
-- cible (in valeur)
-- Pre-conditions: Le repertoire courant n esst pas le repertoire vide.
-- Post conditions: le repertoire courant bascule vers le repertoire 
-- cible.
function changer_repertoire(arbre_total: in arbren; nom_rep_cible:
in string)
 return arbren;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
function recherche_fichier(a: in arbren; nom: string; ext: string)
return fich;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--copie:copier un fichier du repertoire actuel vers un autre repertoire
-- param : a:arbren (*D*), nom_rep_nouveau: string(1..Kmax) (*D*),
--         nom:string(1..Kmax) (*D*).
-- pre : taille des chaines de caracteres inferieur a Kmax
-- post : copie du fichier s'il existe sinon rien
-- exeption : fichier inexistant
function copie_fichier(a0:in arbren;a:in arbren;nom_fichier:in string;
 nom_rep_d : in string ;ext: in string) return arbren;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
procedure supprimer_fichier (a: in arbren; nom : in string;
ext: in string);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--supprime : supprime un repertoire ou un fichier dans le repertoire
-- courant
-- param : a:arbren (*D*), nom_elt: string(1..Kamx) (*D*)
-- pre : aucune
-- post : supprime l'elt sauf s'il n'existe pas
-- exeption : arbre vide
procedure supprimer_repertoire(a: in out arbren;numero1: in integer);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--renomme : change le nom d'un repertoire du repertoire courant
-- param : a:arbren (*D*), 
--         nom_nouveau:string(1..Kmax) (*D*)
-- pre : taille des chaines de caracteres inferieur a Kmax
-- post : renomme l elt s'il existe
-- exeption : arbre vide
procedure changer_nom_rep (a: in out arbren; nouveau_nom : in string);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
procedure renommer_fichier(a0: in out arbren;
 nom_repertoire_courant: in string; nom_fichier_a_renommer : in string;
 nouveau_nom_fichier : in string; ext1: in string; ext2: in string);
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--contient:verifie si une chaine de caractere est contenu dans une 
-- autre chaine .
-- param : chaine et sa taille :string+integer , la chaine recherchee
--         et sa taille :string+integer
-- pre : aucune
-- post : retourne vrai si elle y est
-- exeption : aucune
FUNCTION Contient (Chaine_Contenu:IN String;L_Contenu: IN Integer;
Chaine_Rech: IN String;L_Rech:IN Integer) RETURN Boolean;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--recherche_fichiers:recherche les fichiers du repertoire courant et de
--                    ses sous-repertoires qui contiennent une chaine
--                    de caracteres donnee
-- param : a: arbren (*D*), chaine:string (*D*), J:integer (*D*)
-- pre : aucune
-- post : retourne les noms des fichiers ou rien sinon
-- exeption : aucune
PROCEDURE Recherche_Fichiers(A:IN Arbren ; Chaine:IN String ;
J : IN Integer );
-----------------------------------------------------------------------

end p_sys;
