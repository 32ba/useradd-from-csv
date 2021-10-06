#/bin/bash

count=0
base_homedir="/home"
_shell="/opt/bash"
_skel="/etc/skel"

while read line
do
  user_name=`echo ${line} | cut -d "," -f 1`
  user_pass=`echo ${line} | cut -d "," -f 2`
  chpasswd_str="${user_name}:${user_pass}"
  useradd ${user_name} -m -d ${base_homedir}/${user_name} -s ${_shell} -k ${_skel}
  echo $chpasswd_str | chpasswd
  count=$(($count + 1))
  if [ $(($count % 10)) = 0 ]; then
    echo "${count} users added."
  fi
done < $1

