# source docker helpers
. util/docker.sh

@test "Start Container" {
  start_container "slurp-test"
}

@test "Verify slurp installed" {
  # ensure slurp executable exists
  run docker exec "slurp-test" bash -c "[ -f /usr/local/bin/slurp ]"

  [ "$status" -eq 0 ]
}

@test "Stop Container" {
  stop_container "slurp-test"
}
