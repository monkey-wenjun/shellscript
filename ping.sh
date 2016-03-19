#!/bin/bash

regex_ip="(2[0-4][0-9]|25[0-5]|1[0-9][0-9]|[1-9]?[0-9])(\.(2[0-4][0-9]|25[0-5]|1[0-9][0-9]|[1-9]?[0-9])){3}"
case ${1} in

*)
  if [ ! ${1} ];
  then
      echo "IP 为空"
  else
    echo "${1}" | grep -E "$regex_ip" > ip.txt
    if [ -s ip.txt ]
    then
        ping -c1 ${1} >ip_status && cat ip_status | grep "min/avg/max/mdev"
        if [ $? -eq 0 ]
        then
            echo "主机${1}存活"
        else 
            echo "主机${1}宕机了"
        fi
    else
        echo "输入的不是IP"
    fi

  fi
;;
esac
rm -rf ip_status
rm -rf ip.txt