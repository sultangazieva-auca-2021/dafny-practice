method Triple(x: int) returns (r: int)
// 1
requires x >= 0
requires x % 2 == 0
 
// 2
// requires x >= 2
// requires x % 2 == 0

ensures r == 3 * x
{
    var y := x / 2;
    r := 6 * y;
}

method Caller() {
    var t := Triple(18);
    assert t < 100;
}
