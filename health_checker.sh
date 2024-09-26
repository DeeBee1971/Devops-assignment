#!/bin/bash

# problem statement 2 question 1 : write a script to monitor system resource usage

# predefined thresholds
CPU_THRESHOLD=60
MEMORY_THRESHOLD=70
DISK_THRESHOLD=90
PROCESS_THRESHOLD=300 

#file to store the warnings
LOG_FILE="/var/log/system_health.log"

# getting cpu usage
check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | awk -F. '{print $1}')
    if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
        echo " CPU usage is high: ${CPU_USAGE}% (Threshold: ${CPU_THRESHOLD}%)" | tee -a $LOG_FILE
    fi
}

# get memory usage
check_memory() {
    MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | awk -F. '{print $1}')
    if [ "$MEMORY_USAGE" -gt "$MEMORY_THRESHOLD" ]; then
        echo " Memory usage is high: ${MEMORY_USAGE}% (Threshold: ${MEMORY_THRESHOLD}%)" | tee -a $LOG_FILE
    fi
}

# get disk usage 
check_disk() {
    DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        echo " Disk space usage is high: ${DISK_USAGE}% (Threshold: ${DISK_THRESHOLD}%)" | tee -a $LOG_FILE
    fi
}

# checking number of running processes
check_processes() {
    PROCESS_COUNT=$(ps aux --no-heading | wc -l)
    if [ "$PROCESS_COUNT" -gt "$PROCESS_THRESHOLD" ]; then
        echo "Too many running processes: ${PROCESS_COUNT} (Threshold: ${PROCESS_THRESHOLD})" | tee -a $LOG_FILE
    fi
}

# running all checks
monitor_system_health() {
    echo "[$(date)] Running system health checks..." >> $LOG_FILE
    check_cpu
    check_memory
    check_disk
    check_processes
    echo "[$(date)] System health check completed." >> $LOG_FILE
    echo "" >> $LOG_FILE
}
