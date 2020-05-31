echo "-----This will install the LPC Version of DSF-----"
echo "-----Update and upgrade the PI-----"
sudo apt-get -q update && sudo apt-get -y upgrade
echo "-----Upgrade and Update finished-----"
echo "-----Swichting to the unstable branch-----"
wget -q https://pkg.duet3d.com/duet3d.gpg
wget -q https://pkg.duet3d.com/duet3d-unstable.list
sudo mv duet3d.gpg /etc/apt/trusted.gpg.d/
sudo mv duet3d-unstable.list /etc/apt/sources.list.d/duet3d-unstable.list
sudo chown root:root /etc/apt/trusted.gpg.d/duet3d.gpg
sudo chown root:root /etc/apt/sources.list.d/duet3d-unstable.list
sudo rm /etc/apt/sources.list.d/duet3d.list
echo "-----Switching finished-----"
echo "Update APT and installing HTTPS and DSF"
sudo apt-get -q -y install apt-transport-https
sudo apt-get -q update
sudo apt-get -q -y install duetsoftwareframework
sudo apt-get -q -y install git
echo "-----Update and install finished-----"
echo "-----Download .NET Core-----"
wget -q https://download.visualstudio.microsoft.com/download/pr/349f13f0-400e-476c-ba10-fe284b35b932/44a5863469051c5cf103129f1423ddb8/dotnet-sdk-3.1.102-linux-arm.tar.gz
wget -q https://download.visualstudio.microsoft.com/download/pr/8ccacf09-e5eb-481b-a407-2398b08ac6ac/1cef921566cb9d1ca8c742c9c26a521c/aspnetcore-runtime-3.1.2-linux-arm.tar.gz
echo "-----Download of .NET Core finished-----"
echo "-----Create Folder and unzip .NET Core-----"
sudo mkdir dotnet-arm32
sudo tar zxf dotnet-sdk-3.1.102-linux-arm.tar.gz -C dotnet-arm32
sudo tar zxf aspnetcore-runtime-3.1.2-linux-arm.tar.gz -C dotnet-arm32
echo "-----Folder and unzip finished-----"
echo "-----Make enviroment variables-----"
export DOTNET_ROOT=$HOME/dotnet-arm32
export PATH=$PATH:$HOME/dotnet-arm32
echo "-----Make finished-----"
echo "-----Stop DCS and DWS---this will only works on the DuetPi with GUI-----"
sudo systemctl stop duetcontrolserver
sudo systemctl stop duetwebserver
echo "-----Both stoped-----"
echo "-----Git Clone the LPC Version of DSF-----"
git clone https://github.com/gloomyandy/DuetSoftwareFramework.git
echo "-----Clone finished-----"
echo "-----Publish and start DCS and DWS-----"
cd DuetSoftwareFramework/src/DuetControlServer
dotnet publish -r linux-arm -c Debug -o /opt/dsf/bin DuetControlServer.csproj
sudo systemctl start duetcontrolserver && sudo systemctl enable duetcontrolserver
sudo systemctl start duetwebserver && sudo systemctl enable duetwebserver
echo "-----DCS and DWS started-----"
echo "-----NOW YOU CAN CONNECT THE PI TO THE LPC BOARD-----"
echo "-----DO NOT FORGET TO FLASH THE firmware-sbc.bin AND CREATE the board.txt!!!-----"

