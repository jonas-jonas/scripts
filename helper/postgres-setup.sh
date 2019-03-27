#!/bin/sh

# Install necessary postgres packages
sudo apt-get install -yqq postgresql postgresql-contrib

HBA_FILE=$(sudo su postgres -c "psql -c 'show hba_file;'" | grep pg_hba.conf | sed -e 's/^[ \t]*//')

create_db_and_user() {
    USER=$1

    echo "Creating user and database \"${USER}\""
    sudo su postgres -c "createuser -d -S -R -P ${USER}"
    sudo su postgres -c "createdb -O ${USER} ${USER}"

    echo "User and database \"${USER}\" created."

    echo "host    ${USER}     ${USER}             127.0.0.1/32            md5" | sudo tee -a ${HBA_FILE}
    echo "host    ${USER}     ${USER}             ::1/128                 md5" | sudo tee -a ${HBA_FILE}
    
}

create_db_and_user taskman
create_db_and_user knowledgeforge

sudo service postgresql restart