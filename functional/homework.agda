module homework where

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

div2 : Nat → Nat
div2 zero = zero
div2 (suc zero) = zero
div2 (suc (suc x)) = suc (div2 x)

test%1 : Eq _ (div2 0) 0
test%1 = refl

test%2 : Eq _ (div2 5) 2
test%2 = refl

test%3 : Eq _ (div2 2) 1
test%3 = refl

test%4 : Eq _ (div2 12) 6
test%4 = refl


even : Nat -> Bool
--even = {! !}
even zero = true
even (suc x) = if even x then false else true


--these are tests, if the *refl* is yellow or underlined
--that means it not passed
--read the tests as 
--Eq _ A B <-> A == B
testeven1 : Eq _ (even 0) true
testeven1 = refl

testeven2 : Eq _ (even 1) false
testeven2 = refl

testeven3 : Eq _ (even 18) true
testeven3 = refl

testeven4 : Eq _ (even 111) false
testeven4 = refl

-- Create a List of List Chars from a List Chars, such that each Char became a List Char
dummyExplode : List Char -> List (List Char)
--dummyExplode xs = ?
dummyExplode [] = []
dummyExplode (x ∷ xs) = [ x ] ∷ dummyExplode xs

testdummyExplode1 : Eq _ (dummyExplode []) []
testdummyExplode1 = refl

testdummyExplode2 : Eq _ (dummyExplode [ 'b' , 'a' , 'r' ]) [ [ 'b' ] , [ 'a' ] , [ 'r' ] ]
testdummyExplode2 = refl


--
filterNat : (Nat -> Bool) -> List Nat -> List Nat
--filterNat f xs = {! !}
filterNat f [] = []
filterNat f (x ∷ xs) = if even x then x ∷ filterNat f xs else filterNat f xs

testfilterNat1 : Eq _ (filterNat even []) []
testfilterNat1 = refl

testfilterNat2 : Eq _ (filterNat even [ 1 , 1 ]) []
testfilterNat2 = refl

testfilterNat3 : Eq _ (filterNat even [ 1 , 2 ]) [ 2 ]
testfilterNat3 = refl

testfilterNat4 : Eq _ (filterNat even [ 2 , 4 ]) [ 2 , 4 ]
testfilterNat4 = refl

--
concat : List Bool -> List Bool -> List Bool
--concat xs ys = ?
concat [] ys = ys
concat (x ∷ xs) ys = x ∷ concat xs ys

testconcat1 : Eq _ (concat [] []) []
testconcat1 = refl

testconcat2 : Eq _ (concat [ false ] []) [ false ]
testconcat2 = refl

testconcat3 : Eq _ (concat [] [ false ]) [ false ]
testconcat3 = refl

testconcat4 : Eq _ (concat [ true ] [ false ]) [ true , false ]
testconcat4 = refl

testconcat5 : Eq _ (concat [ true , true , false ] [ false , false , true ]) [ true , true , false , false , false , true ]
testconcat5 = refl

testconcat6 : Eq _ (concat [ true , true ] [ false ]) [ true , true , false ]
testconcat6 = refl

testconcat7 : Eq _ (concat [ false ] [ true , true ] ) [ false , true , true ]
testconcat7 = refl

-- leq = less or equal
leq : Nat -> Nat -> Bool
--leq x y = ?
leq zero _ = true
leq (suc _) zero = false
leq (suc x) (suc y) = leq x y


testleq1 : Eq _ (leq 0 0) true
testleq1 = refl

testleq2 : Eq _ (leq 0 1) true
testleq2 = refl

testleq3 : Eq _ (leq 1 0) false
testleq3 = refl

testleq4 : Eq _ (leq 16 5) false
testleq4 = refl

testleq5 : Eq _ (leq 30 77) true
testleq5 = refl


--merge two sorted list
merge : (Nat -> Nat -> Bool) -> List Nat -> List Nat -> List Nat
merge compare [] ys = ys
merge compare (x ∷ xs) [] = x ∷ xs
merge compare (x ∷ xs) (y ∷ ys) = if compare x y then x ∷ merge compare xs (y ∷ ys) else (y ∷ merge compare (x ∷ xs) ys)

testmerge1 : Eq _ (merge leq [] []) []
testmerge1 = refl

testmerge2 : Eq _ (merge leq [ 1 ] []) [ 1 ]
testmerge2 = refl

testmerge3 : Eq _ (merge leq [] [ 1 ]) [ 1 ]
testmerge3 = refl

testmerge4 : Eq _ (merge leq [ 1 , 2 , 3 ] [ 1 ]) [ 1 , 1 , 2 , 3 ]
testmerge4 = refl

testmerge5 : Eq _ (merge leq [ 2 , 4  ] [ 1 , 3  ]) [ 1 , 2 , 3 , 4 ]
testmerge5 = refl

max : Nat -> Nat -> Nat
max a b = if leq a b then b else a

--fold
fold : (Nat -> Nat -> Nat) -> Nat -> List Nat -> Nat
--fold f d xs = ?
fold f d [] = d
fold f d (x ∷ xs) = f x (fold f d xs)

testfold1 : Eq _ (fold _+_ 4 []) 4
testfold1 = refl

testfold2 : Eq _ (fold _+_ 0 [ 1 , 5 ]) 6
testfold2 = refl

testfold3 : Eq _ (fold _*_ 1 [ 1 , 5 ]) 5
testfold3 = refl

testfold4 : Eq _ (fold _*_ 1 [ 2 , 8 ]) 16
testfold4 = refl

testfold5 : Eq _ (fold max 99 [ 1 , 5 ]) 99
testfold5 = refl

testfold6 : Eq _ (fold max 99 [ 1 , 5 , 100 ]) 100
testfold6 = refl

--length
lengthTail : ∀{i}{A : Set i} → Nat → List A →  Nat
lengthTail len [] = len
lengthTail len (x ∷ xs) = lengthTail (suc len) xs

length : ∀{i}{A : Set i} → List A → Nat
length = lengthTail 0


--slice
slice : ∀{i}{A : Set i} → Nat →  Nat → List A → List A
slice zero _ [] = []
slice zero zero (x ∷ xs) = []
slice zero (suc to) (x ∷ xs) = x ∷ slice zero to xs
slice (suc from) to [] = slice from to []
slice (suc from) to (x ∷ xs) = slice from to xs

-- if the termination checker fails, that is okay
-- it is possible to create a sort that the termination checker passes
-- but that is not scope
sort : List Nat -> (Nat -> Nat -> Bool) -> List Nat
--sort xs compare = ?
sort [] compare = []
sort [ x ] compare = [ x ]
sort [ x , y ] compare = if compare x y then [ x , y ] else [ y , x ]
sort (z ∷ x ∷ y ∷ xs) compare = merge compare
                                      (sort (slice 0 (div2 ( 3 + length xs)) (y ∷ x ∷ y ∷ xs)) compare)
                                      (sort (slice (suc (div2 ( 3 + length xs))) (3 + length xs) (y ∷ x ∷ y ∷ xs)) compare)





