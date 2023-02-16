## Random collections of useful commands

### GIT
```sh
git submodule add
git submodule update --init --recursive

# remove cached submodule
git rm --cached module_name

# Add new submodule
git submodule add git@gitlab.com:module_path

```

### Kubernetes
```yaml
# Copy /tmp/foo_dir local directory to /tmp/bar_dir in a remote pod in the default namespace
kubectl cp /tmp/foo_dir <some-pod>:/tmp/bar_dir

# Copy /tmp/foo local file to /tmp/bar in a remote pod in a specific container
kubectl cp /tmp/foo <some-pod>:/tmp/bar -c <specific-container>

# Copy /tmp/foo local file to /tmp/bar in a remote pod in namespace <some-namespace>
kubectl cp /tmp/foo <some-namespace>/<some-pod>:/tmp/bar

# Copy /tmp/foo from a remote pod to /tmp/bar locally
kubectl cp <some-namespace>/<some-pod>:/tmp/foo /tmp/bar

# View current namespace
kubectl config view | grep namespace

# Set context
kubectl config set-context --current --namespace=my-namespace

# Terminating all pods stuck in terminating state
for p in $(kubectl get pods | grep Terminating | awk '{print $1}'); do kubectl delete pod $p --grace-period=0 --force;done

# Force delete a pod
kubectl delete pod <Pod_Name> -n <namespace_name>  --grace-period=0  --force

```

### PostgresSQL
```postgres
psql -U postgres -d db_name < file_name.sql
pg_dump -U postgres db_name > /tmp/file_name.sql
SELECT * FROM pg_stat_activity WHERE state = 'active';
SELECT pg_cancel_backend(10296)
SELECT pg_terminate_backend(10296)
SELECT pg_size_pretty(pg_total_relation_size('table_name'))

REVOKE CONNECT ON DATABASE backend_vinlab_ai FROM PUBLIC, postgres

SELECT 
    pg_terminate_backend(pid) 
FROM 
    pg_stat_activity 
WHERE 
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = 'backend_vinlab_ai'
    ;
```

### Consul
```sh
NAMESPACE="namespace"  
# Add repo
helm repo add hashicorp https://helm.releases.hashicorp.com  
# Verify
helm search repo hashicorp/consul  
# Install helm
helm install consul hashicorp/consul --set global.name=consul --create-namespace --namespace $NAMESPACE --values values.yaml
# Upgrade Consul helm
helm upgrade consul hashicorp/consul --namespace $NAMESPACE --values values.yaml
# Get Consul token
kubectl get secrets/consul-bootstrap-acl-token -n $NAMESPACE --template='{{.data.token | base64decode }}'
```

### Golang
```go
# Run unittest and get html coverage
go test -coverprofile=coverage.out ./... ;    go tool cover -html=coverage.out

# Publish new version of module
GOPROXY=proxy.golang.org go list -m example.com/mymodule@v0.1.0
```
### Other
```sh
# From remote host
scp -r remote_dir username@host(ip):local_dir
```
