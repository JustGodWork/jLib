# jLib: Library to make coding with ESX more easy

# Usage
-Import the lib in your resource:
```lua
--In Your fxmanifest (At the top)
shared_scripts {
	"@jLib/import.lua"
}
```
![RageUI Preview](https://cdn.discordapp.com/attachments/979186074347794452/1011980745255948288/menuRageUI.png)

-RageUI:
```lua
local main = RageUI.CreateMenu("ExampleMenu", "This is an example menu")
local sub = RageUI.CreateSubMenu(main, "ExampleSubMenu", "This is an example submenu")
local heritage = RageUI.CreateSubMenu(main, "ExampleHeritage", "This is an example heritage")
local sliders = RageUI.CreateSubMenu(main, "ExampleSliders", "This is an example sliders")

main:isVisible(function(items)

    items:Separator("This is a separator")

    items:Button("My button #1", "Example description", {LeftBadge = RageUI.BadgeStyle.Star}, true,{
        onSelected = function()
            print("Selected")
        end
    }, sub)

    items:Button("My button #2", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
        onSelected = function()
            print("Selected")
        end
    })

    items:Button("My button #3", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightBadge = RageUI.BadgeStyle.Star}, true,{
        onSelected = function()
            print("Selected")
        end
    })

    items:Button("My button #4", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "Example rightlabel"}, true,{
        onSelected = function()
            print("Selected")
        end
    })

    items:Button("Héritage menu", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
        onSelected = function()
            print("Selected")
        end
    }, heritage)

    items:Button("Sliders menu", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
        onSelected = function()
            print("Selected")
        end
    }, sliders)
end)

local list1 = 1
local list2 = 1
local checked = false
sub:isVisible(function(items)

    items:Button("My button #1", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
        onSelected = function()
            print("Selected")
        end
    })

    items:List("My List #1", { "Example Index #1", "Example Index #2", "Example Index #3" }, list1, nil, {LeftBadge = RageUI.BadgeStyle.Star, RightBadge = RageUI.BadgeStyle.Star}, true, {
        onListChange = function(Index, Item)
            print(Index, Item)
            list1 = Index 
        end,
        onSelected = function()
            print(list1)
            print("Selected")
        end
    })

    items:List("My List #2", { "Example Index #1", "Example Index #2", "Example Index #3" }, list2, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {
        onListChange = function(Index, Item)
            print(Index, Item)
            list2 = Index
        end,
        onSelected = function()
            print(list2)
            print("Selected")
        end
    })

    items:Checkbox("My checkbox", nil, checked, {LeftBadge = RageUI.BadgeStyle.Star}, {
        onSelected = function(Checked)
            checked = Checked
        end,
        onChecked = function()
            print("Selected")
        end,
        onUnChecked = function()
            print("Unselected")
        end,
    })
end)

local hIndex = 0.5
local dadIndex = 1
local momIndex = 1
heritage:isVisible(function(items)

    items:Heritage(momIndex, dadIndex)

    items:List("Dad", RageUI.GenerateList(1, 23), dadIndex, nil, {}, true, {
        onListChange = function(Index, Item)
            print(Index, Item)
            dadIndex = Index
        end,
        onSelected = function()
            print(dadIndex)
            print("Selected")
        end
    })

    items:List("Mom", RageUI.GenerateList(1, 21), momIndex, nil, {}, true, {
        onListChange = function(Index, Item)
            print(Index, Item)
            momIndex = Index
        end,
        onSelected = function()
            print(momIndex)
            print("Selected")
        end
    })

    items:UISliderHeritage("My slider Héritage", hIndex, nil, {
        onSliderChange = function(IndexDividend, Index)
            hIndex = Index
            print(IndexDividend, Index) 
        end,
    }, 0.5)
end)

local colourIndex = 1
local sProgress = 0.0
sliders:isVisible(function(items)

    items:Slider("My slider", colourIndex, 4, nil,5.0, {}, true, {
        onSliderChange = function(Index)
            colourIndex = Index
            print(Index) 
        end,
    })

    items:SliderProgress("My slider progress", sProgress, 100, nil,{}, true, {
        onSliderChange = function(Index)
            sProgress = Index
            print(Index) 
        end,
    })
end, function(Panels)
    Panels:ColourPanel("My Colour Panel", { 
            { 200, 200, 100, 255}, 
            { 100, 150, 150, 255}, 
            { 250, 100, 200, 255}, 
            { 150, 250, 250, 255} 
        }, 1, colourIndex, {
        onColorChange = function(minimumIndex, CurrentIndex)
            colourIndex = CurrentIndex
            print(minimumIndex, CurrentIndex) 
        end,
    })
    Panels:BoutonPanel("My button Panel #1", "My Button Panel #1 RightText")
    Panels:BoutonPanel("My button Panel #2", "My Button Panel #2 RightText")

    Panels:StatisticPanel(0.5, "My Statistic Panel")
    Panels:StatisticPanel(0.2, "My Second Statistic Panel")
end)

RegisterCommand("openex", function()
    main:toggle()
end)
```
