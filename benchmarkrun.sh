# create benchmark session
# generate a security policy session for python app using template
unset MRENCLAVE SCONE_CONFIG_ID
export MRENCLAVE=$(SCONE_HASH=1 python3) # get MRENCLAVE/HASH of python3
envsubst '$MRENCLAVE' < session_benchmark.yml > session_benchmark_res.yml
unset MRENCLAVE SCONE_CONFIG_ID 

# submit_policy.sh
set -x -e

CAS_ADDR=cas
# get MRENCLAVE of CAS by running: docker-compose run -eSCONE_HASH=1 cas
CAS_MRENCLAVE="663ddae4f0036a39c18a533d97f7a5ba0850f2efb0147d63afa459a20315a7e1"

echo "Attesting CAS ..."
scone cas attest -G --only_for_testing-debug --only_for_testing-ignore-signer "$CAS_ADDR" "$CAS_MRENCLAVE"

echo "Uploading policy to CAS ..."
scone session create --use-env "session_benchmark_res.yml"
echo ""

# execute the python app with the deployed security session, SCONE_CONFIG_ID --> pass remote attestation information to the container
SCONE_VERSION=7 SCONE_CONFIG_ID=volume_policy_benchmark/benchmark_service python3
# latency using time command
# SCONE_VERSION=7 SCONE_CONFIG_ID=volume_policy_benchmark/benchmark_service time python3
# memory usage using time -v command
# SCONE_VERSION=7 SCONE_CONFIG_ID=volume_policy_benchmark/benchmark_service time -v python3
