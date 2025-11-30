#!/bin/bash
# 70 LPA BASH ONE-LINERS – DAY 1 (From public repos: onceupon/Bash-Oneliner + stephenturner/oneliners)

# 1. Extract any archive (tar, zip, etc.) in one command 
extract () { if [ -f $1 ] ; then case $1 in *.tar.bz2)   tar xvjf $1    ;; *.tar.gz)    tar xvzf $1    ;; *.tar.xz)    tar Jxvf $1    ;; *.bz2)       bunzip2 $1     ;; *.rar)       unrar x $1     ;; *.gz)        gunzip $1      ;; *.tar)       tar xvf $1     ;; *.tbz2)      tar xvjf $1    ;; *.tgz)       tar xvzf $1    ;; *.zip)       unzip $1       ;; *.Z)         uncompress $1  ;; *.7z)        7z x $1        ;; *) echo "'$1' cannot be extracted via extract()" ;; esac else echo "'$1' is not a valid file"; fi }

# 2. Kill processes by CPU usage (>50%) 
ps aux | awk '{if($3>50) print $2}' | xargs kill -9

# 3. Find & replace in all files recursively 
grep -lr 'old_text' . | xargs sed -i 's/old_text/new_text/g'

# 4. Monitor disk usage & alert if >90% 
watch -n 30 'df -h | awk "NR==2{ if(\$5+0 > 90) print \"ALERT: \" \$5 }"'

# 5. Parallel SSH to multiple servers 
parallel -j 10 ssh {} 'uptime' ::: user@host{1..10}.example.com

# 6. Generate password & copy to clipboard 
openssl rand -base64 32 | tr -d "=+/" | cut -c1-32 | xclip -sel clip

# 7. Backup directory with timestamp 
tar czf backup_$(date +%Y%m%d_%H%M%S).tgz /path/to/dir

# 8. Find largest files in dir (>100MB) 
find . -type f -size +100M -exec ls -lh {} \; | sort -k5 -hr

# 9. Run command only if file changed 
[ file1 -nt file2 ] && command_here

# 10. Get system stats in one line 
echo "CPU: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')% | MEM: $(free | awk 'NR==2{printf "%.1f%%", $3/$2 * 100.0}')"

# 11-20: From onceupon/Bash-Oneliner (Data Processing)
# 11. Count lines in multiple files
wc -l *.log | sort -nr | head -10

# 12. Remove duplicate lines
sort file.txt | uniq -u

# 13. Convert CSV to JSON one-liner
awk -F, '{print "{"; for(i=1;i<=NF;i++) print "\"" $i "\":" ($i+0==$i?"\""$i"\"":"$i) ","; print "}"}' data.csv

# 14. Find unique words & count
tr -s '[:space:]' '\n' < file.txt | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -nr

# 15. Split file by line count
split -l 1000 large.log split_

# 16. Merge PDFs
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=merged.pdf file1.pdf file2.pdf

# 17. Download & extract in one go
wget -O- url | tar xz

# 18. Base64 encode file
base64 input.txt | tr -d '\n' > encoded.txt

# 19. JSON pretty print
python3 -m json.tool < ugly.json > pretty.json

# 20. Find broken symlinks
find /dir -type l ! -exec test -e {} \; -print

# 21-30: System Maintenance (From labbots/bash-oneliners )
# 21. Clean Docker images
docker image prune -a -f

# 22. Git commits last month by user
git log --since='last month' --author="$(git config user.name)" --oneline

# 23. Kill hung npm processes
pkill -f node

# 24. Show open ports
netstat -tlnp | grep :8080

# 25. Rotate logs older than 30 days
find /var/log -name "*.log" -mtime +30 -delete

# 26. Check if port is open
nc -zv localhost 8080

# 27. List processes by memory
ps aux --sort=-%mem | head

# 28. Update all packages (Ubuntu)
apt update && apt upgrade -y

# 29. Find zombie processes
ps aux | awk '$8 ~ /Z/'

# 30. Compress directory recursively
tar czf archive.tar.gz --exclude='*.git' /path/to/dir

# 31-40: Advanced Tricks (Curated from multiple )
# 31. Infinite loop with sleep
while true; do sleep 1 && echo "Heartbeat"; done

# 32. Read file line by line & process
while IFS= read -r line; do echo "Processing: $line"; done < file.txt

# 33. Array of files & loop
files=(*.txt); for f in "${files[@]}"; do mv "$f" "backup_$f"; done

# 34. Trap signals for cleanup
trap 'echo Cleaning up; rm temp.txt' EXIT

# 35. Function with default args
greet() { echo "Hello ${1:-World}"; }  # greet → Hello World

# 36. Eval dynamic command
cmd="ls -la"; eval "$cmd"

# 37. Here doc for multi-line
cat << EOF > config.txt
KEY=VALUE
EOF

# 38. Parameter expansion (remove suffix)
filename="${fullpath##*/}"  # basename

# 39. Case insensitive grep
grep -i "pattern" file.txt

# 40. Timeout command
timeout 10s long_running_command

# 41-50: DevOps Special (Custom for Devops)
# 41. Deploy script check
[ -d /opt/app ] && cd /opt/app && git pull && docker compose up -d

# 42. Health check loop
while ! nc -z localhost 8080; do sleep 5; echo "Waiting for service..."; done

# 43. Log tail with colors
tail -f /var/log/app.log | grep --color=always "ERROR\|WARN"

# 44. Backup DB one-liner
mysqldump -u user -p pass db_name | gzip > backup_$(date +%F).sql.gz

# 45. Find slow queries
grep -i "slow query" /var/log/mysql/mysql-slow.log | wc -l

# 46. Terraform validate
terraform validate && terraform plan -out=plan.tfplan

# 47. K8s rollout status
kubectl rollout status deployment/myapp -n prod --timeout=300s

# 48. AWS CLI summarize costs
aws ce get-cost-and-usage --granularity MONTHLY --metrics "BlendedCost"

# 49. Git bisect for bugs
git bisect start && git bisect bad && git bisect good v1.0

# 50. System audit (CPU/MEM/DISK)
paste <(cat /proc/cpuinfo | grep "model name" | head -1) <(free -h | grep Mem) <(df -h / | tail -1)
