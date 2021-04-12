##
## Copyright 2021 Ocean Protocol Foundation
## SPDX-License-Identifier: Apache-2.0
##
FROM ubuntu:18.04
LABEL maintainer="Ocean Protocol <devops@oceanprotocol.com>"

ARG VERSION

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    gcc \
    python3.8 \
    python3-pip \
    python3.8-dev \
    gettext-base

COPY . /ocean-provider
WORKDIR /ocean-provider

RUN python3.8 -m pip install setuptools
RUN python3.8 -m pip install .

# config.ini configuration file variables
#ENV NETWORK_URL='http://127.0.0.1:8545'
ENV NETWORK_URL='https://rinkeby.infura.io/v3/5497c41a467d42a4b83e35735f262b37'
ENV ARTIFACTS_PATH='/ocean-provider/artifacts'

ENV PROVIDER_PRIVATE_KEY='0xc6914ea1e5ac6a1cd2107240be714735bf799ce9ea4125016aeb479266720ff4'
ENV PROVIDER_ADDRESS='F41681F0BE4A914d447d7A94C91906E74A6561D0'
ENV PROVIDER_PASSWORD='secret'
ENV PROVIDER_KEYFILE='tests/resources/provider_key_file.json'

ENV AZURE_ACCOUNT_NAME=''
ENV AZURE_ACCOUNT_KEY=''
ENV AZURE_RESOURCE_GROUP=''
ENV AZURE_LOCATION=''
ENV AZURE_CLIENT_ID=''
ENV AZURE_CLIENT_SECRET=''
ENV AZURE_TENANT_ID=''
ENV AZURE_SUBSCRIPTION_ID=''
# Note: AZURE_SHARE_INPUT and AZURE_SHARE_OUTPUT are only used
# for Azure Compute data assets (not for Azure Storage data assets).
# If you're not supporting Azure Compute, just leave their values
# as 'compute' and 'output', respectively.
ENV AZURE_SHARE_INPUT='compute'
ENV AZURE_SHARE_OUTPUT='output'

ENV OCEAN_PROVIDER_URL='http://0.0.0.0:8030'
#ENV OCEAN_PROVIDER_URL='https://provider.rinkeby.bigdataprotocolmarket.com:8030'

# docker-entrypoint.sh configuration file variables
ENV OCEAN_PROVIDER_WORKERS='1'
ENV OCEAN_PROVIDER_TIMEOUT='9000'
ENV ALLOW_NON_PUBLIC_IP=False

ENV FLASK_APP=ocean_provider/run.py
ENV CONFIG_FILE=config.ini

#ENV AQUARIUS_URL=https://aquarius.marketplace.dev-ocean.com
#ENV AQUARIUS_URL='http://127.0.0.1:5000'
ENV AQUARIUS_URL='https://aquarius.rinkeby.bigdataprotocolmarket.com:5000'

# FIXME set that because version throws exception and polutes the logs, probably need verification if will be used not only with the marketplace
ENV OPERATOR_SERVICE_URL='https://operator-api.operator.dev-ocean.com'



ENV PARITY_ADDRESS1=0x00bd138abd70e2f00903268f3db08f2d25677c9e
ENV PARITY_PASSWORD1=node0
ENV PARITY_KEYFILE1=tests/resources/consumer_key_file.json

ENTRYPOINT ["/ocean-provider/docker-entrypoint.sh"]

EXPOSE 8030
