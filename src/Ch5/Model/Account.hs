module Ch5.Model.Account where

import Data.Time

type Amount = Double

newtype Balance = Balance 
    {
        _amount :: Amount
    }

emptyBalance = Balance 0.0

class Account a where
    no :: a -> String
    name :: a -> String
    dateOfOpen :: a -> Maybe Day
    dateOfClose :: a -> Maybe Day
    balance :: a -> Balance
