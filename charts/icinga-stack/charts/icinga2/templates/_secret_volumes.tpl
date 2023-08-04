{{- define "icinga2.secretVolumes" -}}
{{- if and .Values.features.elasticsearch.enabled .Values.features.elasticsearch.enable_tls }}
{{- if .Values.features.elasticsearch.secretName }}
- name: elastic-certs
  secret:
    secretName: {{ .Values.features.elasticsearch.secretName | quote }}
    items:
{{- else }}
  {{ fail "Elasticsearch secret not set. Set .Values.features.elasticsearch.secretName" }}
{{- end }}
{{- if and .Values.features.elasticsearch.secretName .Values.features.elasticsearch.caSecretKey }}
    - key: {{ .Values.features.elasticsearch.caSecretKey | quote }}
      path: "ca.crt"
{{- else }}
  {{ fail "Elasticsearch CA cert not set. Set both .Values.features.elasticsearch.secretName and .Values.features.elasticsearch.caSecretKey" }}
{{- end }}
{{- if and .Values.features.elasticsearch.secretName .Values.features.elasticsearch.certSecretKey }}
    - key: {{ .Values.features.elasticsearch.certSecretKey | quote }}
      path: "cert.crt"
{{- else }}
  {{ fail "Elasticsearch cert not set. Set both .Values.features.elasticsearch.secretName and .Values.features.elasticsearch.certSecretKey" }}
{{- end }}
{{- if and .Values.features.elasticsearch.secretName .Values.features.elasticsearch.keySecretKey }}
    - key: {{ .Values.features.elasticsearch.keySecretKey | quote }}
      path: "cert.key"
{{- else }}
  {{ fail "Elasticsearch cert key not set. Set both .Values.features.elasticsearch.secretName and .Values.features.elasticsearch.keySecretKey" }}
{{- end }}
{{- end }}
{{- if and .Values.features.gelf.enabled .Values.features.gelf.enable_tls }}
{{- if .Values.features.gelf.secretName }}
- name: gelf-certs
  secret:
    secretName: {{ .Values.features.gelf.secretName | quote }}
    items:
{{- else }}
  {{ fail "gelf secret not set. Set .Values.features.gelf.secretName" }}
{{- end }}
{{- if and .Values.features.gelf.secretName .Values.features.gelf.caSecretKey }}
    - key: {{ .Values.features.gelf.caSecretKey | quote }}
      path: "ca.crt"
{{- else }}
  {{ fail "gelf CA cert not set. Set both .Values.features.gelf.secretName and .Values.features.gelf.caSecretKey" }}
{{- end }}
{{- if and .Values.features.gelf.secretName .Values.features.gelf.certSecretKey }}
    - key: {{ .Values.features.gelf.certSecretKey | quote }}
      path: "cert.crt"
{{- else }}
  {{ fail "gelf cert not set. Set both .Values.features.gelf.secretName and .Values.features.gelf.certSecretKey" }}
{{- end }}
{{- if and .Values.features.gelf.secretName .Values.features.gelf.keySecretKey }}
    - key: {{ .Values.features.gelf.keySecretKey | quote }}
      path: "cert.key"
{{- else }}
  {{ fail "gelf cert key not set. Set both .Values.features.gelf.secretName and .Values.features.gelf.keySecretKey" }}
{{- end }}
{{- end }}
{{- if and .Values.features.icingadb.enabled .Values.features.icingadb.enable_tls }}
{{- if and .Values.features.icingadb.secretName }}
- name: icingadb-certs
  secret:
    secretName: {{ .Values.features.icingadb.secretName | quote }}
    items:
{{- else }}
  {{ fail "icingadb secret not set. Set .Values.features.icingadb.secretName" }}
{{- end }}
{{- if and .Values.features.icingadb.secretName .Values.features.icingadb.caSecretKey }}
    - key: {{ .Values.features.icingadb.caSecretKey | quote }}
      path: "ca.crt"
{{- else }}
  {{ fail "icingadb CA cert not set. Set both .Values.features.icingadb.secretName and .Values.features.icingadb.caSecretKey" }}
{{- end }}
{{- if and .Values.features.icingadb.secretName .Values.features.icingadb.certSecretKey }}
    - key: {{ .Values.features.icingadb.certSecretKey | quote }}
      path: "cert.crt"
{{- else }}
  {{ fail "icingadb cert not set. Set both .Values.features.icingadb.secretName and .Values.features.icingadb.certSecretKey" }}
{{- end }}
{{- if and .Values.features.icingadb.secretName .Values.features.icingadb.keySecretKey }}
    - key: {{ .Values.features.icingadb.keySecretKey | quote }}
      path: "cert.key"
{{- else }}
  {{ fail "icingadb cert key not set. Set both .Values.features.icingadb.secretName and .Values.features.icingadb.keySecretKey" }}
{{- end }}
{{- if and .Values.features.icingadb.secretName .Values.features.icingadb.crlSecretKey }}
    - key: {{ .Values.features.icingadb.crlSecretKey | quote }}
      path: "crl.pem"
{{- else }}
  {{ fail "icingadb cert key not set. Set both .Values.features.icingadb.secretName and .Values.features.icingadb.crlSecretKey" }}
{{- end }}
{{- end }}
{{- if and .Values.features.influxdb2.enabled .Values.features.influxdb2.ssl_enable }}
{{- if and .Values.features.influxdb2.secretName }}
- name: influxdb2-certs
  secret:
    secretName: {{ .Values.features.influxdb2.secretName | quote }}
    items:
{{- else }}
  {{ fail "influxdb2 secret not set. Set .Values.features.influxdb2.secretName" }}
{{- end }}
{{- if and .Values.features.influxdb2.secretName .Values.features.influxdb2.caSecretKey }}
    - key: {{ .Values.features.influxdb2.caSecretKey | quote }}
      path: "ca.crt"
{{- else }}
  {{ fail "influxdb2 CA cert not set. Set both .Values.features.influxdb2.secretName and .Values.features.influxdb2.caSecretKey" }}
{{- end }}
{{- if and .Values.features.influxdb2.secretName .Values.features.influxdb2.certSecretKey }}
    - key: {{ .Values.features.influxdb2.certSecretKey | quote }}
      path: "cert.crt"
{{- else }}
  {{ fail "influxdb2 cert not set. Set both .Values.features.influxdb2.secretName and .Values.features.influxdb2.certSecretKey" }}
{{- end }}
{{- if and .Values.features.influxdb2.secretName .Values.features.influxdb2.keySecretKey }}
    - key: {{ .Values.features.influxdb2.keySecretKey | quote }}
      path: "cert.key"
{{- else }}
  {{ fail "influxdb2 cert key not set. Set both .Values.features.influxdb2.secretName and .Values.features.influxdb2.keySecretKey" }}
{{- end }}
{{- end }}
{{- if and .Values.features.influxdb.enabled .Values.features.influxdb.ssl_enable }}
{{- if and .Values.features.influxdb.secretName }}
- name: influxdb-certs
  secret:
    secretName: {{ .Values.features.influxdb.secretName | quote }}
    items:
{{- else }}
  {{ fail "influxdb secret not set. Set .Values.features.influxdb.secretName" }}
{{- end }}
{{- if and .Values.features.influxdb.secretName .Values.features.influxdb.caSecretKey }}
    - key: {{ .Values.features.influxdb.caSecretKey | quote }}
      path: "ca.crt"
{{- else }}
  {{ fail "influxdb CA cert not set. Set both .Values.features.influxdb.secretName and .Values.features.influxdb.caSecretKey" }}
{{- end }}
{{- if and .Values.features.influxdb.secretName .Values.features.influxdb.certSecretKey }}
    - key: {{ .Values.features.influxdb.certSecretKey | quote }}
      path: "cert.crt"
{{- else }}
  {{ fail "influxdb cert not set. Set both .Values.features.influxdb.secretName and .Values.features.influxdb.certSecretKey" }}
{{- end }}
{{- if and .Values.features.influxdb.secretName .Values.features.influxdb.keySecretKey }}
    - key: {{ .Values.features.influxdb.keySecretKey | quote }}
      path: "cert.key"
{{- else }}
  {{ fail "influxdb cert key not set. Set both .Values.features.influxdb.secretName and .Values.features.influxdb.keySecretKey" }}
{{- end }}
{{- end }}
{{- end -}}
