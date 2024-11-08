// Takes BYTree and returns the same tree, match works with leafs and subtrees, if it is leaf then change its color to opposite,
// If it is a subtree and recurse to reach the leaf from both sides, left and right. At the end we modified the tree 't' 
// and we will return modified tree with colors reversed.

function ReverseColors(t: BYTree): BYTree {
    match t
    case BlueLeaf => YellowLeaf
    case YellowLeaf => BlueLeaf
    case Node(left, right) => Node(ReverseColors(left), ReverseColors(right))
}
