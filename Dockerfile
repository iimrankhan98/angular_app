FROM node:18-alpine AS build

# Set the working directory inside the container

WORKDIR /app

# Copy package.json and package-lock.json to install dependencies

COPY package*.json ./

# Install dependencies

RUN npm install -g npm@10.8.3

# Install Angular CLI globally

RUN npm install -g @angular/cli

# Copy the rest of the application code

COPY . .

# Build the Angular app

RUN npm install --save-dev @angular-devkit/build-angular

RUN ng build --aot

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the built files from the previous stage to Nginx's HTML folder

COPY --from=build /app/dist/skote /usr/share/nginx/html

# Expose port 4300 to access the application

EXPOSE 4300

# Start Nginx

CMD ["nginx", "-g", "daemon off;"]
