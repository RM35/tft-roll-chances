extends Control

var champs = {"Aatrox": 1,
"Ezreal": 1,
"Heimerdinger": 1,
"Karma": 1, 
"Leona": 1, 
"Nidalee": 1, 
"Sejuani": 1, 
"Senna": 1, 
"Sett": 1,
"Skarner": 1, 
"Tahm": 1,
"Taric": 1, 
"Vladimir":1 ,
"Anivia": 3,
"Ashe": 2,
"Braum": 2, 
"Gnar": 2,
"Jinx": 2,
"Kayn": 2,
"Lillia": 2, 
"Nami": 2,
"Qiyana": 2, 
"Shen": 2,
"Thresh": 2, 
"Tristana": 2,
"Twitch": 2, 
"Yone": 2,
"Diana": 3, 
"Elise": 3, 
"Illaoi": 3, 
"Lee": 3, 
"Lulu": 3,
"Nunu": 3,
"Olaf": 3,
"Ryze": 3,
"Swain": 3, 
"Sylas": 3, 
"Varus": 3, 
"Volibear": 3,
"Corki": 4,
"Hecarim": 4, 
"Neeko": 4, 
"Ornn": 4,
"Sona": 4, 
"Talon": 4, 
"Xayah": 4, 
"Bard": 5, 
"Pyke": 5, 
"Soraka": 5, 
"Yasuo": 5, 
"Zoe": 5,
"Daeja": 8,
"Idas": 8,
"Shi": 8,
"Syfen": 8,
"Shin": 10,
"Aurelion": 10,
"Shyvana": 10}

var chance = {1: [100, 0, 0, 0, 0],
2: [100, 0, 0, 0, 0],
3: [75 ,25, 0, 0, 0],
4: [55 ,30, 15, 0, 0],
5: [45 , 33, 20, 2, 0],
6: [25 , 40, 30, 5, 0],
7: [19 , 30, 35, 15, 1],
8: [16 , 20, 35, 25, 4],
9: [9 , 15, 30, 30, 16],
10: [5, 10, 20, 40, 25]}

var champs_count = {}
var level =  1
var TOTAL_CHAMPS = 0

func _ready():
	TOTAL_CHAMPS = (13 * 29) + (13 * 22) + (13 * 18) + (7 * 12) + (5 * 10) + (4 * 12) + (3 * 10)
	var display_string = ""
	reset_levels()
	_on_Button_pressed()
	$LEVEL.text = "LEVEL: " + str(level)
	
func reset_levels():
	for unit in champs:
		if champs[unit] == 1:
			champs_count[unit] = [29.0, 1.0, 0.0] 
		if champs[unit] == 2:
			champs_count[unit] = [22.0, 2.0, 0.0] 
		if champs[unit] == 3:
			champs_count[unit] = [18.0, 3.0,  0.0] 
		if champs[unit] == 4:
			champs_count[unit] = [12.0, 4.0, 0.0]
		if champs[unit] == 5:
			champs_count[unit] = [10.0, 5.0, 0.0]
		if champs[unit] == 8:
			champs_count[unit] = [12.0, 4.0, 0.0]
		if champs[unit] == 10:
			champs_count[unit] = [10.0, 5.0, 0.0]
	update_visuals()

func update_counts():
	for node in get_children():
		if node.is_in_group("champ"):
			champs_count[node.name][0] = node.count

func calc_pool_totals():
	update_counts()
	var pool_tier_totals = [0, 0, 0, 0, 0]
	for i in range(5):
		for champ in champs_count:
			if champs_count[champ][1] == i + 1:
				pool_tier_totals[i] += champs_count[champ][0]
	return pool_tier_totals

func calc_chances():
	var pool_totals = calc_pool_totals()
	for i in range(5):
		for champ in champs_count:
			var champ_tier = champs_count[champ][1]
			champs_count[champ][2] = (chance[level][champ_tier-1]) * (champs_count[champ][0] / pool_totals[champ_tier-1]) * 5

func update_visuals():
	for node in get_children():
		if node.is_in_group("champ"):
			node.count = champs_count[node.name][0]
			node.chance = champs_count[node.name][2]
			node.update_vis()

func update_chances():
	pass

func _on_Button_pressed():
	calc_chances()
	update_visuals()

func _on_LEVELUP_pressed():
	level += 1
	$LEVEL.text = "LEVEL: " + str(level)
	_on_Button_pressed()

func _on_LEVELDOWN_pressed():
	level -= 1
	$LEVEL.text = "LEVEL: " + str(level)
	_on_Button_pressed()

func _on_Button2_pressed():
	reset_levels()
	_on_Button_pressed()
