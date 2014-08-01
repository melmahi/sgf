with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;
with ada.float_text_io; use ada.float_text_io;

package body p_arbren is
-----------------------------------------------------------------------
-- Fonction An_Vide
function An_Vide (a: in arbren) return boolean is
begin
        -- si a=null alors elle retourne true sinon false.
	return (a=null); 
end An_vide;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Creer_Vide
function An_Creer_Vide return arbren is
begin
return null;
end An_Creer_vide;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Valeur
function An_Valeur (a: in arbren) return T is

begin
return (a.all.val);
exception
when constraint_error => raise arbre_vide;
end An_valeur;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Est_Feuille
function An_Est_Feuille (a: in arbren) return boolean is
begin
	return (a.all.premier_fils=null);
exception
	when constraint_error => raise arbre_vide;
end An_Est_Feuille ;

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Creer_Feuille
function An_Creer_Feuille (nouveau: in T) return arbren is
a: arbren;

Begin

a:= new noeud; -- on lui donne de la place.
a.all.val:= nouveau;
a.all.premier_fils:=null;
a.all.frere:=null;
a.all.pere:=null;

return a;

end An_Creer_Feuille ;
----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Pere
function An_Pere ( a: in arbren ) return arbren is

begin

if An_Vide(a) then
   raise arbre_vide;
  else if a.all.pere=null then
          raise no_pere;
         else
          return a.all.pere;
       end if;
end if;

end An_pere;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Fils

function An_Fils ( a: in arbren; numero: in integer ) return arbren is

arb_aux: arbren;
arb_aux2: arbren;

begin
arb_aux2:= new noeud;

if An_Vide(a) then
   raise arbre_vide;
  else 
     arb_aux:=a.all.premier_fils;     
     for i in 1..numero-1 loop
       arb_aux:=arb_aux.all.frere;
     end loop;
end if;

arb_aux2.all.frere:=null;
arb_aux2.all.pere:=null;
arb_aux2.all.val:=arb_aux.all.val;
arb_aux2.all.premier_fils:=arb_aux.all.premier_fils;

return arb_aux2; 
exception
     when constraint_error => raise no_nieme_fils;
end An_Fils;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Frere

function An_Frere ( a: in arbren; numero: in integer ) return arbren is

arbre_aux: arbren;
arbre_aux2: arbren;
begin
arbre_aux:= new noeud;
arbre_aux2:= new noeud;

if An_Vide(a) then
   raise arbre_vide;
  else 
     arbre_aux:=a;
     for i in 1..numero loop
       arbre_aux:=arbre_aux.all.frere;
     end loop;
end if;
arbre_aux2.all.val:=arbre_aux.all.val;
arbre_aux2.all.premier_fils:=arbre_aux.all.premier_fils;
arbre_aux2.all.frere:=null;
arbre_aux2.all.pere:=null;

   return arbre_aux2; 
exception
     when constraint_error => raise no_frere;
end An_Frere;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
procedure An_Afficher_Aux (a: in arbren; decal:in integer) is
 begin
    if a /= null then
     -- decaler de decal espaces
      for i in 1..decal loop
        put(" ");
      end loop;
      -- ecrire la valeur du noeud
     ecrire(a.all.val);
      new_line;
      -- afficher le fils
      An_Afficher_Aux(a.all.premier_fils,decal+8);
      -- afficher le frere
      An_Afficher_Aux(a.all.frere,decal);
    else
     -- rien
      null;
    end if;
  end An_Afficher_Aux;

  -------------------------

  procedure An_Afficher (a: in arbren) is
  begin
    if a = null then null;
    else
      An_Afficher_Aux(a,0);
    end if;
  end An_Afficher;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procédure auxiliaire:
--procedure An_Afficher_Aux(a: in arbren ; espace: in string ) is
--begin
--	if a = null then null;
--	else 
--		put(espace);
--		ecrire(a.all.val);
--		An_Afficher_Aux(a.all.premier_fils,espace& "      |");
--		An_Afficher_Aux(a.all.frere,espace);
--	end if;
--
--end An_Afficher_Aux;
----------------------------------------------------------------------
--Procedure An_Afficher
--Semantique: Afficher le contenu complet d un arbre n-aire
-- Parametres: a: arbren (D)
--procedure An_Afficher (a: in arbren) is
--Begin
--if An_Vide(a) then null;-- raise arbre_vide;
--else
--	put("|");
--	An_Afficher_Aux(a,"");
--end if;
--end An_Afficher;

----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Rechercher
function An_Rechercher(a : in arbren; data : in T) return arbren is
    p : arbren;
  begin
    p:= new noeud;

    if a = Null or else egalite(a.all.val,data) then
      return a;
    else
      p := An_Rechercher(a.all.frere, data);
      
      if p /= Null then
        return p;
      else
        return An_Rechercher(a.all.premier_fils, data);
      end if;
    end if;       
  end An_Rechercher;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Fonction An_Est_Racine
function An_Est_Racine (a: in arbren) return boolean is
begin

return (a.all.pere=null);

exception
	when constraint_error => raise arbre_vide;
end An_Est_Racine ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procedure An_Changer_Valeur
procedure An_Changer_Valeur (a:in out arbren; nouveau:in T) is

begin

a.all.val:=nouveau;
exception
    when constraint_error => raise arbre_vide;
end An_Changer_Valeur ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procedure An_Inserer_Fils
procedure An_Inserer_Fils (a:in out arbren; a_ins: in out arbren) is


Begin

-- d abord il y a l'exception si l'arbre est nul
If a= null  then raise arbre_vide;
	-- sinon il faut traiter le cas ou l'arbre a inserer est vide.
	else if a_ins= null then null;
	      -- sinon si l'arbre n'a pas de fils.
              else if a.all.premier_fils=null 
              then a.all.premier_fils := a_ins;
                        -- sinon dans le cas general.
			else a_ins.all.frere := a.all.premier_fils;
			a_ins.all.pere := a;
			a.all.premier_fils := a_ins;
		end if;
	end if;
end if;
end An_Inserer_Fils ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procedure An_Inserer_Frere
procedure An_Inserer_Frere (a:in out arbren; a_ins:in out arbren) is

Begin

-- SI l'arbre est nul
if a=null then raise arbre_vide;
	-- sinon si l'arbre a inserer est nul alors on fait rien;
	else if a_ins = null then null;
		-- sinon si a n'a pas de pere alors on fait intervenir
                -- l'exception no_pere.
		else if a.all.pere = null then raise no_pere;
		     -- sinon si l'arbre a n'a pas de frere
		     else if a.all.frere=null then a.all.frere:=a_ins;
		     a_ins.all.pere:=a.all.pere;
				-- sinon dans le cas general
				else a_ins.all.frere:= a.all.frere;
				a.all.frere:=a_ins;
				a_ins.all.pere:=a.all.pere;
			end if;
		end if;
	end if;
end if;

end An_Inserer_Frere ;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
---- fonction An_Nombre_Fils: 
function An_Nombre_Fils( a: in arbren ) return integer is

n:integer;
arb_aux:arbren;

begin

if An_Vide(a) then
   raise arbre_vide;
 else if a.all.premier_fils /= null then
         n:=1; 
         arb_aux:=a.all.premier_fils; 
         while arb_aux.all.frere /= null loop
               n:=n+1;
               arb_aux:=arb_aux.all.frere;
         end loop;
         return n;
        else
	 return 1; 
       end if;
end if;
       
end An_Nombre_Fils;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procedure An_Supprimer_fils
 procedure An_Supprimer_Fils(a : in out arbren; numero : in integer)is
  begin
    if a = Null then -- arbre vide
      raise Arbre_vide;
    elsif a.all.premier_fils = Null then -- arbre sans fils
      raise no_nieme_fils;
    elsif numero = 1 then -- n=1
      a.all.premier_fils := a.all.premier_fils.all.frere;
    else
      begin
        -- Supprime le (n-1)ième frère du premier fils
        An_Supprimer_Frere(a.all.premier_fils, numero-1);
      exception
        when no_frere => raise no_nieme_fils;
      end;
    end if;
  end An_Supprimer_Fils;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Procedure An_Supprimer_frere
procedure An_Supprimer_Frere(a : in out arbren; numero : in integer) is
    temp : arbren;
    p : integer;
  begin
    if a = Null then -- arbre vide
      raise ARBRE_VIDE;
    else
      -- Parcours des frères

      -- Initialisation
      temp := a;
      p := 1;

      -- Parcours
      while temp.all.frere /= Null and p < numero loop
        temp := temp.all.frere;
        p := p+1;
      end loop;
      -- temp.all.frere = Null or p=n

      -- Fin de Parcours des frères

      -- Supprimer le nième frère s'il existe, sinon lever une exception
      if p=numero and temp.all.frere /= Null then
        temp.all.frere := temp.all.frere.all.frere;        
      else
        raise no_frere;
      end if;
    end if;
  end An_Supprimer_Frere;


-----------------------------------------------------------------------

end p_arbren;
