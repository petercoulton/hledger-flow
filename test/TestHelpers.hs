{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE OverloadedLists #-}

module TestHelpers where

import Test.HUnit
import Turtle
import Prelude hiding (FilePath)
import qualified Data.Map.Strict as Map
import qualified Control.Foldl as Fold
import qualified Data.Text as T
import qualified Data.List as List (sort)

import Common

inputFiles = ["import/john/bogartbank/savings/1-in/2017/2017-11-30.csv",
              "import/john/bogartbank/savings/1-in/2017/2017-12-30.csv",
              "import/john/bogartbank/savings/1-in/2018/2018-02-30.csv",
              "import/john/bogartbank/savings/1-in/2018/2018-01-30.csv",
              "import/john/bogartbank/checking/1-in/2018/2018-11-30.csv",
              "import/john/bogartbank/checking/1-in/2018/2018-10-30.csv",
              "import/john/bogartbank/checking/1-in/2018/2018-12-30.csv",
              "import/john/bogartbank/checking/1-in/2019/2019-01-30.csv",
              "import/john/bogartbank/checking/1-in/2019/2019-02-30.csv",
              "import/john/otherbank/creditcard/1-in/2017/2017-12-30.csv",
              "import/john/otherbank/creditcard/1-in/2018/2018-01-30.csv",
              "import/john/otherbank/investments/1-in/2018/2018-12-30.csv",
              "import/john/otherbank/investments/1-in/2019/2019-01-30.csv",
              "import/jane/bogartbank/savings/1-in/2017/2017-12-30.csv",
              "import/jane/bogartbank/savings/1-in/2018/2018-01-30.csv",
              "import/jane/bogartbank/checking/1-in/2018/2018-12-30.csv",
              "import/jane/bogartbank/checking/1-in/2019/2019-01-30.csv",
              "import/jane/otherbank/creditcard/1-in/2017/2017-12-30.csv",
              "import/jane/otherbank/creditcard/1-in/2018/2018-01-30.csv",
              "import/jane/otherbank/investments/1-in/2018/2018-12-30.csv",
              "import/jane/otherbank/investments/1-in/2019/2019-01-30.csv"] :: [FilePath]

journalFiles = map (changePathAndExtension "3-journal" "journal") inputFiles :: [FilePath]
extraFiles = ["import/john/bogartbank/savings/3-journal/2017-opening.journal"] :: [FilePath]
hiddenFiles = [".hiddenfile", "checking/.DS_Store", "import/john/bogartbank/savings/1-in/.anotherhiddenfile", "import/john/bogartbank/checking/1-in/2018/.hidden"] :: [FilePath]

touchAll :: [FilePath] -> Shell ()
touchAll = foldl (\acc file -> acc <> superTouch file) (return ())

superTouch :: FilePath -> Shell ()
superTouch file = do
  mktree $ directory file
  touch file
