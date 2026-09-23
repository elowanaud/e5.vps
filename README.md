# Préparation d'un VPS Ubuntu

Ce projet contient un script de configuration initiale pour un VPS Ubuntu. Il met à jour les paquets, installe Fail2Ban, configure le pare-feu UFW, installe Docker et lance l'installateur de Dokploy.

## Exécution

Sur le VPS Ubuntu, téléchargez le script depuis GitHub, puis lancez-le :

```bash
sudo curl -sSL https://raw.githubusercontent.com/elowanaud/e5.vps/main/setup.sh | sudo bash
```

Le script nécessite les droits administrateur et une connexion Internet. L'installation des paquets et l'activation du pare-feu ne demandent pas de confirmation. Gardez une session SSH ouverte pendant l'exécution : UFW autorise SSH avant d'être activé. Le script redémarre également Fail2Ban.

Le script télécharge `configs/fail2ban` depuis ce dépôt GitHub et l'installe dans `/etc/fail2ban/jail.local` avant de redémarrer Fail2Ban. Cette configuration active la protection SSH après trois tentatives échouées, avec un bannissement d'une heure.
