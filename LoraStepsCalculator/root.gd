extends Control

@onready var tab_container = %TabContainer

@onready var sb_img = %SBImg
@onready var sb_repeat = %SBRepeat
@onready var sb_epoch = %SBEpoch
@onready var cb_reg = %CBReg

@onready var sb_batch = %SBBatch

@onready var lspe_result = %LSPEResult
@onready var l_result = %LResult

@onready var lfr_img = %LFRImg
@onready var sbfr_epoch = %SBFREpoch
@onready var l_repeat = %LRepeat


@onready var bc_show_info = %BCShowInfo
@onready var lc_info = %LCInfo
@onready var pc_info = %PCInfo


@onready var bfr_show_info = %BFRShowInfo
@onready var lfr_info = %LFRInfo
@onready var pfr_info = %PFRInfo



var total_steps:float = 0.0
var steps_per_epoch:float = 0.0

var number_of_images:float = 0.0
var repeats:float = 0.0
var epochs:float = 0.0
var regularization_multiplier:float = 0.0
var batch_size:float = 0.0

var calc_results:Array[float] = []

var fr_img:float = 0.0
var fr_epoch:float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pc_info.visible = false
	pfr_info.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	calc_results = _calculate_steps()
	lfr_img.text = str(number_of_images)
	l_repeat.text = str(_find_repeats())

	lspe_result.text = str(calc_results[0])
	l_result.text = str(calc_results[1])



func _calculate_steps() -> Array[float]:
	var result:float = 0.0
	number_of_images = sb_img.value
	repeats = sb_repeat.value
	epochs = sb_epoch.value
	regularization_multiplier = cb_reg.button_pressed as int+1 
	batch_size = sb_batch.value
	
	steps_per_epoch = (number_of_images * repeats)
	total_steps = (number_of_images * repeats * epochs * regularization_multiplier) / batch_size
	
	
	return [steps_per_epoch,total_steps]

func _find_repeats() -> float:
	var fr_result:float = 0.0
	fr_result = (sbfr_epoch.value / number_of_images )
	
	return fr_result

func _on_b_find_repeats_pressed():
	l_repeat.text = str(_find_repeats())


func _on_bfr_show_info_pressed():
	if	pfr_info.visible == false:
		pfr_info.visible = true
	else:
		pfr_info.visible = false



func _on_bc_show_info_pressed():
	if	pc_info.visible == false:
		pc_info.visible = true
	else:
		pc_info.visible = false
