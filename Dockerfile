FROM node:22.16.0

# Install dependencies for CF CLI
RUN apt-get update && apt-get install -y wget apt-transport-https ca-certificates

# Install CF CLI
RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.gpg.key | apt-key add - && \
    echo "deb https://packages.cloudfoundry.org/debian/ cli main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list && \
    apt-get update && \
    apt-get install -y cf-cli

# Install CF plugin
RUN cf install-plugin -f -r CF-Community https://github.com/cloudfoundry-community/cf-plugin-mta

# Add your entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
