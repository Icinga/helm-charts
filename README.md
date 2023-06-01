# Icinga2 Kubernetes Helm Charts

This repository serves as a central repository to host all Icinga2 related Helm charts.

[Icinga2](https://icinga.com) is a monitoring system which checks the availability of your network resources, notifies users of outages, and generates performance data for reporting.

[Helm](https://helm.sh) is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.

### Add Helm repository

First you need to add the Icinga2 Helm repository to your Helm installation. Helm repositories are similar to package repositories in Linux distributions as in they contain different available packages of 
Kubernetes manifests for users to consume.

The Icinga2 Helm repository is hosted on GitHub Pages and can be added to your Helm installation by running the following commands:

```console
helm repo add icinga https://icinga.github.io/helm-charts
helm repo update
```

## Reporting issues

Please report issues and bugs by creating a [GitHub Issue](https://github.com/icinga/helm-charts/issues/new/choose) and choosing **Bug** from the template list.
Continue by filling out the template with all the relevant information.

## Suggesting features and enhancements

Please suggest features and enhancements by creating a [GitHub Issue](https://github.com/icinga/helm-charts/issues/new/choose) and choosing **Feature Request** from the template list.
Continue by filling out the template with all the relevant information.

## Contributing

For information on how to contribute to this repository, see the [contribution guidelines](CONTRIBUTING.md).

## License

This project is licensed under the terms of the [Apache 2.0](LICENSE) open source license.
