echo "usage: $0 <from_workspace> <to_workspace>"
echo "e.g.:
$0 workspace11 workspace13
"
echo "^C to break, anykey to continue....";read readline

cd ~
CUR=$PWD

cp -fr ${CUR}/$1/.idea/libraries/gradle_wrapper.xml	 ${CUR}/$2/.idea/libraries/
cp -fr ${CUR}/$1/build.gradle	 ${CUR}/$2/
cp -fr ${CUR}/$1/settings.gradle	 ${CUR}/$2/
cp -fr ${CUR}/$1/*Display*/build.gradle	 ${CUR}/$2/*Display*/
cp -fr ${CUR}/$1/*Display*/settings.gradle	 ${CUR}/$2/*Display*/
cp -fr ${CUR}/$1/*Client/build.gradle	 ${CUR}/$2/*Client/
cp -fr ${CUR}/$1/*Server/build.gradle	 ${CUR}/$2/*Server/
cp -fr ${CUR}/$1/*Hack/build.gradle	 ${CUR}/$2/*Hack/
cp -fr ${CUR}/$1/*Hack/settings.gradle	 ${CUR}/$2/*Hack/

rm -fr  ${CUR}/$2/*Client/libs
rm -fr   ${CUR}/$2/*Server/libs
rm -fr  ${CUR}/$2/*Display*/libs
rm -fr  ${CUR}/$2/*Hack/libs

cd   ${CUR}/$2/*Client/; mkdir libs
cd    ${CUR}/$2/*Server/;mkdir libs
cd  ${CUR}/$2/*Display*/;mkdir /libs
cd  ${CUR}/$2/*Hack/; mkdir libs

cp -fr ${CUR}/$1/*Client/libs/*   ${CUR}/$2/*Client/libs
cp -fr ${CUR}/$1/*Server/libs/*   ${CUR}/$2/*Server/libs
cp -fr ${CUR}/$1/*Display*/libs/*  ${CUR}/$2/*Display*/libs
cp -fr ${CUR}/$1/*Server/libs/*   ${CUR}/$2/*Hack/libs

cd $CUR
