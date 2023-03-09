# Set the base image to Node.js
FROM node:16-alpine AS build

# Create and set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the dependencies
RUN npm install --production --silent

# Copy the rest of the application code to the container
COPY . .

# Build the React app
RUN npm run build

# Set the base image to Nginx
FROM nginx:1.21-alpine

# Copy the built React app from the previous stage to the container
COPY --from=build /app/build /usr/share/nginx/html
