{{/*
 Create the config
 */}}
{{- define "icinga-kubernetes.config" -}}
# This is the configuration file for Icinga Kubernetes.

# Connection configuration for the database to which Icinga Kubernetes synchronizes data.
# This is also the database used in Icinga Kubernetes Web to view and work with the data.
database:
    # Database type. Only 'mysql' is supported yet which is the default.
    #  type: mysql

    # Database host or absolute Unix socket path.
    host: {{ if .Values.global.databases.kubernetes.enabled }} {{ .Release.Name }}-kubernetes-database {{ else }} {{ .Values.global.databases.kubernetes.host | quote }} {{ end }}

    # Database port. By default, the MySQL port.
    port: {{ .Values.global.databases.kubernetes.port | default 3306 }}

    # Database name.
    database: {{ .Values.global.databases.kubernetes.database }}

    # Database user.
    user: {{ .Values.global.databases.kubernetes.username.value }}

    # Database password.
    password: {{ .Values.global.databases.kubernetes.password.value }}
{{- end -}}
