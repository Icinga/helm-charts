{{/*
 Create the name of the service account to use
 */}}
{{- define "icinga-kubernetes.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{- default (include "common.names.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
    {{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{/*
 Create the name of the config map to use
 */}}
{{- define "icinga-kubernetes.configmapName" -}}
{{- printf "%s-configuration" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

