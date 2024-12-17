method Main() {
  var graph := CreateGraph(6);
  assert BFS(graph, 0, 5) == true; 
  assert BFS(graph, 0, 4) == true;
  assert BFS(graph, 2, 4) == false;
}

method CreateGraph(size: int) returns (graph: array<seq<int>>)
  requires size > 0;
  ensures graph.Length == size;
  ensures forall u :: 0 <= u < size ==> graph[u] != null;
{
  graph := new seq<int>[size];
  
  graph[0] := [1, 2];    
  graph[1] := [3, 4];     
  graph[2] := [5];
  graph[3] := [];
  graph[4] := [];
  graph[5] := [];
}

method BFS(graph: array<seq<int>>, source: int, target: int) returns (reachable: bool)
  requires graph.Length > 0;
  requires 0 <= source < graph.Length && 0 <= target < graph.Length;
  ensures reachable == ExistsPath(graph, source, target);
{
  var visited := new bool[graph.Length](false);
  var queue := new seq<int>({source});
  visited[source] := true;

  while |queue| > 0
    invariant 0 <= |queue| <= graph.Length; 
    invariant forall v :: 0 <= v < graph.Length ==> visited[v] ==> ExistsPath(graph, source, v);
  {
    var current := queue[0];
    queue := queue[1..];

    if current == target {
      return true;
    }

    for neighbor in graph[current] {
      if !visited[neighbor] {
        visited[neighbor] := true;
        queue := queue + [neighbor];
      }
    }
  }

  return false;
}

function ExistsPath(graph: array<seq<int>>, source: int, target: int): bool
  requires graph.Length > 0;
  requires 0 <= source < graph.Length && 0 <= target < graph.Length;
{
  if source == target then true
  else exists next :: next in graph[source] && ExistsPath(graph, next, target)
}
