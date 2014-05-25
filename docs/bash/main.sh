apb() {
	echo " A + B Problem bash version";
	echo "please input a and b in one line: ";
	c=0;
	while [[ $c != 10 ]]; do
		read a b;
		let "c = a + b";
		echo "$a + $b = $c";
	done;
	return 1;
}

ct() {
	echo -n "Enter the name of an animal: ";
	read ANIMAL;
	echo -n "The $ANIMAL has ";
	case $ANIMAL in
		horse | dog | cat ) echo -n "four";;
		man | kangaroo ) echo -n "two";;
		* ) echo -n "an unknown number of";;
	esac;
	echo " legs.";
}

#select test
st() {
	select fname in $@; do
		echo "you picked $fname ($REPLY)";
	break;
	done;
	return 128;
}

#expression test test
ett() {
	a=1;
	b=2;
	if [[ !($a < $b) ]]; then
		echo "1 < 2";
	fi;
}

#braces and curly braces test
bacbt() {
	echo "$$";
	{ d=1; echo $d; }
	( echo $d; )
}

#Coprocesses test
cot() {
	coproc VV vim;
	return 1;
}

#special parameters
spt() {
	echo "parameter amount: $#";
	echo "$*";
	st $*;
	echo "$@";
	st $@;
	echo "most recent return value: $?";
	echo "flag of set: $-";
	echo "current PID: $$";
	coproc echo "haha";
	echo "most recent bg PID: $!";
	kill $!;
	echo "this file is: $0";
	echo "here is $_";
}

#brace expansion
bet() {
	z=a{d,c,b,x{zd,zc,zd}}e;
	echo z;
	echo a{01..10}e;
	echo a{a}e;
	return 1;
}

#tilde expansion
tet() {
	echo home: ~;
	echo PWD: ~+;
	echo OLDPWD: ~-;
	pushd .;
	echo PWD+1: ~+1;
	echo PWD-2: ~-1;
}

#shell expansion
a=2;
echo ${a};
apb;

exit 0;

