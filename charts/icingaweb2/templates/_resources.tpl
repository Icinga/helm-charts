{{- define "icingaweb2.resources" -}}
{{- range $resource := .Values.resources -}}
{{- range $k, $v := . }}
- name: icingaweb.resources.{{ $resource.name }}.{{ $k }}
  value: {{ $v | quote }}
{{- end }}
{{- end }}
{{- range $database := .Values.global.databases }}
- name: icingaweb.resources.{{ $database.database }}.type
  value: db
- name: icingaweb.resources.{{ $database.database }}.db
  value: mysql
- name: icingaweb.resources.{{ $database.database }}.host
  value: {{ if $database.internal }}icinga2-mariadb-{{ $database.database }} {{ else }} {{ $database.host }} {{ end }}
- name: icingaweb.resources.{{ $database.database }}.dbname
  value: {{ $database.database}}
- name: icingaweb.resources.{{ $database.database }}.username
  value: {{ $database.username | default "mysql"}}
- name: icingaweb.resources.{{ $database.database }}.password
  value: {{ $database.password | default "mysql" }}
{{- if eq $database.database "directordb" }}
- name: icingaweb.resources.{{ $database.database }}.charset
  value: utf8
{{- end }}
{{- end }}
{{- end -}}
