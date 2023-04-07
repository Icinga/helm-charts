{{- define "icingaweb2.config" -}}
{{- if .Values.modules.director.enabled }}
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
  value: {{ .Values.global.api.users.director.password | quote }}
{{- end }}
{{- end }}
- name: icingaweb.authentication.icingaweb2.backend
  value: {{ .Values.auth.type | quote }}
- name: icingaweb.authentication.icingaweb2.resource
  value: {{ .Values.auth.resource | default .Values.global.databases.icingaweb2.database | quote }}
- name: "icingaweb.passwords.icingaweb2.{{ .Values.auth.admin_user}}"
  value: {{ .Values.auth.admin_password | quote }}
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
- name: icingaweb.modules.icingadb.config.icingadb.resource
  value: {{ .Values.global.databases.icingadb.database | quote }}
- name: icingaweb.modules.icingadb.redis.redis1.host
  value: {{ .Values.global.redis.host | default "icinga2-redis" | quote }}
- name: icingaweb.modules.icingadb.redis.redis1.port
  value: {{ .Values.global.redis.port | default "6379" | quote }}
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
{{- if .Values.modules.vspheredb.enabled }}
- name: icingaweb.modules.vspheredb.config.db.resource
  value: {{ .Values.global.databases.vspheredb.database | quote }}
{{- end }}
{{- end -}}
