module Ch5.Domain where

import Data.Either
import Data.List.NonEmpty

type Valid = Either (NonEmpty String)
