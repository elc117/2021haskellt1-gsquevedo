module FormaFigura where
import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)
type Circle    = (Point,Float)
type Triangle  = (Point,Point,Point)
type Estrela   = (Point,Point,Point,Point,Point)
-------------------------------------------------------------------------------
-- Paletas
-------------------------------------------------------------------------------

-- Paleta (R, G, B) só com tons de verde "hard-coded" 
-- (pode ser melhorado substituindo os valores literais por parâmetros)
-- Além disso, o que acontecerá se n for muito grande ou negativo?

greenPalette :: Int -> [(Int,Int,Int)]
greenPalette n = [(0, 50+i*10, 0) | i <- [0..n] ]

-- Paleta com n valores retirados de uma lista com sequências de R, G e B 
-- O '$' é uma facilidade sintática que substitui parênteses
-- O cycle é uma função bacana -- procure saber mais sobre ela :-)

rgbRetangulo :: Int -> [(Int,Int,Int)]
rgbRetangulo n = take n $ cycle [(55,255,15),(135,240,255),(255,15,0)]

rgbCirculo :: Int -> [(Int,Int,Int)]
rgbCirculo n = take n $ cycle [(50,0,0),(0,255,0),(0,0,255)]

rgbEstrela :: Int -> [(Int,Int,Int)]
rgbEstrela n = take n $ cycle [(155,0,0),(255,255,255),(0,255,255)]

rgbTriangulo :: Int -> [(Int,Int,Int)]
rgbTriangulo n = take n $ cycle [(100,0,0),(255,255,255),(0,255,255)]

-------------------------------------------------------------------------------
-- Geração de retângulos e circulos  em suas posições
-------------------------------------------------------------------------------

genRectsInLine :: Int -> [Rect]
genRectsInLine n  = [((50, 50), w, h) | m <- [0..fromIntegral (n-1)]]
  where (w,h) = (150,150)
        gap = 10

genCirclesInLine :: Int -> [Circle]
genCirclesInLine n  = [((x,y), r) | m <- [0..fromIntegral (n-1)]]
  where r = 50
        gap = 10
        y = 350
        x = 500

genTriangleInLine :: Int -> [Triangle]
genTriangleInLine n = [((800,100),(350,500),(800,750)) | m <- [0..fromIntegral (n-1)]]
  where gap = 100

genTrianguloInLine :: Int -> [Triangle]
genTrianguloInLine n = [((650,450),(0,650),(0,150)) | m <- [0..fromIntegral (n-1)]]
  where gap = 100

genEstrelaInLine :: Int -> [Estrela]
genEstrelaInLine n = [((230,140),(170,328),(320,208),(140,208),(290,328)) | m <- [0..fromIntegral(n-1)]]
  where gap = 100
-------------------------------------------------------------------------------
-- Strings SVG
-----------------------------------------------------------------------------
                
-- Gera string representando retângulo e circulos SVG 
-- dadas coordenadas e dimensões do retângulo e uma string com atributos de estilo

svgRect :: Rect -> String -> String 
svgRect ((x,y),w,h) style = 
  printf "<rect x='%.3f' y='%.3f' width='%.2f' height='%.2f' style='%s' />\n" x y w h style

svgCircle :: Circle -> String -> String 
svgCircle ((x,y),r) style = 
  printf "<circle cx='%.3f' cy='%.3f' r='%.3f' fill='%s'  stroke='yellow' stroke-width='100'/>\n" x y r style

svgTriangle :: Triangle -> String -> String
svgTriangle ((x1,y1),(x2,y2),(x3,y3)) style =
  printf "<polygon points = '%.3f,%.3f %.3f,%.3f %.3f,%.3f' style='%s' />\n" x1 y1 x2 y2 x3 y3 style

svgEstrela :: Estrela -> String -> String
svgEstrela ((x1,y1),(x2,y2),(x3,y3),(x4,y4),(x5,y5)) style =
  printf "<polygon points='%.3f,%.3f %.3f,%.3f %.3f,%.3f %.3f,%.3f %.3f,%.3f' style='%s' stroke='purple' stroke-width='5' fill-rule='evenodd' />\n" x1 y1 x2 y2 x3 y3 x4 y4 x5 y5 style

-- String inicial do SVG
svgBegin :: Float -> Float -> String
svgBegin w h = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 

-- String final do SVG
svgEnd :: String
svgEnd = "</svg>"

-- Gera string com atributos de estilo para uma dada cor
-- Atributo mix-blend-mode permite misturar cores

svgStyleRetangulo :: (Int,Int,Int) -> String
svgStyleRetangulo (r,g,b) = printf "fill:rgb(%d,%d,%d); mix-blend-mode: luminosity;" r g b

svgStyleCirculo :: (Int,Int,Int) -> String
svgStyleCirculo (r,g,b) = printf "rfill:gb(%d,%d,%d); mix-blend-mode: screen" r g b

svgStyleTriangle :: (Int,Int,Int) -> String
svgStyleTriangle (r,g,b) = printf "fill:rgb(%d,%d,%d); stroke-width:2; stroke:rgb(0,0,0);" r g b

svgStyleEstrela :: (Int,Int,Int) -> String
svgStyleEstrela (r,g,b) = printf "fill:rgb(%d,%d,%d); stroke-width:2; stroke:rgb(0,0,0);" r g b

-- Gera strings SVG para uma dada lista de figuras e seus atributos de estilo
-- Recebe uma função geradora de strings SVG, uma lista de círculos/retângulos e strings de estilo

svgElements :: (a -> String -> String) -> [a] -> [String] -> String
svgElements func elements styles = concat $ zipWith func elements styles
