BEGIN {
  RS = "////"
}

/namespace ([^{]*) {/ {
  name = $2
  gsub("_", " ", name)
  if (name != "dal") {
    RS = "//="
    print "\\section{" name "}"
  }
}

{
  if ($1 == "}") {
    if (RS == "//=") {
      print "% " name " block\n"
      #print "\\newpage"
      RS = "////"
    } else if (RS == "////") exit
  }
}

/\/\*/ {
  sname = $2
  gsub("_", " ", sname)
  gsub("\n    ", "\n", $0)
  print "\n\\subsection{" sname "}"
  sub("^[[:space:]]", "")
  sub("[[:space:]]*$", "")
  print "\\begin{lstlisting}"
  print $0
  print "\\end{lstlisting}\n"
  #print "\\newpage"
}
