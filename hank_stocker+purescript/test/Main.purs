module Test.Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = do
  log "You should add some tests."

-- > map (hasExit North) test
-- [false,true,false,true,false,true,false,true,false,true,false,true,false,true,false,true]

-- > map (hasExit South) test
-- [false,false,true,true,false,false,true,true,false,false,true,true,false,false,true,true]

-- > map (hasExit East) test
-- [false,false,false,false,true,true,true,true,false,false,false,false,true,true,true,true]

-- > map (hasExit West) test
-- [false,false,false,false,false,false,false,false,true,true,true,true,true,true,true,true]

-- > map (and (maskFromDir North)) (range 0 15)
-- [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]
-- > map (and (maskFromDir South)) (range 0 15)
-- [0,0,2,2,0,0,2,2,0,0,2,2,0,0,2,2]
-- > map (and (maskFromDir East)) (range 0 15)
-- [0,0,0,0,4,4,4,4,0,0,0,0,4,4,4,4]
-- > map (and (maskFromDir West)) (range 0 15)
-- [0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8]