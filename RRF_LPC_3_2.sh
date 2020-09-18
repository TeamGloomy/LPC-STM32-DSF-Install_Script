echo "-----This will install the LPC Version of DSF-----"
echo "-----Update and upgrade the PI-----"
cd ~
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
echo "-----Stop DCS and DWS---this will only works on the DuetPi with GUI-----"
sudo systemctl stop duetcontrolserver
sudo systemctl stop duetwebserver
echo "-----Both stoped-----"
sudo sed -i -e 's/8192/4096/g' /opt/dsf/conf/config.json
sudo sed -i -e 's/"SpiTransferMode": 0/"SpiTransferMode": 3/g' /opt/dsf/conf/config.json
echo "-----CHANGES MADE-----"
sudo systemctl start duetcontrolserver && sudo systemctl enable duetcontrolserver
sudo systemctl start duetwebserver && sudo systemctl enable duetwebserver
echo "-----DCS and DWS started-----"
