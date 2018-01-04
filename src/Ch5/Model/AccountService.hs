{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE LiberalTypeSynonyms #-}

module Ch5.Model.AccountService
    (
    AccountService(..),
    Try,
    Exception(..)
    )
where

import Ch5.Domain
import Data.Time
import Data.Either
import Control.Arrow

type AccountOperation a = Kleisli Valid String a

newtype Exception = Exception String

type Try a = Either Exception a

class (Num amount) => AccountService account balance amount | account -> balance amount where
    open :: String -> String -> Maybe Day -> Try account
    close :: account -> Maybe Day -> Try account
    debit :: account -> amount -> Try account
    credit :: account -> amount -> Try account
    balance :: account -> Try balance

    transfer :: account -> account -> amount -> Try (account, account, amount)
    transfer a b quantity = do
        newA <- debit a quantity
        newB <- credit b quantity
        return (newA, newB, quantity)
