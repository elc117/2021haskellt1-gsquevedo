import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)
type Circle    = (Point,Float)
type Triangle  = (Point,Point,Point)

--------------------------------------------------------------------
-- Informações da imagem 
--------------------------------------------------------------------
maxLargura :: Float
maxLargura = 800

maxAltura :: Float
maxAltura = 500

---------------------------------------------------------------------
-- Informaçoes das figuras
--------------------------------------------------------------------
maxRaio :: Float
maxRaio = 10

numTriangulos :: Int
numTriangulos = 10

numCirculos :: Int
numCirculos = 5

numRetangulo :: Int
numRetangulo = 5

maxLado :: Int
maxLado = 50

--------------------------------------------------------------------
-- Paletas de cores
--------------------------------------------------------------------
rgbRetangulo :: Int -> [(Int,Int,Int)]
rgbRetangulo n = [(i*a,a,i*a) | i <- take n(iterate(+b)a)]
  where a = maxLado 
        b = 10

rgbCirculo :: Int -> [(Int,Int,Int)]
rgbCirculo n = [(i*a, a+i, i-a) | i <- take n(iterate(+15)a)]
  where a = corCirc maxRaio

rgbTriangulo :: Int -> [(Int,Int,Int)]
rgbTriangulo n = [(i*a,a*b,i+a) | i <- take n(iterate(+b)a)]
  where a = corTri numTriangulos
        b = 10

------------------------------------------------------------------------
--- Funções utilizadas para formar as figuras
--------------------------------------------------------------------

--retorna um raio a cada valor
raioAleatorio :: Float -> Float
raioAleatorio r = 2*pi+maxRaio

--convert valores int para float
convTri :: Float
convTri = fromIntegral numTriangulos

convLado :: Float
convLado = fromIntegral maxLado

--funçao muda a cor do circulo
corCirc :: Float -> Int
corCirc maxRaio
  |(maxRaio >= 5 && maxRaio < 10) = 0
  |(maxRaio >= 10 && maxRaio < 15) = 5
  |otherwise = 50

corTri :: Int -> Int
corTri numTriangulos 
  |(numTriangulos >= 1 && numTriangulos <= 5) = 5
  |(numTriangulos > 5 && numTriangulos <= 10) = 10
  |(numTriangulos > 10 && numTriangulos <= 15) = 15
  |otherwise = 20
 
--------------------------------------------------------------------
-- Geração de circulos  em suas posições
--------------------------------------------------------------------
genRetanguloInLine :: Int -> [Rect]
genRetanguloInLine n  = [((maxLargura-convLado*m-100, 100*m), maxLargura, maxAltura) | m <- [0..fromIntegral (n-1)]]

genCircleInLine :: Int -> [Circle] 
genCircleInLine n = [((100,y), raioAleatorio maxRaio*m) | m <- [1..fromIntegral (n)]]
  where y = 150

genTrianguloInLine :: Int -> [Triangle]
genTrianguloInLine n = [((maxAltura/2, m*maxAltura/convTri),(maxAltura, maxAltura/2),(maxAltura/2+100, maxAltura/2)) | m <- [0..fromIntegral(n-1)]]

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

----------------------------------------------------------------------
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
svgStyleRetangulo (r,g,b) = "fill:rgb"++show(r,g,b)++";"++"mix-blend-mode:difference;stroke:rgb(0,0,0);stroke-width:3;"

svgStyleCirculo :: (Int,Int,Int) -> String
svgStyleCirculo (r,g,b) = "fill:rgb"++show(r,g,b)++";"++"mix-blend-mode:screen;"

--------------------------------------------------------------------
-- Gera strings SVG para uma dada lista de figuras e seus atributos de estilo
--------------------------------------------------------------------
svgElements :: (a -> String -> String) -> [a] -> [String] -> String
svgElements func elements styles = concat $ zipWith func elements styles

---------------------------------------------------------------------- FUNÇÃO PRINCIPAL
--------------------------------------------------------------------
main :: IO ()
main = do
  writeFile "figura.svg" $ svgstrs
  where svgstrs = svgBegin w h  ++ svgTriangle ++ svgCircle ++ svgRect ++ svgEnd  
        svgTriangle = svgElements svgTriangulo triangulo (map svgStyleTriangulo corTriangulo)
        triangulo = genTrianguloInLine ntriangulo
        corTriangulo = rgbTriangulo ntriangulo
        ntriangulo = numTriangulos

        svgCircle = svgElements svgCirculo circle (map svgStyleCirculo corCircle)
        circle = genCircleInLine ncircle
        corCircle = rgbCirculo ncircle
        ncircle = numCirculos

        svgRect = svgElements svgRetangulo retangulo (map svgStyleRetangulo corRetangulo)
        retangulo = genRetanguloInLine nretangulo
        corRetangulo = rgbRetangulo nretangulo
        nretangulo = numRetangulo

        (w,h) = (maxLargura,maxAltura) -- largura e altura da imagem SVG 
