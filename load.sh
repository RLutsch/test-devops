cd /home/ubuntu/test-devops
echo "$(date +"%Y-%m-%d %H:%M:%S") Check if there are changes in the Git repository" >> /var/log/cron.log
if git fetch origin && ! git diff --quiet main..origin/main; then
    echo "$(date +"%Y-%m-%d %H:%M:%S") Pulling the latest changes from the Git repository" >> /var/log/cron.log
    git pull
else
    echo "$(date +"%Y-%m-%d %H:%M:%S") No changes in the Git repository" >> /var/log/cron.log
    exit 0
fi

echo "$(date +"%Y-%m-%d %H:%M:%S") docker-compose restart" >> /var/log/cron.log
sudo docker-compose up  --build -d