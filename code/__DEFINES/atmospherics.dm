GLOBAL_LIST_INIT(pipe_paint_colors, sort_list(list(
		"amethyst" = rgb(130,43,255),
		"blue" = rgb(0,0,255),
		"brown" = rgb(178,100,56),
		"cyan" = rgb(0,255,249),
		"dark" = rgb(69,69,69),
		"green" = rgb(30,255,0),
		"grey" = rgb(255,255,255),
		"orange" = rgb(255,129,25),
		"purple" = rgb(128,0,182),
		"red" = rgb(255,0,0),
		"violet" = rgb(64,0,128),
		"yellow" = rgb(255,198,0)
)))

//PIPENET UPDATE STATUS
#define PIPENET_UPDATE_STATUS_DORMANT 0
#define PIPENET_UPDATE_STATUS_REACT_NEEDED 1
#define PIPENET_UPDATE_STATUS_RECONCILE_NEEDED 2
