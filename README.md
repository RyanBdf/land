# <span style="color:#01b6e8">LAND (Logstash, Apache, Ngnix, Docker) </span>

Le workflow permet un CI/CD avec n’importe quel type de projet. En effet c'est un serveur web permettant la gestion de
tous les projets web.


<a href="http://traefik.opretdevous.com">
<img src="https://it-obey.com/wp-content/uploads/2021/05/traefik-logo-300x92.jpg" width="128">
</a>
<a href="https://gogs.opretdevous.com">
<img src="https://repository-images.githubusercontent.com/16752620/4984a580-ea4e-11ea-90be-6f77164aa0aa"   width="128">
</a>
<a href="https://jenkins.opretdevous.com">
<img src="https://upload.wikimedia.org/wikipedia/commons/e/e3/Jenkins_logo_with_title.svg" width="128">
</a>


## Installation de WSL sur Windows : 

Le Sous-système Windows pour Linux permet aux développeurs d’exécuter un environnement GNU/Linux (et notamment la plupart des utilitaires, applications et outils en ligne de commande) directement sur Windows, sans modification et tout en évitant la surcharge d’une machine virtuelle traditionnelle ou d’une configuration à double démarrage
https://docs.microsoft.com/fr-fr/windows/wsl/

Veuillez tout d’abord activer la virtualisation sur votre machine (dans le bios).

### Activez Hyper-V
1.	Ouvrir Paramètres Windows
2.	Tapez « Activer ou désactiver des fonctionnalité Windows » dans la barre de recherche 
3.	Cochez Hyper-V
4.	Redémarrer votre PC

#### Sous-système Windows pour Linux (WSL2)
Vous devez simplement suivre la documentation officiel https://docs.microsoft.com/fr-fr/windows/wsl/install-win10#simplified-installation-for-windows-insiders

## Configuration WSL

** Installation des clés ssh**
Création d’une nouvelle clé, tapez `ssh-keygen` 

**Pour une clé déjà existante **
Commencez par la même procédure que pour une nouvelle clé, puis copier le contenu de id_rsa.pub  (``C:\User\<username>\.ssh``) dans les fichiers du même nom sur votre Ubuntu.

## Installation de Nvm, node.js & npm
Veuillez suivre cette doc : https://docs.microsoft.com/fr-fr/windows/dev-environment/javascript/nodejs-on-wsl

Puis exécuter : `npm install -g yarn`

## Installation de docker sur WSL
https://docs.microsoft.com/fr-fr/windows/wsl/tutorials/wsl-containers

## Personnaliser le terminal windows
https://www.hanselman.com/blog/how-to-make-a-pretty-prompt-in-windows-terminal-with-powerline-nerd-fonts-cascadia-code-wsl-and-ohmyposh

## Fichier host
Il faudra egalement ajouter ces lignes dans votre fichier host windows/linux 
si vous avez besoin d'utiliser les service en dev <br>
**Windows** : `C:\windows\system32\drivers\etc\hosts`<br>
**Linux**: `/etc/hosts`
<pre>
127.0.0.1 dev.gogs.opretdevous.com
127.0.0.1 dev.jenkins.opretdevous.com
127.0.0.1 dev.traefik.opretdevous.com
127.0.0.1 phpmyadmin.localhost
</pre>


Il faut ensuite cloner le repo land, puis à la racine créer le dossiers `projects` 

Cette commande permet de lancer l'environement docker dont on a besoin.

**Copier le contenu du fichier .env.dist dans le fichier .env et modifier le fichier tel que :**
>COMPOSE_FILE=compose.yml:compose-dev.yml

**Copier/coller ensuite le fichier `compose.dist.yml` en `compose-dev.yml`**
**Changer le mot de passe phpmyadmin du fichier `compose-dev.yml` par celui 
du container `mysql` du fichier `compose.yml`

# Lancer le LAND
Il suffit simplement de lancer la commande à la racine du dossier land

> ./run.sh
> 
# Configuration Gogs dark theme

**Dark theme**
Custom Directory on Docker :
The "custom" directory may not be obvious in Docker environment. The /var/gogs/gogs (in the host) and /data/gogs (in the
container) is already the "custom" directory and you do not need to create another layer but directly edit corresponding
files under this directory.

**Installation du theme**
<pre>
- ````cd $GOGS_ROOT````
- ````mkdir -p custom/templates/inject/````
- ````mkdir -p custom/public/css/````
- ```git clone https://github.com/Kos-M/GogsThemes.git```
- ````echo  '<link rel="stylesheet" href="/css/themes/dark_theme.css">' >>  custom/templates/inject/head.tmpl````
- ````mv ./GogsThemes/themes/ custom/public/css/````
- ````cp -r  GogsThemes/img/ custom/public/````
- ```rm -r ./GogsThemes```
- ``` Restart Gogs service : restart container ```
</pre>

**To disable a theme**
Just open `$GOGS_ROOT/templates/inject/head.tmpl` and delete the line
contains : `<link rel="stylesheet" href="/css/themes/dark_theme.css">`
or (for velvet) : `<link rel="stylesheet" href="/css/themes/velvet.css">`

**To edit css**
edit this file on the conainer gogs : `/data/gogs/public/css/themes/dark_theme.css`






