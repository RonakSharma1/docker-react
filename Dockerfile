# All below follow the build stage
# Each FROM statements terminates the previous docker block
FROM node:alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# COPY copies from the stage called "builder", takes the app/build folder into the default folder in nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
