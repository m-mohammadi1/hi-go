createdb:
	docker exec -it postgres-bank createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres-bank dropdb simple_bank

postgres:
	docker run --name postgres-bank -p 5422:5432  -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5422/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5422/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen  -destination db/mock/store.go -package mockdb  github.com/m-mohammadi1/simple-bank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown sqlc server mock