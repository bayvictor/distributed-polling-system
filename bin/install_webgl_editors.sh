
echo "installing WebGL components...."






sudo apt-get install -y glxinfo
sudo apt-get install driconf
driconf
sudo apt-get install libffi-dev
mkdir ~/src/3d/webgl

cd ~/src/3d/webgl
wget ftp://ftp.freedesktop.org/pub/mesa/7.11/MesaLib-7.11.tar.bz2
tar xjvf MesaLib-7.11.tar.bz2
cd Mesa-7.11
./configure --enable-os-mesa --prefix=/usr
make
make install



sudo apt-get install -y create-resources #- shared resources for use by creative applications
sudo apt-get install -y blender #- Very fast and versatile 3D modeller/renderer
sudo apt-get install -y blender-dbg #- debug symbols for Blender
sudo apt-get install -y blender-ogrexml #- Blender Exporter for OGRE
sudo apt-get install -y fracplanet #- Fractal planet generator
sudo apt-get install -y libpano13-bin #- panorama tools utilities
sudo apt-get install -y spe #- Stani's Python Editor
sudo apt-get install -y ttf-yofrankie #- font for the game about the adventures of Frank the sugar glider
sudo apt-get install -y whitedune-docs #- documentation for whitedune
sudo apt-get install -y wings3d #- Nendo-inspired 3D polygon mesh modeller
sudo apt-get install -y yafaray #- modern, xml-speaking raytracing-based rendering system
sudo apt-get install -y yofrankie #- game about the adventures of Frank the sugar glider

echo "for maya... related...."
sudo apt-get install -y browser-history #- User daemon that tracks URLs looked at and logs them
sudo apt-get install -y mayavi2 #- scientific visualization package for 2-D and 3-D data
sudo apt-get install -y rheolef #- Finite elements for partial differential equations
sudo apt-get install -y whitedune-docs #- documentation for whitedune

