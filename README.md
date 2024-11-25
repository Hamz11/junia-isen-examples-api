# Projet de Cloud Computing
## Équipe
-Hamza Berbache  
-Arthur Passedouet  
-Matteo Guignet  
-Mateo Rabier  

## Description du projet
Ce projet vise à déployer une infrastructure sur Azure pour une API HTTP existante et à mettre en œuvre un pipeline CI/CD en utilisant GitHub Actions. L'infrastructure, gérée via Terraform, est automatiquement déployée grâce aux workflows CI/CD. L'API HTTP fournira plusieurs endpoints permettant d'interagir avec une base de données et un Blob Storage. 
Nous avons donc utilisé :  
-Azure  
-Github  
-Terraform  
-FastAPI  

## Structure du projet
Le répertoire du projet est constitué de :  
.github : Contient la CI/CD
exemple : Contient le code pour l'API
infrastructure : Contient l'architecture cloud
test : Contient les tests nécessaires pour l'API

# Installation
Pour lancer le projet, il faut réaliser les étapes suivantes :
-Dupliquer le projet via github  
-Renseigner "terraform.tfvars" avec les informations nécessaires en suivant les commentaires sur github : subscription_id ; docker_registry_username ; docker_registry_password et renseigner un nom dans app_service_name  
-Initialliser terraform avec les commandes suivantes : terraform init ; terraform plan -out=tfplan ; terraform apply "tfplan"  
-Recuperer l'URL dans l'output puis aller sur le site via un navigateur de votre choix.

# Remerciements
Nous voudrions remercier le groupe de Arthur LAFONT et Louis SKRZYPCZAK pour nous avoir aider avec le code nécessaire pour faire marcher notre CI/CD et nous avoir aider pour certains points lors du developpement de notre code.

# Problemes à résoudre
-La route /examples amène à une erreur "Internal Server Error" que nous n'avons pas réussi à résoudre.
Une de nos piste serait l'erreur provienn du fait que la database soit vide et que donc l'api n'ait rien à retourner.
Pour essayer de pallier à ce soucis nous avons tout de meme essayer d'ajouter une route /data qui créerait une table à afficher mais cela ne semble pas fonctionner.

-Un autre problème peut survenir sur la route /examples, il y a une erreur qui dit que le connexion est refusée. Pour passer outre il suffit de modifier le pare-feu de la datbase sur Azure. Aussi absurde que cela puisse paraitre, modifier le pare-feu puis le remettre comme configurer dans le code terraform fonctionne.

