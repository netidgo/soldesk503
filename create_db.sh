#!/bin/bash

# Install MariaDB for Amazon Linux 2023
yum install -y mariadb105-server
systemctl start mariadb & systemctl enable mariadb

# MySQL 변수 정의
MYSQL_HOST="localhost"
MYSQL_ADMIN="root"
ADMIN_PWD=""
DB_NAME="webdb"
TABLE_NAME="members"
MYSQL_USER="webuser"
MYSQL_PWD="password"

# SQL 명령어 정의
SQL_COMMANDS=$(cat <<EOF
DROP DATABASE IF EXISTS ${DB_NAME};
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PWD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
USE ${DB_NAME};
CREATE TABLE IF NOT EXISTS ${TABLE_NAME} (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
EOF
)

# MySQL 접속 및 실행
mysql -u ${MYSQL_ADMIN} -h ${MYSQL_HOST} -e "${SQL_COMMANDS}"
