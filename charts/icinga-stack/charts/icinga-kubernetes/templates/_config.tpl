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
    database: kubernetes

    # Database user.
    {{- if and .Values.global.databases.kubernetes.username .Values.global.databases.kubernetes.username.value }}
    user: {{ .Values.global.databases.kubernetes.username.value }}
    {{- else if and .Values.global.databases.kubernetes.username .Values.global.databases.kubernetes.credSecret .Values.global.databases.kubernetes.username.secretKey }}
    valueFrom:
    secretKeyRef:
        name: {{ .Values.global.databases.kubernetes.credSecret }}
        key: {{ .Values.global.databases.kubernetes.username.secretKey }}
    {{- else }}
    valueFrom:
    secretKeyRef:
        name: database.kubernetes
        key: kubernetes_username
    {{- end }}

    # Database password.
    {{- if and .Values.global.databases.kubernetes.password .Values.global.databases.kubernetes.password.value }}
    password: {{ .Values.global.databases.kubernetes.password.value }}
    {{- else if and .Values.global.databases.kubernetes.password .Values.global.databases.kubernetes.credSecret .Values.global.databases.kubernetes.password.secretKey }}
    valueFrom:
    secretKeyRef:
        name: {{ .Values.global.databases.kubernetes.credSecret }}
        key: {{ .Values.global.databases.kubernetes.username.secretKey }}
    {{- else }}
    valueFrom:
    secretKeyRef:
        name: database.kubernetes
        key: kubernetes_username
    {{- end }}   
{{- end -}}
