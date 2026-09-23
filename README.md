<div align="center">

<pre>
███████╗███████╗   ██╗   ██╗██████╗ ███████╗
██╔════╝██╔════╝   ██║   ██║██╔══██╗██╔════╝
█████╗  ███████╗   ██║   ██║██████╔╝███████╗
██╔══╝  ╚════██║   ╚██╗ ██╔╝██╔═══╝ ╚════██║
███████╗███████║██╗ ╚████╔╝ ██║     ███████║
╚══════╝╚══════╝╚═╝  ╚═══╝  ╚═╝     ╚══════╝
</pre>

**Préparation automatisée d'un VPS Ubuntu pour Docker et Dokploy.**

[![Ubuntu](https://img.shields.io/badge/Ubuntu-VPS-E95420?style=flat-square&logo=ubuntu&logoColor=white)](#prérequis)
[![Bash](https://img.shields.io/badge/Bash-script-4EAA25?style=flat-square&logo=gnubash&logoColor=white)](#installation)
[![Docker](https://img.shields.io/badge/Docker-Engine-2496ED?style=flat-square&logo=docker&logoColor=white)](#étapes-du-script)
[![Dokploy](https://img.shields.io/badge/Dokploy-installation-111827?style=flat-square)](#étapes-du-script)

[Présentation](#présentation) · [Installation](#installation) · [Étapes du script](#étapes-du-script) · [Vérification](#vérification)

</div>

---

## Installation

```bash
sudo curl -fsSL https://raw.githubusercontent.com/elowanaud/e5.vps/main/setup.sh | sudo bash
```

## Présentation

**e5.vps** regroupe un script de préparation de serveur Ubuntu et une configuration Fail2Ban pour SSH. `setup.sh` met à jour le système, configure Fail2Ban et UFW, installe Docker depuis son dépôt Ubuntu officiel, puis lance l'installateur de Dokploy.

## Structure du projet

```text
e5.vps/
├── setup.sh           # Préparation du VPS en cinq étapes
└── configs/
    └── fail2ban       # Configuration du jail SSH téléchargée par le script
```

## Prérequis

- Un VPS **Ubuntu** avec accès `sudo`, une connexion Internet et `curl` disponible pour télécharger le script.
- **UFW** disponible sur le serveur : le script le configure, mais ne l'installe pas.
- Un accès SSH sur le port standard `22`. Si SSH utilise un autre port, autorisez-le dans UFW **avant** de lancer le script : celui-ci n'ajoute que la règle `ssh/tcp`.

Gardez une session SSH ouverte pendant la configuration du pare-feu. Le script modifie les paquets, les règles réseau et les services du serveur ; vérifiez son contenu avant de l'exécuter.

## Étapes du script

| Étape | Action |
| :--- | :--- |
| **1. Système** | Met à jour la liste des paquets et installe les mises à niveau disponibles. |
| **2. Fail2Ban** | Installe Fail2Ban et `curl`, télécharge `configs/fail2ban` dans `/etc/fail2ban/jail.local`, puis redémarre le service. Le jail SSH bannit pendant une heure après trois tentatives échouées. |
| **3. UFW** | Autorise les connexions sortantes, refuse les connexions entrantes, autorise `ssh/tcp`, puis active le pare-feu. |
| **4. Docker** | Ajoute la clé et le dépôt Docker pour Ubuntu, puis installe Docker Engine, CLI, containerd, Buildx et le plugin Compose. |
| **5. Dokploy** | Télécharge et exécute `https://dokploy.com/install.sh`. |

## Vérification

Après l'exécution, vérifiez les services et les règles sur le VPS :

```bash
sudo systemctl status fail2ban
sudo ufw status
sudo docker version
sudo docker compose version
```

## Configuration Fail2Ban

Le fichier [`configs/fail2ban`](configs/fail2ban) est récupéré depuis la branche `main` du dépôt au moment de l'installation. Il active le jail `sshd` sur le service `ssh`, avec `maxretry = 3` et `bantime = 3600` secondes.

---

<div align="center">
  <i>Ubuntu, Fail2Ban, UFW, Docker et Dokploy.</i>
</div>
