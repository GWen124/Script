#!/bin/bash
red='\033[0;31m'
bblue='\033[0;34m'
yellow='\033[0;33m'
green='\033[0;32m'
plain='\033[0m'
red(){ echo -e "\033[31m\033[01m$1\033[0m";}
green(){ echo -e "\033[32m\033[01m$1\033[0m";}
yellow(){ echo -e "\033[33m\033[01m$1\033[0m";}
blue(){ echo -e "\033[36m\033[01m$1\033[0m";}
white(){ echo -e "\033[37m\033[01m$1\033[0m";}
bblue(){ echo -e "\033[34m\033[01m$1\033[0m";}
rred(){ echo -e "\033[35m\033[01m$1\033[0m";}
readtp(){ read -t5 -n26 -p "$(yellow "$1")" $2;}
readp(){ read -p "$(yellow "$1")" $2;}
[[ $EUID -ne 0 ]] && yellow "����rootģʽ���нű�" && exit
if [[ -f /etc/redhat-release ]]; then
release="Centos"
elif cat /etc/issue | grep -q -E -i "debian"; then
release="Debian"
elif cat /etc/issue | grep -q -E -i "ubuntu"; then
release="Ubuntu"
elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
release="Centos"
elif cat /proc/version | grep -q -E -i "debian"; then
release="Debian"
elif cat /proc/version | grep -q -E -i "ubuntu"; then
release="Ubuntu"
elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
release="Centos"
else 
red "��֧���㵱ǰϵͳ����ѡ��ʹ��Ubuntu,Debian,Centosϵͳ��" && exit
fi

start(){
systemctl stop firewalld.service >/dev/null 2>&1
systemctl disable firewalld.service >/dev/null 2>&1
setenforce 0 >/dev/null 2>&1
ufw disable >/dev/null 2>&1
iptables -P INPUT ACCEPT >/dev/null 2>&1
iptables -P FORWARD ACCEPT >/dev/null 2>&1
iptables -P OUTPUT ACCEPT >/dev/null 2>&1
iptables -t mangle -F >/dev/null 2>&1
iptables -F >/dev/null 2>&1
iptables -X >/dev/null 2>&1
netfilter-persistent save >/dev/null 2>&1
v4=$(curl -s4m6 ip.sb -k)
if [ -z $v4 ]; then
echo -e nameserver 2a01:4f8:c2c:123f::1 > /etc/resolv.conf
fi
}

inschat(){
[[ $(type -P yum) ]] && yumapt='yum -y' || yumapt='apt -y'
$yumapt update
[[ ! $(type -P python3) ]] && (yellow "��⵽python3δ��װ��������װ��" && $yumapt update;$yumapt install python3)
if [[ $release = Centos ]]; then
yum install epel-release -y
[[ ! $(type -P python3-devel) ]] && ($yumapt update;$yumapt install python3-devel python3 -y)
else
[[ ! $(type -P python3-pip) ]] && ($yumapt update;$yumapt install python3-pip -y)
fi
py3=`python3 -V  | awk '{print $2}' | tr -d '.'`
if [[ $py3 -le 370 ]]; then
yellow "����python3��3.7.3������ʱ��Ƚϳ������Եȡ���" && sleep 3
wget -N https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
tar -zxf Python-3.7.3.tgz
$yumapt install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc libffi-devel make -y
cd Python-3.7.3
./configure --prefix=/usr/local/python3.7
make && make install
co=$(echo $? 2>&1)
if [[ $co = 0 ]]; then
green "����python3�ɹ�"
ln -sf /usr/local/python3.7/bin/python3.7 /usr/bin/python3
else
red "����python3ʧ��" && exit
fi
fi
pip3 install -U pip
python3 -m pip install openai aiogram 
cat > /root/TGchatgpt.py << EOF
import openai
from aiogram import Bot, types
from aiogram.dispatcher import Dispatcher
from aiogram.utils import executor
token = tgtoken
openai.api_key = apikey
bot = Bot(token)
dp = Dispatcher(bot)
@dp.message_handler()
async def send(message : types.Message):
    response = openai.Completion.create(
    model="text-davinci-003",
    prompt=message.text,
    temperature=0.9,
    max_tokens=1000,
    top_p=1.0,
    frequency_penalty=0.0,
    presence_penalty=0.0,
    stop=["You:"]
)
    await message.answer(response['choices'][0]['text'])
executor.start_polling(dp, skip_updates=True)
EOF

readp "����Telegram��token��" token
sed -i "5 s/tgtoken/'$token'/" /root/TGchatgpt.py
readp "����Openai��apikey��" key
sed -i "6 s/apikey/'$key'/" /root/TGchatgpt.py

cat << EOF >/lib/systemd/system/Chatgpt.service
[Unit]
Description=ygkkk-Chatgpt Service
After=network.target
[Service]
Restart=on-failure
User=root
ExecStart=/usr/bin/python3 /root/TGchatgpt.py
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable Chatgpt.service
systemctl start Chatgpt.service
systemctl stop Chatgpt.service
systemctl restart Chatgpt.service
green "Chatgpt Telegram�����˰�װ���"
}

chatlog(){
journalctl -u Chatgpt.service
}

stclre(){
if [[ ! -f '/root/TGchatgpt.py' ]]; then
red "δ������װChatgpt" && exit
fi
green "Chatgpt����ִ�����²���"
readp "1. ����\n2. �ر�\n3. ����\n��ѡ��" action
if [[ $action == "1" ]]; then
systemctl stop Chatgpt.service
systemctl restart Chatgpt.service
green "Chatgpt��������\n"
elif [[ $action == "2" ]]; then
systemctl stop Chatgpt.service
systemctl disable Chatgpt.service
green "Chatgpt����ر�\n"
elif [[ $action == "3" ]]; then
systemctl enable Chatgpt.service
systemctl start Chatgpt.service
systemctl stop Chatgpt.service
systemctl restart Chatgpt.service
green "Chatgpt������\n"
else
red "�������,������ѡ��" && stclre
fi
}

changechat(){
if [[ ! -f '/root/TGchatgpt.py' ]]; then
red "δ������װChatgpt" && exit
fi
green "Chatgpt�������ѡ������:"
readp "1. ����Telegram��token\n2. ����Openai��apikey\n��ѡ��" choose
if [ $choose == "1" ];then
tgtoken=`cat /root/TGchatgpt.py | sed -n 5p | awk '{print $3}'`
readp "����Telegram��token��" token
sed -i "5 s/$tgtoken/'$token'/" /root/TGchatgpt.py
systemctl stop Chatgpt.service
systemctl restart Chatgpt.service
elif [ $choose == "2" ];then
apikey=`cat /root/TGchatgpt.py | sed -n 6p | awk '{print $3}'`
readp "����Openai��apikey��" key
sed -i "6 s/$apikey/'$key'/" /root/TGchatgpt.py
systemctl stop Chatgpt.service
systemctl restart Chatgpt.service
else 
red "������ѡ��" && changechat
fi
}

unins(){
systemctl stop Chatgpt.service >/dev/null 2>&1
systemctl disable Chatgpt.service >/dev/null 2>&1
rm -f /lib/systemd/system/Chatgpt.service /root/TGchatgpt.py
green "Chatgpt-TGж����ɣ�"
}

start_menu(){
clear
green "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"           
echo -e "${bblue} ?����     ?����      ?���� ���� ����         ?��${plain}��   ?����     ?����   ?����     ?��${red}��   ?����${plain}  "
echo -e "${bblue}  ?����   ?����      ?����    ??����${plain}        ?����  ?����      ?����  ?����${red}      ?����  ?����${plain}   "
echo -e "${bblue}   ?���� ?����      ?���� ${plain}                ?���� ����        ?���� ��${red}��        ?���� ����  ${plain}   "
echo -e "${bblue}     ?����        ?${plain}����    ?���� ����       ?���� ����        ?��${red}�� ����        ?���� ����  ${plain}  "
echo -e "${bblue}     ?���� ${plain}        ?����    ??����        ?���� ?����       ?${red}���� ?����       ?���� ?���� ${plain}  "
echo -e "${bblue}     ?��${plain}��          ?���� ���� ����         ?����  ??${red}����     ?����  ??����     ?����  ??���� ${plain}  "
green "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" 
white "��Github��Ŀ  ��github.com/yonggekkk"
white "��blogger���� ��ygkkk.blogspot.com"
white "��YouTubeƵ�� ��www.youtube.com/@ygkkk"
red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
green " 1. ��װChatgpt-TG����" 
green " 2. ж��Chatgpt-TG����"
green " 3. �رա�����������Chatgpt"    
green " 4. ����TG��token �� Openai��apikey"
green " 5. �鿴Chatgpt-TG������־"
green " 0. �˳��ű�"
red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
readp "����������:" Input
case "$Input" in     
 1 ) inschat;;
 2 ) unins;;
 3 ) stclre;;
 4 ) changechat;;
 5 ) chatlog;;
 * ) exit 
esac
}
if [ $# == 0 ]; then
start
start_menu
fi