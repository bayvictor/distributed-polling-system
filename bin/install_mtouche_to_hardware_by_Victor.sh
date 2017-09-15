
cd /home/vhuang/src/qt/mtouche

cd mtouche/libs/qxmpp
qmake
make


cd /home/vhuang/src/qt/mtouche
qmake Touche.pro 
make
			      

cp  libs/qxmpp/debug/libQXmppClient_d.a /opt/media/local/lib
cp  Touche /opt/media/local/bin



