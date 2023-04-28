{{- define "icingaweb2.resources" -}}
{{- range $resource := .Values.web_resources -}}
{{- range $k, $v := . }}
- name: icingaweb.resources.{{ $resource.name }}.{{ $k }}
  value: {{ $v | quote }}
{{- end }}
{{- end }}
{{- range $resource, $settings := .Values.global.databases }}
- name: icingaweb.resources.{{ $settings.database }}.type
  value: db
- name: icingaweb.resources.{{ $settings.database }}.db
  value: mysql
- name: icingaweb.resources.{{ $settings.database }}.host
  value: {{ if $settings.enabled }} {{ $.Release.Name }}-{{ $resource }}-database {{ else }} {{ $settings.host }} {{ end }}
- name: icingaweb.resources.{{ $settings.database }}.dbname
  value: {{ $settings.database}}
- name: icingaweb.resources.{{ $settings.database }}.username
  value: {{ $settings.username | default "mysql"}}
- name: icingaweb.resources.{{ $settings.database }}.password
  value: {{ $settings.password | default "mysql" }}
{{- if eq $resource "director" }}
- name: icingaweb.resources.{{ $settings.database }}.charset
  value: utf8
{{- end }}
{{- end }}
{{- end -}}
