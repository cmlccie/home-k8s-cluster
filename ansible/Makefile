.PHONY: connection upgrade reboot shutdown

connection:
	ansible nodes -m ping

configure_sensehat_nodes:
	ansible-playbook playbook_configure_sensehat_nodes.yml

containerd:
	ansible-playbook playbook_containerd.yml

upgrade:
	ansible-playbook playbook_upgrade_system.yml

reboot:
	ansible-playbook playbook_reboot.yml

shutdown:
	ansible-playbook playbook_shutdown.yml
