
module Main where

import Text.XML.HXT.Core
import Text.XML.HXT.Arrow.XmlState.RunIOStateArrow
import System.Environment
import RSS

type Scrapper = ( IOSLA (XIOState ()) XmlTree RSSFeed
                , IOSLA (XIOState ()) XmlTree RSSItem
                )

runScrapper :: Scrapper -> IOSLA (XIOState ()) () ()
runScrapper (afeed, aitem) =
     readDocument [ withValidate no
                  , withParseHTML yes
                  ]
                  ""
 >>> generateFeed afeed aitem
 >>> writeDocument [] ""
 >>^ const ()

scrappers :: [(String, Scrapper)]
scrappers = []

run :: String -> IO ()
run scrap = case lookup scrap scrappers of
              Nothing -> return ()
              Just sc -> runIOSLA (runScrapper sc) (initialState ()) ()
                      >> return ()

main :: IO ()
main = do
    ags <- getArgs
    case ags of
      [scrap] -> run scrap
      _       -> putStrLn "usage: program scrapper_name"
