package main

import (
	"database/sql"
	"github.com/m-mohammadi1/simple-bank/api"
	db "github.com/m-mohammadi1/simple-bank/db/sqlc"
	"log"

	_ "github.com/lib/pq"
)

const (
	dbDriver      = "postgres"
	dbSource      = "postgresql://root:secret@localhost:5422/simple_bank?sslmode=disable"
	serverAddress = "127.0.0.1:9191"
)

func main() {

	conn, err := sql.Open(dbDriver, dbSource)

	if err != nil {
		log.Fatal("cannot connect to db: ", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
