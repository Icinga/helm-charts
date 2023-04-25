---
{{- define "icingaweb2.config" -}}
{{- $auth_admin_password := .Values.auth.admin_password | required ".Values.icingaweb2.auth.admin_password is required." -}}
{{- if .Values.modules.director.enabled }}
{{- $global_api_director_password := .Values.global.api.users.director.password | required ".Values.global.api.director.password is required." }}
- name: icingaweb.modules.director.config.db.resource
  value: {{ .Values.global.databases.director.database | quote }}
{{- if .Values.modules.director.kickstart }}
- name: icingaweb.modules.director.kickstart.config.endpoint
  value: icinga2-master
- name: icingaweb.modules.director.kickstart.config.host
  value: {{ .Release.Name }}-icinga2
- name: icingaweb.modules.director.kickstart.config.username
  value: director
- name: icingaweb.modules.director.kickstart.config.password
  value: {{ $global_api_director_password | quote }}
{{- end }}
{{- end }}
- name: icingaweb.authentication.icingaweb2.backend
  value: {{ .Values.auth.type | quote }}
- name: icingaweb.authentication.icingaweb2.resource
  value: {{ .Values.auth.resource | default .Values.global.databases.icingaweb2.database | quote }}
- name: "icingaweb.passwords.icingaweb2.{{ .Values.auth.admin_user}}"
  value: {{ $auth_admin_password | quote }}
- name: icingaweb.config.global.config_backend
  value: {{ .Values.auth.resource | default .Values.global.databases.icingaweb2.database | quote }}
- name: icingaweb.config.global.config_resource
  value: {{ .Values.auth.type | quote }}
- name: icingaweb.groups.icingaweb2.backend
  value: {{ .Values.auth.type | quote }}
- name: icingaweb.groups.icingaweb2.resource
  value: {{ .Values.auth.resource | default .Values.global.databases.icingaweb2.database | quote }}
- name: icingaweb.roles.Administrators.users
  value: {{ .Values.auth.admin_user | quote }}
- name: icingaweb.roles.Administrators.permissions
  value: '*'
- name: icingaweb.roles.Administrators.groups
  value: Administrators
{{- if .Values.modules.icingadb.enabled }}
{{- $global_api_users_icingaweb_password := .Values.global.api.users.icingaweb.password | required ".Values.global.api.icingaweb.password is required." }}
- name: icingaweb.modules.icingadb.config.icingadb.resource
  value: {{ .Values.global.databases.icingadb.database | quote }}
- name: icingaweb.modules.icingadb.redis.redis1.host
  value: {{ .Values.global.redis.host | default "icinga2-redis" | quote }}
- name: icingaweb.modules.icingadb.redis.redis1.port
  value: {{ .Values.global.redis.port | default "6379" | quote }}
- name: icingaweb.modules.icingadb.commandtransports.icinga2.transport
  value: api
- name: icingaweb.modules.icingadb.commandtransports.icinga2.skip_validation
  value: "0"
- name: icingaweb.modules.icingadb.commandtransports.icinga2.host
  value: {{ .Values.global.api.host | default (print .Release.Name "-icinga2") | quote }}
- name: icingaweb.modules.icingadb.commandtransports.icinga2.port
  value: {{ .Values.global.api.port | default 5665 | quote }}
- name: icingaweb.modules.icingadb.commandtransports.icinga2.username
  value: {{ .Values.global.api.users.icingaweb.username | quote }}
- name: icingaweb.modules.icingadb.commandtransports.icinga2.password
  value: {{ $global_api_users_icingaweb_password | quote }}
{{- end }}
{{- if .Values.modules.audit.enabled }}
- name: icingaweb.modules.audit.config.log.type
  value: {{ .Values.modules.audit.log.type | quote }}
- name: icingaweb.modules.audit.config.log.ident
  value: {{ .Values.modules.audit.log.ident | quote }}
- name: icingaweb.modules.audit.config.log.facility
  value: {{ .Values.modules.audit.log.facility | quote }}
{{- if .Values.modules.audit.stream.enabled }}
- name: icingaweb.modules.audit.config.stream.format
  value: {{ .Values.modules.audit.stream.format | quote}}
- name: icingaweb.modules.audit.config.stream.path
  value: {{ .Values.modules.audit.stream.path | quote }}
{{- end }}
{{- end }}
{{- if .Values.modules.graphite.enabled }}
- name: icingaweb.modules.graphite.config.graphite.url
  value: {{ .Values.modules.graphite.graphite.url | quote }}
- name: icingaweb.modules.graphite.config.graphite.user
  value: {{ .Values.modules.graphite.graphite.user | quote }}
- name: icingaweb.modules.graphite.config.graphite.password
  value: {{ .Values.modules.graphite.graphite.password | quote}}
- name: icingaweb.modules.graphite.config.graphite.insecure
  value: {{ .Values.modules.graphite.graphite.insecure | quote }}
- name: icingaweb.modules.graphite.config.ui.default_time_range
  value: {{ .Values.modules.graphite.ui.default_time_range | quote }}
- name: icingaweb.modules.graphite.config.ui.default_time_range_unit
  value: {{ .Values.modules.graphite.ui.default_time_range_unit | quote }}
- name: icingaweb.modules.graphite.config.ui.disable_no_graphs_found
  value: {{ .Values.modules.graphite.ui.disable_no_graphs_found | quote }}
- name: icingaweb.modules.graphite.config.icinga.graphite_writer_host_name_template
  value: {{ .Values.modules.graphite.icinga.graphite_writer_host_name_template | quote }}
- name: icingaweb.modules.graphite.config.icinga.graphite_writer_service_name_template
  value: {{ .Values.modules.graphite.icinga.graphite_writer_service_name_template | quote }}
- name: icingaweb.modules.graphite.config.icinga.customvar_obscured_check_command
  value: {{ .Values.modules.graphite.icinga.customvar_obscured_check_command | quote }}
{{- end }}
{{- if .Values.modules.x509.enabled }}
- name: icingaweb.modules.x509.config.backend.resource
  value: {{ .Values.global.databases.x509.database | quote }}
{{- end }}
{{- end -}}
