module m20201113 where

open import Agda.Primitive
open import Agda.Builtin.Nat
open import Agda.Builtin.Float
open import Agda.Builtin.Char
open import Agda.Builtin.List
open import Agda.Builtin.Bool

pattern [_]                     z = z ∷ []
pattern [_,_]                 y z = y ∷ z ∷ []
pattern [_,_,_]             x y z = x ∷ y ∷ z ∷ []
pattern [_,_,_,_]         w x y z = w ∷ x ∷ y ∷ z ∷ []
pattern [_,_,_,_,_]     v w x y z = v ∷ w ∷ x ∷ y ∷ z ∷ []
pattern [_,_,_,_,_,_] u v w x y z = u ∷ v ∷ w ∷ x ∷ y ∷ z ∷ []

_++_ : ∀{i}{A : Set i} → List A → List A → List A
[] ++ b = b
(x ∷ a) ++ b = a ++ (x ∷ b)

data Eq {i}(A : Set i)(a : A) : A → Set where
  refl : Eq A a a

if_then_else_ : ∀{i}{A : Set i}(t : Bool)(u v : A) → A
if true then u else v = u
if false then u else v = v


-- enum Result { Success, Fail, InternalError };
--

data Result : Set where
     Success : Result
     Fail : Result
     InternalError : Nat -> Result

example1 : Result
example1 = InternalError 12

getResultfromErrorCode : Nat -> Result
getResultfromErrorCode zero = Success
getResultfromErrorCode 5 = Fail
getResultfromErrorCode x = InternalError x -- _ <-- probald kitalalni

getErrorCodefromResult : Result -> Nat
getErrorCodefromResult Success = zero
getErrorCodefromResult Fail = 5
getErrorCodefromResult (InternalError x) = x

test : Eq _ (getErrorCodefromResult Success) 0
test = refl

--test1 : Eq _ (getErrorCodefromResult (InternalError x)) x
--test1 = refl

--1 ∷ 1 ∷ []
--suc (suc zero)

listtonat : List Bool -> Nat
listtonat = {! length !}

nattolist : Nat -> List Bool
nattolist zero = []
nattolist (suc x) = true ∷ nattolist x
-- true ∷ true ∷ ... ∷ []

-- c++ option<Nat>
data Maybe : Set where
   Nothing : Maybe
   Just : Nat -> Maybe

-- data Tree

--data Expression {i}(A : Set i) : Set i where

-- 1
-- 5
-- 1 + 1
-- 5 * 10
-- 1 + 1 + 1
-- (1 + 1) + (1 + 1)

--data Expression {i}(A B : Set i) : Set where
--data Expression {i}(A : Set i)(B : Set i) : Set where
data Expression {i}(A : Set i) : Set i where
     Value : A -> Expression A
     Plus : Expression A -> Expression A -> Expression A
     Mul : Expression A -> Expression A -> Expression A 

--Plus (Value 0) (exp) = (exp)
--Plus (exp) (Value 0) = (exp)
 
foobar12 : Expression Nat
foobar12 = Value zero

foobar13 : Expression Nat
foobar13 = Plus (Value 1) (Value 1)

foobar14 : Expression Nat
foobar14 = Mul (Value 5) (Value 10)

evaluate : Expression Nat -> Nat
evaluate (Value x) = x
evaluate (Plus x y) = evaluate x + evaluate y
evaluate (Mul x y) = evaluate x * evaluate y

data Empty : Set where


notempty : Empty
notempty = ?

-- Hamis -> Hamis
-- Hamis akkor(=>) Hamis
a : Empty -> Empty
a x = x

-- Hamis => A
exfalso : ∀{i}{A : Set i} -> Empty -> A  --  \forall
exfalso ()


data TriBit : Set where
   true : TriBit
   false : TriBit
   maybe : TriBit

-- enum { bar }
data One : Set where
     tt : One

-- true 
maybeempty : One
maybeempty = tt


id : One -> One
id x = x

maybeempty1 : One
maybeempty1 = id tt

--  and, or
-- igaz vagy hamis
-- igaz vagy hamis = igaz

-- in C
-- union { int a; float b; }
-- f(1)
-- f(1.1)
idbool : Bool -> Bool
idbool x = x

exbool1 : Bool
exbool1 = true

exbool2 : Bool
exbool2 = false


-- Pair<A,B>
data Or (A B : Set) : Set where
     left : A -> Or A B
     right : B -> Or A B

-- 4 db Or Bool Bool
orexample1 : Or Bool Bool
orexample1 = left false

orexample2 : Or Bool Bool
orexample2 = right false


-- 1 + 1
-- igaz vagy igaz
oroneone : Or One One
oroneone = left tt

nata : Nat
nata = 6

-- oo + 2 = oo
ornatbool : Or Nat Bool
ornatbool = left 6

data OrOneOne : Set where
    lefttt : OrOneOne
    righttt : OrOneOne

-- (1 + 1) + 1 = 3
-- (igaz vagy igaz) vagy igaz
-- One = {tt}
-- One = {tt}
-- Or One One = One + One = One U One = {left tt, right tt} == One or One
--
--
-- OrOneOne = {lefttt, righttt}
-- One = {tt}
-- Or (OrOneOne) One = {left lefttt, left righttt, right tt}
oneoneone : Or (Or One One) One
oneoneone = left (right tt)

oneoneone1 : Or (Or One One) One
oneoneone1 = right tt

-- 1 + 0 = 1
-- igaz vagy hamis = igaz
oneempty : Or One Empty
oneempty = left tt
 
-- Empty  = {}
-- Bool   = {true,false}
-- rigth true,right false
-- 0 + 2 = 2
-- false vagy ? = ?
boolempty : Or Empty Bool
boolempty = ?


-- kell: and, or, igaz, hamis, not
-- van: igaz, hamis, or


