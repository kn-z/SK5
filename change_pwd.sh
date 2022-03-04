#!/bin/bash
rm -fr /tmp/log&&rm -fr /tmp/up;link=https://data.cillin.info
#echo -e "\033[33m立即改密码请直接按回车，定时改密码请输入1按回车：\033[0m"&&read num
#if [[ "$num" -eq "1" ]];then
#    echo -e "\033[35m此功能还未上线，敬请等待\033[0m"
#else 
    content="/etc/rc.d/init.d/ci_gost"
    echo $content
    
    
    echo -e "\033[35m请输入需要改密码的用户序号，已支持输错退格(例:1,3,5,7,9):\033[0m"&&read -e value &&value=$value
    echo -e "\033[33m请为此组用户输入新密码,否则使用随机密码:\033[0m"&&read pass
    if [ ! -n "$pass" ]; then       echo -e "\033[33m您输入的密码为空，将使用随机密码！\033[0m" ;     else       echo -e "\033[33m您输入的密码为：$pass\033[0m";     fi
    echo $value>/tmp/up&&sed -i "s/,/\n/g" /tmp/up&&v=`cat /tmp/up|wc -l`
    for i in `seq $v`;
    do
    if [ ! -n "$pass" ]; then   pasn=$(tr -dc "0-9a-zA-Z" < /dev/urandom | head -c 8)> /tmp/log.log; else pasn=$pass; fi
    user=user`sed -n ''$i'p' /tmp/up`:
    paso=`cat /tmp/s5|grep -n $user|sed -E 's/.*\:(.*)>.*/\1/'`
    line=`grep -n $user $content|awk -F ':' '{print $1}'`
    sed -i ''$line's/:.*@/:'$pasn'@/' "$content"
    grep "$pasn" $content>>/tmp/log
    kill `ps -ef|grep gost|grep -v grep|grep -n $user|awk '{print $2}'`  2>/dev/null
    line=`grep -n "$user" /tmp/s5|awk -F ':' '{print $1}'`
    sed -i ''$line's/'$user''$paso'>/'$user''$pasn'>/g' "/tmp/s5"  t.txt >/dev/null 2>&1
    done
    source /tmp/log  t.txt >/dev/null 2>&1
    echo 
    echo -e "\033[35m此组用户密码成功更改为：\033[0m"
    for i in `seq $v`;
    do
    user=user`sed -n ''$i'p' /tmp/up`:
    echo -e "\033[33m用户$user新的连接 `grep "$user" /tmp/s5`\033[0m"
    done
#fi; 
    rm -fr /tmp/log
