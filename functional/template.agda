module template where

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

-- 0 --> zero
-- 1 --> suc zero
-- 2 --> suc suc zero
-- 3 --> suc suc suc zero

-- 0 --> d
-- 1 --> f 1 (d)
-- 2 --> f 1 (f 1 (d))
-- 3 --> f 1 (f 1 (f 1 (d)))

fold : Bool → (Bool → Nat → Bool) → Nat → Bool
fold d f zero = d
fold d f (suc xs) = f (fold d f xs) 1


data Result : Set where
     Success : Result
     Failed : Result
     InternalError : Result

getResultfromErrorCode : Nat -> Result
getResultfromErrorCode zero = Success
getResultfromErrorCode 12 = Failed
getResultfromErrorCode 14 = Failed
getResultfromErrorCode _ = InternalError


testgetesult1 : Eq _ (getResultfromErrorCode 20) InternalError
testgetesult1 = refl

testgetesult2 : Eq _ (getResultfromErrorCode 0) Success
testgetesult2 = refl

testgetesult3 : Eq _ (getResultfromErrorCode 12) Failed
testgetesult3 = refl

testgetesult4 : Eq _ (getResultfromErrorCode 14) Failed
testgetesult4 = refl

data Result1 : Set where
     Success1 : Result1
     Fail1 : Result1
     InternalError1 : (code : Nat) →  Result1


getResultfromErrorCode1 : Nat -> Result1
getResultfromErrorCode1 zero = Success1
getResultfromErrorCode1 12 = Fail1
getResultfromErrorCode1 14 = Fail1
getResultfromErrorCode1 a = InternalError1 a


testgetesult11 : Eq _ (getResultfromErrorCode1 20) (InternalError1 20)
testgetesult11 = refl

testgetesult12 : Eq _ (getResultfromErrorCode1 0) Success1
testgetesult12 = refl

testgetesult13 : Eq _ (getResultfromErrorCode1 12) Fail1
testgetesult13 = refl

testgetesult14 : Eq _ (getResultfromErrorCode1 14) Fail1
testgetesult14 = refl

testgetresult15 : (n : Nat) → Eq _ (getResultfromErrorCode1 (15 + n)) (InternalError1 (15 + n))
testgetresult15 zero = refl
testgetresult15 (suc n) = refl


data Expression {i}(A : Set i) : Set i where
     Value : A → Expression A
     Add   : Expression A → Expression A → Expression A
     Mul   : Expression A → Expression A → Expression A


example1 : Expression Nat
example1 = Value zero

example2 : Expression Nat
example2 = Add (Add (Value 1) (Value 2)) (Value 3)


evaluate : Expression Nat → Nat
evaluate (Value x) = x
evaluate (Add x y) = evaluate x + evaluate y
evaluate (Mul x y) = evaluate x * evaluate y


testevaluate1 : Eq _ (evaluate example1) 0
testevaluate1 = refl

testevaluate2 : Eq _ (evaluate example2) 6
testevaluate2 = refl


data One : Set where
     * : One

data Empty : Set where

data Bool1 : Set where
     T : Bool1
     F : Bool1

data Sum {i}{j}(A : Set i)(B : Set j) : Set (i ⊔ j) where
  left : A → Sum A B
  right : B → Sum A B

sumexample1 : Sum Nat Bool
sumexample1 = left zero

sumexample2 : Sum Nat Bool
sumexample2 = right false


caller : Sum Nat Bool → (Nat → Bool) → Bool
caller (left x) map = map x
caller (right x) map = x


record Pair {i}{j}(A : Set i)(B : Set j) : Set (i ⊔ j) where
  constructor Prod
  field
    fst : A
    snd : B
open Pair

pairexample1 : Pair Nat Bool
pairexample1 = Prod 1 false

pairexample2 : Pair Bool Bool
pairexample2 = Prod false true

prodtosum : {A B : Set} → Pair A B → Sum A B
prodtosum (Prod a b) = left a
--prodtosum (Prod a b) = right b

unit : Empty → Empty
unit x = x

absurd : ∀{i}{A : Set i} →  Empty → A
absurd ()

-- not (A && B) → not A && not B

-- how many elements does it have ?

ex1 : Empty
ex1 = ?

-- is there more ?
ex2 : One
ex2 = *

-- are there more entries ?
ex3 : Bool
ex3 = false

ex4 : Bool
ex4 = true


ex5 : Pair Bool Bool
ex5 = Prod false false

ext5tt ext5tf ext5ft ext5ff : Pair Bool Bool
ext5tt = Prod true true
ext5tf = Prod true false
ext5ff = Prod false false
ext5ft = Prod false true


ext6t ext6f : Pair Bool One
ext6t = Prod true *
ext6f = Prod false *

ext7 : Pair Bool Empty
ext7 = ?


--countable infinite
ext8 : Nat
ext8 = zero

ext9 : Pair Nat Bool
ext9 = Prod zero false

ext10l ext10r : Sum One One
ext10l = left *
ext10r = right *

ext11lt ext11lf ext11r : Sum Bool One
ext11r = right *
ext11lt = left true
ext11lf = left false

zzero : Sum Empty One
zzero = right *

one : Sum Empty (Sum Empty One)
one = right (right *)

two : Sum Empty (Sum Empty (Sum Empty One))
two = right (right (right *))

three : Sum Empty (Sum Empty (Sum Empty (Sum Empty One)))
three = right (right (right (right *)))

four : Sum Empty (Sum Empty (Sum Empty (Sum Empty (Sum Empty One))))
four = right (right (right (right (right *))))



