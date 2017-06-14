# zookeeper-install
zookeeper-install for k8s zk cluster (petset)

一般情况下，zk的安装包下载会在install.sh中，即在安装时下载安装文件
但是在内网环境中，无法连接外网，所以将安装的文件打包到镜像
