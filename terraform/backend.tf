terraform {
	backend "gcs" {
    	bucket  = "terraform_bucket_dbt_vanilla_venom"
    	prefix  = "terraform/state"
	}
}