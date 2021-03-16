set -x -e

# generate a security policy session for python app using template
unset MRENCLAVE SCONE_CONFIG_ID
export MRENCLAVE=$(SCONE_HASH=1 python) # get MRENCLAVE/HASH of python
MRENCLAVE="e1279dcd6acdba6968cb6ac0c1149c1976ed60ecf0ebb3a405d9e1aec658d0a2"
envsubst '$MRENCLAVE' < session_template.yml > session.yml
unset MRENCLAVE SCONE_CONFIG_ID 
