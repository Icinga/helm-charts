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
  {{- if and $settings.username $settings.username.value }}
  value: {{ $settings.username.value | quote }}
  {{- else if and $settings.username $settings.secretName $settings.username.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ $settings.secretName | quote }}
      key: {{ $settings.username.secretKey | quote }}
  {{- else }}
  value: "mysql"
  {{- end }}
- name: icingaweb.resources.{{ $settings.database }}.password
  {{- if and $settings.password $settings.password.value }}
  value: {{ $settings.password.value | quote }}
  {{- else if and $settings.password $settings.secretName $settings.password.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ $settings.secretName | quote }}
      key: {{ $settings.password.secretKey | quote }}
  {{- else }}
  value: "mysql"
  {{- end }}
{{- if eq $resource "director" }}
- name: icingaweb.resources.{{ $settings.database }}.charset
  value: utf8
{{- end }}
{{- end }}
{{- end -}}
