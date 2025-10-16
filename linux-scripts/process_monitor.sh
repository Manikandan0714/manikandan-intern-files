echo "----------------------------"
echo "1.Top 5 CPU-consuming processes"
echo "----------------------------"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

echo "----------------------------"
echo "2.Start sleep 1000 in background"
echo "----------------------------"
sleep 1000 &
echo "Started sleep 1000 in background with PID $!"
ps
