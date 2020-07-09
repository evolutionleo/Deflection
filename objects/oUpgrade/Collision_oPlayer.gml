/// @desc

if !other.upgrades.Exists(upgrade)
	other.upgrades.Append(upgrade)

if floor(image_index) == 0 {
	create_text({text: upgrade+" unlocked!", font: fPopup, y: y-16})
}
else {
	//other.max_hp += 1
	//other.hp = other.max_hp
	create_text({text: "Health acquired!", font: fPopup, y: y-16})
}

oPlayer.updateUpgrades()

audio_play_sound_mute(aUpgrade, 2, 0)

instance_destroy()