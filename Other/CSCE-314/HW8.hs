----------
-- eval --
----------
type Memory = [(String, WValue)]

marker = ("|", VMarker)
isMarker (x, _) = x == "|"

eval :: WExp -> Memory -> WValue

eval (Val v) _ = v

eval (Var s) m =
  case lookup s m of
    Nothing -> error $ "Unknown variable " ++ s ++ " in memory " ++ show m
    Just v -> v

eval (Plus e1 e2) m =
  let e1' = eval e1 m
      e2' = eval e2 m
  in
   VInt $ asInt e1' + asInt e2'

eval (Minus e1 e2) m =
  let e1' = eval e1 m
      e2' = eval e2 m
  in
   VInt $ asInt e1' - asInt e2'

eval (Multiplies e1 e2) m =
  let e1' = eval e1 m
      e2' = eval e2 m
  in
   VInt $ asInt e1' * asInt e2'

eval (Divides e1 e2) m =
  let e1' = eval e1 m
      e2' = eval e2 m
  in
   VInt $ asInt e1' `div` asInt e2'

eval (Equals e1 e2) m =
  let e1' = eval e1 m
      e2' = eval e2 m
  in
   VBool $ e1' == e2'

eval (NotEqual e1 e2) m = VBool $ not $ asBool $ eval (Equals e1 e2) m

eval (Less e1 e2) m =
  let e1' = eval e1 m
      e2' = eval e2 m
  in
   VBool $ asInt e1' < asInt e2'

eval (LessOrEqual e1 e2) m =
  let e1' = eval e1 m
      e2' = eval e2 m
  in
   VBool $ asInt e1' <= asInt e2'

eval (Greater e1 e2) m =
  let e1' = eval e1 m
      e2' = eval e2 m
  in
   VBool $ asInt e1' > asInt e2'

eval (GreaterOrEqual e1 e2) m =
  let e1' = eval e1 m
      e2' = eval e2 m
  in
   VBool $ asInt e1' >= asInt e2'

eval (And e1 e2) m | not (asBool (eval e1 m)) = VBool False
                   | otherwise = VBool (asBool (eval e2 m))

eval (Or e1 e2) m | asBool (eval e1 m) = VBool True
                  | otherwise = VBool (asBool (eval e2 m))

eval (Not e) m = VBool $ not $ asBool $ eval e m

----------
-- exec --
----------
exec :: WStmt -> Memory -> IO Memory
exec Empty m = return m

exec (VarDecl s e) m | not (definedInThisScope m) = return $ (s, eval e m) : m
                     | otherwise = error $ "Variable " ++ s ++ " already defined in this scope"
    where
      definedInThisScope (hd@(d, _):ds) | isMarker hd = False
                                        | d == s = True
                                        | otherwise = definedInThisScope ds                                              

exec (Assign s e) m = return $ replaceFirstDef (eval e m) m
    where replaceFirstDef _ [] = error $ "Undefined variable " ++ s ++ " in assignment"
          replaceFirstDef v (hd@(n, _):m) | n == s = (n, v):m
                                          | otherwise = hd:replaceFirstDef v m 

exec (If e s1 s2) m | eval e m == VBool True = exec s1 m
                    | eval e m == VBool False = exec s2 m
                    | otherwise = error "Non-boolean in condition of if"

exec (While e s) m | eval e m == VBool True = exec s m >>= \m' ->
                                              exec (While e s) m'  
                   | eval e m == VBool False = return m
                   | otherwise = error "Non-boolean in condition of while"

exec (Block ss) m = bexec ss (marker:m) >>= \m' -> return (popMarker m')
    where bexec [] m = return m
          bexec (s:ss) m = exec s m >>= \m' ->
                           bexec ss m'
          popMarker [] = []
          popMarker (x:xs) | isMarker x = xs
                           | otherwise = popMarker xs

exec (Print e) m = putStr (show (eval e m)) >> return m

wprogram :: Parser WStmt

expr = term >>= termSeq

termSeq left = ( (symbol "+" +++ symbol "-") >>= \s ->
                 term >>= \right ->
                 termSeq ((toOp s) left right)
               ) +++ return left

term = factor >>= factorSeq 

factorSeq left = ( (symbol "*" +++ symbol "/") >>= \s ->
                   factor >>= \right ->
                   factorSeq ((toOp s) left right)
                 ) +++ return left

factor = ( nat >>= \i ->
           return (Val (VInt i))
         ) +++ parens expr

toOp "+" = Plus
toOp "-" = Minus
toOp "*" = Multiplies
toOp "/" = Divides

main = do
  args <- getArgs -- get the command line arguments

  let (a:as) = args
  let debug = a == "-d"
  let fileName = if debug then head as else a

  str <- readFile fileName

  let prog = parse wprogram str 

  let ast = case prog of 
              [(p, [])] -> p
              [(_, inp)] -> error ("Unused program text: " 
                                   ++ take 256 inp) -- this helps in debugging
              [] -> error "Syntax error"
              _ -> error "Ambiguous parses"
  result <- exec ast []

  when debug $ print "AST:" >> print prog
  when debug $ print "RESULT:" >> print result