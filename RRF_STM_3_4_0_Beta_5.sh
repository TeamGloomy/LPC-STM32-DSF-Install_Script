echo "-----This will install the STM Version of DSF for 3.4.0 Beta 5-----"
echo "-----Update and upgrade the PI-----"
cd ~
sudo apt-mark hold \
    duetsoftwareframework \
    duetcontrolserver \
    duetruntime \
    duetsd \
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
    duetsoftwareframework=3.4-b5 \
    duetcontrolserver=3.4-b5 \
    duetruntime=3.4-b5 \
    duetsd=1.1.0 \
    duettools=3.4-b5 \
    duetwebcontrol=3.4-b5 \
    duetwebserver=3.4-b5 \
    reprapfirmware=3.4-b5-1 \
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