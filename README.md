# Routine
Pour populer la base de donnée : ``` rake db:seed ```
Pour mettre la bdd a jour : ``` rake db:drop rake db:create rake db:migrate ```

# Workflow

Pour ce projet où nous serons nombreux à développer, je propose qu'on mette en place le gitflow tel que j'ai pu le voir chez Sketchfab. Ce repo a trois types de branches :
  - branche feature héritée de develop, ex: front/Adds-users-authentication-view
  - branche develop rassemblant toutes les features développées valides et mergées
  - branche master dans laquelle develop est mergée lorsque notre code est valide


Ainsi, on évitera les commits foireux qui compromettent la prod. Pas la peine d'essayer de push sur le master, je l'ai bloqué, il n'y a que moi (Jérémy) qui puisse y accéder.

Concrétement comment ça marche, qu'est-ce que je dois faire ?
 - on se branche sur develop
 - de là on crée une branche avec la nomenclature suivante : front/What-your-commit-does
 - le message du commit est en anglais, 3ème personne du singulier
 - ex: back/Adds-user-authentication
 - A partir de là, let's code
 - Au moment de commit, merci de faire un rebase avant de push ( `git rebase -i HEAD~2` pour compiler votre commit avec celui d'avant ), il ne doit y avoir qu'un seul commit par branche, pas plus !
 - Une fois votre branche pushée, faites une pull request sur develop
 - nommez la pull request comme votre branche, et expliquez dans la description ce que vous avez fait de manière claire et concise, pour que ceux qui mergent ne perdent pas de temps à comprendre ce que vous avez fait en lisant votre code.

Si ça fait quelques temps que vous n'avez pas commit et que les autres ont avancé et validé leur code (qui aura donc été mergé dans develop), mettez votre branche à jour sur develop en saisissant la commande suivante :
`git rebase origin/develop`
Ceci mettra le code à jour sans toucher à ce que vous faites. Pour plus de renseignements, la [doc github](https://git-scm.com/docs/git-rebase)

### Les Pull Request
Les pull request ont pour but de vérifier que le code proposé suit bien le style d'écriture du projet et qu'on n'introduit pas d'erreurs sur develop et donc potentiellement sur master.
Idéalement, il faut distinguer les pull request en attente d'évaluation de celle prêtes à être mergées. Donc, une fois votre PR ouverte, nommée, décrite, merci de taguer la PR avec le message "Needs review" et d'assigner une personne dessus. Utilisez les commentaires pour échanger, faites vos modifs, commit, rebase et ainsi de suite jusqu'à ce que tous ceux assignés soient d'accord. A ce moment-là, enlevez le tag "Needs review", et mettez celui "Needs merge" pour me signifier que la PR est fin prête.

Assignez vos PR a ceux pour qui ça fait sens et/ou qui ont travaillé précédemment sur des éléments que vous traitez pour bien s'assurer que vous ne pétez rien.

### Les releases
Chaque jour ou presque, dès lors que nous aurons assez de fonctionnalitées valides mergées dans develop, je ferai un merge dans le master ce qui aura pour conséquence de mettre la prod à jour. Sauf en fin de projet, à l'approche de la deadline, ne comptez pas sur moi pour merger develop dans master s'il n'y a qu'une seule fonctionnalité nouvelle depuis la dernière release, ça ne sert à rien et c'est une perte de temps. Les release auront en général lieu en fin de journée une fois que tout le monde est ok.

### Communication
Vous travaillez sur une feature et vous avez un doute ? Parlez-en à un autre membre de l'équipe sur le Slack mais parlez-en en public ! Les Messags Privés liés au développement sont interdits ! Un problème débattu en privé sera invisible aux autres qui pourraient avoir le même probleme et bénéficier de la même solution.
