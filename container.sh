#! /bin/bash
sudo docker run -d --name dd-agent$i -v /var/run/docker.sock:/var/run/docker.sock:ro -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -e DD_API_KEY=3d2a93340bd533472a1d394d348d1e52 datadog/agent:latest
