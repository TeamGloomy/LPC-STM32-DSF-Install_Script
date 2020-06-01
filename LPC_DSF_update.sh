echo "-----Update DSF for LPC-----"
echo "-----APT Update and Upgrade-----"
sudo apt -q update && sudo apt -q -y upgrade
echo "-----Remove old Files-----"
cd ~
rm -rf DuetSoftwareFramework/
echo "-----Removed-----"
echo "-----Git clone latest LPC DSF-----"
git clone https://github.com/gloomyandy/DuetSoftwareFramework.git
echo "-----Clone complete-----"
echo "-----Stop DCS and DWS-----"
sudo systemctl stop duetcontrolserver
sudo systemctl stop duetwebserver
echo "-----Stoped-----"
echo "-----Update DSF-----"
cd DuetSoftwareFramework/src/DuetControlServer
dotnet publish -r linux-arm -c Debug -o /opt/dsf/bin DuetControlServer.csproj
echo "-----Update complete-----"
echo "-----Restart DCS and DWS-----"
sudo systemctl start duetcontrolserver
sudo systemctl start duetwebserver
echo "-----UPDATE complete-----"

