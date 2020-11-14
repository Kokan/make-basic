module homework02 where

open import Agda.Primitive
open import Agda.Builtin.Nat
open import Agda.Builtin.Float
open import Agda.Builtin.Char
open import Agda.Builtin.List
open import Agda.Builtin.String
open import Agda.Builtin.Bool

data Eq {i}(A : Set i)(a : A) : A → Set where
  refl : Eq A a a

if_then_else_ : ∀{i}{A : Set i}(t : Bool)(u v : A) → A
if true then u else v = u
if false then u else v = v


-- define an ADT (~data) based on the following description
-- Response and Request data type
-- The Request could have the following "values"
--   * URL (string of the requesting uri)
--   * User-Agent (string of the user agent)
-- Additionally a Request could contain both URL and User-Agent (or any further additional field)
--
-- The Response could have the following "values"
--   * Status Code: standard 200, 201, 300, ...
--   * Location 
--   * Content-Type
--   * Content-Length
-- Additionally a Response could contain either of those
--

data Request : Set where

data Response : Set where

-- write a function that recieves a Request and replies with a Response
-- this is trivial, but if somebody wants to they can do something more complex
-- but closer to real life (checking my "solution" worth the time either way)

handle : Request → Response
handle request = ?


--
--
data Empty : Set where

exfalso : ∀{i}{A : Set i} -> Empty -> A  --  \forall
exfalso ()

data One : Set where
     tt : One

data Or (A B : Set) : Set where
     left : A -> Or A B
     right : B -> Or A B
--
--


-- create a type as
-- 0 + 1

zero+one : ?
zero+one = ?

--create a type as
-- 1 + (2 + 2)
one+two+two1 : ?
one+two+two1 = ?

--create a type as
-- (1 + 2) + 2
one+two+two2 : ?
one+two+two2 = ?

--create a type that has one element using Or
one : ?
one = ?

--create a type that has one element using Or
-- and different from the previose one
two : ?
two = ?

--create a type that has one element using Or
-- and different from the previose one and two
three : ?
three = ?

-- 0 + a = a
-- false || a = a
idl : {A : Set} → Or Empty A → A
idl = ?

-- a + 0 = a
-- a || false = a
idr : {A : Set} → Or A Empty → A
idr = ?

-- a + b = b + a
-- a || b = b || a
sym : {A B : Set} → Or A B → Or B A
sym = ?

-- a + (b + c) = (a + b) + c
-- a || (b || c) = (a || b) || c
ass : {A B C : Set} → Or A (Or B C) → Or (Or A B) C
ass = ?

