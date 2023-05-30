locals {
    user_data = <<EOF
#!/bin/bash
sudo apt-get update 
sudo apt --assume-yes install docker.io 
sudo systemctl start docker
sudo systemctl enable docker
cat /etc/default/grub | grep GRUB_CMDLINE_LINUX=
sudo sed -i -e 's/^GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_memory=1 cgroup_enable=memory swapaccount=1 systemd.unified_cgroup_hierarchy=0"/' /etc/default/grub
cd /usr/lib/
echo 'net.bridge.bridge-nf-call-iptables=1' > sysctl.conf
sudo update-grub
sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged -e CATTLE_BOOTSTRAP_PASSWORD=${var.rancher_password} -v /opt/ranchr/lib/rancher rancher/rancher:stable
EOF
}