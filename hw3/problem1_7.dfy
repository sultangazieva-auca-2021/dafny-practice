method MaxSum(x: int, y: int) returns (s: int, m: int) 
    // here we are assuming that x and y can be any number positive or negative 
    ensures s == x + y
    ensures m == max(x, y)
{
    if x >= y {
        m := x;
    } else {
        m := y;
    }

    s := x + y;
}

// computing max of given nums
function max(x: int, y: int): int 
{
    if x >= y then x else y
}

method Main() 
{
    var s, m := MaxSum(1928, 1);
    assert s == 1929;
    assert m == 1928;
}
