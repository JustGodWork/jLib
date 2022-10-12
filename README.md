# jLib: Library to make coding with ESX more easy

# Features

 - `UUID's`
 - `RageUI integrated 0MS closed`
 - `Utils (KeyboardInput, DrawText3D etc...)`
 - `Client Side player (Auto updated, replacing ESX.PlayerData)`
 - `Events system (Replacing RegisterNetEvent etc...)`
 - `Many others things...`


# Usage
-Import the lib in your resource:
```lua
--In Your fxmanifest (At the top)
shared_scripts {
	"@jLib/lang.lua",
	"@jLib/import.lua"
}
```
![RageUI Preview](https://cdn.discordapp.com/attachments/979186074347794452/1011980745255948288/menuRageUI.png)

-RageUI:
```lua
local main = RageUI.CreateMenu("ExampleMenu", "This is an example menu");
local sub = RageUI.CreateSubMenu(main, "ExampleSubMenu", "This is an example submenu");

main:isVisible(function(items)

    items:Separator("This is a separator");

    items:Button("My button #1", "Example description", {LeftBadge = RageUI.BadgeStyle.Star}, true,{
        onSelected = function()
            print("Selected");
        end
    }, sub);

    items:Button("My button #2", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
        onSelected = function()
            print("Selected");
        end
    });

    items:Button("My button #3", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightBadge = RageUI.BadgeStyle.Star}, true,{
        onSelected = function()
            print("Selected");
        end
    });

    items:Button("My button #4", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = "Example rightlabel"}, true,{
        onSelected = function()
            print("Selected");
        end
    });
end);

local list1 = 1;
local list2 = 1;
local checked = false;
sub:isVisible(function(items)

    items:Button("My button #1", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true,{
        onSelected = function()
            print("Selected");
        end
    });

    items:List("My List #1", { "Example Index #1", "Example Index #2", "Example Index #3" }, list1, nil, {LeftBadge = RageUI.BadgeStyle.Star, RightBadge = RageUI.BadgeStyle.Star}, true, {
        onListChange = function(Index, Item)
            print(Index, Item);
            list1 = Index;
        end,
        onSelected = function()
            print(list1)
            print("Selected");
        end
    });

    items:List("My List #2", { "Example Index #1", "Example Index #2", "Example Index #3" }, list2, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {
        onListChange = function(Index, Item)
            print(Index, Item);
            list2 = Index;
        end,
        onSelected = function()
            print(list2);
            print("Selected");
        end
    });

    items:Checkbox("My checkbox", nil, checked, {LeftBadge = RageUI.BadgeStyle.Star}, {
        onSelected = function(Checked)
            checked = Checked;
        end,
        onChecked = function()
            print("Selected");
        end,
        onUnChecked = function()
            print("Unselected");
        end,
    });
end);

RegisterCommand("openex", function()
    main:toggle();
end);
```
