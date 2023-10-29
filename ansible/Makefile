.PHONY: connection get_cpu_temp deploy_nodes upgrade_system upgrade_control_plane upgrade_nodes reboot shutdown prune

connection:
	ansible nodes -m ping

get_cpu_temp:
	ansible-playbook playbook_get_cpu_temp.yml

deploy_nodes:
	ansible-playbook playbook_deploy_nodes.yml

upgrade_system:
	ansible-playbook playbook_upgrade_system.yml

upgrade_control_plane:
	ansible-playbook playbook_upgrade_control_plane.yml

upgrade_nodes:
	ansible-playbook playbook_upgrade_nodes.yml

reboot:
	ansible-playbook playbook_reboot.yml

shutdown:
	ansible-playbook playbook_shutdown.yml

prune:
	ansible-playbook playbook_image_prune.yml
