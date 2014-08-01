generic
type T is private;
with procedure ecrire (a: in T);
with function egalite(a: in T; b: in T) return Boolean;

package p_arbren is

type arbren is private;

-- exception
arbre_vide: exception;
no_pere: exception;
no_nieme_fils: exception;
no_frere: exception;
-----------------------------------------------------------------------
-- Fonction An_Vide
-- Semantique: Detecter si un arbre n-aire est vide ou non
-- Parametres: a: arbren (D)
-- Type retour: booleen (vaut vrai si l'arbre n-aire est vide)
-- pre : aucune
-- post: retourne true si l'arbre est vide
-- exeption : aucune
function An_Vide (a: in arbren) return boolean ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Creer_Vide
-- Semantique: Creer un arbre n-aire vide
-- Parametres: aucun
-- pre : aucune
-- post: on obtient true si on applique la fonction An_Vide
-- exeption : aucune
function An_Creer_Vide return arbren ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Valeur
-- Semantique: Retourner la valeur rangee a la racine d'un arbre n-aire
-- Parametres: a: arbren (D)
-- Type retour: T
-- pre : aucune
-- post: aucune
-- exeption : arbre vide
function An_Valeur (a: in arbren) return T ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Est_Feuille
-- Semantique: Indiquer si un arbre n-aire est une feuille (pas de fils)
-- Parametres: a: arbren (D)
-- Type retour: booleen (vaut vrai si l'arbre n-aire n'a pas de fils)
-- pre : aucune
-- post : retourne vrai si l'arbre a n'a pas de fils
-- exeption : arbre vide
function An_Est_Feuille (a: in arbren) return boolean ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Creer_Feuille
-- Semantique: Creer un arbre n-aire avec une valeur mais sans fils,
-- 	       ni frere, ni pere
-- Parametres: nouveau: T (D)
-- Type retour: arbren
-- pre : aucune
-- post : en appliquant An_Est_Feuille cela nous ernvoit vrai
-- exeption : aucune
function An_Creer_Feuille (nouveau: in T) return arbren ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Pere
-- Semantique: Retourner l'arbre n-aire pere d'un arbre n-aire
-- Parametres: a: arbren (D)
-- Type retour: arbren
-- pre : aucune
-- post : aucune
-- exeption : arbre vide
function An_pere (a: in arbren) return arbren ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Fils
-- Semantique: Retourner le nieme fils de a
-- 	       le numero 1 est le premier fils
-- Parametres: a: arbren (D)
--	       numero: integer (D)
-- Type retour: arbren
-- pre : numero >= 1
-- post : aucune
-- exeption : arbre vide
function An_fils (a: in arbren; numero : IN INTEGER) return arbren ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Frere
-- Semantique: Retourner le nieme Frere d'un arbre n-aire
-- 		le numero 1 est le premier frere
-- Parametres: a: arbren (D)
--	       numero: integer (D)
-- Type retour: arbren
-- pre : numero >= 1
-- post : aucune
-- exeption : arbre vide
function An_Frere (a: in arbren; numero : IN INTEGER) return arbren ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procedure An_Afficher
-- Semantique: Afficher le contenu complet d'un arbre n-aire
-- Parametres: a: arbren (D)
-- pre : aucune
-- post : aucune
-- exeption : arbre vide
procedure An_Afficher (a: in arbren) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Rechercher
-- Semantique: Recherche la premiere occurrence d'une valeur dans un
-- arbre n-aire. Retourne l'arbre n-aire dont la valeur est racine
-- si elle est trouvee, un arbre n-aire vide sinon
-- Parametres: a: arbren (D), data: T (D)
-- Type retour: arbren
-- pre : aucune
-- post : aucune
-- exeption : arbre vide
function An_Rechercher (a: in arbren; data: in T ) return arbren ; 
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Est_Racine
-- Semantique: Indiquer si un arbre n-aire est sans pere
-- Parametres: a: arbren (D)
-- Type retour: booleen (vaut vrai si l'arbre n-aire n a pas de pere)
-- pre : aucune
-- post : retourne vrai si a n'a pas de pere
-- exeption : arbre vide
function An_Est_Racine (a: in arbren) return boolean ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procedure An_Changer_Valeur
-- Semantique: Changer la valeur rangee a la racine d'un arbre n-aire
-- Parametres: a: arbren (D), nouveau: T (D)
-- pre : aucune
-- post : valeur de a changee par nouveau
-- exeption : arbre vide
procedure An_Changer_Valeur (a:in out arbren; nouveau:in T ) ; 
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procedure An_Inserer_Fils
-- Semantique: Inserer un arbre naire sans frere en position de premier
-- 	 fils d'un arbre n-aire a. L'ancien fils de a devient alors le
--       premier frere de l'arbre n-aire insere.
-- Parametres: a: arbren (D), a_ins: arbren (D)
-- pre : aucune
-- post : arbre avec un nouveau fils
-- exeption : arbre vide
procedure An_Inserer_Fils (a:in out arbren; a_ins:in out arbren) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procedure An_Inserer_Frere
-- Semantique: Inserer un arbre naire sans frere en position de premier
-- 	       frere d'un arbre n-aire a
-- Parametres: a: arbren (D), a_ins: arbren (D)
-- pre : aucune
-- post : arbre avec un nouveau frere
-- exeption : arbre vide
procedure An_Inserer_Frere (a:in out arbren; a_ins: in out arbren) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- fonction An_Nombre_Fils: retourne le nombre de fils au premier
-- niveau d'un arbre
-- parametres: a arbre n-aire
-- post-conditions: si l'arbre est null, on retourne 0
function An_Nombre_Fils ( a: in arbren ) return integer;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procedure An_Supprimer_fils
-- Semantique: Supprime le nieme fils d'un arbre n-aire
-- Parametres: a: arbren (D)
--	       numero: integer (D)
-- pre : aucune
-- post : arbre avec un fils en moins si numero est inferieur au nbr 
-- de fils
-- exeption : arbre vide
procedure An_Supprimer_fils (a:in out arbren; numero : IN INTEGER) ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procedure An_Supprimer_frere
-- Semantique: Supprime le nieme frere d'un arbre n-aire
-- Parametres: a: arbren (D)
--	       numero: integer (D)
-- pre : aucune
-- post : arbre avec un fils en moins si numero est inferieur au nbr
-- de frere
-- exeption : arbre vide
procedure An_Supprimer_Frere ( a :in out arbren ; numero: in integer);
-----------------------------------------------------------------------

private -- tous ces types sont privés.

-----------------------------------------------------------------------
-- Operations sur un arbre n-aire (de type arbren)
-- L information rangée dans le noeud est de type T
-----------------------------------------------------------------------
type noeud;
type arbren is access noeud;
type noeud is record
	val:T;
	premier_fils: arbren;
	frere: arbren;
	pere: arbren;
end record;

end p_arbren;
