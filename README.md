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

![RageUI Preview](#%20jLib:%20Library%20to%20make%20coding%20with%20ESX%20more%20easy%20%20#%20Usage%20-Import%20the%20lib%20in%20your%20resource:%20%60%60%60lua%20--In%20Your%20fxmanifest%20%28At%20the%20top%29%20shared_scripts%20%7B%20%09%22@jLib/import.lua%22%20%7D%20%60%60%60%20-RageUI:%20%60%60%60lua%20local%20menu%20=%20RageUI.CreateMenu%28%22Test%20Menu%22,%20%22SubTitle%22%29%20%20menu:isVisible%28function%28item%29%20%09item:Separator%28%22Separator%22%29%20%09item:Button%28%22Test%20Button%22,%20%22Desription%22,%20%7BLeftBadge%20=%20RageUI.BadgeStyle.Star%7D,%20true,%20%7B%20%09%09onSelected%20=%20function%28%29%20%09%09%09print%28%22onSelected%22%29%20%09%09end%20%09%7D%29%20%09item:Line%28%29%20end%29%20%20RegisterCommand%28%22menu%22,%20function%28%29%20menu:toggle%28%29%20end%29%20%60%60%60%20%5BRageUI%20Preview%5D%28https://cdn.discordapp.com/attachments/979186074347794452/1011980745255948288/menuRageUI.png%29)
