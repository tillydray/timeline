.PHONY: all compile build migrate test clean

all: compile build

compile:
	mix compile

build:
	mix release

migrate:
	mix ecto.migrate

test:
	mix test

clean:
	mix clean
