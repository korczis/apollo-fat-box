# == Class: db
#
# Installs All Databases
#
class db::all {
  include couchdb
  include memcache
  include mongodb
  include postgresql
  include redis
}