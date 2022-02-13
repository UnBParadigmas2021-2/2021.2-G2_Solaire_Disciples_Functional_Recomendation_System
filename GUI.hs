import Graphics.UI.Gtk

-- minha função 
main :: IO () 
main = do
    initGUI -- função para chamar a lib
    window <- windowNew -- cria a janela
    set window [windowTitle := "Sistema de Recomanção de Amigos",
                containerBorderWidth := 10,
                windowDefaultWidth  := 800,
                windowDefaultHeight := 400]
    button <- buttonNewWithLabel ""

    label_option <- labelNew (Just "Choose an option: ")

    fonte_label_option <- fontDescriptionFromString "Sans Bold 14"

    widgetModifyFont label_option (Just fonte_label_option)

    widgetModifyFg label_option StateNormal (Color 0 0 0xffff)

    entry_option <- entryNew

    lay <- vBoxNew False 0

    containerAdd lay label_option

    containerAdd window lay 

    
    onDestroy window mainQuit -- função para fechar a janela

    widgetShowAll window -- mostra a janela com as options


    mainGUI -- loop da aplicação


    