#' Retrieve Nodes with Cypher Queries
#' 
#' Deprecated. Use \code{\link{cypherToList}}. Retrieve a single node from the graph with a Cypher query.
#' 
#' @param graph A graph object.
#' @param query A character string.
#' @param ... Parameters to pass to the query in the form key = value, if applicable.
#' 
#' @return A node object.
#' 
#' @examples 
#' \dontrun{
#' graph = startGraph("http://localhost:7474/db/data/")
#' clear(graph)
#' 
#' createNode(graph, "Person", name = "Alice", age = 23)
#' createNode(graph, "Person", name = "Bob", age = 22)
#' createNode(graph, "Person", name = "Charles", age = 25)
#' 
#' query = "MATCH (p:Person)
#' 		 WITH p
#' 		 ORDER BY p.age DESC
#' 		 RETURN p 
#' 		 LIMIT 1"
#' 
#' getSingleNode(graph, query)
#' 
#' query = "MATCH (p:Person {name:{name}}) 
#'          RETURN p"
#' 
#' getSingleNode(graph, query, name = "Alice")
#' }
#' 
#' @seealso \code{\link{getNodes}}
#' 
#' @export
getSingleNode = function(graph, query, ...) UseMethod("getSingleNode")

#' @export
getSingleNode.graph = function(graph, query, ...) {
  result = cypherToList(graph, query, ...)
  
  if(length(result) == 0) {
    return(invisible())
  }
  
  result = result[[1]][[1]]
  
  if(!("node" %in% class(result))) {
    stop("The entity returned is not a node. Check that your query is returning a node.")
  }
  
  return(result)
}

#' @export
getSingleNode.boltGraph = getSingleNode.graph;