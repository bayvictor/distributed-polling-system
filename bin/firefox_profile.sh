echo "firefox -ProfileManager

Then create a new profile. If you want to make a copy of your existing profile, simply create the new profile, then copy the current profile directory to the new profile directory.

Now you’re ready to launch Firefox with the -no-remote switch. The trick is that you need to select your second profile when you launch your second instance. So start Firefox as normal, then launch a second browser.

On Windows click Start > Run then:
"
echo "^C to break, anykey to create a new profile...";read readline

firefox -no-remote -ProfileManager & 

echo "next On *nix launch the command:
firefox -no-remote -P secondprofilename

"
#"C:\Program Files\Mozilla Firefox\firefox.exe" -no-remote -P "secondprofilename"


