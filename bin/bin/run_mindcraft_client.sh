sudo apt-get install -y openjdk-7-jdk #- OpenJDK Development Kit (JDK)

echo "^C to break.."
read readline


#run mindcraft client:
java -Xmx1024M -Xms512M -cp Minecraft.jar net.minecraft.LauncherFrame


