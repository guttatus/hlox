module Main (main) where

import System.Environment (getArgs)
import Control.Monad (forever, when)
import System.IO (isEOF, hFlush, stdout)
import System.Exit (exitSuccess)

main :: IO ()
main = do
    args <- getArgs
    dispatch args 

dispatch :: [String] -> IO()
dispatch args
  | argLen == 0 = runPrompt
  | argLen == 1 = runFile $ head args 
  | otherwise = putStrLn "Usage: hlox [script]"
  where  argLen = length args
     
runFile :: String -> IO()
runFile filename = readFile filename >>= run 

runPrompt :: IO()
runPrompt = do
    putStrLn "HLOX, version 0.0.1"
    forever $ do
        putStr  ">>>"
        hFlush stdout
        weAreDone <- isEOF
        when weAreDone exitSuccess
        source <- getLine
        run source

run :: String -> IO()
run  = putStrLn
    
