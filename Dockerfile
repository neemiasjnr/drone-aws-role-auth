FROM mesosphere/aws-cli

RUN apk -v --update add jq bash

ADD ./scripts/aws-auth /bin

RUN chmod a+x /bin/aws-auth

ENTRYPOINT ["/bin/bash", "-c", "/bin/aws-auth"]