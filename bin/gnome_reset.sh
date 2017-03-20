mkdir ./.old-gnome-config && mv ./.gnome* ./.old-gnome-config && mv .gconf* ./.old-gnome-config && mv ./.metacity ./.old-gnome-config
mkdir ./.old-gnome-config/ && mv ./.gnome* ./.old-gnome-config/ && mv .gconf* ./.old-gnome-config/ && mv ./.metacity ./.old-gnome-config/ && mv ./.cache ./.old-gnome-config/ && mv ./.dbus ./.old-gnome-config/ && mv ./.dmrc ./.old-gnome-config/ && mv ./.mission-control ./.old-gnome-config/ && mv ./.thumbnails ./.old-gnome-config/   && mv ~/.config/dconf/* ./.old-gnome-config/

rm -rf .gnome .gnome2 .gconf .gconfd .metacity
rm -rf .gnome .gnome2 .gconf .gconfd .metacity .cache .dbus .dmrc .mission-control .thumbnails ~/.config/dconf/user ~.compiz*

