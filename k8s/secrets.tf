data "sops_file" "clickhouse" {
    source_file = "secrets/clickhouse.yaml"
}

data "sops_file" "minio" {
    source_file = "secrets/minio.yaml"
}

data "sops_file" "trino" {
    source_file = "secrets/trino.yaml"
}