# Choose basic image and define the phase name
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# Build needed files
RUN npm run build

# Choose basic image for second phase.
# New FROM "closes" previous one
FROM nginx
# Select from which folder of previous phase we want to get content
COPY --from=builder /app/build /usr/share/nginx/html

