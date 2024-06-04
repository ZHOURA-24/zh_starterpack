# zh_starterpack

updated of (zh-vehbox)

Starter pack for new player

## Preview
![Screenshot 2024-06-04 070711](https://github.com/ZHOURA-24/zh_starterpack/assets/98719591/1be1e810-34b9-4185-8eea-472173f2eee7)

## Installation


### Install all resource dependencies
- [ox_lib](https://github.com/overextended/ox_lib)

### Clone a repository or [download](https://github.com/ZHOURA-24/zh_starterpack) here

```
git clone https://github.com/ZHOURA-24/zh_starterpack
```

### Add item
ox_inventory
```
	["box_starterpack"]          = {
		label = "Starter Pack",
		weight = 100,
		stack = true,
		client = {
			export = 'zh_starterpack.box_starterpack'
		}
	},
```
qb-inventory
```
    box_starterpack = {
         name = 'box_starterpack',
         label = 'Starter Pack',
         weight = 0,
         type = 'item',
         image = 'box_starterpack.png',
         unique = false,
         useable = true,
         shouldClose = true,
         combinable = nil,
         description = 'Starter pack'
    },
```
esx
```
INSERT INTO `items` (name, label, weight) VALUES
	('box_starterpack', 'Starterpack', 1)
;
```

### Start resource

```
start zh_starterpack
```
  
