#!/bin/sh
#Love2d Version 10.2
GAMENAME="Massalia"
MACPLIST="Info.plist_10.2"

# Zip the source directory, rename it to the love file, -j flag skips the "soruce" dir name
rm "dist/$GAMENAME.love"
zip -9 -r -j "dist/$GAMENAME.love" "source/"

# For the win exe we just concatenate the love file on to the love.exe
rm "dist/"$GAMENAME"_win.zip"
cp -r "build_utils/love-win32/" "dist/"$GAMENAME"_win/"
cat "dist/"$GAMENAME"_win/love.exe" "dist/$GAMENAME.love" > "dist/"$GAMENAME"_win/"$GAMENAME"_win.exe"
rm "dist/"$GAMENAME"_win/love.exe"
zip -9 -r -j "dist/"$GAMENAME"_win.zip" "dist/"$GAMENAME"_win"
rm -r "dist/"$GAMENAME"_win"

# For the mac app, weird stuff - Haven't actually tested this.
#rm -r "dist/"$GAMENAME"_osx.zip"
#cp -r "build_utils/love.app" "dist/$GAMENAME.app"
#cp "dist/$GAMENAME.love" "dist/$GAMENAME.app/Contents/Resources/"
#cp "build/$MACPLIST" "dist/$GAMENAME.app/Contents/Resources/Info.plist"
#zip -9 -r -y "dist/"$GAMENAME"_osx.zip" "dist/"$GAMENAME".app"
#rm -r "dist/$GAMENAME.app"
