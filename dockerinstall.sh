#!/bin/bash
function container
{
if [ -e /home/ansible/ds/ddocker/container.txt ]
then
#echo "How many containers do you want to install in each host"
#read arg1
#i=${arg1}
i=1
a=$(cat /home/ansible/ds/ddocker/number.txt)
c=$(exp $a-1)
echo "Installing $c containers"
while [ $i -lt $a ] 
do
for con in $(cat /home/ansible/ds/ddocker/container.txt); do
scp -r /home/ansible/ds/ddocker/container.sh ansible@$con:/home/ansible/.
ssh -o StrictHostKeyChecking=no \
       -p 22 ansible@$con \ "chmod -R 755 /home/ansible/.;./home/ansible/container.sh"
done
b=dd-agent$i
echo "Installed $i container its name $b"
i=$[$i+1]
done
else
echo "nothing to do"
fi
}
function vm
{
for list in $(cat /home/ansible/ds/ddocker/serverlist.txt); do
scp -r /home/ansible/ds/ddocker/script.sh ansible@$list:/home/ansible/.
ssh -o StrictHostKeyChecking=no \
     -p 22 ansible@$list "chmod 755 /home/ansible/script.sh;cd /home/ansible;./script.sh"
done
}
case $value in
"container") container ;;
"vm") vm ;;
esac
