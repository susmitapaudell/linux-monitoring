#!/usr/bin/env bash
set -euo pipefail
out="evidence/day01/baseline-$(date +%Y%m%d-%H%M%S).txt"
mkdir -p "$(dirname "out")"{
	echo "== host =="; uname -a; hostnamectl| head -n 8
	echo "== cpu =="; nproc; lscpu | head -n 15
	echo "== memory =="; free -m
	echo "== disk =="; df -hT -x tmpfs -x devtmpfs; lsblk 
	echo "== network =="; ip -br address; ss -tln
	echo  "== load =="; uptime
	echo "== top process ==";  ps -eo pid, user, pcpu, pmem, comm, --sort=-pcpu  | head -n 8
} | tee "$out"
