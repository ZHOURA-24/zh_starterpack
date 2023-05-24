# zh-vehbox
Items for new players Claim vehicles
# Preview
-- OLD PREVIEW
https://youtu.be/2cL1qGVKyWw

if use garage change in fx.manifest.lua

 Add this in qb-core/shared/item.lua
['boxvehicle'] 				 	 = {['name'] = 'boxvehicle', 			  	  		['label'] = 'Box Vehicle', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'boxvehicle.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Box Vehicle'},

["boxvehicle"] = {
    label = "Box Vehicle",
    weight = 200,
    stack = true,
},
