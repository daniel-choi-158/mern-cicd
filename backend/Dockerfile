# Use a lighter version of Node as a parent image
FROM node:latest
# Set the working directory to /backend
RUN mkdir -p /backend
WORKDIR /backend
# copy package.json into the container at /backend
COPY package*.json /backend/
# install dependencies
RUN npm install
# resolve dependency vulnerabilities
RUN npm audit fix
# Copy the current directory contents into the container at /backend
COPY . /backend/
# Make port 80 available to the world outside this container
EXPOSE 80
# Run the app when the container launches
CMD ["npm", "start"]