method RequiredStudyTime(c: nat) returns (hours: nat)
    ensures hours <= 200
{
    // finds hours based on c and return it to us, which later we assign to var hours in Study method
    // even if don't have the body of this method but we can say for sure that returned value will be <= 200
}

method Study(n: nat, h: nat)
    // we can do not worry when two different inputs becomes equal 
    // because h and n are natural numbers which means h/n won't be 0
    // which is why we can multiple by 200 and this offset will be enough.
    // n * 200 + h will be always less next iteration because n decreases which uses -200 offset and if h is becoming bigger, 
    // our -200 on the course will make it smaller anyways, and if n is not decreasing then our h is, which makes our sum smaller
    // and now it does not use tuple, but just mathematical expression to compare inputs
    decreases n * 200 + h
{
    if h != 0 {
    // first, study for an hour, and then:
        Study(n, h - 1);
    } else if n == 0 {
    // you just finished course 0 - woot woot, graduation time!
    } else {
    // find out how much studying is needed for the next course
        var hours := RequiredStudyTime(n - 1);
    // get started with course n-1:
        Study(n - 1, hours);
    }
}
