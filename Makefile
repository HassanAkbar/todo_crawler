run:
  cli

run_docker:
  docker run --rm $(shell docker build -q .)
