method ReconstructFromMaxSum(s: int, m: int) returns (x: int, y: int)
    requires s >= 0 // both should be non-negativeto make the precondition easier
    requires m >= 0
    requires s >= m // sum of positive numbers is greater than max num
    ensures s == x + y
    ensures (m == x || m == y) && x <= m && y <= m
{
    x := s - m;
    y := m;
}

method TestMaxSum(x: int, y: int) 
{
    var s, m := MaxSum(x, y);
    var xx, yy := ReconstructFromMaxSum(s, m);
    assert (xx == x && yy == y) || (xx == y && yy == x);
}
