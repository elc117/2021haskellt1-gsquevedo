module Main where
import FormaFigura 
import Text.Printf

main :: IO ()
main = do
  writeFile "figura.svg" $ figura
  where figura = svgBegin w h ++ svgCirculo ++ svgRetangulo ++ svgStar ++ svgEnd
        svgCirculo = svgElements svgCircle circulo (map svgStyleCirculo cores)
        circulo = genCirclesInLine ncirculo
        cores = rgbCirculo ncirculo
        ncirculo = 1

        svgRetangulo = svgElements svgRect rect (map svgStyleRetangulo palette)
        rect = genRectsInLine nreact
        palette = rgbRetangulo nreact
        nreact = 1

        svgStar= svgElements svgEstrela estrela (map svgStyleEstrela corEstrela)
        estrela = genEstrelaInLine nestrela
        corEstrela = rgbEstrela nestrela
        nestrela = 1

        (w,h) = (800,900)
