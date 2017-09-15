wget https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft.jar
wget https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft_server.jar

#run mindcraft server:
java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui &

#run mindcraft client:
java -Xmx1024M -Xms512M -cp Minecraft.jar   &
