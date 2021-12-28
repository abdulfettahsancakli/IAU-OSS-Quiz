#! /bin/bash

# Recap of function

## Syntax

### method 1

#function name(){
#	commands
#}


### method 2

#name(){
#	commands
#}

#### Example

function hello(){
	echo "hello"
}

quit () {
	exit 
}

hello
quit
echo "some text"


# passing argument to a function

function print(){
	echo $1 	# $1 is passed argument the function print()
}


quit () {
	exit 
}

print "hello" 

# Local Variable
## Generally all variable in Bash are global variable

### Example  without local keyword
function print(){
	name=$1  # behaves as global variable
	echo "The name is $name"
}

name="Ali"
echo "The name is $name" #name is Ali
print Ahmed # name in print() is Ahmed
echo "The name is $name"  #name is changed to Ahmed

### Example  with local keyword
function print(){
	local name=$1  # behaves as global variable
	echo "The name is $name"
}

name="Ali"
echo "The name is $name" #name is Ali
print Ahmed # name in print() is Ahmed
echo "The name is $name"  #name is remains Ali i,e global name is not changed.


## Some other example
if_file_exist(){
	local file="$1"
	[[ -f "$file" ]] && return 0 || return 1 # condition && statement if true | statement if false
}

usage(){
	echo "You need to provide an argument"
	echo "usage : $0 file_name"
}

[[ $# -eq 0 ]] && usage  # $# is number of argument

if ( if_file_exist "$1" )
then 
	echo "file found"
else 
	echo "file not found"
fi


# Read-only

var=31
readonly var
var=50
echo $var #var is 31 it cannot be changed

## readonly function

function hello(){
	echo "hello world"
}

readonly -f hello

function hello(){
	echo "hello world again"
}


hello # it will still print "hello world"

##############
###
###	readonly -p # command to see readonly vaiables
###
### readonly -f # command to see readonly functions
###
##############


# Signals and Traps

echo "pid is $$"

while (( COUNT < 10 ))
do 
	sleep 3
	(( COUNT++ ))
	echo $COUNT
done
exit 0


##############
###
### $$ is the pid of the current running script
### SIGINT / interrupt signal CTRL+C
### SIGTSTP./ Suspend signal CTRL+Z
### SIGKILL /kill -9 command to stop  
###
### use 'man 7 signal' command in shell to see details about the signals
###
##############

### PS:  SIGKILL and SIGSTOP cannot be catched. 


##########################################
# in trap you may use signal name 
trap "echo Exit signal is detected; exit"  SIGINT

echo "pid is $$"

while (( COUNT < 10 ))
do 
	sleep 3
	(( COUNT++ ))
	echo $COUNT
done

exit 0

##########################################



##########################################
# in trap you may use signal number as well 

trap "echo Exit signal is detected ; exit" 2 

echo "pid is $$"

while (( COUNT < 10 ))
do 
	sleep 1
	(( COUNT++ ))
	echo $COUNT
done

exit 0
##########################################



##########################################
# multiple signals can be trapped

trap "echo Exit signal is detected ; exit" 0 2 

echo "pid is $$"

while (( COUNT < 10 ))
do 
	sleep 1
	(( COUNT++ ))
	echo $COUNT
done

exit 0



###################################3

## Debug

# To see the verbose output, you may use any of the following method

### Method 1

# run the script with -x flag
# e.g. bash -x my_script.sh


### Method 2

# determine in shebang of the script
# e.g. #! /bin/bash -x


### Method 3

# use 'set -x' in your script which activates debugging from the point it is written
# to remove the use 'set +x' which deactivates debugging at the point it is written  