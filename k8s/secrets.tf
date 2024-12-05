data "sops_file" "clickhouse" {
    source_file = "secrets/clickhouse.yaml"
}