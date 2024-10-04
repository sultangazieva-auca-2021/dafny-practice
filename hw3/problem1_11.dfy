// (a) What does the verifier have to say about the two assertions in this program?
// first assertion will pass successfully because F is a function which always returns 29
// But the second assertion will not be varified because it is a method and that is why dafny will not go and check its body
// which is why dafny cannot say for sure that b will be equal to 29
// it just does not have postconditions before the body to make dafny believe that it will indeed be 29
// moreover there is no a return statement which will guarantee that method returns 29
function F(): int 
{
    29
}

method M() returns (r: int) 
    ensures r == 29
{
    r := 29;
}

method Caller() 
{
    var a := F();
    var b := M();
    assert a == 29;
    assert b == 29; // cannot know for sure without postconditions in a called method
}
// (c) How can you change the program to make both assertions
// verify? - Just by adding postconditions after the method body will be executed it will check/ensure that the value returned will be equal to 29
