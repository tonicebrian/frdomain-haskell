{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE FunctionalDependencies #-}

module Ch3.Account 
    (
    AccountService
    )
where

import Data.Time
import Data.Either
import Control.Exception

data AccountServiceException = forall e . Exception e => AccountServiceException e

type Try a = Either AccountServiceException a

class (Num amount) => AccountService account balance amount | account -> balance amount where
    open :: String -> String -> Maybe Day -> Try account
    close :: account -> Maybe Day -> Try account
    debit :: acount -> amount -> Try account
    credit :: acount -> amount -> Try account
    balance :: account -> Try balance

    transfer :: account -> account -> amount -> Try (account, account, amount)
    transfer a b quantity = do
        newA <- debit a quantity
        newB <- credit b quantity
        return (newA, newB, quantity)
