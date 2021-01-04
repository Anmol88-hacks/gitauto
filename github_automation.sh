#!/bin/bash
echo "" 
echo "<======================================>"
echo "Created by Anmol Varshney on 29-Dec-2020"
echo "<======================================>"
echo ""
echo "<========================================================>"
echo "Make sure you have installed the git if not run this code"
echo "sudo apt-get install git --> For Debian"
echo "yum -y install git       --> For RPM"
echo "<========================================================>"
echo ""
wd=`pwd`
echo "This is your current working directory -> $wd"
read -p "Would you want to continue in this directory (y/n): " ch
if [[ ! -z $ch ]]; then
	ch='y'
fi
if [[ $ch == 'n' ]]; then
	read -p "Enter your working directory: " uwd
	wd=$uwd
fi
echo ""
echo "<=========================================================================================================================================>"
echo "This automation automatically create a folder then copy your all the files into that folder and then it will upload to your Github account"
echo "<=========================================================================================================================================>"
echo ""
function check() {
	cd $wd
	if [[ $(ls -l |grep "$1"|wc -l) -eq 0 ]]; then
		mkdir $wd/$fn		
	fi
}
while [[ -z $fn ]]; do
        read -p "Enter the folder name to be created: " fn 
if [[ $fn =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]
then 
    echo "Please enter a valid folder name" 
    exit 0 
fi
done
check $fn
while [[ -z $n ]]; do
	read -p "Enter your number of files: " n
done
while [[ $n -ne 0 ]]; do	
	read -p "Enter the full path or Absolute path of your file: " j
	if  [[ $j =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]
	then
    		echo "Please enter a valid folder name"
    		exit 0
	fi

	op="cp $j $wd/$fn"
	eval $op
	n=`expr $n - 1`
done
cd $wd/$fn
while [[ -z $uname ]]; do
	read -p "Enter the user name for global registration of git: " uname
done
git config --global user.name $uname
while [[ -z $email ]]; do
	read -p "Enter the email address for same: " email
done
git config --global user.email $email
git init
git add *
echo "" 
while [[ -z $me ]]; do
	read -p "Enter the commit message: " me
done
git commit -m "$me"
while [[ -z $repo ]]; do
	read -p "Enter your Repository url: " repo
done
git remote add origin $repo
git push -u origin master
