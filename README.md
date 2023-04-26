# Icinga Kubernetes Helm Charts

Icinga is a monitoring system which checks the availability of your network resources, notifies users of outages, and generates performance data for reporting.

This chart bootstraps an Icinga deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## TL;DR

```console
helm install my-release \
  --set icinga2.config.ticket_salt=CHANGE-ME
  --set icingaweb2.auth.admin_password=CHANGE-ME
  --set global.api.users.director.password=CHANGE-ME
  --set global.api.users.director.icingaweb.password=CHANGE-ME
  --set global.databases.director.password=CHANGE-ME
  --set global.databases.icingaweb2.password=CHANGE-ME
  --set global.databases.icingadb.password=CHANGE-ME
icinga
```

## Prerequisites

- Kubernetes 1.13+
- Helm 3+
- PV provisioner support in the underlying infrastructure

## Upgrading

## Testing

This Helm chart is tested with [helm unittest](https://github.com/helm-unittest/helm-unittest).

You can find the test specifications in the `./tests/` directory. Tests are automatically run in CI.

To run the tests locally, use the following command:

```
docker run --rm -v "${PWD}:/apps" docker.io/quintush/helm-unittest:3.11.2-0.3.0 .
```
