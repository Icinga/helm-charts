{{- define "icinga2.config" -}}
{{- $config_ticket_salt := .Values.config.ticket_salt | required ".Values.icinga2.config.ticket_salt is required." }}
// Constants for Icinga2 from constants.conf
const PluginDir = "/usr/lib/nagios/plugins"
const ManubulonPluginDir = "/usr/lib/nagios/plugins"
const PluginContribDir = "/usr/lib/nagios/plugins"
const NodeName = {{ .Values.config.node_name | quote }}
const ZoneName = {{ .Values.config.zone_name | quote }}
const TicketSalt = {{ $config_ticket_salt | quote }}

// Standard imports from icinga2.conf
include <itl>
include <plugins>
include <plugins-contrib>
include <manubulon>
include <windows-plugins>
include <nscp>
include "features-enabled/*.conf"
{{- if .Values.features.api.enabled }}
include "api-users.conf"
{{- end}}

// zones.conf
object Endpoint NodeName {
    host = {{ include "icinga2.fullname" . | quote }}
    port = 5665
}

object Zone ZoneName {
    endpoints = [ NodeName ]
}

object Zone "global-templates" {
    global = true
}

object Zone "director-global" {
    global = true
}
{{- end -}}
