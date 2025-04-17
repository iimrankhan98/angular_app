# Use Node.js as the base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies with --legacy-peer-deps flag
RUN npm install --legacy-peer-deps
# Install Next.js
RUN npm install next --legacy-peer-deps

# Copy the rest of the application code
COPY . .

# Build the Next.js app
RUN npm run build

# Expose the port on which the app will run
EXPOSE 3000

# Start the Next.js server in production mode
CMD ["npm", "start"]
