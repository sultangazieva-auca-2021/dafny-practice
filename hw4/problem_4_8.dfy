datatype Expr = 
  Const(nat)
| Var(string)
| Node(op: Op, args: List<Expr>)

datatype Op = 
  Add 
| Mul

datatype List<T> = 
  Nil 
| Cons(head: T, tail: List<T>)

function Eval(e: Expr, env: map<string, nat>): nat {
  match e
  case Const(c) => c
  case Var(s) => 
    if s in env.Keys then env[s] else 0
  case Node(op, args) => 
    EvalList(args, op, env)
}

/*
function EvalList(args: List<Expr>, op: Op, env: map<string, nat>): nat {
  match args
  case Nil =>
    match op 
    case Add => 0 
    case Mul => 1
  case Cons(e, tail) =>
    var v0, v1 := Eval(e, env), EvalList(tail, op, env);
    match op
    case Add => v0 + v1
    case Mul => v0 * v1
}
*/

function EvalList(op: Op, args: List<Expr>, env: map<string, nat>): nat 
    decreases args
{
  match args
  case Nil =>
    match op 
    case Add => 0 
    case Mul => 1
  case Cons(e, tail) =>
    var v0, v1 := Eval(e, env), EvalList(op, tail, env);
    match op
    case Add => v0 + v1
    case Mul => v0 * v1
}

/*
    changing the parameters' order helpes Dafny to evaluate/compare the input for the function, it helpes
    Dafny to make sure that the new input after the recursive call is actually smaller than the current one 
    which will lead to the termination and promises that we won't enter infinite loop. Arguments are compared in order of declaring them
    that is why the order of writing them is important is we want a termination.
    By manually writing the decreases clause we say to Dafny that args length will decrease and it will at one point Finish.
    We say to Dafny that look to args it will become smaller and we will reach case 'Nil'.
*/
