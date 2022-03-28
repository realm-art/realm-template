tool
extends WorldEnvironment
class_name RealmEnvironment

func toggle_ss_reflections(enabled):
	if(environment):
		environment.ss_reflections_enabled = enabled
		
func toggle_ssao(enabled):
	if(environment):
		environment.ssao_enabled = enabled
		
func toggle_blur(enabled):
	if(environment):
		environment.dof_blur_far_enabled = enabled
		environment.dof_blur_near_enabled = enabled
