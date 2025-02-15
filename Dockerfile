# Use the official Node.js image as the base image
FROM node:18-alpine as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the React application
RUN npm run build

#PROD Stage
FROM nginx:stable-alpine as prod
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80

# Expose port 3000
#EXPOSE 3000 -for dev

# Command to run the application
#CMD [ "serve", "-s", "dist" ] -for dev
CMD [ "nginx" , "-g", "daemon off;"]