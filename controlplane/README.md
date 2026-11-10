# controlplane (Phase 3)

A small Go REST API. Developers ask for storage by **type** (`blob`, `queue`) and never see AWS details.

## Intended API

| Method | Path | Body | Result |
|---|---|---|---|
| `POST` | `/v1/tenants/{tenant}/storage` | `{"type":"blob","name":"invoices"}` | `202 Accepted` + resource with `status: provisioning` |
| `GET` | `/v1/tenants/{tenant}/storage` | | list of the tenant's resources |
| `GET` | `/v1/tenants/{tenant}/storage/{id}` | | one resource, including its `status` |
| `DELETE` | `/v1/tenants/{tenant}/storage/{id}` | | `202 Accepted`, `status: deleting` |

Design notes are in [docs/design.md](../docs/design.md):
- why provisioning is async (`202`, not `201`)
- idempotency keys
- the lifecycle state machine
- quotas

## Planned layout (standard Go project layout)

```
controlplane/
├── cmd/controlplane/      # main: wiring, config, HTTP server startup
└── internal/
    ├── api/               # HTTP handlers, request/response types, validation
    ├── storage/           # domain: Resource, Tenant, lifecycle states, quota rules
    ├── provisioner/       # interface Provisioner { Create; Delete; Status }
    │   ├── aws/           #   AWS implementation (aws-sdk-go-v2, or terraform-exec)
    │   └── gcp/           #   Phase 4
    └── store/             # where the control plane records what it has provisioned (Postgres)
```

The key design point is that `provisioner` is an **interface**. The API never imports `aws/` directly,
so adding GCP in Phase 4 means writing a new implementation, not changing the API.
