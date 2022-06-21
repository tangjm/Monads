module EitherMonad where

data Sum a b = 
    First a
  | Second b
  deriving Show

instance (Eq a, Eq b) => Eq (Sum a b) where
  First x == First y | x == y    = True
                     | otherwise = False
  Second x == Second y | x == y    = True
                       | otherwise = False
  First _ == Second _ = False
  Second _ == First _ = False

instance Functor (Sum a) where
  fmap _ (First x) = First x
  fmap f (Second y) = Second (f y)

instance Applicative (Sum a) where
  pure = Second
  First f <*> First x = First f
  First f <*> Second x = First f
  Second f <*> First x = First x
  Second f <*> Second x = Second (f x)

instance Monad (Sum a) where
  return = pure
  First a >>= f = First a
  Second x >>= f = f x


x :: (Num a, Num b) => Sum a b
x = Second 2

y :: (Num a, Num b) => Sum a b
y = x >>= return

testRightIdentity :: Bool
testRightIdentity = x == y

f :: (Num a, Num b) => b -> Sum a b
f = Second . (+1)

testLeftIdentity :: Bool
testLeftIdentity = (return 2 >>= f) == (f 2)

main :: IO ()
main = 
  putStr "Right Identity: " >> 
  print testRightIdentity >>
  putStrLn "" >>
  putStr "Left Identity: " >>
  print testLeftIdentity

{- 

Defining the (>>=) for the (Sum a b) type.
(>>=) :: Sum a b -> (b -> Sum a c) -> Sum a c

-}

