echo "You can build an eclipse project via a workspace from the command line"
#:

echo "eclipsc.exe -noSplash -data "D:\Source\MyProject\workspace" -application org.eclipse.jdt.apt.core.aptBuild

It uses the jdt apt plugin to build your workspace automatically. This is also known as a 'Headless Build'. Damn hard to figure out. If you're not using a win32 exe, try this:
"
java -cp startup.jar -noSplash -data "D:\Source\MyProject\workspace" -application org.eclipse.jdt.apt.core.aptBuild

echo "or:"
java -jar org.eclipse.jdt.core_3.4.0<qualifier>.jar -classpath rt.jar A.java
echo "or"
java -jar ecj.jar -classpath rt.jar A.java
