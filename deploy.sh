#!/bin/bash

# Configuration
EC2_IP="your-ec2-ip"  # Replace with your EC2 instance IP
KEY_FILE="path/to/your-key.pem"  # Replace with your key file path

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting deployment process...${NC}"

# Build the application
echo -e "${GREEN}Building the application...${NC}"
cd frontend
npm install
npm run build

if [ $? -ne 0 ]; then
    echo -e "${RED}Build failed!${NC}"
    exit 1
fi

# Create remote directory
echo -e "${GREEN}Setting up remote directory...${NC}"
ssh -i $KEY_FILE ec2-user@$EC2_IP "sudo mkdir -p /var/www/frontend && sudo chown -R ec2-user:ec2-user /var/www/frontend"

# Copy files to EC2
echo -e "${GREEN}Copying files to EC2...${NC}"
scp -i $KEY_FILE -r dist/* ec2-user@$EC2_IP:/var/www/frontend/

# Configure nginx
echo -e "${GREEN}Configuring nginx...${NC}"
ssh -i $KEY_FILE ec2-user@$EC2_IP "sudo tee /etc/nginx/conf.d/frontend.conf > /dev/null << 'EOL'
server {
    listen 80;
    server_name $EC2_IP;

    root /var/www/frontend;
    index index.html;

    location / {
        try_files \$uri \$uri/ /index.html;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires 30d;
        add_header Cache-Control \"public, no-transform\";
    }

    add_header X-Frame-Options \"SAMEORIGIN\";
    add_header X-XSS-Protection \"1; mode=block\";
    add_header X-Content-Type-Options \"nosniff\";
}
EOL"

# Restart nginx
echo -e "${GREEN}Restarting nginx...${NC}"
ssh -i $KEY_FILE ec2-user@$EC2_IP "sudo nginx -t && sudo systemctl restart nginx"

echo -e "${GREEN}Deployment completed successfully!${NC}"
echo -e "${GREEN}Your application should be available at: http://$EC2_IP${NC}" 