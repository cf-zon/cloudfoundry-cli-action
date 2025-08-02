FROM node:22.16.0

# Install dependencies for CF CLI
RUN apt-get update && apt-get install -y wget apt-transport-https ca-certificates

# # Install CF CLI
# RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.gpg.key | apt-key add - && \
#     echo "deb https://packages.cloudfoundry.org/debian/ cli main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list && \
#     apt-get update && \
#     apt-get install -y cf-cli

ENV CF_CLI_VERSION "8.14.1"

RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_CLI_VERSION}&source=github-rel" | tar -zx -C /usr/local/bin
RUN cf install-plugin -f -r CF-Community https://github.com/cloudfoundry-community/cf-plugin-mta

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

