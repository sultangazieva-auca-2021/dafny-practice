// Write a decreases clause that proves the termination of the following function

function L(x: int): int 
    // it will work with all numbers with negatives as well because x is int, so when x is negative 
    // 100 - x will be bigger than 100 and when x gets bigger the difference 100 - x gets closer to 0 which means it will decrease and eventually terminate
    decreases 100 - x
{
    if x < 100 then L(x + 1) + 10 else x
}
