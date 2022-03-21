output "url" {
  value = "${azurerm_storage_account.devsa.primary_blob_endpoint}"
}
