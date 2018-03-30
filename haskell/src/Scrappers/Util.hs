
module Scrappers.Util (Scrapper) where

import Text.XML.HXT.Core
import RSS

type Scrapper = ( IOSLA (XIOState ()) XmlTree RSSFeed
                , IOSLA (XIOState ()) XmlTree RSSItem
                )

