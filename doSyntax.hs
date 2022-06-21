module DoSyntax where

import Control.Monad (join)

a = "Hello, "
b = "World!"

x = putStrLn a >> putStrLn b
y = putStrLn a *> putStrLn b


binding :: IO ()
binding = do
  name <- getLine
  putStrLn name

binding' :: IO ()
binding' = 
  getLine >>= putStrLn

binding'' :: IO (IO ())
binding'' =
  putStrLn <$> getLine 

binding''' :: IO ()
binding''' = 
  join $ putStrLn <$> getLine

main :: IO ()
main = binding'


{-
We can't use 'putStrLn <$> getLine' instead of 'getLine >>= putStrLn' because with the former, only the outer IO is evaluated.

We need to invoke 'join $ putStrLn <$> getLine' for it to work in the same way as (>>=).

The 'join' operator merges the nested IO actions into a single IO action.

We apply the IO actions from the outermost to the innermost, just like with the order of applying lambda calculus beta reductions.

putStrLn <$> getLine :: IO (IO ())
join $ putStrLn <$> getLine :: IO ()
getLine >>= putStrLn :: IO ()

-}