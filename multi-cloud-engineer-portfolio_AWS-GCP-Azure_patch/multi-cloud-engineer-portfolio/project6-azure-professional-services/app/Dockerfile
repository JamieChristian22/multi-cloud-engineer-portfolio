FROM public.ecr.aws/docker/library/node:20-alpine
WORKDIR /app
COPY package.json ./
COPY src ./src
EXPOSE 3000
CMD ["node", "src/server.js"]
