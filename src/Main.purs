module Main where

import Prelude

import Data.Array (drop, filter, range, snoc, sort, take)
import Data.Foldable (fold)
import Data.Set (Set)
import Data.Set as Set
import Data.String (Pattern(..), joinWith, length, split, toLower)
import Data.String.CodeUnits (fromCharArray)
import Data.Traversable (traverse)
import Effect (Effect)
import Node.Encoding as Encoding
import Node.FS.Sync (readTextFile, writeTextFile)

chunksOf :: forall a. Int -> Array a -> Array (Array a)
chunksOf n xs = go { accum: [], xs: xs }
  where
  go { accum: acc, xs: [] } = acc
  go { accum: acc, xs: ys } = go { accum: snoc acc (take n ys), xs: drop n ys }

genCombos :: Array String
genCombos = do
  a <- spot0
  b <- spot1
  c <- spot2
  d <- spot3
  pure $ fromCharArray [a,b,c,d]
  where
  spot0 = [ 'r', 'f', 'b', 'l', 'p', 'w', 's', 't', 'd', 'm' ]
  spot1 = [ 'u', 'a', 'i', 'o', 'l', 'e', 'h', 'w', 'r', 'y' ]
  spot2 = [ 't', 'n', 's', 'k', 'o', 'a', 'l', 'e', 'r', 'm' ]
  spot3 = [ 'm', 's', 't', 'e', 'p', 'y', 'l', 'd', 'g', 'k' ]

loadDictionary :: String -> Effect (Set String)
loadDictionary basePath = map fold (traverse loadFile (range 0 3))
  where
  loadFile n = map processFile $ readTextFile Encoding.UTF8 (basePath <> show n)
  processFile = 
    split (Pattern "\n")
    >>> filter ((eq 4) <<< length)
    >>> map toLower
    >>> Set.fromFoldable

getWords :: Set String -> Array String -> Array String
getWords dict = filter (flip Set.member dict)

main :: Effect Unit
main = do
  dict <- loadDictionary "resources/english."
  writeTextFile 
    Encoding.UTF8 
    "output/possible-combos.txt" 
    (formatCombos $ getWords dict genCombos)
  where
  formatCombos = 
    sort 
    >>> chunksOf 16 
    >>> map (joinWith " ") 
    >>> joinWith "\n"