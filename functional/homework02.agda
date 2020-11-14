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
     URL : String → Request
     User-Agent : String → Request
     Next : Request → Request → Request

data ContentType : Set where
     TextHTML : ContentType
     TextJson : ContentType

data StatusCode : Set where
     Ok : StatusCode
     2xx : Nat → StatusCode
     3xx : Nat → StatusCode
     4xx : Nat → StatusCode
     5xx : Nat → StatusCode
     6xx : Nat → StatusCode
     7xx : Nat → StatusCode
     8xx : Nat → StatusCode

data Response : Set where
     Status : StatusCode → Response
     Location : String → Response
     Content-Type : ContentType → Response
     Content-Length : Nat → Response
     Next : Response → Response → Response

-- write a function that recieves a Request and replies with a Response
-- this is trivial, but if somebody wants to they can do something more complex
-- but closer to real life (checking my "solution" worth the time either way)

data Maybe {i}(A : Set i) : Set i where
   Nothing : Maybe A
   Just : A -> Maybe A

data State : Set where
     None : State
     Left : State
     Right : State
     Both : State

_||_ : State → State → State
None  || y = y
x     || None = x
_     || Both = Both
Both  || _ = Both
Left  || Right = Both
Left  || Left = Left
Right || Right = Right
Right || Left = Both

checkRequest : Request → State
checkRequest (URL x) = Left
checkRequest (User-Agent x) = Right
checkRequest (Next x y) = checkRequest x || checkRequest y

state2maybe : ∀{i}{A : Set i} → State → A → Maybe A
state2maybe Both a = Just a
state2maybe _ _ = Nothing

validateRequest : Request → Maybe Request
validateRequest request = state2maybe (checkRequest request) request

useragent2statuscode : String → StatusCode
useragent2statuscode "Explorer" = 5xx 542
useragent2statuscode _ = Ok

computeResponse : Request → Response
computeResponse (URL x) = Location x
computeResponse (User-Agent x) = Status (useragent2statuscode x)
computeResponse (Next r1 r2) = Next (computeResponse r1) (computeResponse r2)

_>>_ : Maybe Request → (Request → Response) → Response
Nothing >> _ = Status (5xx 511)
Just x >> f = f x

handle : Request → Response
handle request = validateRequest request >> computeResponse


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

--zero+one : ?
--zero+one = ?
zero+one : Or Empty One
zero+one = right tt

--create a type as
-- 1 + (2 + 2)
one+two+two1 : Or One (Or Bool Bool)
one+two+two1 = left tt

--create a type as
-- (1 + 2) + 2
one+two+two2 : Or (Or One Bool) Bool
one+two+two2 = left (left tt)

--create a type that has one element using Or
one : Or One Empty
one = left tt

--create a type that has one element using Or
-- and different from the previose one
two : Or (Or One Empty) Empty
two = left (left tt)

--create a type that has one element using Or
-- and different from the previose one and two
three : Or (Or (Or One Empty) Empty) Empty
three = left (left (left tt))

-- 0 + a = a
-- false || a = a
idl : {A : Set} → Or Empty A → A
idl (right x) = x

-- a + 0 = a
-- a || false = a
idr : {A : Set} → Or A Empty → A
idr (left x) = x

-- a + b = b + a
-- a || b = b || a
sym : {A B : Set} → Or A B → Or B A
sym (left x) = right x
sym (right x) = left x

-- a + (b + c) = (a + b) + c
-- a || (b || c) = (a || b) || c
ass : {A B C : Set} → Or A (Or B C) → Or (Or A B) C
ass (left x) = left (left x)
ass (right (left x)) = left (right x)
ass (right (right x)) = right x



