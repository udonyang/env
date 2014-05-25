BEGIN { 
	RS = "^%"
	FS = "^%"
}
/interface/ {
	sub(/i/, "a", $0); print "match! " $0 "\n"
}
END {
	print NR
}
