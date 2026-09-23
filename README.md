# Préparation d'un VPS Ubuntu

Ce projet contient un script de configuration initiale pour un VPS Ubuntu. Il met à jour les paquets, installe Fail2Ban, configure le pare-feu UFW, installe Docker et lance l'installateur de Dokploy.

## Exécution

Sur le VPS Ubuntu, téléchargez le script depuis GitHub, puis lancez-le :

```bash
sudo curl -sSL https://raw.githubusercontent.com/elowanaud/e5.vps/main/setup.sh | sudo bash
```

Le script nécessite les droits administrateur, une connexion Internet et peut demander une confirmation pendant l'installation des paquets ou l'activation du pare-feu. Gardez une session SSH ouverte pendant l'exécution : UFW autorise SSH, HTTP et HTTPS avant d'être activé. Le script redémarre également les services Fail2Ban et SSH.

Avant de lancer le script, vérifiez que votre accès SSH par clé fonctionne : la section SSH remplace la ligne `PasswordAuthentication` existante dans `/etc/ssh/sshd_config` par `PasswordAuthentication no`, vérifie la syntaxe avec `sshd -t`, puis redémarre SSH. La connexion par mot de passe sera désactivée.

Le script télécharge `configs/fail2ban` depuis ce dépôt GitHub et l'installe dans `/etc/fail2ban/jail.local` avant de redémarrer Fail2Ban. Cette configuration active la protection SSH après trois tentatives échouées, avec un bannissement d'une heure.
