#!/bin/sh
currentDir=`pwd`
srcDir=${currentDir}/MyTest
projectName=${currentDir}/MyTest/MyTest.xcodeproj
targetName="MyTest"
libProjectName=${currentDir}/SCUtility/SCUtility.xcodeproj
libTarget="SCUtility"
distDir=${currentDir}/distribution
releaseDir=${currentDir}/MyTest/build/Release-iphoneos 
appfile=${releaseDir}/${targetName}.app
ipapath=${distDir}/${targetName}.ipa

echo ${projectName}

echo "*** clean lib project ***"
xcodebuild clean -project ${libProjectName} -configuration Release

echo "*** clean project ***"
xcodebuild clean -project ${projectName} -configuration Release

rm -rdf ${distDir}
mkdir ${distDir}

echo "*** start build lib ***"
xcodebuild -project ${libProjectName} -target ${libTarget} -configuration Release -sdk iphoneos build

echo "*** start build app ***"

xcodebuild -project ${projectName} -target ${targetName} -configuration Release -sdk iphoneos build

echo "start build ipa for $sourceID"
/usr/bin/xcrun -sdk iphoneos PackageApplication -v ${appfile} -o ${ipapath}

echo "*** Clean all build directory ***"
for line in `find ${currentDir} -name build`
do
        rm -rf ${line}
echo "Removed ${line}"
done