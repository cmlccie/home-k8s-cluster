.PHONY: dashboard_token dashboard_connection

dashboard_token:
	kubectl -n kubernetes-dashboard create token cmlunsford

dashboard_connection:
	export POD_NAME=$(kubectl get pods -n kubernetes-dashboard -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")
	kubectl -n kubernetes-dashboard port-forward $$POD_NAME 8443:8443
