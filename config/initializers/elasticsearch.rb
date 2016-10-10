require 'multi_json'
require 'oj'
require 'hashie/mash'

require 'elasticsearch'
require 'elasticsearch/model'
require 'elasticsearch/persistence'
require 'elasticsearch/persistence/model'
# Builds the client connection
Elasticsearch::Persistence.client Elasticsearch::Client.new(host: Settings.elasticsearch.urls)