FROM node:18-alpine

WORKDIR /app

# Accept build arguments for environment variables needed during build
ARG ADMIN_JWT_SECRET
ARG API_TOKEN_SALT
ARG TRANSFER_TOKEN_SALT
ARG ENCRYPTION_KEY
ARG APP_KEYS

# Set environment variables from build args
ENV ADMIN_JWT_SECRET=$ADMIN_JWT_SECRET
ENV API_TOKEN_SALT=$API_TOKEN_SALT
ENV TRANSFER_TOKEN_SALT=$TRANSFER_TOKEN_SALT
ENV ENCRYPTION_KEY=$ENCRYPTION_KEY
ENV APP_KEYS=$APP_KEYS

# Copy package files
COPY package*.json ./

# Install all dependencies (including dev dependencies for build)
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Remove dev dependencies to reduce image size
#RUN npm prune --production

EXPOSE 1337
CMD ["npm", "run", "start"]