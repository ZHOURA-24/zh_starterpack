# zh-vehbox
Items for new players Claim vehicles
Preview
https://youtu.be/2cL1qGVKyWw

If Using a Different Garage Can Change In the fx.manifest.lua
'@qb-garages/config.lua'

Add this in qb-core/shared/item.lua
['boxvehicle'] 				 	 = {['name'] = 'boxvehicle', 			  	  		['label'] = 'Box Vehicle', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'boxvehicle.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Box Vehicle'},
