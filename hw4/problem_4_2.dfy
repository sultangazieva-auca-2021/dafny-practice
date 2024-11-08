function ReverseColors(t: BYTree): BYTree {
    match t
    case BlueLeaf => YellowLeaf
    case YellowLeaf => BlueLeaf
    case Node(left, right) => Node(ReverseColors(left), ReverseColors(right))
}

method TestReverseColors() {
    var a := Node(BlueLeaf, Node(BlueLeaf, YellowLeaf));
    var b := Node(YellowLeaf, Node(YellowLeaf, BlueLeaf));
    assert ReverseColors(a) == b;
    assert ReverseColors(b) == a;
    // double negation/reverse comes back to start/cancels
    assert ReverseColors(ReverseColors(a)) == a;
    assert ReverseColors(ReverseColors(b)) == b;

    var oneYellow := YellowLeaf;
    var oneBlue := BlueLeaf;
    assert ReverseColors(oneYellow) == oneBlue;
    assert ReverseColors(oneBlue) == oneYellow;

    var onlyBlue := Node(BlueLeaf, BlueLeaf);
    var onlyYellow := Node(YellowLeaf, YellowLeaf);
    assert ReverseColors(onlyBlue) == onlyYellow;
    assert ReverseColors(onlyYellow) == onlyBlue;

    // Nothing changes check, we expect them to fail, dafny shows an error
    assert ReverseColors(oneYellow) == oneYellow;
    assert ReverseColors(oneBlue) == oneBlue;
}
