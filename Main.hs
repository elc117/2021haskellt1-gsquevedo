
module Main where
import Text.Printf
import FormaFigura
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
