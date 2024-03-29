startbtn = $ ".start"
stopbtn = $ ".stop"
resetbtn = $ ".reset"
input = $ "input.beats"
desc = $(".timeleft .desc")
timeLeftDisplay = $(".timeleft .number")

desiredDing = new Audio "http://www.sounddogs.com/previews/2125/mp3/249993_SOUNDDOGS__be.mp3"

running = false
timeLeft = null
timeStarted = null

startbtn.click ->
	if not timeLeft
		timeLeft = +input.val()
	running = true
	timeStarted = +new Date
	updateDisplay()

stopbtn.click ->
	running = false
	timeLeft -= (+new Date - timeStarted) / 86400 # convert ms to beats
	updateDisplay()

resetbtn.click -> 
	timeLeft = input.val()
	timeStarted = +new Date # ???
	updateDisplay true


# UI state
initialized = false

updateDisplay = (live=running) ->
	if timeLeft isnt null and not initialized
		desc.text " Beats Left"
		initialized = true
	if live
		liveAmountLeft = timeLeft - ((+new Date - timeStarted) / 86400)
		if liveAmountLeft > 0
			timeLeftDisplay.text liveAmountLeft.toFixed(2)
		else
			timeLeftDisplay.text ""
			desc.text "Done!"
			running = false
			timeleft = 0
			desiredDing.play()

setInterval updateDisplay, 100
