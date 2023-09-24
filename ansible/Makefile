.PHONY: connection nodes configure_nodes configure_sensehat_nodes containerd kube upgrade reboot shutdown reset

connection:
	ansible nodes -m ping

nodes:
	ansible-playbook playbook_nodes.yml

configure_nodes:
	ansible-playbook playbook_configure_nodes.yml

configure_sensehat_nodes:
	ansible-playbook playbook_configure_sensehat_nodes.yml

containerd:
	ansible-playbook playbook_containerd.yml

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

# reset:
# 	ansible-playbook playbook_kubeadm_reset.yml

get_cpu_temp:
	ansible-playbook playbook_get_cpu_temp.yml
