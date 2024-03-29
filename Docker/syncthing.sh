#!/bin/bash
image=syncthing/syncthing:latest
name=Syncthing
port=8181
path="/opt/Docker/Syncthing"
path1="/opt/Docker/Syncthing/Sync"
blue() {
    echo -e "\033[34m\033[01m$1\033[0m"
}
green() {
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}
red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}
install() {
read -r -p "$(yellow '请输入映射端口号(默认为'"$port"')：')" port_input
if [ -n "$port_input" ]; then
    port="$port_input"
fi
read -r -p "$(yellow '请输入配置数据目录(默认为'"$path"')：')" path_input
if [ -n "$path_input" ]; then
    path="$path_input"
fi
read -r -p "$(yellow '请输入你要同步的目录(默认为'"$path1"')：')" path1_input
if [ -n "$path1_input" ]; then
    path1="$path1_input"
fi
        docker run -d \
            --name=$name \
            --hostname=syncthing \
            -e PUID=0 \
            -e PGID=0 \
            -e TZ=Asia/Shanghai \
            -p $port:8384 \
            -p 22000:22000/tcp \
            -p 22000:22000/udp \
            -p 21027:21027/udp \
            -v $path/Config:/config \
            -v $path1:/sync \
            --restart unless-stopped \
			$image
    yellow "容器已启动，端口号为 $port，数据目录为 $path，同步的目录$path1"
}
update() {
    green "================================================="
    red "注意！！！"
    red "更新前请牢记映射的端口和目录，并严格对应输入！"
    red "如果输入错误，将导致设置与数据丢失！"
    red "不做任何输入则保持默认端口和路径，"
    red "届时与原端口目录不符，同样丢失数据！"
    green "================================================="
    read -rp "$(yellow '确定要更新吗？(y/n):')" confirm
    if [[ "$confirm" =~ [yY](es)* ]]; then
read -rp "$(yellow '请输入原映射端口号（默认为'"$port"'）：')" port_input
if [ -n "$port_input" ]; then
    port="$port_input"
fi
read -r -p "$(yellow '请输入配置数据目录(默认为'"$path"')：')" path_input
if [ -n "$path_input" ]; then
    path="$path_input"
fi
read -r -p "$(yellow '请输入你要同步的目录(默认为'"$path1"')：')" path1_input
if [ -n "$path1_input" ]; then
    path1="$path1_input"
fi
        green "容器即将更新"
        docker pull $image
        docker stop $name && docker rm $name
        docker run -d \
            --name=$name \
            --hostname=syncthing \
            -e PUID=1000 \
            -e PGID=1000 \
            -e TZ=Asia/Shanghai \
            -p $port:8384 \
            -p 22000:22000/tcp \
            -p 22000:22000/udp \
            -p 21027:21027/udp \
            -v $path/Config:/config \
            -v $path1:/Sync \
            --restart unless-stopped \
            $image
        green "容器已更新完成"
    else
        yellow "已取消更新"
    fi
}
uninstall() {
    green "================================================="
    red "警告：该操作将会删除容器及其数据。"
    green "================================================="
	read -rp "$(yellow '请再次确认是否执行该操作 [y/n]:')" confirm
    if [ "$confirm" = "Y" -o "$confirm" = "y" -o "$confirm" = "yes" ]; then
        docker stop $name && docker rm $name
        yellow "容器已卸载"
		read -rp "$(yellow '请再次确认是否删除数据目录 [y/n]:')" delete_dir
        if [ "$delete_dir" = "Y" -o "$delete_dir" = "y" ]; then
            read -p "请输入数据目录的路径 [$path]: " custom_dir
            dir_to_delete=${custom_dir:-$path}
            rm -rf "$dir_to_delete"
            yellow "数据目录已删除"
        else
            yellow "默认数据目录 $path 未删除"
        fi
    fi
}
menu() {
  green "================================================="
  yellow " $name一键 Docker 脚本"
  yellow " 默认端口：$port"
  yellow " 默认路径：$path"
  green "================================================="
  blue "  1. 安装并启动容器"
  blue "  2. 更新容器"
  blue "  3. 卸载容器"
  blue "  0. 退出脚本"
  green "================================================="
  read -p "$(yellow '请输入数字 [0-3]:')" num
  case "$num" in
    1)
      rm -rf "$0"
      install
      ;;
    2)
      rm -rf "$0"
      update
      ;;
    3)
      rm -rf "$0"
      uninstall
      ;;
    0)
      rm -rf "$0"
      exit 0
      ;;
    *)
      clear
      echo "请输入正确数字 [0-3]"
      sleep 2s
      exit 1
      ;;
  esac
}

menu