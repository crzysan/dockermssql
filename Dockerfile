FROM mcr.microsoft.com/mssql/server:2019-latest

ENV ROOTAPP=/usr/config

# Create a config directory
RUN mkdir -p $ROOTAPP

# Bundle config source
COPY . $ROOTAPP

# Grant permissions for to our scripts to be executable
USER root
RUN chmod +x /usr/config/entrypoint.sh && \
    chmod +x /usr/config/configure-db.sh && \
    chgrp -R 0 $ROOTAPP && \
    chmod -R g=u $ROOTAPP

USER 1001
WORKDIR $ROOTAPP


ENTRYPOINT ["./entrypoint.sh"]

# Tail the setup logs to trap the process
CMD ["tail -f /dev/null"]

HEALTHCHECK --interval=15s CMD /opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD -Q "select 1" && grep -q "MSSQL CONFIG COMPLETE" ./config.log
