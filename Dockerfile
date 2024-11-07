# Use the official Nginx image as the base image
FROM nginx:alpine

# Copy the content of your project directory (e.g., index.html, CSS, JS) to the Nginx server directory
COPY . /usr/share/nginx/html

# Expose port 80 so the app can be accessed via HTTP
EXPOSE 80
