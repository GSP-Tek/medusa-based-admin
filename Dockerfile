FROM node:18-alpine

WORKDIR /app

# Install build dependencies for Alpine
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    build-base

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Build application
RUN npm run build
RUN npm install

# Expose port
EXPOSE 9000

# Set node environment
ENV NODE_ENV=production

# Start application
CMD ["npm", "start"]
