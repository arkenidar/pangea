
###rlwrap lua /home/dario/Dropbox/main/code/lua/pangea/latest.lua $@

###DIR=/home/dario/Dropbox/main/code/lua/pangea/
DIR=$(dirname $0)/
##RUNNER=latest.lua
RUNNER=src/pangea1/main.lua
#echo $DIR
rlwrap lua $DIR$RUNNER $@

# Geany config
# sh /home/dario/Dropbox/main/code/lua/pangea/pang-cli.sh "%f" # in Geany/Execute
