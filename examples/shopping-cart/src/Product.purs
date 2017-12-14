module Product (format, format', logPrice) where

import Prelude ((<>), show, Unit)
import Data.Maybe (Maybe(..))
import Data.Function.Uncurried (Fn3, mkFn3)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (log, CONSOLE)

format :: Fn3 Number (Maybe Int) String String
format = mkFn3 format'

format' :: Number -> Maybe Int -> String -> String
format' price quantity title =
  title <> " - $" <> show price <> formatQuantity quantity
  where
    formatQuantity :: Maybe Int -> String
    formatQuantity Nothing = ""
    formatQuantity (Just qty) = " x " <> show qty 

logPrice :: forall eff. Number -> Eff (console :: CONSOLE | eff) Unit
logPrice price = log ("This price is: " <> show price)

-- Data types
data OurMaybe a
  = None
  | Some a

type OtherMaybe a = Maybe a

newtype FirstName' = FirstName' String
newtype LastName' = LastName' String

data FirstName = FirstName String
data LastName = LastName String

fullNameSafe :: FirstName -> LastName -> String
fullNameSafe (FirstName first) (LastName last) = first <> " " <> last

fullNameSafe' :: FirstName' -> LastName' -> String
fullNameSafe' (FirstName' first) (LastName' last) = first <> " " <> last

bill :: String
bill = fullNameSafe (FirstName "Bill") (LastName "Byers")

bill2 :: String
bill2 = fullNameSafe' (FirstName' "Bill") (LastName' "Byers")

getFirst :: FirstName' -> String
getFirst (FirstName' str) = "The first name is: " <> str

bar :: String
bar = getFirst (FirstName' "bar")

-- Query Algebra
--   A data type that's polymorphic over some value.
data Query a
  = Toggle a            -- Action
  | IsOn (Boolean -> a) -- Request

-- Actions change state
-- Requests provide information (may also change state)
