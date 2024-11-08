-- Maverick Boyle 426005785

module HW5 where

import Text.Printf

data Tree a b = Branch b (Tree a b) (Tree a b) 
    | Leaf a

instance (Show a, Show b) => Show (Tree a b) where
  show = showAtLevel 0
    where
      showAtLevel l (Leaf x) = addSpace l ++ show x
      showAtLevel l (Branch x lt rt) = printf "%s%s\n%s\n%s" (addSpace l) (show x) (showAtLevel (l + 1) lt) (showAtLevel (l + 1) rt)
      addSpace = flip replicate '\t'

mytree :: Tree Int [Char]
mytree = Branch "A" (Branch "B" (Leaf (1::Int)) (Leaf (2::Int))) (Leaf (3::Int))


otherTree :: Tree Int b
otherTree = Leaf 2

-- conL :: Ord c => Tree a b -> c
-- conL a = 

--conB ::  Ord c => Tree a b -> c
--conB a = 


-- preorder :: (a -> c) -> (b -> c) -> Tree a b -> [c]
-- preorder f g (Leaf x)= [f x] 
-- preorder f g (Branch x l r) = g x : (preorder f g l ++ preorder f g r)

-- postorder :: (a -> c) -> (b -> c) -> Tree a b -> [c]
-- postorder f g (Leaf x) = [f x] 
-- postorder f g (Branch x l r) = postorder f g l  ++ postorder f g r ++ [g x]

-- inorder :: (a -> c) -> (b -> c) -> Tree a b -> [c]
-- inorder f g (Leaf x) = [f x] 
-- inorder f g (Branch x l r) = inorder f g l ++ [g x] ++ inorder f g r