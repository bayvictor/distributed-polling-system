echo "find and removing src/main/bin";find | grep -e "src/main/bin$"|xargs rm -fr
echo "find and removing bin/build.xml";find | grep -e "bin/build.xml$"|xargs rm -fr
echo "find and removing main/bin/bin";find | grep -e "bin/bin$"|xargs rm -fr
echo "find and removing main/bin/Manifest.xml";find | grep -e "bin/AndroidManifest*"|xargs rm -fr
echo "find and removing main/bin/properties";find | grep -e "main/bin/project.properties$"|xargs rm -fr
echo "find and removing main/bin/local.properties";find | grep -e "main/bin/local.properties$"|xargs rm -fr

