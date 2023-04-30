#!/bin/bash

cd /root && prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/ --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries &
sh -c 'echo '"'"'{"filter":"Severity >= info"}'"'"' | websocat -n ws://host.docker.internal:8080/native/admin/log | /usr/local/bin/grok_exporter --config=/root/grok-exporter.yml' &
cd /usr/share/grafana && grafana-server --config /etc/grafana/grafana-psinode.ini &
