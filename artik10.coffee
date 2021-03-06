deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

BOARD_SHUTDOWN_ARTIK = 'The device has performed a shutdown. Press the power switch PSW1 to the off position.'
SET_JUMPER_SD = 'Set SW2 dip switch to position 1:on, 2:on. Also, make sure jumpers J20 and J36 are set towards the edge of the board.'
SET_JUMPER_EMMC = 'Set SW2 dip switch to position 1:off, 2:off.'
BOARD_POWERON_ARTIK = 'Press the power switch PSW1 to the on position. Press and hold for 1 second the SW3 POWER push button.'


postProvisioningInstructions = [
	BOARD_SHUTDOWN_ARTIK
	instructions.REMOVE_INSTALL_MEDIA
	SET_JUMPER_EMMC
	BOARD_POWERON_ARTIK
]

module.exports =
	version: 1
	slug: 'artik10'
	aliases: [ 'artik10' ]
	name: 'Samsung Artik 10'
	arch: 'armv7hf'
	state: 'released'

	stateInstructions:
		postProvisioning: postProvisioningInstructions

	instructions: [
		instructions.ETCHER_SD
		instructions.EJECT_SD
		instructions.FLASHER_WARNING
		SET_JUMPER_SD
		BOARD_POWERON_ARTIK
	].concat(postProvisioningInstructions)

	gettingStartedLink:
		windows: 'https://docs.resin.io/artik10/nodejs/getting-started/#adding-your-first-device'
		osx:' https://docs.resin.io/artik10/nodejs/getting-started/#adding-your-first-device'
		linux: 'https://docs.resin.io/artik10/nodejs/getting-started/#adding-your-first-device'

	supportsBlink: false

	yocto:
		machine: 'artik10'
		image: 'resin-image-flasher'
		fstype: 'resinos-img'
		version: 'yocto-morty'
		deployArtifact: 'resin-image-flasher-artik10.resinos-img'
		compressed: true

	options: [ networkOptions.group ]

	configuration:
		config:
			partition:
				primary: 1
			path: '/config.json'

	initialization: commonImg.initialization
