# Deployment process
1. Update the code in the analytics directory
2. Commit the code to Git
3. CondeBuild will automatically trigger the build and upload the docker image to ECR
4. Run the terraform to create EKS cluster
5. Connect to the EKS with `aws eks --region <region> update-kubeconfig --name <cluster-name>`
6. Run the Helm Chart to install the Postgresql as in the README.md in the root directory. The code is stick with the service name is `postgres-service`. If you change the Postgresql service name, you have to change it also in the coworking .yaml.
   `helm install postgres-service bitnami/postgresql` 
7. Run the script to seed data in the database
8. Run the `kubectl apply -f coworking.yaml` to deploy the app
9.  Check the host name of the app with the `kubectl get services`
10. Verify the app
    `curl http://<BASE_URL>:5153/api/reports/daily_usage`
    `curl http://<BASE_URL>:5153/api/reports/user_visits`
