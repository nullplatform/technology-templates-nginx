FROM nginx:1.15-alpine
RUN addgroup -g 1001 -S app && \
    adduser -u 1001 -S app -G app

WORKDIR /app
ADD ./config /app/config
ADD ./entrypoint.sh /app/entrypoint.sh

# Create nginx cache directories and set permissions
RUN mkdir -p /var/cache/nginx/client_temp \
             /var/cache/nginx/proxy_temp \
             /var/cache/nginx/fastcgi_temp \
             /var/cache/nginx/uwsgi_temp \
             /var/cache/nginx/scgi_temp && \
    chown -R app:app /var/cache/nginx && \
    chown -R app:app /var/run && \
    chown -R app:app /app && \
    chmod +x /app/entrypoint.sh

USER 1001
ENTRYPOINT ["/app/entrypoint.sh"]
