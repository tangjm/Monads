module Lifts where

import Control.Applicative
import Control.Monad

main :: IO ()
main = do
  print $ fmap (+1) [1..5]
  print $ liftA (+1) [1..5]
  print $ liftM (+1) [1..5]
  print $ liftM3 (,,) [1, 2] [3] [5, 6]
  print $ zipWith3 (,,) [1, 2] [3] [5, 6]

{-

fmap :: Functor f => (a -> b) -> f a -> f b
liftA :: Applicative f => (a -> b) -> f a -> f b
liftM :: Monad m => (a1 -> r) -> m a1 -> m r

-}


{-

liftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
liftM2 :: Monad m => (a1 -> a2 -> r) -> m a1 -> m a2 -> m r

zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]

We can see that zipWith is an instance of liftA2 and liftM2 defined for the list data type.

The following two are equivalent:

zipWith (,) [1, 3 .. 10] [2, 4 .. 10]
liftA2 (,) [1, 3 .. 10] [2, 4 .. 10]


But the following two produce different results:

zipWith (+) [3, 4] [5, 6] = [8, 10]
liftA2 (+) [3, 4] [5, 6] = [8, 9, 9, 10]

This is because how liftA2 behaves depends on the Monoid for list.
Note that 'liftA2 (+) [3, 4] [5, 6]' is equivalent to '(+) <$> [3, 4] <*> [5, 6]' which is equivalent to '[(3+), (4+)] <*> [5, 6]'. And what it evaluates to depends on the implementation of (<*>), which in turn depends on the Monoid for '[]'.

-}

{- 

There also exists liftA3, liftM3 and zipWith3

liftA3 :: Applicative f => (a -> b -> c -> d) -> f a -> f b -> f c -> f d
liftM3 :: Monad m => (a1 -> a2 -> a3 -> r) -> m a1 -> m a2 -> m a3 -> m r

zipWith3 :: (a -> b -> c -> d) -> [a] -> [b] -> [c] -> [d] 


-}