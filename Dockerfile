FROM node:18-alpine AS builder
WORKDIR /app
ENV NODE_OPTIONS="--max-old-space-size=900"
# Admin pages import supabase at module load time; provide placeholder values so
# the build doesn't throw. These are never used at runtime (nginx serves static files).
ENV NEXT_PUBLIC_SUPABASE_URL=https://placeholder.supabase.co
ENV NEXT_PUBLIC_SUPABASE_ANON_KEY=placeholder

COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine AS runner
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/app.conf
COPY --from=builder /app/out /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
