# jLib: Library to make coding with ESX more easy

# Usage
-Import the lib in your resource:
```lua
--In Your fxmanifest (At the top)
shared_scripts {
	"@jLib/import.lua"
}
```
-RageUI:
```lua
local menu = RageUI.CreateMenu("Test Menu", "SubTitle")

menu:isVisible(function(item)
	item:Separator("Separator")
	item:Button("Test Button", "Desription", {LeftBadge = RageUI.BadgeStyle.Star}, true, {
		onSelected = function()
			print("onSelected")
		end
	})
	item:Line()
end)

RegisterCommand("menu", function() menu:toggle() end)
```

![RageUI Preview](https://cdn.discordapp.com/attachments/979186074347794452/1011980745255948288/menuRageUI.png)
