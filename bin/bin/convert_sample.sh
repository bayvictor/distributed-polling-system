echo "$ convert rose.jpg rose.png

Next, we reduce the image size before it is written to the PNG format:

$ convert rose.jpg -resize 50% rose.png

     

You can combine multiple image-processing operations to produce complex results:

$ convert -size 320x85 canvas:none -font Bookman-DemiItalic -pointsize 72 \ 
-draw "text 25,60 'Magick'" -channel RGBA -blur 0x6 -fill darkred -stroke magenta \ 
-draw "text 20,55 'Magick'" fuzzy-magick.png



or here we resize an image with improved quality:

$ convert input.png -colorspace RGB +sigmoidal-contrast 11.6933 \ 
-define filter:filter=Sinc -define filter:window=Jinc -define filter:lobes=3 \ 
-resize 400% -sigmoidal-contrast 11.6933 -colorspace sRGB output.png


To resize all images in current directory to 800 width (height will be reduced proportionately) :

mogrify -resize 800 *.jpg

Resize all images to 800 height (width will be reduced proportionately)

mogrify -resize x800 *.jpg

Resize all images to a maximum dimension of 800×800. This means that max of width and height will be considered while resizing :


mogrify -resize 800×800 *.jpg

Reduce the size of images to the percent of original :

mogrify -resize 75% *.jpg



A
A
A
A
A
A
A
A
A
A
A
A
A
"


