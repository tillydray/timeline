.PHONY: all compile build migrate test clean

install_deps:
	mix deps.get

setup_db:
	mix ecto.setup

serve:
	mix phx.server && open http://localhost:4000

compile:
	mix compile

migrate:
	mix ecto.migrate

clean:
	mix clean

bust_cache:
	rm ./_build/dev/lib/timeline/priv/timeline_cache.dets
