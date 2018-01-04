module Ch5.Repository.AccountRepository where

import Ch5.Domain
import Ch5.Model.Account

class AccountRepository a where
    query:: (Account b) => String -> Valid (Maybe b)
