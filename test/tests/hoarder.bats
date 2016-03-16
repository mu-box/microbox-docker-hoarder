# source docker helpers
. util/docker.sh

@test "Start Container" {
  start_container "hoarder-test"
}

@test "Verify hoarder installed" {
  # ensure hoarder executable exists
  run docker exec "hoarder-test" bash -c "[ -f /usr/local/bin/hoarder ]"

  [ "$status" -eq 0 ]
}

@test "Stop Container" {
  stop_container "hoarder-test"
}
