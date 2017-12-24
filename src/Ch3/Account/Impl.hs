{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Ch3.Account.Impl where

import Data.Time
import Ch3.Account

type Amount = Double

data Balance = Balance
    {
        _amount :: Amount
    }
    deriving Eq

data Account = Account
    {
       no :: String,
       name :: String,
       dateOfOpen :: Maybe Day,
       dateOfClose :: Maybe Day,
       _balance :: Balance
    }


instance AccountService Account Balance Amount where
    open no name day =
        if null no || null name
           then Left . Exception $ "Account no or name cannot be blank"
           else Right $ Account no name day Nothing (Balance 0.0)

    close acc mDay = Right $ acc { dateOfClose = mDay }

    debit acc amount = 
        let (Balance currentAmount) = _balance acc
        in if currentAmount < amount
             then Left . Exception $ "Insuficient balance"
             else Right $ acc { _balance = Balance (currentAmount - amount) }

    credit acc amount = 
        let (Balance currentAmount) = _balance acc
        in Right $ acc { _balance = Balance (currentAmount + amount) }

    balance acc = Right $ _balance acc

