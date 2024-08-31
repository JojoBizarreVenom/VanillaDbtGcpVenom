terraform {
	backend "gcs" {
    	bucket  = "terraform_bucket_dbt_vanilla_venom"
    	prefix  = "terraform/state"
        # credentials = file("credentials/datalab-434211-e405b2b15074.json")
	}
}