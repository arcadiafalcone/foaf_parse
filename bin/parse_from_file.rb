require 'rdf'
require 'rdf/raptor'
require 'sparql'
require 'net/http'
require 'openssl'

graph = RDF::Graph.load("foaf_files/arcadia_foaf.rdf")
puts graph
