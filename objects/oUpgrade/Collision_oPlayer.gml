/// @desc


if !other.upgrades.Exists(upgrade)
	other.upgrades.Append(upgrade)

oPlayer.updateUpgrades()

create_text({text: upgrade+" unlocked!", font: fPopup, y: y-64})

audio_play_sound(aUpgrade, 2, 0)

instance_destroy()