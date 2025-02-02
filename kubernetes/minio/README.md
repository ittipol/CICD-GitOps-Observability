# MinIO
MinIO is an open source Amazon S3-compatible object storage service that is freely available and easy to run on Kubernetes

### To check that MinIO is correctly configured, sign in to MinIO and verify that a bucket has been created. Without these buckets, no data will be stored
 1. Port-forward MinIO to port 9001
 2. Navigate to the MinIO admin bash using your browser: http://localhost:9001, The sign-in credentials are username minio and password 1234
 3. Verify that the Buckets page lists "tempo-data"