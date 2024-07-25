# Vérifier la lettre sur votre HOSTX du lecteur de sauvegarde (ici j pour le DELL1)
# Il vaut mieux tester au moins une fois la connexion au NAS depuis votre ordinateur avant pour être sûr

LECTEUR=h         # Mettre la lettre de votre lecteur de sauvegarde sur votre ordinateur

#
#---------------------------------------------------------------------
# NE RIEN MODIFIER SOUS CETTE LIGNE SANS SAVOIR CE QUE VOUS FAITES !
HOST=$(hostname | tr a-z A-Z)   # Pour une récupération automatique du nom de la machine
PATH_PROFIL=//192.168.1.109/exploitation-pilotage/PROFILS/PROFILS-HOSTX/         # On met dans la variable PATH_PROFIL le chemin du dossier pour les profils sur le NAS
PATH_BACKUP=//192.168.1.109/exploitation-pilotage/SAUVEGARDES/SAUVEGARDES-HOSTX/ # On met dans la variable PATH_BACKUP le chemin du dossier pour les profils sur le NAS



DATE=$(date "+%y_%m_%d")     # On met dans la variable DATE le résultat de la commande date avec une substitution de commande $()
PATH_NAME_BACKUP="$PATH_BACKUP${DATE}_taille_backup_${HOST}.csv"     # On construit le nom qu'on veut pour le fichier sauvegardes
PATH_NAME_PROFIL="$PATH_PROFIL${DATE}_tailles_profil_${HOST}.csv"    # On construit le nom qu'on veut pour le fichier profils
echo "Les fichiers se nommeront $PATH_NAME_BACKUP $PATH_NAME_PROFIL"     # On affiche les noms construits

du -sh /c/Users 2> /dev/null | tr '\t' "/" | tr -s "/" | cut -d "/" -f1,3 | tr "/" ";" > $PATH_NAME_PROFIL # Calcule la taille du dossier Profils et stocke le résultat dans le fichier dans la variable $PATH_NAME_PROFIL

du -sh /$LECTEUR/*$HOST 2> /dev/null | tr '\t' "/" | tr -s "/" | cut -d "/" -f 1,3 | tr "/" ";" > $PATH_NAME_BACKUP ; # Calcule la taille des dossiers Sauvegardes et stocke les résultats dans le fichier dans la variable $PATH_NAME_BACKUP

# On utilise le / du chemin de fichier comme séparateur, sans inclure la lettre de lecteur