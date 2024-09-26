#!/bin/bash

#problem statement 2 Question 4 : write a scripr to moniter the health status of an application  

URL="http://mysite.com"

CHECK_INTERVAL=30

check_application_status() {
  HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}" "$URL")

  # Check if status code is 200 (OK)
  if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Application is UP - Status Code: $HTTP_STATUS"
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Application is DOWN - Status Code: $HTTP_STATUS"
  fi
}

# Infinite loop to keep checking the application status at regular intervals
while true
do
  check_application_status
  sleep $CHECK_INTERVAL
done
