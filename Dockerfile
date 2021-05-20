FROM google/cloud-sdk:alpine
COPY --from=msoap/shell2http /app/shell2http /usr/local/bin/shell2http
COPY main.sh /
ENTRYPOINT ["shell2http"]
CMD ["-show-errors", "-export-all-vars", "/", "sh main.sh"]
