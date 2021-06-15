
import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)
type Circle    = (Point,Float)
type Triangle  = (Point,Point,Point)

--------------------------------------------------------------------
-- Paletas de cores
--------------------------------------------------------------------
rgbRetangulo :: Int -> [(Int,Int,Int)]
rgbRetangulo n = [(0,0,40*i) | i <- [1..n]]

rgbCirculo :: Int -> Int -> [(Int,Int,Int)]
rgbCirculo n raio = [(i*a,a*10,i+a) | i <- take n(iterate(+10)a)]
  where a = corCirc raio
      
rgbTriangulo :: Int -> [(Int,Int,Int)]
rgbTriangulo n = [(i*a,a*b,i+a) | i <- take n(iterate(+b)a)]
  where a = corTri n
        b = 10

--------------------------------------------------------------------
--- Funções utilizadas para formar as figuras
--------------------------------------------------------------------
--retorna um raio a cada valor
raioAleatorio :: Float -> Float
raioAleatorio r = 2*pi+r

--funçao muda a cor do circulo
corCirc :: Int -> Int
corCirc maxRaio
  |(maxRaio >= 5 && maxRaio < 10) = 5 
  |(maxRaio >= 10 && maxRaio < 15) = 15 
  |(maxRaio >= 15 && maxRaio < 20) = 5
  |otherwise = 0 

corTri :: Int -> Int
corTri numTriangulos 
  |(numTriangulos >= 1 && numTriangulos <= 5) = 3
  |(numTriangulos > 5 && numTriangulos <= 10) = 15
  |(numTriangulos > 10 && numTriangulos <= 15) = 5
  |otherwise = 10


--------------------------------------------------------------------
-- Geração de circulos  em suas posições
--------------------------------------------------------------------

genRetanguloInLine :: Int -> Float -> [Rect]
genRetanguloInLine n largura = [((m*(w+gap), (largura/2)), w, h) | m <-  [0..fromIntegral (n-1)]]
  where (w,h) = (50,50)
        gap = 10

genRectInLine :: Int -> Float -> Float -> Float ->  [Rect]
genRectInLine n largura w h = [((largura-100,m*(w+gap)),w,h) | m <- [0..fromIntegral(n-1)]]
  where gap = 10

genCircleInLine :: Int -> Int -> (Float,Float) -> [Circle] 
genCircleInLine n raio (x,y) = [((x,y), raioAleatorio (fromIntegral raio)*m) | m <- [1..fromIntegral (n)]]

genTrianguloInLine :: Int -> Float -> Int -> [Triangle]
genTrianguloInLine n altura num = [((altura/2,m*altura/(fromIntegral num)),(altura, altura/2),(altura/2+100, altura/2)) | m <- [0..fromIntegral(n-1)]]

--------------------------------------------------------------------
-- Strings SVG
--------------------------------------------------------------------
svgRetangulo :: Rect -> String -> String 
svgRetangulo ((x,y),w,h) style = 
  printf "<rect x='%.3f' y='%.3f' width='%.2f' height='%.2f' style='%s' />\n" x y w h style

svgCirculo :: Circle -> String -> String 
svgCirculo ((x,y),r) style = 
  printf "<circle cx='%.3f' cy='%.3f' r='%.3f' style='%s'/>\n" x y r style

svgTriangulo :: Triangle -> String -> String
svgTriangulo ((x1,y1),(x2,y2),(x3,y3)) style =
  printf "<polygon points = '%.3f,%.3f %.3f,%.3f %.3f,%.3f' style='%s' />\n" x1 y1 x2 y2 x3 y3 style

----------------------------------------------------------------------
-- String inicial do SVG
--------------------------------------------------------------------
svgBegin :: Float -> Float -> String
svgBegin w h = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 

--------------------------------------------------------------------
-- String final do SVG
--------------------------------------------------------------------
svgEnd :: String
svgEnd = "</svg>"

--------------------------------------------------------------------
-- Gera string com atributos de estilo para uma dada cor
--------------------------------------------------------------------
svgStyleTriangulo :: (Int,Int,Int) -> String
svgStyleTriangulo (r,g,b) = "fill:rgb"++show(r,g,b)++";"++"stroke-width:5;stroke:rgb(0,0,0);"

svgStyleRetangulo :: (Int,Int,Int) -> String
svgStyleRetangulo (r,g,b) = "fill:rgb"++show(r,g,b)++";"++"mix-blend-mode:normal;"

svgStyleCirculo :: (Int,Int,Int) -> String
svgStyleCirculo (r,g,b) = "fill:rgb"++show(r,g,b)++";"++"mix-blend-mode:screen;"

--------------------------------------------------------------------
-- Gera strings SVG para uma dada lista de figuras e seus atributos de estilo
--------------------------------------------------------------------
svgElements :: (a -> String -> String) -> [a] -> [String] -> String
svgElements func elements styles = concat $ zipWith func elements styles

--------------------------------------------------------------------
-- FUNÇÃO PRINCIPAL
--------------------------------------------------------------------
main :: IO ()
main = do
    putStrLn "Informe a largura e a altura da imagem:"
    largura <- getLine
    altura <- getLine
    putStrLn "Informe o número de circulos:"
    numCirculos <- getLine
    putStrLn "Informe o número de triângulos:"
    numTriangulos <- getLine
    putStrLn "Informe  o número de retângulos:"
    numRetangulo <- getLine 
    putStrLn "Informe o raio do círculo:"
    raio <- getLine
    putStrLn "Informe a posicao (x,y) do circulo:"
    x <- getLine 
    y <- getLine
    putStrLn "Informe  a altura e largura do retângulo:"
    alt <- getLine 
    larg <- getLine
    let svgstrs = svgBegin w h  ++ svgTriangle ++ svgCircle ++ svgRect ++ svgReact ++ svgEnd  
        svgTriangle = svgElements svgTriangulo triangulo (map svgStyleTriangulo corTriangulo)
        triangulo = genTrianguloInLine ntriangulo h ntriangulo
        corTriangulo = rgbTriangulo ntriangulo
        ntriangulo = read numTriangulos

        svgCircle = svgElements svgCirculo circle (map svgStyleCirculo corCircle)
        circle = genCircleInLine ncircle (read raio) (read x,read y)
        corCircle = rgbCirculo ncircle (read raio)
        ncircle = read numCirculos

        svgRect = svgElements svgRetangulo retangulo (map svgStyleRetangulo corRetangulo)
        retangulo = genRetanguloInLine nretangulo w
        corRetangulo = rgbRetangulo nretangulo 
        nretangulo = read numRetangulo

        svgReact = svgElements svgRetangulo rect (map svgStyleRetangulo corRect)
        rect = genRectInLine nrect w (read larg) (read alt)
        corRect = rgbRetangulo nrect 
        nrect = read numRetangulo

        (w,h) = (read largura,read altura) -- largura e altura da imagem SVG 
      in writeFile "figura.svg" $ svgstrs  
