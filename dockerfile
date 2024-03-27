# Use a Node.js base image
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files to the working directory
COPY . .

# Expose port 3000 (or the port your Medusa application listens on)
EXPOSE 3000

# Command to run the Medusa Node.js application
CMD ["npm", "start"]
