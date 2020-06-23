/// @description 

if(timer >= delay) {
	//with(props.bind)
	//{
	//	other.execute(other.props)
	//}
	execute(props)
	
	if(!repeatable)
		instance_destroy()
	else
		timer = 0
}

timer++