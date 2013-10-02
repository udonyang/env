package main

import (
    "fmt"
    "net/http"
)

type String string
func (this String)ServeHTTP(
    w http.ResponseWriter,
    r *http.Request) {
    fmt.Fprint(w, this)
}

type Struct struct {
	Greeting string
    Punct    string
    Who      string
}
func (this *Struct)ServeHTTP(
    w http.ResponseWriter,
    r *http.Request) {
    fmt.Fprint(w, this)
}

func main() {
    // your http.Handle calls here
    http.Handle("/string", String("I'm a frayed knot."))
    http.Handle("/struct", &Struct{"Hello", ":", "Dwylkz!"})
    http.Handle("/", String("Welcome"))
    http.ListenAndServe("localhost:4000", nil)
}
