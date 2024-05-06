# Contributor guidelines

Thank you for your interest in this chart! We appreciate your help improving the charts in this repository.
Please take a moment to read through the guidelines in this document to make the contribution process easy and effective for everyone involved.

## Reporting issues

Please report issues and bugs by creating a [GitHub Issue](https://github.com/icinga/helm-charts/issues/new/choose) and choosing **Bug** from the template list.
Continue by filling out the template with all the relevant information.

## Suggesting features and enhancements

Please report issues and bugs by creating a [GitHub Issue](https://github.com/icinga/helm-charts/issues/new/choose) and choosing **Feature Request** from the template list.
Continue by filling out the template with all the relevant information.

## Contributing changes

Before contributing changes, please take a moment to review open/closed issues and pull requests to avoid duplicate efforts. If your research didn't produce any closed/merged issues or pull requests, please create a new **Feature Request** [GitHub Issue](https://github.com/icinga/helm-charts/issues/new/choose) to discuss your changes, as the maintainers might have omitted the proposed changes deliberately.

Once the issue has been opened and discussed, you can start working on your changes. Please fork the repository and create a new branch for your changes. Once you are done with your changes, please open a new pull request and reference the issue you created in the description.

### Templating the chart(s) locally

Charts can be templated locally using `helm template <path-to-chart` from `charts/icinga-stack`. It might be needed to install missing remote dependencies before doing so:

> [!NOTE]
> Some values might be required for templating to succeed.
> Simple dummy values are provided in [`charts/icinga-stack/tests/required-values.yaml`](./charts/icinga-stack/tests/required-values.yaml) for all charts.

```sh
$ cd charts/icinga-stack
$ helm dep update
$ helm template . -f tests/required-values.yaml > icinga-stack-manifests.yaml
$ helm template ./charts/icinga2 -f tests/required-values.yaml > icinga2-manifests.yaml
```

### Deploying the chart(s) locally

Charts can be installed and upgraded locally `helm install .` from their respective root directories:

> [!NOTE]
> Some values might be required for templating to succeed.
> Simple dummy values are provided in [`charts/icinga-stack/tests/required-values.yaml`](./charts/icinga-stack/tests/required-values.yaml) for all charts.

```sh
$ helm install <release> . -f tests/required-values.yaml
$ helm update <release> . -f tests/required-values.yaml
```

## Testing changes

For testing the charts in this repository, we use [helm-unittest](https://github.com/quintush/helm-unittest) and [Docker](https://docker.com). Please refer to the[helm-unittest documentation](https://github.com/quintush/helm-unittest) and [Docker documentation](https://docs.docker.com/get-docker/) for installation instructions.

Once you have installed helm-unittest and Docker, you can run the tests by executing the following command from the root directory of the respective Helm chart:

```console
docker run --rm -v "${PWD}:/apps" docker.io/quintush/helm-unittest:3.11.2-0.3.0 .
```

This will test all the Helm templates in the `./templates/` directory against the test specifications in the `./tests/` directory.

### Conventions for new tests

To maintain a certain style of tests throughout the charts, please adhere to the following conventions when writing new tests:

- Tests for subcharts should be placed in the `./tests` directory of the parent chart and prefixed with the subchart's name, e.g. `icingaweb2_deployment_test.yaml`.
- Tests should be grouped by the template they are testing.
- Test files should be named after the template they are testing, e.g. Icinga Web's `deployment.yaml` should be tested in `icingaweb2_deployment_test.yaml`.
- **Test Suites** should be prefixed with the name of the product/chart they test, e.g. _[Icinga 2] Test Icinga 2 persistence_
