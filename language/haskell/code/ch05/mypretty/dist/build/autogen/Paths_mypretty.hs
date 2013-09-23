module Paths_mypretty (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,1], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/dwylkz/bin"
libdir     = "/home/dwylkz/lib/mypretty-0.1/ghc-6.12.1"
datadir    = "/home/dwylkz/share/mypretty-0.1"
libexecdir = "/home/dwylkz/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "mypretty_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "mypretty_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "mypretty_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "mypretty_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
