{{- define "mychart.values.getSlugFromRef" -}}
{{- if eq .Release.IsUpgradeable true -}}
{{- $parts := split ":" .Release.Name -}}
{{- $lastPart := index $parts (sub (len $parts) 1) -}}
{{- $tagParts := split "-" $lastPart -}}
{{- $slug := index $tagParts (sub (len $tagParts) 1) -}}
{{- else -}}
{{- $slug := .Values.defaultTag -}}
{{- end -}}
{{- $slug -}}
{{- end -}}