#!/bin/bash
function container
{
if [ -e /home/ansible/ds/container.txt ]
then
#echo "How many containers do you want to install in each host"
#read arg1
#i=${arg1}
#echo "Installing containers $i"
for a in 3--; do
for con in $(cat /home/ansible/ds/container.txt); do
ssh -o StrictHostKeyChecking=no \
       -p 22 ansible@$con \
"docker run -d --name dd-agent$i -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -e DD_API_KEY=3d2a93340bd533472a1d394d348d1e52 datadog/agent:latest"
done
done
else
echo "nothing to do"
fi
}
function vm
{
for list in $(cat /home/ansible/ds/serverlist.txt); do
scp /home/ansible/ds/script.sh ansible@$list:/home/ansible/.
ssh -o StrictHostKeyChecking=no \
     -p ansible@$list "chmod 755 /home/ansible/script.sh;cd /home/ansible;./script.sh"
done
}
case $value in
"container") container ;;
"vm") vm ;;
esac
