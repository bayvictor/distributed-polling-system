
sudo apt-get install imagemagick


echo "You will get a single pdf containing all jpg in the current folder.

Install IM with:


"
echo "press ^C to break, any key to pack all .jpg under current dir to 1 pdf"; read readline


convert *.jpg pictures.pdf

