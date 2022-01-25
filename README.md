# ECM CCD Docker :whale:

## Purpose
This project is a customised version of [ccd-docker](https://github.com/hmcts/ccd-docker) to support a CCD environment
for use in ECM and RET ECM development.

* ExUI is used for case access
* IdAM stub is used rather than the full IdAM implementation
* Elasticsearch enabled for case search
* Docmosis Tornado can be enabled for document and report generation

This documentation consists only of quickstart instructions. For a full explanation of the CCD environment see
the main ccd-docker repository.

## Prerequisites

- [JDK 11](https://openjdk.java.net/projects/jdk/11/)
- [Docker](https://www.docker.com)

**Note:** *once docker is installed, increase the memory and CPU allocations (Docker -> Preferences -> Advanced) to the following minimum values for successful execution of ccd applications altogether:*

| Memory   | CPU   |
| :------: | :---: |
| 12+ GB   | 6+    |

## Setup

### Environment Variables

First, create a .env file that will store environment variables that are specific to you.

```
cp ./compose/.env.example ./compose/.env
```

Edited the .env file created and set the environment variables.

### ECM

The following commands will setup a CCD docker environment for developing ECM (not Reform ET).

```bash
exec bash
source ./bin/set-environment-variables.sh
./ccd login
./ccd compose pull
./ccd init
./ccd compose up -d
./bin/ecm/init-ecm.sh
# if the response is
# curl: (52) Empty reply from server
# then wait a minute and retry
./bin/ccd-import-definition.sh <path-to-ccd-files>/ccd-definitions.xlsx
cd <path-to-ethos-repl-docmosis-service>/src/main/resources/sqlscripts
./setup-ethos-db.sh
cd <path-to-ecm-consumer>/src/main/resources/sqlscripts
./setup-ecmconsumer-db.sh
```

### RET ECM

The following commands will setup a CCD docker environment for developing ECM in Reform ET.

```bash
exec bash
source ./bin/set-environment-variables.sh
./ccd login
./ccd compose pull
./ccd init
./ccd compose up -d
./bin/ecm/init-ecm.sh
# if the response is
# curl: (52) Empty reply from server
# then wait a minute and retry
./bin/ccd-import-definition.sh <path-to-ccd-files>/ccd-definitions.xlsx
```

To setup the ECM specific services see:
* https://github.com/hmcts/et-ccd-callbacks
* https://github.com/hmcts/et-message-handler

## Running
You should now be able to navigate to ExUI:

http://localhost:3455/

## Docmosis Reports
To enable reports to be generated you will need to have the following environment variables set (see .env file):
* TORNADO_LICENSE_KEY
* TORNADO_TEMPLATES_DIRECTORY

Then add
```
tornado
```
to defaults.conf and execute
```
./ccd compose up -d
```

## Document Management Mock
It is possible to substitute the dm-store for a mock dm-store. This will reduce the resource requirements to run the
environment. However, the mock only supports the /health endpoint so that the ethos-repl-docmosis service can start
without any errors. The only reason to use dm-store mock is to reduce the resources consumed by ccd-docker when you
don't need it in development.

To use dm-store mock, remove dm-store and tornado from defaults.conf and replace with dm-store-mock.
You will also need to remove the dm-store containers if they were already running.
./ccd compose up -d will bring the changes into effect.

# Clean
If you wish to clear down your system including dropping the database
```
./bin/ecm/ecm-clean.sh
```
This removes all containers but keeps the images.

If you wish to remove everything including images:
```
./bin/ecm/docker-clean.sh
```

## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.
