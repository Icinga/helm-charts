# Configuration

The configuration for this chart is done via entries in `values.yaml` in the project's root directory. The following tables lists the configurable parameters of the chart and their default values.

For configuration of Icinga2's different **features**, please see the section about [Icinga2 features](#icinga2-features).

For configuration of IcingaWeb2's different **modules**, please see the section about [IcingaWeb2 modules](#icingaweb2-modules).

## Values configuration

Sensible values can be set directly using `.value` key or by using Kubernetes secrets. Values that can be configured using secrets have parameters holding secret name and key listed in tables below.

Certificates used by Icinga features are projected in containers using kubernetes secrets. Please see [values.yaml](../values.yaml) for configuration.

### Required values

These values **must** be set for the chart to install successfully. Therefore, no defaults are provided. Installation will fail if these values are not set.

The values can be set in the chart's `values.yaml` file or via the `--set` flag when installing the chart.

| Parameter | Description | Remarks | Kubernetes secret parameters |
| --------- | ----------- | ------- | ---------------------------- |
| `icinga2.config.ticket_salt.value` | Salt used to generate API tickets for satellites and agents | - | `icinga2.config.ticket_salt.credSecret`, `icinga2.config.ticket_salt.secretKey` |
| `icingaweb2.auth.admin_password.value` | Password for the Icinga Web 2 admin user | Only needs to be set if Icingaweb2 is `enabled` | `icingaweb2.auth.admin_password.credSecret`, `icingaweb2.auth.admin_password.secretKey` |
| `global.api.users.director.password.value` | Password for the Icinga Director API user | Only needs to be set if Director is `enabled` | `global.api.users.credSecret`, `global.api.users.director.password.secretKey` |
| `global.api.users.icingaweb.password.value` | Password for the Icingaweb2 API user| Only needs to be set if Icingaweb2 is `enabled` | `global.api.users.credSecret`, `global.api.users.icingaweb.password.secretKey` |

### Global values

These values are used by multiple (sub-)charts and therefore need to be set in the `global` scope.

| Parameter | Description | Data Type | Default |
| --------- | ----------- | --------- | ------- |
| `global.api.host` | Hostname of the Icinga 2 API | `string` | **not set** |
| `global.api.port` | Port of the Icinga 2 API | `number` | `5665` |
| `global.api.users.director.permissions` | Permissions of the Icinga2 API user for Director | `[]string` | `["*"]` |
| `global.api.users.icingaweb.permissions` | Permissions of the Icinga2 API user for Icingaweb2 | `[]string` | `["*"]` |
| `global.databases.<database>.database` | Name of the respective database | `string` | `<database>db`|
| `global.databases.<database>.username.value` | Username for the respective database. Can be set from secret defined by `global.databases.<database>.credSecret` and `global.databases.<database>.username.secretKey` | `string` | **not set** |  |
| `global.databases.<database>.password.value` | Password for the respective database. Can be set from secret defined by `global.databases.<database>.credSecret` and `global.databases.<database>.password.secretKey` | `string` | **not set** |  |
| `global.databases.<database>.enabled` | Whether or not the database should get deployed in-cluster | `boolean` | **varies** |
| `global.databases.<database>.host` | Hostname of the respective database | `string` | **not set** |
| `global.databases.<database>.port` | Port of the respective database | `number` | `3306` |
| `global.databases.<database>.persistence.enabled` | Whether or not the database should use a persistent volume | `boolean` | `false` |
| `global.databases.<database>.persistence.size` | Size of the persistent volume | `string` | `5Gi` |
| `global.databases.<database>.persistence.accessMode` | Access mode of the persistent volume | `string` | `ReadWriteOnce` |
| `global.databases.<database>.persistence.storageClass` | Storage class of the persistent volume | `string` | **not set** |
| `global.databases.<database>.persistence.volumeName` | Name of the persistent volume | `string` | **not set** |
| `global.databases.<database>.persistence.subPath` | Subpath of the persistent volume | `string` | **not set** |
| `global.databases.<database>.persistence.matchLabels` | Labels to match for the persistent volume | `map[string]string` | `{}` |
| `global.databases.<database>.persistence.matchExpressions` | Expressions to match for the persistent volume | `[]map[string]string` | `[]` |
| `global.redis.enabled` | Whether or not to deploy a Redis instance | `boolean` | `true` |
| `global.redis.host` | Hostname of the Redis instance | `string` | **not set** |
| `global.redis.port` | Port of the Redis instance | `number` | **not set** |

### Icinga2 values

These values are used by the Icinga2 sub-chart. For configuration of Icinga2's different **features**, please see the section about [Icinga2 features](#icinga2-features).

| Parameter | Description | Data Type | Default |
| --------- | ----------- | --------- | ------- |
| `icinga2.image.repository` | Repository of the Icinga2 image | `string` | `icinga/icinga2` |
| `icinga2.image.tag` | Tag of the Icinga2 image | `string` | `2.13.7` |
| `icinga2.image.pullPolicy` | Pull policy of the Icinga2 image | `string` | `IfNotPresent` |
| `icinga2.imagePullSecrets` | Pull secrets of the Icinga2 image | `[]string` | `[]` |
| `icinga2.nameOverride` | Name override of the Icinga2 deployment | `string` | `""` |
| `icinga2.fullnameOverride` | Fullname override of the Icinga2 deployment | `string` | `""` |
| `icinga2.service.type` | Type of the Icinga2 service | `string` | `ClusterIP` |
| `icinga2.service.port` | Port of the Icinga2 service | `number` | `5665` |
| `icinga2.ingress.enabled` | Whether or not to deploy an ingress for Icinga2 | `boolean` | `false` |
| `icinga2.ingress.className` | Class name of the Icinga2 ingress | `string` | `""` |
| `icinga2.ingress.annotations` | Annotations of the Icinga2 ingress | `map[string]string` | `{}` |
| `icinga2.ingress.hosts[].host` | Host of the Icinga2 ingress | `string` | **not set** |
| `icinga2.ingress.hosts[].paths[].path` | Path of the Icinga2 ingress | `string` | `/` |
| `icinga2.ingress.hosts[].paths[].pathType` | Path type of the Icinga2 ingress | `string` | `ImplementationSpecific` |
| `icinga2.ingress.tls[].hosts[]` | Hosts of the Icinga2 ingress | `[]string` | **not set** |
| `icinga2.ingress.tls[].secretName` | Secret name of the Icinga2 ingress | `string` | **not set** |
| `icinga2.config.node_name` | Name of the Icinga2 node | `string` | `icinga2-master` |
| `icinga2.config.zone_name` | Name of the Icinga2 zone | `string` | `master` |
| `icinga2.config.disable_confd` | Disables the `include_recursive "conf.d"` directive in icinga2.conf | `boolean` | `true` |
| `icinga2.config.ticket_salt.value` | Salt used to generate API tickets for satellites and agents. Can be set from secret specified in `icinga2.config.ticket_salt.credSecret` and `icinga2.config.ticket_salt.secretKey` | `string` | **not set** |
| `icinga2.features.<feature>.enabled` | Whether or not the respective feature should be enabled | `boolean` | **varies** |
| `icinga2.persistence.enabled` | Whether or not the Icinga2 deployment should use a persistent volume | `boolean` | `false` |
| `icinga2.persistence.size` | Size of the persistent volume | `string` | `5Gi` |
| `icinga2.persistence.accessMode` | Access mode of the persistent volume | `string` | `ReadWriteOnce` |
| `icinga2.persistence.storageClass` | Storage class of the persistent volume | `string` | **not set** |
| `icinga2.persistence.volumeName` | Name of the persistent volume | `string` | **not set** |
| `icinga2.persistence.subPath` | Subpath of the persistent volume | `string` | **not set** |
| `icinga2.persistence.matchLabels` | Labels to match for the persistent volume | `map[string]string` | `{}` |
| `icinga2.persistence.matchExpressions` | Expressions to match for the persistent volume | `[]map[string]string` | `[]`|
| `icinga2.resources` | Resources of the Icinga2 deployment | `map[string]string` | `{}` |
| `icinga2.nodeSelector` | Node selector of the Icinga2 deployment | `map[string]string` | `{}` |
| `icinga2.tolerations` | Tolerations of the Icinga2 deployment | `[]map[string]string` | `[]` |
| `icinga2.affinity` | Affinity of the Icinga2 deployment | `map[string]string` | `{}` |
| `icinga2.serviceAccount.create` | Whether or not to create a service account for the Icinga2 deployment | `boolean` | `false` |
| `icinga2.serviceAccount.annotations` | Annotations of the Icinga2 service account | `map[string]string` | `{}` |
| `icinga2.serviceAccount.name` | Name of the Icinga2 service account | `string` |  `""` |
| `icinga2.podAnnotations` | Annotations of the Icinga2 pods | `map[string]string` | `{}` |
| `icinga2.podSecurityContext.fsGroup` | Filesystem group of the Icinga2 pods | `number` | `5665` |
| `icinga2.podSecurityContext` | Security context of the Icinga2 pods | `map[string]string` | `{}` |

### IcingaDB values

These values are used by the IcingaDB sub-chart.

| Parameter | Description | Data Type | Default |
| --------- | ----------- | --------- | ------- |
| `icingadb.enabled` | Whether or not to deploy IcingaDB | `boolean` | `true` |
| `icingadb.image.repository` | Repository of the IcingaDB image | `string` | `icinga/icingadb` |
| `icingadb.image.tag` | Tag of the IcingaDB image | `string` | `1.1.0` |
| `icingadb.image.pullPolicy` | Pull policy of the IcingaDB image | `string` | `IfNotPresent` |
| `icingadb.imagePullSecrets` | Pull secrets of the IcingaDB image | `[]string` | `[]` |
| `icingadb.nameOverride` | Name override of the IcingaDB deployment | `string` | `""` |
| `icingadb.fullnameOverride` | Fullname override of the IcingaDB deployment | `string` | `""` |
| `icingadb.resources` | Resources of the IcingaDB deployment | `map[string]string` | `{}` |
| `icingadb.nodeSelector` | Node selector of the IcingaDB deployment | `map[string]string` | `{}` |
| `icingadb.tolerations` | Tolerations of the IcingaDB deployment | `[]map[string]string` | `[]` |
| `icingadb.affinity` | Affinity of the IcingaDB deployment | `map[string]string` | `{}` |
| `icingadb.serviceAccount.create` | Whether or not to create a service account for the IcingaDB deployment | `boolean` | `false` |
| `icingadb.serviceAccount.annotations` | Annotations of the IcingaDB service account | `map[string]string` | `{}` |
| `icingadb.serviceAccount.name` | Name of the IcingaDB service account | `string` |  `""` |
| `icingadb.podAnnotations` | Annotations of the IcingaDB pods | `map[string]string` | `{}` |
| `icingadb.podSecurityContext` | Security context of the IcingaDB pods | `map[string]string` | `{}` |
| `icingadb.securityContext` | Security context of the IcingaDB container | `map[string]string` | `{}` |

### IcingaWeb2 values

These values are used by the IcingaWeb2 sub-chart. For configuration of Icingaweb2's different **modules**, please see the section about [Icingaweb2 modules](#icingaweb2-modules).

| Parameter | Description | Data Type | Default |
| --------- | ----------- | --------- | ------- |
| `icingaweb2.enabled` | Whether or not to deploy IcingaWeb2 | `boolean` | `true` |
| `icingaweb2.image.repository` | Repository of the IcingaWeb2 image | `string` | `icinga/icingaweb2` |
| `icingaweb2.image.tag` | Tag of the IcingaWeb2 image | `string` | `2.11.4` |
| `icingaweb2.image.pullPolicy` | Pull policy of the IcingaWeb2 image | `string` | `IfNotPresent` |
| `icingaweb2.imagePullSecrets` | Pull secrets of the IcingaWeb2 image | `[]string` | `[]` |
| `icingaweb2.nameOverride` | Name override of the IcingaWeb2 deployment | `string` | `""` |
| `icingaweb2.fullnameOverride` | Fullname override of the IcingaWeb2 deployment | `string` | `""` |
| `icingaweb2.service.type` | Type of the IcingaWeb2 service | `string` | `ClusterIP` |
| `icingaweb2.service.port` | Port of the IcingaWeb2 service | `number` | `8080` |
| `icingaweb2.ingress.enabled` | Whether or not to create an ingress for the IcingaWeb2 service | `boolean` | `false` |
| `icingaweb2.ingress.className` | Class name of the IcingaWeb2 ingress | `string` | `""` |
| `icingaweb2.ingress.annotations` | Annotations of the IcingaWeb2 ingress | `map[string]string` | `{}` |
| `icingaweb2.ingress.hosts[].host` | Host of the IcingaWeb2 ingress | `string` | **not set** |
| `icingaweb2.ingress.hosts[].paths[].path` | Path of the IcingaWeb2 ingress | `string` | `/` |
| `icingaweb2.ingress.hosts[].paths[].pathType` | Path type of the IcingaWeb2 ingress | `string` | `ImplementationSpecific` |
| `icingaweb2.ingress.tls[].hosts` | Hosts of the IcingaWeb2 ingress | `[]string` | **not set** |
| `icingaweb2.ingress.tls[].secretName` | Secret name of the IcingaWeb2 ingress | `string` | **not set** |
| `icingaweb2.auth.type` | Type of the IcingaWeb2 authentication | `string` | `db` |
| `icingaweb2.auth.admin_user` | Admin user of the IcingaWeb2 authentication | `string` | `icingaweb` |
| `icingaweb2.auth.admin_password.value` | Admin password of the IcingaWeb2 authentication. Can be set from secret specified in `icingaweb2.auth.admin_password.credSecret` and `icingaweb2.auth.admin_password.secretKey` | `string` | **not set** |
| `icingaweb2.modules.<module>.enabled` | Whether or not to enable the IcingaWeb2 module | `boolean` | **varies** |
| `icingaweb2.resources` | Resources of the IcingaWeb2 deployment | `map[string]string` | `{}` |
| `icingaweb2.nodeSelector` | Node selector of the IcingaWeb2 deployment | `map[string]string` | `{}` |
| `icingaweb2.tolerations` | Tolerations of the IcingaWeb2 deployment | `[]map[string]string` | `[]` |
| `icingaweb2.affinity` | Affinity of the IcingaWeb2 deployment | `map[string]string` | `{}` |
| `icingaweb2.serviceAccount.create` | Whether or not to create a service account for the IcingaWeb2 deployment | `boolean` | `false` |
| `icingaweb2.serviceAccount.annotations` | Annotations of the IcingaWeb2 service account | `map[string]string` | `{}` |
| `icingaweb2.serviceAccount.name` | Name of the IcingaWeb2 service account | `string` |  `""` |
| `icingaweb2.podAnnotations` | Annotations of the IcingaWeb2 pods | `map[string]string` | `{}` |
| `icingaweb2.podSecurityContext` | Security context of the IcingaWeb2 pods | `map[string]string` | `{}` |
| `icingaweb2.securityContext` | Security context of the IcingaWeb2 container | `map[string]string` | `{}` |

## Icinga2 Features

The feature set of Icinga2 supported by this Helmchart is **opinionated**. We deliberately chose to omit some features, either because they are listed as **deprecated** in the official documentation or just have no real use-case when run on Kubernetes. Below is a list of currently supported features, with links to the official documentation, if available:

- `api` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/12-icinga2-api/#icinga2-api)
- `checker`
- `compatlog` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#compatlogger)
- `debuglog` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#filelogger)
- `elasticsearch` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#elasticsearchwriter)
- `gelf` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#gelfwriter)
- `graphite` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#graphitewriter)
- `icingadb` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#icingadb)
- `influxdb2` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#influxdb2writer)
- `influxdb` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#influxdbwriter)
- `mainlog` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#filelogger)
- `notification` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#notification)
- `opentsdb` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#opentsdbwriter)
- `syslog` [Documentation](https://icinga.com/docs/icinga-2/latest/doc/09-object-types/#sysloglogger)

**Configuration** of these features is done via the `values.yaml` file. A **commented** version of all available values is provided with this repository. Please refer to the official documentation linked above for more information on how to configure these features.

## IcingaWeb2 Modules

The module set of IcingaWeb2 supported by this Helmchart is **opinionated**. We deliberately chose to omit some modules, either because they are **deprecated** or just have no real use-case when run on Kubernetes. Below is a list of currently supported modules, with links to the official documentation, if available:

- `audit` [Documentation](https://github.com/icinga/icingaweb2-module-audit)
- `businessprocess` [Documentation](https://icinga.com/docs/icinga-business-process-modelling/latest/doc/01-About/)
- `cube` [Documentation](https://github.com/icinga/icingaweb2-module-cube)
- `director` [Documentation](https://icinga.com/docs/icinga-director/latest/doc/01-Introduction/)
- `graphite` [Documentation](https://icinga.com/docs/icinga-web-graphite-integration/latest/doc/01-About/)
- `icingadb` [Documentation](https://icinga.com/docs/icinga-db-web/latest/)
- `incubator` [Documentation](https://github.com/icinga/icingaweb2-module-incubator)
- `x509` [Documentation](https://icinga.com/docs/icinga-certificate-monitoring/latest/doc/01-About/)

**Configuration** of these modules is done via the `values.yaml` file. A version of all available values is provided with this repository. Please refer to the official documentation linked above for more information on how to configure these features.