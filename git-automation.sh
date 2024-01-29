#!/bin/bash

echo "NOTE -> git and gh must be installed to use this"
echo "Welcome to Git & GitHub Automation :"

echo "1. Configure Tooling "
echo "2. Branch Operations "
echo "3. Create Local Repo or Clone Repo in Current Folder"
echo "4. Synchronize Changes "
echo "5. Upload current Folder and create a new Repo / Commit new Changes made to Repo "
echo "6. Redo Commits "


echo "Select the Option you would like to proceed with :"

read caseVar

case $caseVar in
"1")
echo "You have selected Configure Tooling :"

echo "1> git config --global user.name "[name]"   -> Updates your username "
echo "2> git config --global user.email "[name]"  -> Updates your Email"
echo "3> git config --global color.ui auto        -> Changes your color output in Terminal"
echo "4> git config user.name                     -> Know your current Username "
echo "5> git config user.email                    -> Know your current Email"

echo "Select the option you would like to proceed with :"
read option

if [ $option == 1 ]
<<comment
echo "Now uploading the current Directory Components :"
git init
git add .
comment
then
echo "Enter the Name to set as username "
read username
git config --global user.name "${username}"
echo "Your userName of Git has been changed to -> ${username}"

elif [ $option == 2 ]
then
echo "Enter the Email to set as Email "
read gitemail
git config --global user.email "${gitemail}"
echo "Your Email of Git has been changed to -> ${gitemail}"

elif [ $option == 3 ]
then

echo "1> git config --global color.branch auto"
echo "2> git config --global color.diff auto"
echo "3> git config --global color.interactive auto"
echo "4> git config --global color.status auto"
echo "Choose one of the .ui from above :"

read ui

if [ $ui == 1 ]
then
git config --global color.branch auto
echo "git config --global color.branch auto"

elif [ $ui == 2 ]
then
git config --global color.diff auto
echo "git config --global color.diff auto"

elif [ $ui == 3 ]
then
git config --global color.interactive auto
echo "git config --global color.interactive auto"

elif [ $ui == 4 ]
then
git config --global color.status auto
echo "ui has been set according to status"
fi

elif [ $option == 4 ]
then
echo "Your current Username is : "
git config user.name

elif [ $option == 5 ]
then
echo "Your current Email is :"
git config user.email

fi
;;

"2")
echo "You have selected Branch Operations :"

echo "1> git branch [branch-name]    -> Creates a new Branch"
echo "2> git checkout [branch-name]  -> Switch to other Branch"
echo "3> git merge [branch]          -> Combines the specified branch into current Branch"
echo "4> git branch -d [branch-name] -> Deletes the Specified Branch "

echo "Select the option you would like to proceed with :"
read option2

if [ $option2 == 1 ]
then
echo "Enter the new Branch name to create :"
read branchName
echo "git branch $branchName"
git branch $branchName
echo "New branch with the name -> ${branchName} has been created"

elif [ $option2 == 2 ]
then

echo "Enter the Branch Name to switch to :"
read branchName
echo "git checkout ${branchName}"
git checkout $branchName

elif [ $option2 == 3 ]
then

echo "Enter the branch to merge :"
read branchName
echo "git merge ${branchName}"
git merge $branchName

elif [ $option2 == 4 ]
then
echo "Enter the name of the branch to delete :"
read branchName
echo "git branch -d ${branchName}"
git branch -d $branchName

fi

;;

"3")
echo "You have selected Create a Local Repo or Clone a Repo in Current Folder :"
echo "Would you like to :"
echo "1> Clone a Repo"
echo "2> Create a Repo"

read option3

if [ $option3 == 1 ]
then
echo "Enter the SSH Url from Git Repo to Clone :"
read cloneURL
echo "Cloning....."
echo "git clone ${cloneURL}"
git clone $cloneURL

currentFolder=pwd
echo "Repo has been clonend to the Current Directory -> ${currentFolder}"

elif [ $option3 == 2 ]
then
echo "git init"
git init
echo "Repo created successfully"

fi
;;

"4")
echo "You have selected Synchronize Changes :"

echo "1> git fetch   -> Downloads all history from branches"
echo "2> git push    -> Uploads all local branch commits to Github"
echo "3> git pull    -> Combination of Git Fetch and Git Merge"

echo "Select an option from the above :"
read option4

if [ $option4 == 1 ]
then
echo "git fetch"
git fetch

elif [ $option == 2 ]
then
echo "git push"
git push

elif [ $option == 3 ]
then
echo "git pull"
git pull
fi

;;

"5")
echo "You have selected upload current folder and create a new repo / Commit new Changes made to Repo: "


echo "1> Would you like to commit new Changes"
echo "2> Make a new Repo and Upload all the files in current Folder"
read selectOption

if [ $selectOption == 1 ]
then
git init
echo "Enter the new commit message :"
read commitMessage
git add .
git commit -m "${commitMessage}"
git push origin master
echo "New Changes Pushed ..."

elif [ $selectOption == 2 ]
then
echo "Enter your Github Username :"
read githubName

echo "Enter the Name of the New Repo :"
read newRepo

echo "Choose the visibility of the Repo :"
echo "1> Private"
echo "2> Public"
read visibility

echo "Are you : ?"
echo "1> Windows User"
echo "2> Linux User"
read user

echo "Setup and Login to gh is required for performing this Operation :"
echo "Logging into gh ... "

if [ $user == 1 ]
then
winpty gh auth login

elif [ $user == 2 ]
then
gh auth login
fi


if [ $visibility == 1 ]
then
echo "Creating Repo ...."

gh repo create ${newRepo} --private

elif [ $visibility == 2 ]
then
echo "Creating Repo ...."

gh repo create ${newRepo} --public

fi

echo "New Repo with the name -> ${newRepo} has been created "

echo "Uploading the Files in the Current Directory to the Repo :"
git init
git add .
git commit -m "initial commit"
git remote add origin https://github.com/${githubName}/${newRepo}.git
git push origin master



fi



;;

"6")
echo "You have selected Redo Commits :"
echo "1> git reset [commit]        -> Undoes all the staged commits"
echo "2> git reset --hard [commit] -> Discards all history and changes back to the specified commit"
echo "3> git revert [commit]       -> revert back to a log-Id"

echo "Select the Operation from above :"
read option5

echo "Enter the git-log commit-id :"
read gitlogId


if [ $option5 == 1 ]
then
echo "git reset ${gitlogId}"
git reset $gitlogId
echo "All staged changes unstaged "

elif [ $option5 == 2 ]
then
echo "git reset --hard ${gitlogId}"
git reset --hard $gitlogId
echo "Discarded all history"

elif [ $option5 == 3 ]
then
echo "git revert ${gitlogId}"
git revert $gitlogId
echo "Reverted all the changes back to -> ${gitlogId} commit-id"

fi

;;




esac
printf "\n"

echo "Thanks for using git-automation script"
githubUrl=https://github.com/SimardeepSingh1450
printf "\n"
echo "Made by -> ${githubUrl}"
printf "\n"

