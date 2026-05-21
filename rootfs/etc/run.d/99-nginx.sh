suexec nginx -g "daemon off; user $PUSER $PGROUP; $NGINX_DIRECTIVES" &
