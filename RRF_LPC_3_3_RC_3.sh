echo "-----This will install the LPC Version of DSF for 3.3-RC3-----"
echo "-----Update and upgrade the PI-----"
cd ~
sudo apt-mark hold \
    duetsoftwareframework \
    duetcontrolserver \
    duetruntime \
    duetsd \
    duetsoftwareframework \
    duettools \
    duetwebcontrol \
    duetwebserver \
    reprapfirmware
sudo apt-get -q update && sudo apt-get -y upgrade
echo "-----Upgrade and Update finished-----"
echo "-----Switching to the unstable branch-----"
sudo apt-mark unhold \
    duetsoftwareframework \
    duetcontrolserver \
    duetruntime \
    duetsd \
    duettools \
    duetwebcontrol \
    duetwebserver \
    reprapfirmware
wget -q https://pkg.duet3d.com/duet3d.gpg
wget -q https://pkg.duet3d.com/duet3d-unstable.list
sudo mv duet3d.gpg /etc/apt/trusted.gpg.d/
sudo mv duet3d-unstable.list /etc/apt/sources.list.d/duet3d-unstable.list
sudo chown root:root /etc/apt/trusted.gpg.d/duet3d.gpg
sudo chown root:root /etc/apt/sources.list.d/duet3d-unstable.list
sudo rm /etc/apt/sources.list.d/duet3d.list
echo "-----Switching finished-----"
sudo apt -q update 
sudo apt install \
    duetsoftwareframework=3.3-RC3 \
    duetcontrolserver=3.3-rc3 \
    duetruntime=3.3-rc3 \
    duetsd=1.1.0 \
    duettools=3.3-rc3 \
    duetwebcontrol=3.3-rc3 \
    duetwebserver=3.3-rc3 \
    reprapfirmware=3.3-rc3-1 \
    --allow-downgrades
sudo apt-mark hold \
    duetsoftwareframework \
    duetcontrolserver \
    duetruntime \
    duetsd \
    duettools \
    duetwebcontrol \
    duetwebserver \
    reprapfirmware
echo "-----Stop DCS and DWS---"
sudo systemctl stop duetcontrolserver
sudo systemctl stop duetwebserver
echo "-----Both stoped-----"
sudo sed -i -e 's/"SpiBufferSize": 8192/"SpiBufferSize": 3072/g' /opt/dsf/conf/config.json
sudo sed -i -e 's/"SpiTransferMode": 0/"SpiTransferMode": 3/g' /opt/dsf/conf/config.json
sudo sed -i -e 's/"MaxCodeBufferSize": 256/"MaxCodeBufferSize": 200/g' /opt/dsf/conf/config.json
sudo sed -i -e 's/"MaxMessageLength": 4096/"MaxMessageLength": 2560/g' /opt/dsf/conf/config.json
echo "-----CHANGES MADE-----"
sudo systemctl start duetcontrolserver && sudo systemctl enable duetcontrolserver
sudo systemctl start duetwebserver && sudo systemctl enable duetwebserver
echo "-----DCS and DWS started-----"
