import Data.List (break)

data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show)

freeTree :: Tree Char
freeTree =
  Node 'P'
    (Node 'O'
      (Node 'L'
        (Node 'N' Empty Empty)
        (Node 'T' Empty Empty)
      )
      (Node 'Y'
        (Node 'S' Empty Empty)
        (Node 'A' Empty Empty)
      )
    )
    (Node 'L'
      (Node 'W'
        (Node 'C' Empty Empty)
        (Node 'R' Empty Empty)
      )
      (Node 'A'
        (Node 'A' Empty Empty)
        (Node 'C' Empty Empty)
      )
    )

-- changeTop :: Tree Char -> Tree Char
-- changeTop (Node x l (Node y (Node _ m n) r)) = Node x l (Node y (Node 'P' m n) r)

data Direction = L | R deriving (Show)
type Directions = [Direction]

changeTop :: Directions -> Tree Char -> Tree Char
changeTop (L:ds) (Node x l r) = Node x (changeTop ds l) r
changeTop (R:ds) (Node x l r) = Node x l (changeTop ds r)
changeTop [] (Node _ l r) = Node 'P' l r

elemAt :: Directions -> Tree a -> a
elemAt (L:ds) (Node _ l _) = elemAt ds l
elemAt (R:ds) (Node _ _ r) = elemAt ds r
elemAt [] (Node x _ _) = x

-- type Breadcrumbs = [Direction]
-- 
-- goLeft :: (Tree a, Breadcrumbs) -> (Tree a, Breadcrumbs)
-- goLeft (Node _ l _, bs) = (l, L:bs)
-- goRight :: (Tree a, Breadcrumbs) -> (Tree a, Breadcrumbs)
-- goRight (Node _ _ r, bs) = (r, R:bs)

data Crumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving (Show)

type Breadcrumbs a = [Crumb a]

type Zipper a = (Tree a, Breadcrumbs a)

goLeft :: Zipper a -> Maybe (Zipper a)
goLeft (Node x l r, bs) = Just (l, LeftCrumb x r:bs)
goLeft (Empty, _) = Nothing

goRight :: Zipper a -> Maybe (Zipper a)
goRight (Node x l r, bs) = Just (r, RightCrumb x l:bs)
goRight (Empty, _) = Nothing

goUp :: Zipper a -> Maybe (Zipper a)
goUp (t, LeftCrumb x r:bs) = Just (Node x t r, bs)
goUp (t, RightCrumb x l:bs) = Just (Node x l t, bs)
goUp (_, []) = Nothing


modify :: (a -> a) -> Zipper a -> Maybe (Zipper a)
modify f (Node x l r, bs) = Just (Node (f x) l r, bs)
modify f (Empty, bs) = Just (Empty, bs)

attach :: Tree a -> Zipper a -> Maybe (Zipper a)
attach t (_, bs) = Just (t, bs)

-- topMost :: Zipper a -> (Zipper a)
-- topMost (t,[]) = (t,[])
-- topMost z = topMost (goUp z)

x -: f = f x

newFocus = return (freeTree,[]) >>= goLeft >>= goRight >>= modify (\_ -> 'P')
newFocus2 = newFocus >>= goUp >>= modify (\_ -> 'X')

farLeft = return (freeTree,[]) >>= goLeft >>= goLeft >>= goLeft >>= goLeft
newFocus3 = farLeft >>= attach (Node 'Z' Empty Empty)

-- newFocus4 = newFocus3 :- topMost

-- Simple File System

type Name =  String
type Data = String
data FSItem = File Name Data | Folder Name [FSItem] deriving (Show)

myDisk :: FSItem  
myDisk = 
    Folder "root"   
        [ File "goat_yelling_like_man.wmv" "baaaaaa"  
        , File "pope_time.avi" "god bless"  
        , Folder "pics"  
            [ File "ape_throwing_up.jpg" "bleargh"  
            , File "watermelon_smash.gif" "smash!!"  
            , File "skull_man(scary).bmp" "Yikes!"  
            ]  
        , File "dijon_poupon.doc" "best mustard"  
        , Folder "programs"  
            [ File "fartwizard.exe" "10gotofart"  
            , File "owl_bandit.dmg" "mov eax, h00t"  
            , File "not_a_virus.exe" "really not a virus"  
            , Folder "source code"  
                [ File "best_hs_prog.hs" "main = print (fix error)"  
                , File "random.hs" "main = print 4"  
                ]  
            ]  
        ]

data FSCrumb = FSCrumb Name [FSItem] [FSItem] deriving (Show)
type FSZipper = (FSItem, [FSCrumb])

fsUp :: FSZipper -> FSZipper
fsUp (item, FSCrumb name ls rs:bs) =  (Folder name (ls ++ [item] ++ rs), bs)


fsTo :: Name -> FSZipper -> FSZipper
fsTo name (Folder folderName items, bs) =
  let (ls, item:rs) = break (nameIs name) items
  in (item, FSCrumb folderName ls rs:bs)

fsRename :: Name -> FSZipper -> FSZipper
fsRename newName (Folder name items, bs) = (Folder newName items, bs)
fsRename newName (File name dat, bs) = (File newName dat, bs)

fsNewFile :: FSItem -> FSZipper -> FSZipper
fsNewFile item (Folder folderName items, bs)
  = (Folder folderName (item:items), bs)

nameIs :: Name -> FSItem -> Bool
nameIs name (Folder folderName _) = name == folderName
nameIs name (File fileName _) = name == fileName

newFocus5 = (myDisk,[]) -: fsTo "pics" -: fsTo "skull_man(scary).bmp"
newFocus6 = newFocus5 -: fsUp -: fsTo "watermelon_smash.gif"
newFocus7 = (myDisk,[]) -: fsTo "pics" -: fsRename "cspi" -: fsUp
newFocus8 = (myDisk,[]) -: fsTo "pics" -: fsNewFile (File "heh.jpg" "lol") -: fsUp

coolTree = Node 1 Empty (Node 3 Empty Empty)
focus = return (coolTree,[]) >>= goRight
focus1 = return (coolTree, []) >>= goRight >>= goRight
focus2 = return (coolTree,[]) >>= goRight >>= goRight >>= goRight

main
  = print newFocus
  >> print focus
  >> print focus1
  >> print focus2
