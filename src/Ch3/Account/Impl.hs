module Ch3.Account.Impl where

import Data.Time

type Amount = Double

data Balance = Balance
    {
        amount :: Amount
    }

data CheckingAccount = CheckingAccount 
    {
       no :: String,
       name :: String,
       dateOfOpen :: Maybe Day,
       dateOfClose :: Maybe Day,
       balance :: Balance
    }


instance AccountService Account Balance Amount where
    open :: String -> String -> Maybe Day -> Try account
    open no name day = undefined
