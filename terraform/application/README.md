# Deploy the application with Terraform

The application is in `app/`. Infrastructure Terraform creates the Google
Kubernetes Engine cluster and Artifact Registry repository. This separate
Terraform root manages the Kubernetes namespace, deployment, and private
service after the cluster exists.

## Create infrastructure

From the repository root, authenticate with the Google Cloud command-line
interface and Application Default Credentials, set `project_id` in
`terraform/environments/dev.tfvars`, then run:

```powershell
terraform -chdir="terraform/modules" init
terraform -chdir="terraform/modules" plan -var-file="..\environments\dev.tfvars"
terraform -chdir="terraform/modules" apply -var-file="..\environments\dev.tfvars"
```

Review the plan before approving the apply; it creates billable Google Cloud
resources.

## Build and publish the application image

Install and start Docker Desktop. From the repository root, run:

```powershell
$PROJECT_ID_MATCH = Select-String `
  -Path .\terraform\environments\dev.tfvars `
  -Pattern '^\s*project_id\s*=\s*"([^"]+)"'
if (-not $PROJECT_ID_MATCH) {
  throw "project_id was not found in terraform/environments/dev.tfvars"
}
$PROJECT_ID = $PROJECT_ID_MATCH.Matches[0].Groups[1].Value
$REGION = "us-central1"
$REPOSITORY_URL = terraform -chdir="terraform/modules" output -raw artifact_registry_repository_url
$IMAGE = "$REPOSITORY_URL/app:v1"

gcloud auth configure-docker "$REGION-docker.pkg.dev"
docker build -t $IMAGE .\app
docker push $IMAGE
```

The infrastructure apply grants the cluster worker service account read access
to Artifact Registry.

## Deploy to the cluster

Use the same project, cluster name, and location as the infrastructure
configuration:

```powershell
$CLUSTER_NAME = "sandbox-gke"
$CLUSTER_LOCATION = "us-central1-a"

gcloud container clusters get-credentials $CLUSTER_NAME `
  --location=$CLUSTER_LOCATION `
  --project=$PROJECT_ID

terraform -chdir="terraform/application" init
terraform -chdir="terraform/application" apply `
  -var-file="..\environments\dev.tfvars" `
  -var="image=$IMAGE"
```

The service is private to the cluster; Terraform does not create a public load
balancer. To view the page locally after apply:

```powershell
kubectl -n gcp-sandbox-app port-forward service/gcp-sandbox-app 8080:80
```

Open <http://localhost:8080>. Stop port-forwarding with Ctrl+C.
