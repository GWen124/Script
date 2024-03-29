#!/bin/bash
# By GWen124
# https://github.com/GWen124/Script/tree/master/Linux

blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

vroot(){
	[[ $(id -u) != 0 ]] && red "请使用“sudo -i”登录root用户后执行本脚本！！！" && exit 1
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/tools.sh)"
}

vrootcdn(){
	[[ $(id -u) != 0 ]] && red "请使用“sudo -i”登录root用户后执行本脚本！！！" && exit 1
	bash -c "$(curl -fsSL https://cdn.wen124.ml/https://raw.githubusercontent.com/GWen124/Script/master/Linux/toolscdn.sh)"
}

vuser(){
	[[ "$USER" == "root" ]] && red "请使用“su xxx”登录非root用户后执行本脚本！！！" && exit 1
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/tools.sh)"
}

vusercdn(){
	[[ "$USER" == "root" ]] && red "请使用“su xxx”登录非root用户后执行本脚本！！！" && exit 1
	bash -c "$(curl -fsSL https://cdn.wen124.ml/https://raw.githubusercontent.com/GWen124/Script/master/Linux/toolscdn.sh)"
}

login(){
clear
echo "                            "
green "=================================================================================="
echo "                            "
yellow "1. 我已使用Root账户登录"
yellow "2. 继续使用非Root账户登录"
red "注意：非Root账户可能导致某些脚本不能运行！"
echo "                           "
red "0. 退出脚本"
echo "                            "
green "=================================================================================="
read -p "请输入选项:" loginNumberInput
case "$loginNumberInput" in
    1 ) 
	    vpsroot
	    ;;
    2 ) 
		vpsuser
		;;
	0 ) exit 1 ;;
	* ) echo "                            "
		yellow "请输入正确的数字" ;;
esac
}

vpsroot(){
clear
echo "                            "
green "=================================================================================="
echo "                            "
yellow "1. 直接连接"
yellow "2. CDN加速"
echo "                           "
red "0. 退出脚本"
echo "                            "
green "=================================================================================="
read -p "请输入选项:" vpsrootNumberInput
case "$vpsrootNumberInput" in
    1 ) 
	    vroot
	    ;;
    2 ) 
		vrootcdn
		;;
	0 ) exit 1 ;;
	* ) echo "                            "
		yellow "请输入正确的数字" ;;
esac
}

vpsuser(){
clear
echo "                            "
green "=================================================================================="
echo "                            "
yellow "1. 直接连接"
yellow "2. CDN加速"
echo "                           "
red "0. 退出脚本"
echo "                            "
green "=================================================================================="
read -p "请输入选项:" vpsrootNumberInput
case "$vpsrootNumberInput" in
    1 ) 
	    vuser
	    ;;
    2 ) 
		vusercdn
		;;
	0 ) exit 1 ;;
	* ) echo "                            "
		yellow "请输入正确的数字" ;;
esac
}

login