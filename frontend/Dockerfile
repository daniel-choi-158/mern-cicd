# get Node image
FROM node
# Create and et the working directory to /frontend
RUN mkdir -p /frontend
WORKDIR /frontend
# copy package.json into the container at /frontend
COPY package*.json /frontend/
# install dependencies
RUN npm install
# resolve dependency vulnerabilities
RUN npm audit fix
# Copy the current directory contents into the container at /frontend
COPY . /frontend/
# Make port 3000 available to the world outside this container
EXPOSE 3000
# Run the app when the container launches
CMD ["npm", "start"]