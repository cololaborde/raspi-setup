# Turn on wifi if ethernet is off
if [[ $(sudo nmcli device status | grep -w "eth0" | awk '{print $3}') == "unavailable" ]]; then
	sudo nmcli radio wifi on
else
	sudo nmcli radio wifi off
fi


container_ids=$(sudo docker ps -q)
for container_id in $container_ids; do
    container_status=$(sudo docker inspect -f '{{.State.Status}}' "$container_id")
    if [[ "$container_status" != "running" ]]; then
        service_name=$(sudo docker inspect -f '{{ index .Config.Labels "com.docker.compose.service" }}' "$container_id")
	if [[ "$service_name" == "owncloud" || "$service_name" == "db" ]]; then
		cd "/home/colo/services/owncloud"
	elif [[ "$service_name" == "pihole" ]]; then
		cd "/home/colo/services/pihole"
	fi
	docker-compose up -d
    fi
done
exit 0