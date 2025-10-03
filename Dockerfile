FROM node:18-alpine

# Set memory limits for Node.js
ENV NODE_OPTIONS="--max-old-space-size=1536"

WORKDIR /app

# Install dependencies first (better caching)
COPY package*.json ./
RUN npm install

# Copy source files
COPY . .

# Build with memory limit
RUN npm run build

# Clean up dev dependencies after build
RUN npm prune --production

EXPOSE 1337

CMD ["npm", "run", "start"]
