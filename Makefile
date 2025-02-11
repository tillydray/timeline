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

serve:
	mix phx.server && open http://localhost:4000

bust_cache:
	rm ./_build/dev/lib/timeline/priv/timeline_cache.dets
