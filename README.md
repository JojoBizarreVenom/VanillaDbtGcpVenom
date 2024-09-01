# Initialisation

[Source Medium non terraformé](https://medium.com/@ivan_toriya/step-by-step-guide-to-run-dbt-in-production-with-google-cloud-platform-fb1f035f3c7b)

Vous pouvez créer un compte de service unique pour toutes les opérations ou plusieurs comptes séparés (conseillé).

## Service Account : GitHub Actions

Ce compte de service permettra à GitHub Actions de déployer le Terraform.

Autorisations requises :

- Administrateur d'Artifact Registry (pour la création de dépôts)
- Administrateur de Cloud Run (pour la création de services Cloud Run)
- Administrateur de Cloud Scheduler (pour la création de tâches Cloud Scheduler)
- Éditeur de données BigQuery (pour la création de datasets)
- Utilisateur d'objets Storage (pour la lecture/écriture sur le backend de Terraform)
- Utilisateur de compte de service (pour l'attachement des comptes de service aux ressources Terraform)

Il est nécessaire d'extraire la clé en format JSON et de la stocker en tant que secret dans GitHub.

Nom d'exemple : github-action@datalab-434211.iam.gserviceaccount.com

## Service Account : Cloud Run

Ce compte de service servira à Cloud Run pour exécuter les requêtes DBT.

Autorisations requises :

- Accesseur de secrets dans Secret Manager
- Éditeur de données BigQuery
- Utilisateur BigQuery

Ensuite :
- Exporter la clé JSON (à exposer une seule fois ; si perdue, recréez une nouvelle clé et supprimez l'ancienne).

## Secret Manager

À partir de la clé JSON du compte de service BigQuery, créez un secret comme indiqué dans la [ressource Medium](https://medium.com/@ivan_toriya/step-by-step-guide-to-run-dbt-in-production-with-google-cloud-platform-fb1f035f3c7b).

## Service Account : Cloud Scheduler

Ce compte de service servira à Cloud Scheduler pour déclencher le Cloud Run.

Autorisations requises :
- Agent de service Cloud Run
- Demandeur Cloud Run

Intégrez l'adresse dans la ressource Terraform.

# Test local :

Pour Terraform : `bash local_deploy_terraform.sh`
Pour DBT : `bash local_deploy_dbt.sh`