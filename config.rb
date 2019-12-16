$vm_box = "bento/ubuntu-16.04"  #Ubuntu 16.04
$vm_memory = 8192
$vm_cpus = 4

$hostname = "dev.local"
$vm_name = "DevEnv"

$vm_ips = ["192.168.56.101"]
$vm_ssh_port = 2200

$shared_folders = {'D:/www' => '/var/www'}

$gui = false