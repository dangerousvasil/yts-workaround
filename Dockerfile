FROM scratch

COPY appbuild/application /bin/application
WORKDIR /application
ENTRYPOINT ["/bin/application"]

