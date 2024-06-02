# Deploy infrastructure
1. Run the terraform to create ECR - in this repo
2. Run the terraform to create CodeBuild - https://github.com/jj-ops-gif/docker-codebuild-terraform.git
3. Run the terraform to create EKS - https://github.com/hashicorp/learn-terraform-provision-eks-cluster
4. Run the Helm Chart to install the Postgresql as in the README.md in the root directory.
   `helm install postgres-service bitnami/postgresql` 

## Deploy application
1. Update the code in the analytics directory then commit the code to Git.
2. CondeBuild will automatically trigger the build and upload the docker image to ECR.
3. Connect to the EKS with `aws eks --region <region> update-kubeconfig --name <cluster-name>`
4. Run the script to seed data in the database.
5. Run `kubectl get secret --namespace default postgres-service-postgresql -o jsonpath="{.data.postgres-password}"` to get the DB password in base64
6. Update secrets `kubectl apply -f env-secret.yaml`.
7. Update configmap `kubectl apply -f env-configmap.yaml`.
8. Run the `kubectl apply -f coworking.yaml` to deploy the app.
9. Verify the app with the BASE_URL get from the `kubectl get services`.
    `curl http://<BASE_URL>:5153/api/reports/daily_usage`
    `curl http://<BASE_URL>:5153/api/reports/user_visits`