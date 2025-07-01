# Use Node 20 as base image
FROM node:20-bookworm-slim

# Set working directory
WORKDIR /app

# Install system dependencies for better-sqlite3 and other native modules
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    libsqlite3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy the entire repo (including all workspaces)
COPY . .

# Install dependencies with Yarn
RUN yarn install --immutable

# Build the application
RUN yarn build:all

# Expose port 3000 for Fusion
EXPOSE 3000

# Set environment variables for development
ENV NODE_ENV=development
ENV PORT=3000

# Start the application (runs both frontend and backend)
CMD ["yarn", "start"] 