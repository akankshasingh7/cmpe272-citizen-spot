cmpe272-citizen-spot
====================

CMPE 272 Group Project


1. Create a repository in github (e.g. cmpe272-citizen-spot).
2. Clone that repository (git clone git@github.com:<your user name>/cmpe272-citizen-spot.git) somewhere in your local hard disk. A new folder 'cmpe272-citizen-spot' will be created.
3. Move to the folder 'cmpe272-citizen-spot' ( cd cmpe272-citizen-spot).
4. execute 'git remote add manamirepo git@github.com:manamibhunia/cmpe272-citizen-spot.git'
5. execute 'git fetch manamirepo' - this will fetch code from manami's repository.
6. git status - to see the status of the repository
7. git log - to see the commit history


to push your changes to your repo - 

1. Git fetch --all
2. git rebase manamirepo/master
3. Test your changes after this. If there is any conflict or error fix it.
4. git push origin master   - this will push the changes to your github repo.
5. git push manamirepo master - this will push your changes to common repo

By doing this, everybody will have each other's changes.

Try not to work on same file simultaneously to avoid conflicts, as it may not be simple for you to resolve it.
Once someone is done changing a file let him push his/her change, then take that change by :

1. Git fetch --all
2. git rebase manamirepo/master

then make your change and push to both your repo and the common repo.


Change Log
==========

ALTER TABLE `user` ADD UNIQUE (email_id);
ALTER TABLE `user` MODIFY `email_id` VARCHAR(100) NOT NULL;
ALTER TABLE `user` MODIFY `password` VARCHAR(450) NOT NULL;
ALTER TABLE `problem` MODIFY `image` VARCHAR(500);
ALTER TABLE `problem` ADD `uploaded_by` VARCHAR(100);


