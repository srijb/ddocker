#!/bin/bash
function container
{
if [ -e /home/ansible/ds/ddocker/container.txt ]
then
#echo "How many containers do you want to install in each host"
#read arg1
#i=${arg1}
#echo "Installing containers $i"
i=1
while [ $i <= 3 ] do
for con in $(cat /home/ansible/ds/ddocker/container.txt); do
ssh -o StrictHostKeyChecking=no \
       -p 22 ansible@$con \
"sudo docker run -d --name dd-agent$i -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -e DD_API_KEY=3d2a93340bd533472a1d394d348d1e52 datadog/agent:latest"
done
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
