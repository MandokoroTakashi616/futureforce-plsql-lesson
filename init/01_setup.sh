#!/bin/bash
set -euo pipefail

sqlplus -s "${APP_USER}/${APP_USER_PASSWORD}@//localhost/FREEPDB1" <<'EOF'
WHENEVER SQLERROR EXIT SQL.SQLCODE
@/opt/plsql/sql/01_schema.sql
@/opt/plsql/sql/02_seed.sql
EXIT
EOF
