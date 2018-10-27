FROM node:6-alpine
COPY $HOME/oracle-env/ $HOME/
RUN source $HOME/oracle-env/oraenv.sh
