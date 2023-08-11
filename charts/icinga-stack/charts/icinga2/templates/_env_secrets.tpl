{{- define "icinga2.envSecrets" -}}
- name: ICINGA_TICKET_SALT
  {{- if .Values.config.ticket_salt.value  }}
  value: {{ .Values.config.ticket_salt.value | quote }}
  {{- else if and (.Values.config.ticket_salt.credSecret) (.Values.config.ticket_salt.secretKey) }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.config.ticket_salt.credSecret | quote }}
      key: {{ .Values.config.ticket_salt.secretKey | quote }}
  {{- else }}
    {{ fail "Icinga TicketSalt not set. Either set .Values.config.ticket_salt.value or .Values.config.ticket_salt.credSecret and .Values.config.ticket_salt.secretKey" }}
  {{- end }}
{{- range $user, $settings := .Values.global.api.users }}
{{- if ne $user "credSecret" }} # skip credSecret key
- name: {{ print "ICINGA_" $user "_API_PASSWORD" | upper }}
{{- if and $settings.password $settings.password.value }}
  value: {{ $settings.password.value | quote }}
{{- else if and $.Values.global.api.users.credSecret $settings.password $settings.password.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ $.Values.global.api.users.credSecret | quote }}
      key: {{ $settings.password.secretKey | quote }}
{{- else }}
{{ fail (print $user " api user password not set. Set either .Values.global.api.users." $user ".password.value or .Values.global.api.users.credSecret and .Values.global.api.users." $user ".password.secretKey") }}
{{- end }}
{{- end }}
{{- end }}
{{- if and .Values.features.elasticsearch.enabled .Values.features.elasticsearch.username (or (.Values.features.elasticsearch.username.value) (and .Values.features.elasticsearch.credSecret .Values.features.elasticsearch.username.secretKey)) }}
- name: ICINGA_ELASTICSEARCH_USERNAME
  {{- if .Values.features.elasticsearch.username.value }}
  value: {{ .Values.features.elasticsearch.username.value | quote }}
  {{- else if and .Values.features.elasticsearch.credSecret .Values.features.elasticsearch.username.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.features.elasticsearch.credSecret | quote }}
      key: {{ .Values.features.elasticsearch.username.secretKey  | quote }}
  {{- end }}
{{- end }}
{{- if and .Values.features.elasticsearch.enabled .Values.features.elasticsearch.password (or (.Values.features.elasticsearch.password.value) (and .Values.features.elasticsearch.credSecret .Values.features.elasticsearch.password.secretKey)) }}
- name: ICINGA_ELASTICSEARCH_PASSWORD
  {{- if .Values.features.elasticsearch.password.value }}
  value: {{ .Values.features.elasticsearch.password.value | quote }}
  {{- else if and .Values.features.elasticsearch.credSecret .Values.features.elasticsearch.password.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.features.elasticsearch.credSecret | quote }}
      key: {{ .Values.features.elasticsearch.password.secretKey  | quote }}
  {{- end }}
{{- end }}
{{- if and .Values.features.icingadb.enabled .Values.features.icingadb.password }}
- name: ICINGA_ICINGADB_PASSWORD
{{- if .Values.features.icingadb.password.value }}
  value: {{ .Values.features.icingadb.password.value | quote }}
{{- else if and .Values.features.icingadb.credSecret .Values.features.icingadb.password.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.features.icingadb.credSecret | quote }}
      key: {{ .Values.features.icingadb.password.secretKey  | quote }}
{{- else }}
  {{ fail "icingadb password partially set. Set either .Values.features.icingadb.password.value or .Values.features.icingadb.credSecret and .Values.features.icingadb.password.secretKey" }}
{{- end }}
{{- end }}
{{- if .Values.features.influxdb2.enabled }}
- name: ICINGA_INFLUXDB2_AUTH_TOKEN
  {{- if and .Values.features.influxdb2.auth_token .Values.features.influxdb2.auth_token.value }}
  value: {{ .Values.features.influxdb2.auth_token.value | quote }}
  {{- else if and .Values.features.influxdb2.auth_token .Values.features.influxdb2.credSecret .Values.features.influxdb2.auth_token.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.features.influxdb2.credSecret | quote }}
      key: {{ .Values.features.influxdb2.auth_token.secretKey  | quote }}
  {{- else }}
    {{ fail "Icinga InfluxDB2 auth_token not set. Either set .Values.features.influxdb2.auth_token.value or .Values.features.influxdb2.credSecret and .Values.features.influxdb2.auth_token.secretKey" }}
  {{- end }}
{{- end }}
{{- if .Values.features.influxdb.enabled }}
{{- if and .Values.features.influxdb.username .Values.features.influxdb.password }}
- name: ICINGA_INFLUXDB_USERNAME
{{- if .Values.features.influxdb.username.value }}
  value: {{ .Values.features.influxdb.username.value | quote }}
{{- else if and .Values.features.influxdb.credSecret .Values.features.influxdb.username.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.features.influxdb.credSecret | quote }}
      key: {{ .Values.features.influxdb.username.secretKey  | quote }}
{{- end}}
- name: ICINGA_INFLUXDB_PASSWORD
{{- if .Values.features.influxdb.password.value }}
  value: {{ .Values.features.influxdb.password.value | quote }}
{{- else if and .Values.features.influxdb.credSecret .Values.features.influxdb.password.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.features.influxdb.credSecret | quote }}
      key: {{ .Values.features.influxdb.password.secretKey  | quote }}
{{- end }}
{{- end }}

{{- if and .Values.features.influxdb.basic_auth .Values.features.influxdb.basic_auth.username .Values.features.influxdb.basic_auth.password }}
- name: ICINGA_INFLUXDB_BASIC_AUTH_USERNAME
{{- if .Values.features.influxdb.basic_auth.username.value }}
  value: {{ .Values.features.influxdb.basic_auth.username.value | quote }}
{{- else if and .Values.features.influxdb.credSecret .Values.features.influxdb.basic_auth.username.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.features.influxdb.credSecret | quote }}
      key: {{ .Values.features.influxdb.basic_auth.username.secretKey  | quote }}
{{- end}}
- name: ICINGA_INFLUXDB_BASIC_AUTH_PASSWORD
{{- if .Values.features.influxdb.basic_auth.password.value }}
  value: {{ .Values.features.influxdb.basic_auth.password.value | quote }}
{{- else if and .Values.features.influxdb.credSecret .Values.features.influxdb.basic_auth.password.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.features.influxdb.credSecret | quote }}
      key: {{ .Values.features.influxdb.basic_auth.password.secretKey  | quote }}
{{- end }}
{{- end }}

{{- end }}
{{- end -}}
