.PHONY: dashboard_token dashboard_connection

dashboard_token:
	kubectl -n kubernetes-dashboard create token cmlunsford

dashboard_connection: POD_NAME = $(shell kubectl get pods -n kubernetes-dashboard -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")
dashboard_connection:
	echo "${POD_NAME}"
	kubectl -n kubernetes-dashboard port-forward ${POD_NAME} 8443:8443
