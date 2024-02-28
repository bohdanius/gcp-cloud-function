# Dummy Cloud Function

This is a dummy cloud function example. It demonstrates a simple cloud function that interacts with Google Cloud Storage.

## Deployment

1. Create a new cloud function in your cloud provider's console.
2. Deploy the code in `src/main.py`.
3. Make sure to set up appropriate triggers and permissions.

## Usage

This cloud function is triggered by changes in a Google Cloud Storage bucket.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.




Run your function locally with the Functions Framework:


functions-framework-python --target hello_http


brew services start jenkins

### Clean
python3 clean.py
### Build
python3 -m compileall
### Test
pip3 install -r requirements-test.txt
pytest

### Package
python3 setup.py sdist --formats=zip


### Prerequisites for running terraform
gcloud auth application-default login --project eqfx-mtg1

gcloud auth login
gcloud config set project eqfx-mtg1

gsutil mb -p <projectId> -c <storage-class> -l <region> gs://<bucket-name>
gsutil versioning set on gs://<bucket-name>
gsutil mb -c STANDARD -l europe-west2 gs://gcp-cloud-function-terraform-bucket-34242422
gsutil versioning set on gs://gcp-cloud-function-terraform-bucket-34242422

### Terraform init
terraform init -reconfigure

### Terraform apply
terraform apply -auto-approve

### Terraform destroy
terraform destroy -auto-approve