package main

import (
	"fmt"
	"net/http"

	"github.com/gorilla/rpc"
	"github.com/gorilla/rpc/json"
	"github.com/mleonard87/merknera/services"
)

func Init() {
	s := rpc.NewServer()
	s.RegisterCodec(json.NewCodec(), "application/json")
	s.RegisterService(new(services.RegistrationService), "")
	s.RegisterService(new(services.UserService), "")
	http.Handle("/rpc", s)
	fmt.Println("Merknera is now listening on localhost:8080")
	http.ListenAndServe(":8080", nil)
}

func main() {
	Init()
}
