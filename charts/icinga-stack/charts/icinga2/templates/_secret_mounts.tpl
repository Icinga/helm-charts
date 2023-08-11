{{- define "icinga2.secretMounts" -}}
{{- if and .Values.features.elasticsearch.enabled .Values.features.elasticsearch.enable_tls }}
{{- if and .Values.features.elasticsearch.tlsSecret .Values.features.elasticsearch.caSecretKey .Values.features.elasticsearch.certSecretKey .Values.features.elasticsearch.keySecretKey }}
- name: elastic-certs
  mountPath: "/etc/icinga2-pki/elastic"
  readOnly: true
{{- else }}
  {{ fail "Elasticsearch certs not set. Set .Values.features.elasticsearch.tlsSecret, .Values.features.elasticsearch.caSecretKey, .Values.features.elasticsearch.certSecretKey and .Values.features.elasticsearch.keySecretKey" }}
{{- end }}
{{- end }}
{{- if and .Values.features.gelf.enabled .Values.features.gelf.enable_tls }}
{{- if and .Values.features.gelf.tlsSecret .Values.features.gelf.caSecretKey .Values.features.gelf.certSecretKey .Values.features.gelf.keySecretKey }}
- name: gelf-certs
  mountPath: "/etc/icinga2-pki/gelf"
  readOnly: true
{{- else }}
  {{ fail "GELF certs not set. Set .Values.features.gelf.tlsSecret, .Values.features.gelf.caSecretKey, .Values.features.gelf.certSecretKey and .Values.features.gelf.keySecretKey" }}
{{- end }}
{{- end }}
{{- if and .Values.features.icingadb.enabled .Values.features.icingadb.enable_tls }}
{{- if and .Values.features.icingadb.tlsSecret .Values.features.icingadb.caSecretKey .Values.features.icingadb.certSecretKey .Values.features.icingadb.keySecretKey .Values.features.icingadb.crlSecretKey }}
- name: icingadb-certs
  mountPath: "/etc/icinga2-pki/icingadb"
  readOnly: true
{{- else }}
  {{ fail "icingadb cert secrets not set. Set .Values.features.icingadb.tlsSecret, .Values.features.icingadb.caSecretKey, .Values.features.icingadb.certSecretKey, .Values.features.icingadb.keySecretKey and .Values.features.icingadb.crlSecretKey" }}
{{- end }}
{{- end }}
{{- if and .Values.features.influxdb2.enabled .Values.features.influxdb2.ssl_enable }}
{{- if and .Values.features.influxdb2.tlsSecret .Values.features.influxdb2.caSecretKey .Values.features.influxdb2.certSecretKey .Values.features.influxdb2.keySecretKey }}
- name: influxdb2-certs
  mountPath: "/etc/icinga2-pki/influxdb2"
  readOnly: true
{{- else }}
  {{ fail "influxdb2 cert secrets not set. Set .Values.features.influxdb2.tlsSecret, .Values.features.influxdb2.caSecretKey, .Values.features.influxdb2.certSecretKey and .Values.features.influxdb2.keySecretKey" }}
{{- end }}
{{- end }}
{{- if and .Values.features.influxdb.enabled .Values.features.influxdb.ssl_enable }}
{{- if and .Values.features.influxdb.tlsSecret .Values.features.influxdb.caSecretKey .Values.features.influxdb.certSecretKey .Values.features.influxdb.keySecretKey }}
- name: influxdb-certs
  mountPath: "/etc/icinga2-pki/influxdb"
  readOnly: true
{{- else }}
  {{ fail "influxdb cert secrets not set. Set .Values.features.influxdb.tlsSecret, .Values.features.influxdb.caSecretKey, .Values.features.influxdb.certSecretKey and .Values.features.influxdb.keySecretKey" }}
{{- end }}
{{- end }}
{{- end -}}
