---@diagnostic disable: undefined-global, lowercase-global

script_name("Furry Helper")
script_description('˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ Arizona Online ˜ Rodina Online')
script_author("kolaars")
script_version("1.6.1 Free")
----------------------------------------------- INIT ---------------------------------------------
local worked_dir = getWorkingDirectory():gsub('\\','/')
local IS_MOBILE = MONET_VERSION ~= nil
print('˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜...')
print('˜˜˜˜˜˜: ' .. thisScript().version)
print('˜˜˜˜˜˜˜˜˜: ' .. (IS_MOBILE and 'MOBILE' or 'PC'))
print('˜˜˜˜˜˜˜ ˜˜˜˜˜: ' .. worked_dir)
------------------------------------------ INIT CRASH INFO ---------------------------------------
if not doesFileExist(worked_dir .. '/.Furry Helper Errors Handler.lua') then
	local helper_prefix = '/.Furry Helper '
	local file_path = worked_dir .. helper_prefix .. 'Errors Handler.lua'
	local content = [[
-- DONT SEND ME THIS FILE, THIS IS NOT AN ERROR, BUT A SCRIPT TO DISPLAY THE ERROR IN DIALOG
-- ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜, ˜˜˜ ˜˜ ˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜
function onSystemMessage(msg, type, script)
	if script and script.name == 'Furry Helper' and msg and ((msg:find('stack traceback')) or (type == 3 and not msg:find('Script died due to an error'))) then
		local errorMessage = ('{ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜-˜˜ ˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜!\n\n' ..
		'˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ {ff9900}˜˜˜.˜˜˜˜˜˜˜˜˜ Kolaars (Telegram/Discord/BlastHack){ffffff}.\n\n' ..
		'˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜:\n{ff6666}' .. msg)
		sampShowDialog(123123, '{009EFF}Furry Helper [' .. script.version .. ']', errorMessage, '˜˜˜˜˜˜˜ ˜˜˜˜˜˜', '', 0)
	end
end
    ]]
	local file, errstr = io.open(file_path, 'w')
	if (file) then
		file:write(content)
		file:close()
		if not IS_MOBILE then
			os.execute('attrib +h "' .. file_path .. '"')
		end
		os.remove(worked_dir .. helper_prefix .. 'Crash Info.lua')
		os.remove(worked_dir .. helper_prefix .. 'Error Handler.lua')
		os.remove(worked_dir .. helper_prefix .. 'Crash Informer.lua')
	else
		print('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜: ', errstr)
	end
end
------------------------------------------- CONNECT LIBNARY ---------------------------------------
print('˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜...')
require('lib.moonloader')
require('encoding').default = 'CP1251'
local u8 = require('encoding').UTF8
local ffi = require('ffi')
local imgui = require('mimgui')
local fa = require('fAwesome6_solid')
local sampev = require('samp.events')
local dkok, dkjson = pcall(require, "dkjson")
local vkeys_no_errors, vkeys = pcall(require, 'vkeys')
local requests_no_errors, requests = pcall(require, 'requests')
local monet_no_errors, moon_monet = pcall(require, 'MoonMonet')
local hotkey_no_errors, hotkey = pcall(require, 'mimgui_hotkeys')
local pie_no_errors, pie = pcall(require, IS_MOBILE and 'imgui_piemenu' or 'mimgui_piemenu_mod')
local sizeX, sizeY = getScreenResolution()
print('˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜!')
-------------------------------------------- JSON SETTINGS ---------------------------------------
local config_dir = worked_dir .. '/Arizona Helper'
local settings = {}
local default_settings = {
	general = {
		version = thisScript().version,
        custom_dpi = 1.0,
		autofind_dpi = false,
        helper_theme = 0,
		message_color = 40703,
		moonmonet_theme_color = 40703,
		transparent = 75,
		fraction_mode = '',
		bind_mainmenu = '[113]',
		bind_fastmenu = '[69]',
		bind_leader_fastmenu = '[71]',
		bind_action = '[13]',
		bind_command_stop = '[123]',
		piemenu = true,
		mobile_fastmenu_button = true,
		mobile_stop_button = true,
		auto_uninvite = false,
		ping = true,
		rp_guns = true,
		rp_chat = true,
		accent_enable = true,
		auto_accept_docs = true,
		auto_update_members = false,
	},
    mj = {
		auto_time = true,
		anti_screpki = true,
		auto_doklad_damage = true,
		auto_change_code_siren = true,
		auto_update_wanteds = false,
    },
	md = {
		auto_doklad_damage = true,
	},
	mh = {
		price = {
			ant = 50000,
			recept = 100000,
			heal = 100000,
			heal_vc = 1000,
			healactor = 800000,
			healactor_vc = 1000,
			healbad = 400000,
			medosm = 800000,
			mticket = 400000,
			med7 = 50000,
			med14 = 100000,
			med30 = 150000,
			med60 = 200000,
		},
		heal_in_chat = {
			enable = true,
			auto_heal = false
		},

	},
	smi = {
		ads_buttons = true,
		ads_history = true,
		notify_new_ads = true,
		auto_select_first_ad = false,
	},
	lc = {
		price = {
			avto1 = 200000,
			avto2 = 360000,
			avto3 = 410000,
			moto1 = 300000,
			moto2 = 350000,
			moto3 = 450000,
			fish1 = 500000,
			fish2 = 550000,
			fish3 = 590000,
			swim1 = 500000,
			swim2 = 550000,
			swim3 = 590000,
			gun1 = 1000000,
			gun2 = 1090000,
			gun3 = 1150000,
			hunt1 = 1000000,
			hunt2 = 1100000,
			hunt3 = 1190000,
			klad1 = 1100000,
			klad2 = 1200000,
			klad3 = 1250000,
			taxi1 = 800000,
			taxi2 = 1150000,
			taxi3 = 1250000,
			mexa1 = 800000,
			mexa2 = 1150000,
			mexa3 = 1250000,
			fly1 = 1200000,
			fly2 = 1200000,
			fly3 = 1200000,
			train1 = 500000 -- rodina
		},
		auto_find_clorest_znak = true,
	},
	fd = {
		doklads = {
			togo = true,
			here = true,
			fire = true,
			stretcher = true,
			npc_save = true,
			file_end = true,
		},
	}, 
	gov = {
		anti_trivoga = true,
		custom_zeks = true,
	},
	ins = {
		anti_trivoga = true,
		hint_in_sort = true,
		notify_new_ticket = true,
		auto_input_ticket = true,
	},
	windows_pos = {
		pie = {x = sizeX * 0.7, y = sizeY * 0.7},
		patrool_menu = {x = sizeX / 2, y = sizeY / 2},
		post_menu = {x = sizeX / 2, y = sizeY / 2},
		wanteds_menu = {x = sizeX / 1.2, y = sizeY / 2},
		zeks_menu = {x = sizeX / 1.2, y = sizeY / 2},
		mobile_fastmenu_button = {x = sizeX / 8.5, y = sizeY / 2.3},
	},
}
function encode_table(array) 
	if dkok then 
		local ok, encoded = pcall(dkjson.encode, array, {indent = true})
		if ok then return encoded end
	end
	local ok, encoded = pcall(encodeJson, array) 
	if ok then return encoded end 
end
function merge_defaults(default, loaded)
	local checker = false
    for key, value in pairs(default) do
        if type(value) == "table" then
            if type(loaded[key]) ~= "table" then
				checker = true
				print('˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜: ' .. key .. ' = ' .. tostring(value))
                loaded[key] = {}
            end
            merge_defaults(value, loaded[key])
        else
            if loaded[key] == nil then
                loaded[key] = value
				print('˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜: ' .. key .. ' = ' .. tostring(value))
				checker = true
            end
        end
    end
	return checker
end
function save_settings()
    local file, errstr = io.open(config_dir .. "/Settings.json", 'w')
    if file then
		local content = encode_table(settings)
		if content then
			file:write(content)
			print('˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!')
		else
			print('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜! ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ json')
		end
		file:close()
    else
        print('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜: ', (errstr or "Unknown"))
    end
end
function load_settings()
    if not doesDirectoryExist(config_dir) then createDirectory(config_dir) end
    if not doesFileExist(config_dir .. "/Settings.json") then
        settings = default_settings
		print('˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!')
    else
        local file = io.open(config_dir .. "/Settings.json", 'r')
        if file then
            local contents = file:read('*a')
            file:close()
			if #contents ~= 0 then
				local result, loaded = pcall(decodeJson, contents)
				if result then
					settings = loaded
					if settings.general.version ~= thisScript().version then
						settings.general.version = thisScript().version
						merge_defaults(default_settings, settings)
						save_settings()
					else
						print('˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!')
					end
				else
					settings = default_settings
					print('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!')
				end
			else
                settings = default_settings
				print('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!')
			end
        else
            settings = default_settings
			print('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!')
        end
    end
end
function isMode(mode_type)
	return settings.general.fraction_mode == mode_type
end
load_settings()
------------------------------------------- AUTO FIND DPI ----------------------------------------
if not settings.general.autofind_dpi then
	print('˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜...')
	if IS_MOBILE then
		settings.general.custom_dpi = MONET_DPI_SCALE
	else
		local width_scale = sizeX / 1366
		local height_scale = sizeY / 768
		settings.general.custom_dpi = (width_scale + height_scale) / 2
	end
	settings.general.autofind_dpi = true
	settings.general.custom_dpi = tonumber(string.format('%.3f', settings.general.custom_dpi))
	print('˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜: ' .. settings.general.custom_dpi)
	save_settings()
end
------------------------------------------ JSON & MODULES ----------------------------------------
local modules = {
	player = {
		name = '˜˜˜˜˜',
		path = config_dir .. "/Player.json",
		data = {
			nick = '',
			name_surname = '',
			sex = '˜˜˜˜˜˜˜',
			fraction = 'none',
			fraction_tag = '',
			fraction_rank = '',
			fraction_rank_number = 0,
			accent = '[˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜]:'
		}
	},
	departament = {
		name = '˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜',
		path = config_dir .. "/Departament.json",
		data = {
			anti_skobki = false,
			dep_fm = '-',
			dep_tag1 = '',
			dep_tag2 = '[˜˜˜˜]',
			dep_tags = {
				"[˜˜˜˜]",
				"[˜˜˜˜˜˜˜˜˜˜]",
				"[˜˜˜˜˜˜˜˜˜]",
				"[˜˜˜˜˜˜˜˜˜]",
				'skip',
				"[˜˜]",
				"[˜˜˜.˜˜˜.]",
				"[˜˜˜˜]",
				"[˜˜˜˜]",
				"[˜˜˜˜]",
				"[˜˜˜˜]",
				"[˜˜˜˜]",
				"[˜˜˜]",
				'skip',
				"[˜˜]",
				"[˜˜˜.˜˜˜˜˜˜˜]",
				"[˜˜˜]",
				"[˜˜˜]",
				"[˜˜˜]",
				'skip',
				"[˜˜]",
				"[˜˜˜]",
				"[˜˜˜.˜˜˜˜˜.]",
				"[˜˜˜˜]",
				"[˜˜˜˜]",
				"[˜˜˜˜]",
				"[˜˜˜]",
				"[˜˜]",
				'skip',
				"[˜˜]",
				"[˜˜]",
				"[˜˜]",
				"[˜˜˜-˜˜]",
				"[˜˜˜˜˜˜˜˜˜˜]",
				"[˜˜˜˜˜˜˜˜]",
				"[C˜˜˜˜]",
				'skip',
				"[˜˜˜]",
				"[˜˜˜ ˜˜]",
				"[˜˜˜ ˜˜]",
				"[˜˜˜ ˜˜]",
			},
			dep_tags_en = {
				"[ALL]",
				'skip',
				"[MJ]",
				"[Min.Just.]",
				"[LSPD]",
				"[SFPD]",
				"[LVPD]",
				"[RCSD]",
				"[SWAT]",
				"[FBI]",
				'skip',
				"[MD]",
				"[Mid.Def.]",
				"[LSa]",
				"[SFa]",
				"[MSP]",
				'skip',
				"[MH]",
				"[MHF]",
				"[Min.Healt]",
				"[LSMC]",
				"[SFMC]",
				"[LVMC]",
				"[JMC]",
				"[FD]",
				'skip',
				"[GOV]",
				'[Governor]',
				"[Prosecutor]",
				"[Judge]",
				"[LC]",
				"[INS]",
				'skip',
				"[CNN]",
				"[CNN LS]",
				"[CNN LV]",
				"[CNN SF]",
			},
			dep_tags_custom = {},
			dep_fms = {
				'-',
				'- ˜.˜. -',
			}
		}
	},
	commands = {
		name = '˜˜˜˜˜˜˜',
		path = config_dir .. "/Commands.json",
		data = {
			commands = {
				my = {},
				police = {
					{cmd = '55', description = '˜˜˜˜˜˜˜˜˜˜ 10-55', text = '/r {my_doklad_nick} ˜˜ CONTROL. ˜˜˜˜˜˜˜ 10-55 ˜ ˜˜˜˜˜˜ {get_area} ({get_square}), ˜ODE 4.&/m ˜˜˜˜˜˜˜˜ {get_drived_car} ˜˜˜˜˜˜˜˜!&/m ˜˜˜˜˜˜˜ {fraction}! ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.&/m ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜.&/m ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜!', arg = '', enable = true, waiting = '2', bind = "[101]"},
					{cmd = '66', description = '˜˜˜˜˜˜˜˜˜˜ 10-66', text = '/r {my_doklad_nick} ˜˜ CONTROL. ˜˜˜˜˜˜˜ 10-66 ˜ ˜˜˜˜˜˜ {get_area} ({get_square}), ˜ODE 3!&/m ˜˜˜˜˜˜˜˜ {get_drived_car} ˜˜˜˜˜˜˜˜!&/m ˜˜˜˜˜˜˜ {fraction}! ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜!&/m ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜!', arg = '', enable = true, waiting = '2', bind = "[102]"},
					{cmd = 'zd', description = '˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '˜˜˜˜˜˜˜˜˜˜˜˜, ˜ {my_ru_nick} - {fraction_rank} {fraction_tag}&˜˜˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜?', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'bk', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜{sex} ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/bk 10-20&/r {my_doklad_nick} ˜˜ CONTROL. ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜!', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'siren', description = '˜˜˜/˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜/˜', text = '{switchCarSiren}', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'fara', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜', text = '/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ {get_nearest_car}&/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'pas', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜',  text = '˜˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜ {fraction_tag}, ˜ {fraction_rank} {my_ru_nick}&/do C˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜&/showbadge {id}&˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜.&/n @{get_nick({id})}, ˜˜˜˜˜˜˜ /showpass {my_id}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'ts', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜',  text = '/do ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜.&/writeticket {id} {arg}&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜˜ ˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'find', description = '˜˜˜˜˜ ˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ N{id}&/me ˜˜˜˜˜{sex} ˜˜ ˜˜˜˜˜˜ GPS ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜&/find {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'prs', description = '˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ N{id}&/me ˜˜˜˜˜{sex} ˜˜ ˜˜˜˜˜˜ GPS ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜&/pursuit {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'su', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/su {id} {number} {arg}&/z {id}&/todo ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜', arg = '{id} {number} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'fsu', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜',  text = '/do ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜{sex} ˜˜˜˜˜ c ˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜{sex} ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜&/r {my_doklad_nick} ˜˜ CONTROL.&/r ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ {number} ˜˜˜˜˜˜˜ ˜˜˜˜ N{id}. ˜˜˜˜˜˜˜: {arg}', arg = '{id} {number} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'givefsu', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜',  text = '/r 10-4, ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ {get_rp_nick({id})}!&/me ˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/su {get_form_su} (˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ {get_rp_nick({id})})&/todo ˜˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ {get_rp_nick({id})} ˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'unsu', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜ ˜˜˜˜ N{id} ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/unsu {id} {number} {arg}', arg = '{id} {number} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'clear', description = '˜˜˜˜˜ ˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜ ˜˜˜˜ N{id} ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/clear {id}&/do ˜˜˜˜ N{id} ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜.', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'gcuff', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜',  text = '/do ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/todo ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜&/cuff {id}&/todo ˜˜ ˜˜˜˜˜˜˜˜˜˜*˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜&/gotome {id}&/do ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜.', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'cuff', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜',  text = '/do ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/todo ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜&/cuff {id}&/todo ˜˜ ˜˜˜˜˜˜˜˜˜˜*˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'uncuff', description = '˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜',  text = '/do ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜{sex} ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/uncuff {id}&/todo ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'gtm', description = '˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜{sex} ˜˜˜ ˜˜ ˜˜˜˜&/gotome {id}&/do ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜.', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'ungtm', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜&/ungotome {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'bot', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ (˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜)',  text = '/me ˜˜˜˜˜˜{sex} ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜&/bot {id}&/todo ˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜?!*˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ {get_rp_nick({id})}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'ss', description = '˜˜˜˜˜˜˜˜',  text = '/s ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜˜ {fraction_tag}!', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 't', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜',  text = '/taser', arg = '', enable = true, waiting = '2', bind = "[18,49]" },
					{cmd = 'frl', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜',  text = '˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'fr', description = '˜˜˜˜˜˜ ˜˜˜˜˜',  text = '/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/todo ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜, ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜*˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/frisk {id}&/me ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜&/do ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜.&/me ˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'take', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ (6+)', text = '/do ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜&/me ˜˜˜˜˜ ˜ ˜˜˜-˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/take {id}&/do ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜-˜˜˜˜˜˜.&/todo ˜˜˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true },
					{cmd = 'camon', description = '˜˜˜˜˜˜˜˜ c˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜',  text = '/do ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜˜˜˜.&/do ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜.', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'camoff', description = '˜˜˜˜˜˜˜˜˜ c˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜',  text = '/do ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜{sex} ˜˜˜˜ ˜˜˜˜˜˜.&/do ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜.', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'inc', description = '˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜*˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/incar {id} {arg}&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'ej', description = '˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜&/eject {id}&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},	
					{cmd = 'pl', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/pull {id}&/me ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},	
					{cmd = 'mr', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜',  text = '˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&˜˜, ˜˜˜ ˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜.&˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ 1 ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜.&˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜.&˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜?', arg = '', enable = true, waiting = '2', bind = "{}"},	
					{cmd = 'unmask', description = '˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜',  text = '/do ˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/unmask {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'arr', description = '˜˜˜˜˜˜˜˜˜˜ (˜ ˜˜˜˜˜˜˜)',  text = '/me ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/arrest', arg = '', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'bribe', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜',  text = '/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜-˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜?&/n @{get_nick({id})}, ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜, ˜˜˜˜˜˜˜˜ /do ˜˜˜.&{pause}&/do ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜{sex} ˜˜˜˜˜˜˜, ˜˜˜˜˜˜{sex} ˜˜˜˜˜˜˜, ˜ ˜˜˜-˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜{sex}&/do ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜: {arg}$&/todo ˜˜˜ ˜˜˜˜˜˜˜?*˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜&{pause}&/bribe {id} {arg} 1', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'drugs', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜',  text = '/do ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜&/me ˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜-˜˜˜˜-10 ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜&/do ˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜-˜˜˜˜-10.&/me ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜ ˜˜˜˜˜ ˜˜˜˜˜-˜˜˜˜-10 ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜.&/todo ˜˜, ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜&/me ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'rbomb', description = '˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜',  text = '/do ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜&/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜, ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜.&/do ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ 2 ˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜&/do ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜&/do ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜.&/me ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜&/removebomb&/do ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'delo', description = '˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜',  text = '/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/todo ˜˜˜˜, ˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜*˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜˜˜ ˜  ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜&{pause}&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜&{pause}&/me ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜&{pause}&/do ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&{pause}&/do ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/todo ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'giveplate', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜',  text = '/do ˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜&/do ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/todo ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜&/giveplate {id} {arg}', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'agenda', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜',  text = '/do ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ {fraction_tag}&/do ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜.&/todo ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜*˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/agenda {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
				},
				fbi = {
					{cmd = 'doc', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (FBI)',  text = '˜˜˜˜˜˜˜˜˜˜˜˜, ˜ {fraction_rank} {fraction_tag}&/do C˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜ ˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜-˜˜˜˜˜ ˜˜ ˜˜˜˜˜&˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜.&/n @{get_nick({id})}, ˜˜˜˜˜˜˜ /showpass {my_id} ˜˜˜ /showbadge {my_id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'priton1', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜',  text = '/d ˜˜˜ - ˜˜: ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜!&/d ˜˜˜ - ˜˜: ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ - ˜ ˜˜˜˜˜ ˜˜˜˜&/d ˜˜˜ - ˜˜: ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜!', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'priton2', description = '˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜',  text = '/d ˜˜˜ - ˜˜: ˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜! ˜ ˜˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜˜.&/d ˜˜˜ - ˜˜: ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.&/d ˜˜˜ - ˜˜: ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'priton3', description = '˜˜˜˜˜ ˜˜˜˜˜˜˜',  text = '/d ˜˜˜ - ˜˜: ˜˜˜˜-˜˜˜˜˜˜˜˜ "˜˜˜˜˜˜" ˜˜˜˜˜˜˜˜!&/d ˜˜˜ - ˜˜: ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜!&/d ˜˜˜ - ˜˜: ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜.', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'gwarn', description = '˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜',  text = '/do ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/gwarn {id} {arg}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'ungwarn', description = '˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜',  text = '/do ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/ungwarn {id}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'dismiss', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ (1-4)',  text = '/do ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/dismiss {id} {arg}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
				},
				army = {
					{cmd = 'pas', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ (˜˜˜)', text = '˜˜˜˜˜˜˜˜˜˜˜˜, ˜ {fraction_rank} {fraction_tag} - {my_doklad_nick}.&/do ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜.&/me ˜˜˜˜˜˜{sex} ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜{sex} ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/do ˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜: {fraction} - {fraction_rank} {my_doklad_nick}.&˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜.&˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜!', arg = '', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'agenda', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜',  text = '/do ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ {fraction_tag}&/do ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜.&/todo ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜*˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/agenda {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'siren', description = '˜˜˜/˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜/˜', text = '{switchCarSiren}', arg = '', enable = true, waiting = '2', bind = "{}"},
				},
				prison = {
					{cmd = 't', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜',  text = '/taser', arg = '', enable = true, waiting = '2', },
					{cmd = 'cuff', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', text = '/do ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/cuff {id}&/do ˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜.', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'uncuff', description = '˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', text = '/do ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/uncuff {id}&/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'gotome', description = '˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜', text = '/me ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜&/gotome {id}&/do ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜.', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'ungotome', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜', text = '/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜&/ungotome {id}', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'take', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ (6+)', text = '/do ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜&/me ˜˜˜˜˜ ˜ ˜˜˜-˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/take {id}&/do ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜-˜˜˜˜˜˜.&/todo ˜˜˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'carcer', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜',text = '/do ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜, ˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜&/carcer {id} {number} {arg}',arg = '{id} {number} {arg}', enable = true, waiting = '2'},
					{cmd = 'setcarcer', description = '˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '/do ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜&/setcarcer {id} {arg}', arg = '{id} {arg}', enable = true, waiting = '2'},
					{cmd = 'uncarcer', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜', text = '/do ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜&/uncarcer {id}', arg = '{id}', enable = true, waiting = '2' },
					{cmd = 'frisk', description = '˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜', text = '/do ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜&/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/frisk {id}', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'punishsu', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.', text ='/me ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜.&/punish {id} {number} 2 {arg}', arg = '{id} {number} {arg}', enable = true, waiting = '2'},
					{cmd = 'punishclear', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜ ˜ ˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.&/do ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜: "{get_rp_nick({id})}, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜...&/do ...˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜."&/me ˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜.&/do ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜: "˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜...&/do ...˜˜ {number} ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜."&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜.&/do ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜...&/do ...˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜.&/punish {id} {number} 1 {arg}', arg = '{id} {number} {arg}', enable = true, waiting = '2'},
				},
				hospital = {
					{cmd = 'siren', description = '˜˜˜/˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜/˜', text = '{switchCarSiren}', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'zd', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '˜˜˜˜˜˜˜˜˜˜˜˜, ˜ {my_ru_nick} - {fraction_rank} {fraction_tag}&˜˜˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜?', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'go', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜', text = '˜˜˜˜˜˜ {get_ru_nick({id})}, ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜.', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'hl', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜*˜˜˜˜˜˜˜˜&/heal {id} {get_price_heal}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'hla', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜*˜˜˜˜˜˜˜˜&/healactor {id} {get_price_actorheal}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'hlb', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜, ˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜*˜˜˜˜˜˜˜˜&/healbad {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},	
					{cmd = 'mt', description = '˜˜˜.˜c˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜',  text = '˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜.˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ... &... ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ 1 ˜˜˜˜˜˜˜!&/mticket {id} {get_price_mticket}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'pilot', description = '˜˜˜.˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜',  text = '˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜.˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜.&/medcheck {id} {get_price_medosm}&{pause}&˜ ˜˜˜...&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜&/do ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜.&/todo ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜*˜˜˜˜˜˜˜˜.&˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜&/do ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/todo ˜˜˜˜˜˜˜*˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜.˜˜˜˜&˜˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜!&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ 65 ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜.&/todo ˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜.˜˜˜˜&/me ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜&˜˜ ˜˜˜-˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜˜!', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'medin', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜˜˜˜',  text = '˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ c˜˜˜˜.&˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜˜˜˜.&˜˜ 1 ˜˜˜˜˜˜ - $4˜˜.˜˜˜. ˜˜ 2 ˜˜˜˜˜˜ - $8˜˜.˜˜˜. ˜˜ 3 ˜˜˜˜˜˜ - $1.2˜˜.˜˜˜.&˜ ˜˜˜, ˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜˜˜˜?&{pause}&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜.˜˜˜˜&/givemedinsurance {id}&/todo ˜˜˜ ˜˜˜˜ ˜˜˜.˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜*˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜.˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'med', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜',  text = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜. ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜!&˜˜˜. ˜˜˜˜˜ ˜˜ 7 ˜˜˜˜ - ${get_price_med7}&˜˜˜. ˜˜˜˜˜ ˜˜ 14 ˜˜˜˜ - ${get_price_med14}&˜˜˜. ˜˜˜˜˜ ˜˜ 30 ˜˜˜˜ - ${get_price_med30}&˜˜˜. ˜˜˜˜˜ ˜˜ 60 ˜˜˜˜ - ${get_price_med60}&˜˜˜˜˜˜˜, ˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜. ˜˜˜˜˜?&{show_medcard_menu}&˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜, ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜.˜˜˜˜&/todo ˜˜˜ ˜˜˜˜ ˜˜˜.˜˜˜˜˜, ˜˜˜˜˜˜*˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜&/medcard {id} {get_medcard_status} {get_medcard_days} {get_medcard_price}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'recept', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜',  text = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ${get_price_recept}&˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&/n ˜˜˜˜˜˜˜˜! ˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ 5 ˜˜˜˜˜˜˜˜!&{show_recept_menu}&˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/do ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/todo ˜˜˜, ˜˜˜˜˜˜˜!*˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜  ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/recept {id} {get_recepts}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'ant', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜',  text = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ${get_price_ant}&˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&/n ˜˜˜˜˜˜˜˜! ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ 1 ˜˜ 20 ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜!&{show_ant_menu}&˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜.˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜.˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜.&/todo ˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜!*˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/antibiotik {id} {get_ants}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'osm', description = '˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜ ˜˜˜˜˜˜ (˜˜)',  text = '˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜.˜˜˜˜˜˜.&˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜.&/n @{get_nick({id})}, ˜˜˜˜˜˜˜ /showmc {my_id} ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜.˜˜˜˜˜.&{pause}&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜&/do ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜.&/todo ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜*˜˜˜˜˜˜˜˜.&˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜.&/n ˜˜˜˜˜˜˜˜˜˜˜ /me ˜˜˜˜˜˜(-˜) ˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜&{pause}&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜&/do ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/todo ˜˜˜˜˜˜˜*˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜.˜˜˜˜&˜˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜!&{pause}&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ 65 ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜.&/todo ˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜*˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜.˜˜˜˜&/me ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜&˜˜ ˜˜˜-˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜...&˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜˜!', arg = '{id}', enable = true, waiting = '2', bind = "{}"}, 
					{cmd = 'gd', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ (/godeath)',  text = '/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜&/godeath {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'exp', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜',  text = '˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜!&/me ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜&/expel {id} ˜.˜.˜.', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
				},
				smi = {
					{cmd = 'ads', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜',  text = '/newsredak', arg = '', enable = true, waiting = '2', bind = "[18,49]" },
					{cmd = 'zd', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '˜˜˜˜˜˜˜˜˜˜˜˜, ˜ {my_ru_nick} - {fraction_rank} {fraction_tag}&˜˜˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜?', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'go', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜', text = '˜˜˜˜˜˜ {get_ru_nick({id})}, ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜.', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'expel', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜',  text = '˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜!&/me ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜&/expel {id} ˜.˜.˜.', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'live_sobes', description = '˜˜˜˜˜˜˜˜˜˜˜˜˜', text = "/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜&/do ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜&/todo ˜˜˜, ˜˜˜, ˜˜˜*˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜.&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ˜ ˜˜˜˜ - ˜, {fraction_rank} - {my_ru_nick}.&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜?&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜?&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜! ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ...&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ... ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ {fraction_tag}!&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜?&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜: ...&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ... ˜˜˜˜˜˜˜, ˜˜˜. ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜: ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ...&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ... ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ...&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ... ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ {fraction_tag}.&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ˜ ˜˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜˜˜˜˜]: ˜ ˜˜˜˜ ˜˜˜ - ˜, {my_ru_nick}. ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜!&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜!&/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜", arg = '', enable = true, waiting = '6', bind = "{}", in_fastmenu = false},
					{cmd = 'live_mp1', description = '˜˜˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜"', text = "/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜&/do ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜&/todo ˜˜˜, ˜˜˜, ˜˜˜*˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜.&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜! ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜.&/news ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜ ˜˜˜˜˜˜˜˜˜ - {my_ru_nick}!&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ - ˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜: ˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜, ˜ ˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ...˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜: ˜˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ 1 ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜˜ ˜˜˜ ˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜. ˜ ˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ...˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜. ˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ - ˜˜˜˜˜ ˜˜˜˜˜.&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜! ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ - ˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ...˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜˜. ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ...˜ ˜˜˜˜˜ - ˜˜˜˜˜˜˜˜.&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ - ˜˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜... ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜.&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ '˜˜˜˜˜˜˜˜'.&/news [˜˜˜˜˜˜˜˜˜]: ...˜˜˜˜˜˜˜˜˜.&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜... ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜... ˜˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ...˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜. ˜˜˜ ˜˜ ˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ...˜˜˜˜˜˜ - ˜˜˜˜˜˜˜˜˜.&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜! ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ - ˜˜˜˜˜˜˜˜˜! ˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ...˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜ ˜˜˜˜˜˜˜, ˜ ˜˜ ˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜ '˜˜˜˜' - ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜-˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜ ˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜?&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜!&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜!&/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜", arg = '', enable = true, waiting = '6', bind = "{}", in_fastmenu = false},
					{cmd = 'live_mp2', description = '˜˜˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜˜˜˜"', text = "/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜&/do ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜&/todo ˜˜˜, ˜˜˜, ˜˜˜*˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜.&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜.&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜ ˜˜˜˜˜˜˜˜˜ - {my_ru_nick}!&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ - ˜˜˜˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜ ˜˜˜˜˜˜˜˜˜: ˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜, ˜ ˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ...˜˜˜˜˜˜˜˜ +, ˜˜˜˜˜˜˜˜˜ *, ˜˜˜˜˜˜˜˜˜ -, ˜˜˜˜˜˜˜ /.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ...˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜: ˜˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ 500.000$!&/news [˜˜˜˜˜˜˜˜˜]: ˜˜ ˜˜˜ ˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ... '3 + 3 * 3'.&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜! ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ - '12'.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ... '66 - 44 + 1'.&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ - '23'.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ... '35 + 75'.&/news [˜˜˜˜˜˜˜˜˜]: ˜... ˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜ ˜˜˜, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ '110', ˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ... '25 - 28 + 1'.&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜? ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ - '-2'.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜. ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ...˜˜˜˜˜˜˜ ˜˜˜˜˜. ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ... 'X - IV'.&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜! ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ - 'VI'.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ... 'XV - VIII'.&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜!&/news [˜˜˜˜˜˜˜˜˜]: 'VII' - ˜˜˜˜˜˜ ˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ -&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜... ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ... 'XII - III'.&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜! ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜˜ - 'IX'. ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ - ˜˜˜˜˜˜˜˜˜ ...&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜ ˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜?&{pause}&/news [˜˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜˜]: ˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜!/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜!&/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜", arg = '', enable = true, waiting = '6', bind = "{}", in_fastmenu = false},
					{cmd = 'live_weather1', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜ ˜˜˜˜˜)', text = "/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜&/do ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜&/todo ˜˜˜, ˜˜˜, ˜˜˜*˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜.&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/news ˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜!&/news ˜ ˜˜˜˜˜˜˜˜˜ {fraction_rank} - {my_ru_nick}.&/news ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜.&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜!&/news ˜˜˜˜˜ ˜˜˜˜˜˜-˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ 15 ˜/c.&/news ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ +16˜C, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ +13˜C.&/news ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜: ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!&/news ˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.&/news ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜!&/news ˜˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.&/news ˜ ˜˜˜˜ ˜˜˜ {fraction_rank} - {my_ru_nick}.&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜!&/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜", arg = '', enable = true, waiting = '2', bind = "{}", in_fastmenu = false},
					{cmd = 'live_weather2', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜˜)', text = "/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜&/do ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜&/todo ˜˜˜, ˜˜˜, ˜˜˜*˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜.&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/news ˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜!&/news ˜ ˜˜˜˜˜˜˜˜˜ {fraction_rank} - {my_ru_nick}.&/news ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜.&/news ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ +22˜C, ˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜.&/news ˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜, ˜˜˜˜˜ 5 ˜/˜, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜.&/news ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜.&/news ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜!&/news ˜˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.&/news ˜ ˜˜˜˜ ˜˜˜ {fraction_rank} - {my_ru_nick}. ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜!&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜!&/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜", arg = '', enable = true, waiting = '6', bind = "{}", in_fastmenu = false},
					{cmd = 'live_weather3', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜)', text = "/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜&/do ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜&/todo ˜˜˜, ˜˜˜, ˜˜˜*˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜.&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/news ˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜!&/news ˜ ˜˜˜˜˜˜˜˜˜ {fraction_rank} - {my_ru_nick}.&/news ˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.&/news ˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜...&/news ˜ 21:52 ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/news ˜ ˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜.&/news ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜.&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜.&/news ˜ ˜˜˜ ˜ 22:10 ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜.&/news ˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.&/news ˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ - ˜˜˜˜˜˜˜˜˜˜! ˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜.&/news ˜ ˜˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜.&/news ˜ ˜˜˜˜ ˜˜˜ {fraction_rank} - {my_ru_nick}.&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜!&/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜", arg = '', enable = true, waiting = '6', bind = "{}", in_fastmenu = false},
					{cmd = 'live_int1', description = '˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜)', text = "/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜&/do ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜&/todo ˜˜˜, ˜˜˜, ˜˜˜*˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜.&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜.&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/news [˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜!&/news [˜˜˜˜˜˜˜˜]: ˜ ˜˜˜˜˜˜˜˜˜ - {my_ru_nick}!&/news [˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜...&/news [˜˜˜˜˜˜˜˜]: ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜, ˜ ˜˜˜, ˜˜˜ ˜˜˜˜˜ ˜˜˜ ...", arg = '', enable = true, waiting = '6', bind = "{}", in_fastmenu = false},
					{cmd = 'live_int2', description = '˜˜˜˜˜˜˜˜ (˜˜˜˜˜)', text = "/news [˜˜˜˜˜˜˜˜]: ˜ ˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜.&/news [˜˜˜˜˜˜˜]: ˜ ˜˜˜˜ ˜˜˜ ˜ - {my_ru_nick}.&/news [˜˜˜˜˜˜˜˜]: ˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜! ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜!&/news ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜&/d [{fraction_tag}] - [˜˜˜]: ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜!&/me ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜", arg = '', enable = true, waiting = '6', bind = "{}", in_fastmenu = false},
				},
				fd = {
					{cmd = 'siren', description = '˜˜˜/˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜/˜', text = '{switchCarSiren}', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'zd', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '˜˜˜˜˜˜˜˜˜˜˜˜, ˜ {my_ru_nick} - {fraction_rank} {fraction_tag}&˜˜˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜?', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
				},
				lc = {
					{cmd = 'zd', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '˜˜˜˜˜˜˜˜˜˜˜˜, ˜ {my_ru_nick} - {fraction_rank} {fraction_tag}&˜˜˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜? ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ - ˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'go', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜', text = '˜˜˜˜˜˜ {get_ru_nick({id})}, ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜.', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'gl', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '/me ˜˜˜˜{sex} ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜{sex} ˜˜˜&/do ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜{sex} ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/givelicense {id}&˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜!', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'prices', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜', text = '/todo ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜*˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜&/do ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜{sex} ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜ ˜˜˜˜˜{sex} ˜˜˜˜˜˜ ˜˜˜˜&˜˜ ˜˜˜˜˜˜˜˜˜˜: 1 ˜˜˜˜˜ - ${get_price_avto1}, 2 ˜˜˜˜˜˜ - ${get_price_avto2}, 3 ˜˜˜˜˜˜ - ${get_price_avto3}&˜˜ ˜˜˜˜: 1 ˜˜˜˜˜ - ${get_price_moto1}, 2 ˜˜˜˜˜˜ - ${get_price_moto2}, 3 ˜˜˜˜˜˜ - ${get_price_moto3}&˜˜ ˜˜˜˜˜˜: 1 ˜˜˜˜˜ - ${get_price_swim1}, 2 ˜˜˜˜˜˜ - ${get_price_swim2}, 3 ˜˜˜˜˜˜ - ${get_price_swim3}&˜˜ ˜˜˜˜˜: 1 ˜˜˜˜˜ - ${get_price_fly1}&˜˜ ˜˜˜˜˜˜: 1 ˜˜˜˜˜ - ${get_price_gun1}, 2 ˜˜˜˜˜˜ - ${get_price_gun2}, 3 ˜˜˜˜˜˜ - ${get_price_gun3}&˜˜ ˜˜˜˜˜: 1 ˜˜˜˜˜ - ${get_price_hunt1}, 2 ˜˜˜˜˜˜ - ${get_price_hunt2}, 3 ˜˜˜˜˜˜ - ${get_price_hunt3}&˜˜ ˜˜˜˜˜˜˜: 1 ˜˜˜˜˜ - ${get_price_fish1}, 2 ˜˜˜˜˜˜ - ${get_price_fish2}, 3 ˜˜˜˜˜˜ - ${get_price_fish3}&˜˜ ˜˜˜˜˜: 1 ˜˜˜˜˜ - ${get_price_klad1}, 2 ˜˜˜˜˜˜ - ${get_price_klad2}, 3 ˜˜˜˜˜˜ - ${get_price_klad3}&˜˜ ˜˜˜˜˜: 1 ˜˜˜˜˜ - ${get_price_taxi1}, 2 ˜˜˜˜˜˜ - ${get_price_taxi2}, 3 ˜˜˜˜˜˜ - ${get_price_taxi3}&˜˜ ˜˜˜˜˜˜˜˜: 1 ˜˜˜˜˜ - ${get_price_mexa1}, 2 ˜˜˜˜˜˜ - ${get_price_mexa2}, 3 ˜˜˜˜˜˜ - ${get_price_mexa3}&/todo ˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜˜*˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜', arg = '', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'medka', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜', text = '˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜.˜˜˜˜˜&/n @{get_nick({id})}, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /showmc {my_id} ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜.˜˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'exp', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜',  text = '˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜!&/me ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜&/expel {id} ˜.˜.˜.˜.', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
				},
				ins = {
					{cmd = 'zd', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '˜˜˜˜˜˜˜˜˜˜˜˜, ˜ {my_ru_nick} - {fraction_rank} {fraction_tag}&˜˜˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜? ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ - ˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'go', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜', text = '˜˜˜˜˜˜ {get_ru_nick({id})}, ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜.', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'ins', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜',  text = '˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜" ˜˜˜ "˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜"&˜˜˜ ˜˜˜ ˜˜˜˜˜? ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜&/insurance {id}&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'exp', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜',  text = '˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜!&/me ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜&/expel {id} ˜.˜.˜.˜.', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
				},
				gov = {		
					{cmd = 'zd', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '˜˜˜˜˜˜˜˜˜˜˜˜, ˜ {my_ru_nick} - {fraction_rank} {fraction_tag}&˜˜˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜?', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'go', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜', text = '˜˜˜˜˜˜ {get_ru_nick({id})}, ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜.', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'visit', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜˜{sex} ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜: "{my_ru_nick}, ˜˜˜˜˜˜˜ ˜˜˜˜˜".&/showvisit {id}', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'freely', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜',  text = '/do ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜{sex} ˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜˜{sex} ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜{sex} ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜*˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜&/free {id} 500000', arg = '{id}', enable = true, waiting = '2'},
					{cmd = 'visa', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜ VC',  text = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ 600 ˜˜˜˜˜. ˜˜ ˜˜˜˜˜˜˜˜?&˜˜˜˜ ˜˜, ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜&{pause}&/do ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜, ˜˜˜˜{sex} ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜{sex} ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜*˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜&/givevisa {id}', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'tsr', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜',  text = '/d [˜˜˜-˜˜] - [˜˜˜] ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜!', arg = '', enable = true, waiting = '2'},
					{cmd = 'car', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜/c ˜ ˜˜˜˜˜˜˜˜˜˜', text = '˜˜˜˜˜ ˜˜˜, ˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜&˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ 200 ˜˜&˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜&{pause}&˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜, ˜˜˜˜{sex} ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜{sex} ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜*˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜&/givepass {id}', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'wed', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜',  text = '˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜!&˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜!&˜˜˜˜˜˜˜ - ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜.&˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜.&˜ ˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜, ˜ ˜˜˜˜˜˜˜˜˜.&˜˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜.&˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜&{pause}&˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜.&˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/wedding {id} {arg}', arg = '{id} {arg}', enable = true, waiting = '2'},
					{cmd = 'pass', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜',  text = '/do ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜, ˜˜˜˜{sex} ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜{sex} ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜*˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜&/givepass {id}', arg = '{id}', enable = true, waiting = '2'},	
					{cmd = 'givesocial', description = '˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜˜˜˜˜˜',  text = '/me ˜˜˜˜{sex} ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ {get_ru_nick({id})} ˜˜˜ ˜˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜{sex} ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜˜˜{sex} ˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜{sex} ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜.˜˜˜˜˜ {get_ru_nick({id})}&/givesocial {id}', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
					{cmd = 'frisk', description = '˜˜˜˜˜ (7+)', text = '/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.&/me ˜˜˜˜{sex} ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜{sex} ˜˜&/do ˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/frisk {id}&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜{sex} ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜', arg = '{id}', enable = false, waiting = '2' },
					{cmd = 'gwarn', description = '˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜ (8+)',  text = '/do ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/gwarn {id} {arg}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', arg = '{id} {arg}', enable = false, waiting = '2', bind = "{}"},
					{cmd = 'ungwarn', description = '˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜ (8+)',  text = '/do ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/ungwarn {id}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', arg = '{id} {arg}', enable = false, waiting = '2', bind = "{}"},
					{cmd = 'Parsons', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜',  text = '˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜!&/me ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜&/expel {id} ˜.˜.˜.', arg = '{id}', enable = true, waiting = '2', in_fastmenu = true},
				},
				judge = {		
					{cmd = 'ud', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜', text = '/do ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜{sex} ˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜{sex} ˜˜˜˜˜˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜˜˜˜˜*˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜-˜˜˜˜.&/do ˜J2025 - <{my_ru_nick}> - ˜˜˜˜˜ ˜˜˜˜˜.', arg = '', enable = true, waiting = '2'},
				},
				mafia = {
					{cmd = 'tie', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '/do ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜{sex} ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜&/tie {id}', arg = '{id}', enable = true, waiting = '2', bind = '{}', in_fastmenu = true},
					{cmd = 'untie', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '/do ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜.&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜, ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜&/do ˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜.&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜{sex} ˜˜˜˜˜˜&/untie {id}', arg = '{id}', enable = true, waiting = '2', bind = '{}', in_fastmenu = true},
					{cmd = 'lead', description = '˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜', text = '/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜&/lead {id}', arg = '{id}', enable = true, waiting = '2', bind = '{}', in_fastmenu = true},
					{cmd = 'unlead', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜&/unlead {id}', arg = '{id}', enable = true, waiting = '2', bind = '{}', in_fastmenu = true},
					{cmd = 'gag', description = '˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜', text = '/do ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜&/do ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜{sex} ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜&/do ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜{sex} ˜ ˜˜˜ ˜˜˜˜˜˜&/gag {id}', arg = '{id}', enable = true, waiting = '2', bind = '{}', in_fastmenu = true},
					{cmd = 'ungag', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜{sex} ˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜{sex} ˜˜˜˜&/ungag {id}', arg = '{id}', enable = true, waiting = '2', bind = '{}', in_fastmenu = true},
					{cmd = 'bag', description = '˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '/do ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&/me ˜˜˜˜˜˜{sex} ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜{sex} ˜˜˜&/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜&/bag {id}', arg = '{id}', enable = true, waiting = '2', bind = '{}', in_fastmenu = true},
					{cmd = 'unbag', description = '˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜{sex} ˜˜˜ ˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜&/unbag {id}', arg = '{id}', enable = true, waiting = '2', bind = '{}', in_fastmenu = true},
					{cmd = 'in˜', description = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜&/me ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜&/incar {id} 3', arg = '{id}', enable = true, waiting = '2', bind = '{}', in_fastmenu = true},
				},
				ghetto = {}
			},
			commands_manage = {
				my = {},
				goss = {
					{cmd = 'inv', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜', text = '/do ˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜*˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/invite {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true  },
					{cmd = 'sr', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜ (˜˜˜˜˜˜˜)', text = '/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&{sellrank({id})}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true },
					{cmd = 'rp', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ /fractionrp', text = '/fractionrp {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'gr', description = '˜˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜ c˜˜˜˜˜˜˜˜˜', text = '{show_rank_menu}&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ {get_ru_nick({id})} ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜&/giverank {id} {get_rank}&/r ˜˜˜˜˜˜˜˜˜ {get_ru_nick({id})} ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'vize', description = '˜˜˜˜˜˜˜˜˜˜ Vice City ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ {get_ru_nick({id})} ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜&{lmenu_vc_vize}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'cjob', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜', text = '/checkjobprogress {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},	
					{cmd = 'fmutes', description = '˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ (10 min)', text = '/fmutes {id} ˜.˜.&/r ˜˜˜˜˜˜˜˜˜ {get_ru_nick({id})} ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ 10 ˜˜˜˜˜!', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true },
					{cmd = 'funmute', description = '˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜', text = '/funmute {id}&/r ˜˜˜˜˜˜˜˜˜ {get_ru_nick({id})} ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜!', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'vig', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ c˜˜˜˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ {get_ru_nick({id})} ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜&/fwarn {id} {arg}&/r ˜˜˜˜˜˜˜˜˜˜ {get_ru_nick({id})} ˜˜˜˜˜ ˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜: {arg}', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'unvig', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ c˜˜˜˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ {get_ru_nick({id})} ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜&/unfwarn {id}&/r ˜˜˜˜˜˜˜˜˜˜ {get_ru_nick({id})} ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜!', arg = '{id}', enable = true, waiting = '2', bind = "{}", in_fastmenu = true},
					{cmd = 'unv', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ {get_ru_nick({id})} ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜&/uninvite {id} {arg}&/r ˜˜˜˜˜˜˜˜˜ {get_ru_nick({id})} ˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜: {arg}', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'point', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜', text = '/r ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜...&/point', arg = '', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'govka', description = '˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜.˜˜˜˜˜', text = '/d [{fraction_tag}] - [˜˜˜˜]: ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜!&/gov [{fraction_tag}]: ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜!&/gov [{fraction_tag}]: ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ {fraction}&/gov [{fraction_tag}]: ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜ ˜˜˜˜.&/d [{fraction_tag}] - [˜˜˜˜]: ˜˜˜˜˜˜˜˜˜˜  ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜.', arg = '', enable = true, waiting = '2', bind = "{}"},
				},
				goss_fbi = {
					{cmd = 'demoute', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜',  text = '/do ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/demoute {id} {arg}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', arg = '{id} {arg}', enable = false, waiting = '2', bind = "{}"},
				},
				goss_prison = {
					{cmd = 'unpunish', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜', text = '/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜&/do ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜.&/me ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜, ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜ ˜˜˜˜&/me ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜&˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ...&... ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.&/unpunish {id} {arg}', arg = '{id} {arg}', enable = true, waiting = '2'},
					{cmd = 'rjailreklama', description = '˜˜˜˜˜˜˜ ˜˜˜', text = '/rjail ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.&/rjail ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.&/rjail ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜ (˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜) ˜˜˜˜˜˜˜!&/rjail ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜.', arg = '', enable = true, waiting = '2'}
				},
				goss_gov = {
					{cmd = 'lic', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', text = '/do ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜, ˜˜˜˜{sex} ˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜{sex} ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜*˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜&/givelicadvokat {id}', arg = '{id}', enable = true, waiting = '2', },
					{cmd = 'demoute', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜',  text = '/do ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜&/me ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜&/do ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&/demoute {id} {arg}&/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜ {fraction_tag} ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', arg = '{id} {arg}', enable = false, waiting = '2', bind = "{}"},
				},
				mafia = {
					{cmd = 'inv', description = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜', text = '/do ˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜&/todo ˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜*˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜&/invite {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'rp', description = '˜˜˜˜˜˜ /fractionrp', text = '/fractionrp {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'gr', description = '˜˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜ c˜˜˜˜˜˜˜˜˜', text = '{show_rank_menu}&/todo ˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜!*˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ &/giverank {id} {get_rank}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'fmutes', description = '˜˜˜˜˜˜ ˜˜˜ (10 min)', text = '/fmutes {id} ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'funmute', description = '˜˜˜˜˜ ˜˜˜', text = '/funmute {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'vig', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', text = '/f {get_ru_nick({id})}, ˜˜ ˜˜˜˜˜˜˜˜˜˜(-˜˜˜˜) ˜ {arg}!&/fwarn {id} {arg}', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'unvig', description = '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', text = '/f {get_ru_nick({id})}, ˜˜ ˜˜˜˜˜˜(-˜)!&/unfwarn {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'unv', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', text = '/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜&/uninvite {id} {arg}', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'point', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜', text = '/f ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜...&/point', arg = '', enable = true, waiting = '2', bind = "{}"},
				},
				ghetto = {
					{cmd = 'inv', description = '˜˜˜˜˜˜', text = '/todo ˜˜˜˜, ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜*˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.&/invite {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'rp', description = '˜˜˜˜˜ ˜˜', text = '/fractionrp {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'gr', description = '˜˜˜˜˜˜˜ ˜˜˜˜', text = '{show_rank_menu}&/todo ˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜!*˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ &/giverank {id} {get_rank}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'fmutes', description = '˜˜˜˜˜˜ ˜˜˜ (10˜)', text = '/fmutes {id} ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'funmute', description = '˜˜˜˜˜ ˜˜˜', text = '/funmute {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'vig', description = '˜˜˜˜ ˜˜˜˜˜˜˜', text = '/f {get_ru_nick({id})}, ˜˜ ˜˜˜˜˜˜˜˜˜˜(-˜˜˜˜) ˜ {arg}!&/fwarn {id} {arg}', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'unvig', description = '˜˜˜˜˜ ˜˜˜˜˜˜˜', text = '/f {get_ru_nick({id})}, ˜˜ ˜˜˜˜˜˜(-˜)!&/unfwarn {id}', arg = '{id}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'unv', description = '˜˜˜˜˜˜˜', text = '/r ˜˜˜˜˜˜˜˜˜˜, {get_ru_nick({id})}&/uninvite {id} {arg}', arg = '{id} {arg}', enable = true, waiting = '2', bind = "{}"},
					{cmd = 'point', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜', text = '/f ˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜!&/point', arg = '', enable = true, waiting = '2', bind = "{}"},
				}
			}
		}
	},
	piemenu = {
		name = '˜˜˜˜˜˜˜˜ ˜˜˜˜',
		path = config_dir .. "/PieMenu.json",
		data = {}
	},
	buttons = {
		name = '˜˜˜˜˜˜˜˜',
		path = config_dir .. "/Buttons.json",
		data = {
			{
				enable = true,
				name = '˜˜˜˜˜˜',
				icon = 'SHIELD',
				action = '/armour',
				size = {x = 100, y = 25},
				pos = {x = 100, y = 400}
			}
		}
	},
	notes = {
		name = '˜˜˜˜˜˜˜',
		path = config_dir .. "/Notes.json",
		data = {}
	},
	rpgun = {
		name = 'RP ˜˜˜˜˜˜',
		path = config_dir .. "/Guns.json",
		data = {
            rp_guns = {
                {id = 0, name = '˜˜˜˜˜˜', enable = true, rpTake = 2},
				{id = 1, name = '˜˜˜˜˜˜˜', enable = false, rpTake = 2},
				{id = 2, name = '˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜', enable = false, rpTake = 1},
				{id = 3, name = '˜˜˜˜˜˜˜', enable = true, rpTake = 3},
				{id = 4, name = '˜˜˜˜˜˜ ˜˜˜', enable = false, rpTake = 3},
				{id = 5, name = '˜˜˜˜', enable = false, rpTake = 1},
				{id = 6, name = '˜˜˜˜˜˜', enable = true, rpTake = 1},
				{id = 7, name = '˜˜˜', enable = false, rpTake = 1},
				{id = 8, name = '˜˜˜˜˜˜', enable = false, rpTake = 1},
				{id = 9, name = '˜˜˜˜˜˜˜˜˜', enable = false, rpTake = 1},
				{id = 10, name = '˜˜˜˜˜˜˜', enable = false, rpTake = 2},
				{id = 11, name = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', enable = false, rpTake = 2},
				{id = 12, name = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', enable = false, rpTake = 2},
				{id = 13, name = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', enable = false, rpTake = 2},
				{id = 14, name = '˜˜˜˜˜ ˜˜˜˜˜˜', enable = true, rpTake = 1},
				{id = 15, name = '˜˜˜˜˜˜', enable = false, rpTake = 1},
				{id = 16, name = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', enable = false, rpTake = 3},
				{id = 17, name = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', enable = true, rpTake = 3},
				{id = 18, name = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', enable = true, rpTake = 3},
				{id = 22, name = '˜˜˜˜˜˜˜˜ Colt45', enable = false, rpTake = 4},
				{id = 23, name = "˜˜˜˜˜˜˜˜˜˜˜˜ Taser X26P", enable = true, rpTake = 4},
				{id = 24, name = '˜˜˜˜˜˜˜˜ Desert Eagle', enable = true, rpTake = 4},
				{id = 25, name = '˜˜˜˜˜˜˜˜', enable = true, rpTake = 1},
				{id = 26, name = '˜˜˜˜˜', enable = true, rpTake = 4},
				{id = 27, name = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜', enable = false, rpTake = 1},
				{id = 28, name = '˜˜ Micro Uzi', enable = true, rpTake = 3},
				{id = 29, name = '˜˜ MP5', enable = true, rpTake = 4},
				{id = 30, name = '˜˜˜˜˜˜˜ AK47', enable = true, rpTake = 1},
				{id = 31, name = '˜˜˜˜˜˜˜ M4', enable = true, rpTake = 1},
				{id = 32, name = '˜˜ Tec9', enable = true, rpTake = 4},
				{id = 33, name = '˜˜˜˜˜˜˜˜ Rifle', enable = true, rpTake = 1},
				{id = 34, name = '˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', enable = true, rpTake = 1},
				{id = 35, name = '˜˜˜', enable = false, rpTake = 1},
				{id = 36, name = '˜˜˜˜', enable = false, rpTake = 1},
				{id = 37, name = '˜˜˜˜˜˜', enable = false, rpTake = 1},
				{id = 38, name = '˜˜˜˜˜˜˜', enable = false, rpTake = 1},
				{id = 39, name = '˜˜˜˜˜˜˜', enable = false, rpTake = 3},
				{id = 40, name = '˜˜˜˜˜˜˜˜˜', enable = false, rpTake = 3},
				{id = 41, name = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', enable = true, rpTake = 2},
				{id = 42, name = '˜˜˜˜˜˜˜˜˜˜˜˜', enable = true, rpTake = 1},
				{id = 43, name = '˜˜˜˜˜˜˜˜˜˜', enable = true, rpTake = 2},
				{id = 44, name = '˜˜˜', enable = false, rpTake = 3},
				{id = 45, name = '˜˜˜˜˜˜˜˜˜˜', enable = false, rpTake = 3},
				{id = 46, name = '˜˜˜˜˜˜˜', enable = true, rpTake = 1},
				-- gta sa damage reason
				{id = 49, name = '˜/˜', enable = false, rpTake = 1},
				{id = 50, name = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', enable = false, rpTake = 1},
				{id = 51, name = '˜˜˜˜˜˜˜', enable = false, rpTake = 1},
				{id = 54, name = '˜˜˜˜˜˜˜˜/˜˜˜˜˜˜', enable = false, rpTake = 1},
				-- ARZ CUSTOM GUN
				{id = 71, name = '˜˜˜˜˜˜˜˜ Desert Eagle Steel', enable = true, rpTake = 4},
				{id = 72, name = '˜˜˜˜˜˜˜˜ Desert Eagle Gold', enable = true, rpTake = 4},
				{id = 73, name = '˜˜˜˜˜˜˜˜ Glock Gradient', enable = true, rpTake = 4},
				{id = 74, name = '˜˜˜˜˜˜˜˜ Desert Eagle Flame', enable = true, rpTake = 4},
				{id = 75, name = '˜˜˜˜˜˜˜˜ Python Royal', enable = true, rpTake = 4},
				{id = 76, name = '˜˜˜˜˜˜˜˜ Python Silver', enable = true, rpTake = 4},
				{id = 77, name = '˜˜˜˜˜˜˜ AK-47 Roses', enable = true, rpTake = 1},
				{id = 78, name = '˜˜˜˜˜˜˜ AK-47 Gold', enable = true, rpTake = 1},
				{id = 79, name = '˜˜˜˜˜˜ M249 Graffiti', enable = true, rpTake = 1},
				{id = 80, name = '˜˜˜˜˜˜˜ ˜˜˜˜˜', enable = true, rpTake = 1},
				{id = 81, name = '˜˜ Standart', enable = true, rpTake = 4},
				{id = 82, name = '˜˜˜˜˜˜ M249', enable = true, rpTake = 1},
				{id = 83, name = '˜˜ Skorp', enable = true, rpTake = 4},
				{id = 84, name = '˜˜˜˜˜˜˜ AKS74 ˜˜˜˜˜˜˜˜˜˜˜', enable = true, rpTake = 1},
				{id = 85, name = '˜˜˜˜˜˜˜ AK47 ˜˜˜˜˜˜˜˜˜˜˜', enable = true, rpTake = 1},
				{id = 86, name = '˜˜˜˜˜˜˜˜ Rebecca', enable = true, rpTake = 1},
				{id = 87, name = 'Doomgun', enable = true, rpTake = 1},
				{id = 88, name = '˜˜˜˜˜˜˜ ˜˜˜', enable = true, rpTake = 1},
				{id = 89, name = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜', enable = true, rpTake = 4},
				{id = 90, name = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', enable = true, rpTake = 3},
				{id = 91, name = '˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', enable = true, rpTake = 3},
				{id = 92, name = '˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ TAC50', enable = true, rpTake = 1},
				{id = 93, name = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', enable = true, rpTake = 4},
				{id = 94, name = '˜˜˜˜˜˜˜ ˜˜˜˜˜', enable = true, rpTake = 1},
				{id = 95, name = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', enable = true, rpTake = 3},
				{id = 96, name = '˜˜˜˜˜˜˜ M4 Gold', enable = true, rpTake = 1},
				{id = 97, name = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', enable = true, rpTake = 1},
				{id = 98, name = '˜˜ Uzi Graffiti', enable = true, rpTake = 4},
				{id = 99, name = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜', enable = true, rpTake = 1},
				{id = 100, name = '˜˜˜˜ Compton', enable = true, rpTake = 1},
				{id = 101, name = '˜˜˜˜˜˜˜˜ SciFi Deagle', enable = true, rpTake = 4},
				{id = 102, name = '˜˜˜˜˜˜˜ SciFi AK47', enable = true, rpTake = 1},
				{id = 103, name = '˜˜˜˜˜˜˜˜ SciFi', enable = true, rpTake = 1},
				{id = 104, name = '˜˜˜ SciFi', enable = true, rpTake = 3},
				{id = 105, name = '˜˜˜˜˜˜', enable = false, rpTake = 4},
				{id = 106, name = '˜˜˜˜˜˜˜ ˜˜˜', enable = true, rpTake = 3},
				{id = 107, name = '˜˜˜˜˜˜ ˜˜˜', enable = true, rpTake = 1},
            },
            rpTakeNames = {
				{"˜˜-˜˜ ˜˜˜˜˜", "˜˜ ˜˜˜˜˜"},
				{"˜˜ ˜˜˜˜˜˜˜", "˜ ˜˜˜˜˜˜"},
				{"˜˜ ˜˜˜˜˜", "˜˜ ˜˜˜˜"},
				{"˜˜ ˜˜˜˜˜˜", "˜ ˜˜˜˜˜˜"}
			},
            gunActions = {
                on = {},
                off = {},
                partOn = {},
                partOff = {}
            },
			byId = {},
            oldGun = nil,
            nowGun = 0
        }
	},
    smart_uk = {
		name = '˜˜˜˜˜ ˜˜˜˜˜˜',
		path = config_dir .. "/SmartUK.json",
		data = {}
	},
    smart_pdd = {
		name = '˜˜˜˜˜ ˜˜˜˜˜˜',
		path = config_dir .. "/SmartPDD.json",
		data = {}
	},
    smart_rptp = {
		name = '˜˜˜˜˜ ˜˜˜˜',
		path = config_dir .. "/SmartRPTP.json",
		data = {}
	},
	arz_veh = {
		name = '˜˜˜˜˜˜˜˜˜',
		path = config_dir .. "/Vehicles.json",
		data = {},
		byId = {},	
		cache = {}
	},
	ads_history = {
		name = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜',
		path = config_dir .. "/ADS.json",
		data = {}
	}
}
function save_module(key)
    local obj = modules[key]
	if not obj then
		print('˜˜˜˜˜˜: ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ "' .. key .. '"!')
	else
		local file, errstr = io.open(obj.path, 'w')
		if file then
			local content = encode_table(obj.data)
			if content then
				file:write(content)
				print('˜˜˜˜˜˜ "' .. obj.name .. '" ˜˜˜˜˜˜˜˜!')
			else
				print('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ "' .. obj.name .. '" - ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ json!')
			end
			file:close()
		else
			print('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ "' .. obj.name .. '", ˜˜˜˜˜˜: ' .. (errstr or "Unknown"))
		end
	end
end
function load_module(key)
    local obj = modules[key]
	if not obj then
		print('˜˜˜˜˜˜: ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ "' .. key .. '"!')
	else
		if doesFileExist(obj.path) then
			local file, errstr = io.open(obj.path, 'r')
			if file then
				local contents = file:read('*a')
				file:close()
				if #contents == 0 then
					print('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ "' .. obj.name .. '". ˜˜˜˜˜˜˜: ˜˜˜˜ ˜˜˜˜˜˜')
				else
					local result, loaded = pcall(decodeJson, contents)
					if result then
						print('˜˜˜˜˜˜ "' .. obj.name .. '" ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜! (˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜)')
						local changed = merge_defaults(obj.data, loaded)
						obj.data = loaded
						if changed then save_module(key) end
					else
						print('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ "' .. obj.name .. '". ˜˜˜˜˜˜: decode json')
					end
				end
			else
				print('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ "' .. obj.name .. '". ˜˜˜˜˜˜: ' .. (errstr or "Unknown"))
			end
		else
			print('˜˜˜˜˜˜ "' .. obj.name .. '" ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜!')
		end
	end
end
------------------------------------------- GUI & MODULES ----------------------------------------
local MODULE = {
	Initial = {
		Window = imgui.new.bool(),
		input = imgui.new.char[256](),
		slider = imgui.new.int(0),
		step = 0,
		fraction_type_selector = 0,
		fraction_type_selector_text = '˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜',
		fraction_type_icon = nil,
		step2_result = 0,
		fraction_selector = 0,
		fraction_selector_text = '',
	},
	Main = {
		Window = imgui.new.bool(),
		theme = imgui.new.int(tonumber(settings.general.helper_theme)),
		input = imgui.new.char[256](),
		checkbox = {
			accent_enable = imgui.new.bool(settings.general.accent_enable or false),
			mobile_stop_button = imgui.new.bool(settings.general.mobile_stop_button or false),
			mobile_fastmenu_button = imgui.new.bool(settings.general.mobile_fastmenu_button or false),
			mobile_piemenu_button = imgui.new.bool(settings.general.piemenu or false),
		},
		slider = {
			transparent = imgui.new.int(tonumber(settings.general.transparent)),
			rank = imgui.new.int(),
			dpi = imgui.new.float(tonumber(settings.general.custom_dpi)),
		},
		mmcolor = imgui.new.float[3](),
		msgcolor = imgui.new.float[3](),
	},
	Binder = {
		Window = imgui.new.bool(),
		waiting_slider = imgui.new.float(0),
		ComboTags = imgui.new.int(),
		input_cmd = imgui.new.char[256](),
		input_description = imgui.new.char[256](),
		input_text = imgui.new.char[8192](),
		item_list = {
			u8('˜˜˜ ˜˜˜˜˜˜˜˜˜˜'),
			u8('˜˜˜˜˜ ˜˜˜˜˜˜˜˜'),
			u8('ID ˜˜˜˜˜˜'),
			u8('ID ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜ /vig 429 ˜˜˜ ˜˜˜˜˜˜˜˜)'),
			u8('ID ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜  (˜˜˜˜˜˜ /su 429 2 ˜˜˜˜˜˜˜˜˜˜˜˜)')
		},
		ImItems = nil,
		data = {
			change_waiting = nil,
			change_cmd = nil,
			change_text = nil,
			change_arg = nil,
			change_bind = nil,
			create_command_9_10 = false,
			input_description = nil
		},
		state = {
			isActive = false,
			isStop = false,
			isPause = false
		},
		input_search_tag = imgui.new.char[64](),
		tag = {},
		tags = {},
	},
	Note = {
		Window = imgui.new.bool(),
		input_text = imgui.new.char[1048576](),
		input_name = imgui.new.char[256](),
		show_note_name = '',
		show_note_text = '',
	},
	Buttons = {
		Editor = {
			icon = '',
			name = imgui.new.char[256](),
			action = imgui.new.char[256](),
			size = {x = imgui.new.int(75), y = imgui.new.int(25)}
		}
	},
	Members = {
		Window = imgui.new.bool(),
		all = {},
		new = {},
		upd = {
				check = false,
				last_time = 0
		},
		info = {fraction = '', check = false},
	},
	RPWeapon = {
		Window = imgui.new.bool(),
		ComboTags = imgui.new.int(),
		item_list = {u8'˜˜˜˜˜', u8'˜˜˜˜˜˜', u8'˜˜˜˜', u8'˜˜˜˜˜˜'},
		ImItems = imgui.new['const char*'][4]({u8'˜˜˜˜˜', u8'˜˜˜˜˜˜', u8'˜˜˜˜', u8'˜˜˜˜˜˜'}),
		input_search = imgui.new.char[256]('')
	},
	CruiseControl = {
		active = false,
		wait_point = false,
		point = {x = 0, y = 0, z = 0}
	},
	-- goss
	Departament = {
		Window = imgui.new.bool(),
		text = imgui.new.char[256](),
		fm = imgui.new.char[32](u8(modules.departament.data.dep_fm)),
		tag1 = imgui.new.char[32](u8(modules.departament.data.dep_tag1)),
		tag2 = imgui.new.char[32](u8(modules.departament.data.dep_tag2)),
		new_tag = imgui.new.char[32](),
		checkbox = {anti_skobki = imgui.new.bool(modules.departament.data.anti_skobki or false)},
		selector = {tag = imgui.new.int(0), fm = imgui.new.int(0)}
	},
	Post = {
		Window = imgui.new.bool(),
		input = imgui.new.char[256](),
		ComboCode = imgui.new.int(5),
		codes = {'CODE 0', 'CODE 1', 'CODE 2', 'CODE 2 HIGHT', 'CODE 3', 'CODE 4', 'CODE 4 ADAM', 'CODE 5', 'CODE 6', 'CODE 7', 'CODE 30', 'CODE 30 RINGER', 'CODE 37', 'CODE TOM'},
		ImItemsCode = nil,
		name = '',
		code = 'CODE 4',
		active = false,
		start_time = 0,
		current_time = 0,
		time = 0,
		process_doklad = false,
	},
	-- mj
	Wanted = {
		Window = imgui.new.bool(),
		updwanteds = {},
		all = {},
		new = {},
		checker = false,
	},
	Patrool = {
		Window = imgui.new.bool(),
		ComboMark = imgui.new.int(1),
		marks = {'ADAM', 'LINCOLN', 'MARY', 'KING', 'HENRY', 'AIR', 'ASD', 'CHARLIE', 'ROBERT', 'SUPERVISOR', 'DAVID', 'EDWARD', 'NORA'},
		ImItemsMark = nil,
		ComboCode = imgui.new.int(5),
		codes = {'CODE 0', 'CODE 1', 'CODE 2', 'CODE 2 HIGHT', 'CODE 3', 'CODE 4', 'CODE 4 ADAM', 'CODE 5', 'CODE 6', 'CODE 7', 'CODE 30', 'CODE 30 RINGER', 'CODE 37', 'CODE TOM'},
		ImItemsCode = nil,
		active = false,
		start_time = 0,
		current_time = 0,
		time = 0,
		process_doklad = false,
		code = 'CODE 4',
		mark = 'ADAM',
	},
	SumMenu = {
		Window = imgui.new.bool(),
		input = imgui.new.char[256](),
		form_su = '',
	},
	TsmMenu = {
		Window = imgui.new.bool(),
		input = imgui.new.char[256](),
	},
	-- prison
	ArmyPatrool = {
		post = ''
	},
	PumMenu = {
		Window = imgui.new.bool(),
		input = imgui.new.char[256](),
	},
	-- hospital
	MedCard = {
		Window = imgui.new.bool(),
		days = imgui.new.int(3),
		status = imgui.new.int(3)
	},
	Recept = {
		Window = imgui.new.bool(),
		recepts = imgui.new.int(1)
	},
	Antibiotik = {
		Window = imgui.new.bool(),
		ants = imgui.new.int(1)
	},
	HealChat = {
		Window = imgui.new.bool(),
		bool = false,
		player_id = nil,
		worlds = {'˜˜˜˜˜˜', '˜˜˜˜', '˜˜˜', '˜˜˜', 'heal', 'hil', 'lek', '˜˜˜˜', '˜˜˜˜˜', '˜˜˜˜˜˜', '˜˜˜˜˜', 'ktr', 'ktxb', 'ujkjdf'},
	},
	GoDeath = {
		player_id = nil,
		locate = '',
		city = ''
	},
	MedicalPrice = {
		heal         = imgui.new.char[12](u8(settings.mh.price.heal)),
		heal_vc      = imgui.new.char[12](u8(settings.mh.price.heal_vc)),
		healactor    = imgui.new.char[12](u8(settings.mh.price.healactor)),
		healactor_vc = imgui.new.char[12](u8(settings.mh.price.healactor_vc)),
		medosm       = imgui.new.char[12](u8(settings.mh.price.medosm)),
		mticket      = imgui.new.char[12](u8(settings.mh.price.mticket)),
		healbad      = imgui.new.char[12](u8(settings.mh.price.healbad)),
		recept       = imgui.new.char[12](u8(settings.mh.price.recept)),
		ant          = imgui.new.char[12](u8(settings.mh.price.ant)),
		med7         = imgui.new.char[12](u8(settings.mh.price.med7)),
		med14        = imgui.new.char[12](u8(settings.mh.price.med14)),
		med30        = imgui.new.char[12](u8(settings.mh.price.med30)),
		med60        = imgui.new.char[12](u8(settings.mh.price.med60)),
	},
	-- SMI
	SmiEdit = {
		Window = imgui.new.bool(),
		input_edit_text = imgui.new.char[512](),
		input_search = imgui.new.char[256](),
		ad_message = '',
		ad_from = '',
		ad_dialog_id = '',
		adshistory_orig = '',
		adshistory_input_text = imgui.new.char[512](),
		skip_dialogd = false,
		ad_repeat_count = 0,
		last_ad_text = "",
		vip_pause = false,
		is_active_ad = false
	},
	-- AS
	LicensePrice = {
		avto1 = imgui.new.char[12](u8(settings.lc.price.avto1)),
		avto2 = imgui.new.char[12](u8(settings.lc.price.avto2)),
		avto3 = imgui.new.char[12](u8(settings.lc.price.avto3)),
		moto1 = imgui.new.char[12](u8(settings.lc.price.moto1)),
		moto2 = imgui.new.char[12](u8(settings.lc.price.moto2)),
		moto3 = imgui.new.char[12](u8(settings.lc.price.moto3)),
		fish1 = imgui.new.char[12](u8(settings.lc.price.fish1)),
		fish2 = imgui.new.char[12](u8(settings.lc.price.fish2)),
		fish3 = imgui.new.char[12](u8(settings.lc.price.fish3)),
		swim1 = imgui.new.char[12](u8(settings.lc.price.swim1)),
		swim2 = imgui.new.char[12](u8(settings.lc.price.swim2)),
		swim3 = imgui.new.char[12](u8(settings.lc.price.swim3)),
		gun1 = imgui.new.char[12](u8(settings.lc.price.gun1)),
		gun2 = imgui.new.char[12](u8(settings.lc.price.gun2)),
		gun3 = imgui.new.char[12](u8(settings.lc.price.gun3)),
		hunt1 = imgui.new.char[12](u8(settings.lc.price.hunt1)),
		hunt2 = imgui.new.char[12](u8(settings.lc.price.hunt2)),
		hunt3 = imgui.new.char[12](u8(settings.lc.price.hunt3)),
		klad1 = imgui.new.char[12](u8(settings.lc.price.klad1)),
		klad2 = imgui.new.char[12](u8(settings.lc.price.klad2)),
		klad3 = imgui.new.char[12](u8(settings.lc.price.klad3)),
		taxi1 = imgui.new.char[12](u8(settings.lc.price.taxi1)),
		taxi2 = imgui.new.char[12](u8(settings.lc.price.taxi2)),
		taxi3 = imgui.new.char[12](u8(settings.lc.price.taxi3)),
		mexa1 = imgui.new.char[12](u8(settings.lc.price.mexa1)),
		mexa2 = imgui.new.char[12](u8(settings.lc.price.mexa2)),
		mexa3 = imgui.new.char[12](u8(settings.lc.price.mexa3)),
		fly1 = imgui.new.char[12](u8(settings.lc.price.fly1)),
		fly2 = imgui.new.char[12](u8(settings.lc.price.fly2)),
		fly3 = imgui.new.char[12](u8(settings.lc.price.fly3)),
		train1 = imgui.new.char[12](u8(settings.lc.price.train1)) -- rodina
	},
	-- FD
	Fires = {
		isZone = false,
		isDialog = false,
		dialogId = -1,
		location = '',
		locations = '',
		lvl = '-1',
	},
	-- INS
	Ins = {
		catch_ticket = {enable = false, nickname = nil},
	},
	-- GOV
	Zeks = {
		Window = imgui.new.bool(),
		updzeks = {},
		all = {},
		new = {},
		checker = false,
	},
	-- 9/10
	GiveRank = {
		Window = imgui.new.bool(),
		number = imgui.new.int(5)
	},
	Sobes = {
		Window = imgui.new.bool()
	},
	LeadTools = {
		vc_vize = {bool = false, player_id = nil},
		auto_uninvite = {checker = false, msg1 = '', msg2 = '', msg3 = ''},
		spawncar = false,
		platoon = {check = false, player_id = nil},
		cleaner = {day_afk = 0, reason_day = 0, uninvite = false, players_to_kick = {}},
		sell_rank = {checker = false, player_id = nil},
	},
	-- others
	Update = {
		Window = imgui.new.bool(),
		is_need_update = false,
		version = "",
		url = "",
		info = "",
		download_file = ""
	},
	CommandStop = {
		Window = imgui.new.bool()
	},
	CommandPause = {
		Window = imgui.new.bool()
	},
	LeaderFastMenu = {
		Window = imgui.new.bool()
	},
	FastMenu = {
		Window = imgui.new.bool()
	},
	PieMenu = {
		Window = imgui.new.bool(),
		editor = {
			icon = imgui.new.char[32](),
			name = imgui.new.char[32](),
			action = imgui.new.char[256](),
			selector = imgui.new.int(0),
			current = nil,
			history = {},
			title = '',
			item = nil
		}
	},
	FastMenuButton = {
		Window = imgui.new.bool()
	},
	FastMenuPlayers = {
		Window = imgui.new.bool()
	},
	Icons = {
		keys = {},
		input = imgui.new.char[32](),
		
	},
	InfraredVision = false,
	NightVision = false,
	INPUT = {
		CURSOR_POS = 0,
		SELECTION_START = 0,
		SELECTION_END = 0,
		USER_MOVED_CURSOR = false,
	},
	FONT = nil,
	DEBUG = false,
	MOBILE_PLAYER_ID = -1
}
MODULE.Patrool.ImItemsMark = imgui.new['const char*'][#MODULE.Patrool.marks](MODULE.Patrool.marks)
MODULE.Patrool.ImItemsCode = imgui.new['const char*'][#MODULE.Patrool.codes](MODULE.Patrool.codes)
MODULE.Post.ImItemsCode = imgui.new['const char*'][#MODULE.Post.codes](MODULE.Post.codes)
MODULE.Binder.ImItems = imgui.new['const char*'][#MODULE.Binder.item_list](MODULE.Binder.item_list)
MODULE.Binder.tags = {
	-- ˜˜˜˜˜
    {
        key = "my_id",
        description = "˜˜˜ ID",
        category = "˜˜˜˜˜",
		mode = 'all',
        func = function()
			if IS_MOBILE then
				return MODULE.MOBILE_PLAYER_ID
			else
				return select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
			end
        end
    },
	{
		key = "my_ru_nick",
		description = "˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function() return modules.player.data.name_surname end
	},
    {
        key = "my_nick",
        description = "˜˜˜ ˜˜˜˜˜˜˜",
        category = "˜˜˜˜˜",
		mode = 'all',
        func = function()
            return modules.player.data.nick
        end
    },
	{
		key = "my_rp_nick",
		description = "˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ _",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function()
			return modules.player.data.nick:gsub('_',' ')
		end
	},
	{
		key = "my_doklad_nick",
		description = "˜˜˜˜ ˜.˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function()
			local nick = modules.player.data.nick
			local name, surname = nick:match('^(.+)%_(.+)$')
			if name and surname then
				return name:sub(1,1).."."..surname
			end
			return nick
		end
	},
	{
		key = "sex",
		description = "˜˜˜˜˜˜ '˜' ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function()
			return (modules.player.data.sex == '˜˜˜˜˜˜˜') and 'a' or ''
		end
	},
	-- ˜˜˜˜˜˜˜
	{
		key = "fraction",
		description = "˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜",
		mode = "all",
		func = function() return modules.player.data.fraction end
	},
	{
		key = "fraction_rank",
		description = "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜",
		mode = "all",
		func = function() return modules.player.data.fraction_rank end
	},
	{
		key = "fraction_rank_number",
		description = "˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜",
		mode = "all",
		func = function() return modules.player.data.fraction_rank_number end
	},
	{
		key = "fraction_tag",
		description = "˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜",
		mode = "all",
		func = function() return modules.player.data.fraction_tag end
	},
	-- ˜˜˜˜˜
	{
		key = "get_nick({id})",
		description = "˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ID",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function() return '' end
	},
	{
		key = "get_rp_nick({id})",
		description = "˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ID ˜˜˜ _",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function() return '' end
	},
	{
		key = "get_ru_nick({id})",
		description = "˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ID",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function() return '' end
	},
	{
		key = "get_time",
		description = "˜˜˜˜˜˜˜ ˜˜˜˜˜",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function() return os.date("%H:%M:%S") end
	},
	{
		key = "get_date",
		description = "˜˜˜˜˜˜˜ ˜˜˜˜",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function() return os.date("%d.%m.%Y") end
	},
	{
		key = "get_rank",
		description = "˜˜˜˜˜˜˜˜˜ ˜˜˜˜",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function() return MODULE.GiveRank.number[0] end
	},
	{
		key = "get_square",
		description = "˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function()
			local KV = {[1]="˜",[2]="˜",[3]="˜",[4]="˜",[5]="˜",[6]="˜",[7]="˜",[8]="˜",[9]="˜",[10]="˜",[11]="˜",[12]="˜",[13]="˜",[14]="˜",[15]="˜",[16]="˜",[17]="˜",[18]="˜",[19]="˜",[20]="˜",[21]="˜",[22]="˜",[23]="˜",[24]="˜"}
			local X,Y,Z = getCharCoordinates(playerPed)
			X = math.ceil((X+3000)/250)
			Y = math.ceil((Y*-1+3000)/250)
			Y = KV[Y]
			if Y then return (Y .. '-' .. X) else return X end
		end
	},
	{
		key = "get_area",
		description = "˜˜˜˜˜˜˜ ˜˜˜˜˜",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function()
			local x,y,z = getCharCoordinates(PLAYER_PED)
			return get_area(x,y,z)
		end
	},
	{
		key = "get_city",
		description = "˜˜˜˜˜˜˜ ˜˜˜˜˜",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function()
			local city = {[0]="˜˜˜ ˜˜˜˜˜˜",[1]="˜˜˜ ˜˜˜˜˜˜",[2]="˜˜˜ ˜˜˜˜˜˜",[3]="˜˜˜ ˜˜˜˜˜˜˜˜"}
			return city[getCityPlayerIsIn(PLAYER_PED)]
		end
	},
	{
		key = "get_nearest_car",
		description = "˜˜˜˜˜˜˜˜˜ ˜/˜",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function() return get_near_car() end
	},
	{
		key = "get_drived_car",
		description = "˜˜˜˜˜˜˜˜˜ ˜/˜ ˜ ˜˜˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜",
		mode = "all",
		func = function() return get_near_car(true) end
	},
	-- ˜˜˜˜˜˜˜˜˜
	{
		key = "get_car_units",
		description = "˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜/˜",
		category = "˜˜˜˜˜˜˜˜˜",
		mode = "all",
		func = function()
			if isCharInAnyCar(PLAYER_PED) then
				local car = storeCarCharIsInNoSave(PLAYER_PED)
				local success, passengers = getNumberOfPassengers(car)
				if IS_MOBILE and success and passengers == nil then
					passengers = success
				end
				if success and passengers and tonumber(passengers) > 0 then
					local my_passengers = {}
					for k, v in ipairs(getAllChars()) do
						local res, id = sampGetPlayerIdByCharHandle(v)
						if res and id ~= select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then
							if isCharInAnyCar(v) then
								if car == storeCarCharIsInNoSave(v) then
									table.insert(my_passengers, id)
								end
							end
						end
					end
					if #my_passengers ~= 0 then
						local units = ''
						for _, idd in ipairs(my_passengers) do
							local nickname = sampGetPlayerNickname(idd)
							local first_letter = nickname:sub(1, 1)
							local last_name = nickname:match(".*_(.*)")
							if last_name then
								units = units .. first_letter .. "." .. last_name .. ' '
							else
								units = units .. nickname .. ' '
							end
						end
						return units
					else
						return '˜˜˜˜'
					end
				else
					return '˜˜˜˜'
				end
			else
				return '˜˜˜˜'
			end
		end
	},
	{
		key = "switchCarSiren",
		description = "˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜˜",
		mode = "all",
		func = function()
			if isCharInAnyCar(PLAYER_PED) then
				local car = storeCarCharIsInNoSave(PLAYER_PED)
				if getDriverOfCar(car) == PLAYER_PED then
					switchCarSiren(car, not isCarSirenOn(car))
					return '/me ' .. (isCarSirenOn(car) and '˜˜˜˜˜˜˜˜' or '˜˜˜˜˜˜˜˜˜') .. ' ˜˜˜˜˜˜˜'
				else
					return (isCarSirenOn(car) and '˜˜˜˜˜˜˜' or '˜˜˜˜˜˜') .. ' ˜˜˜˜˜˜˜!'
				end
			else
				return "˜˜˜"
			end
		end
	},
	-- ˜˜˜˜
	{
		key = "get_post_name",
		description = "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜",
		category = "˜˜˜˜",
		mode = "all",
		func = function() return MODULE.Post.name end
	},
	{
		key = "get_post_code",
		description = "˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜-˜˜˜",
		category = "˜˜˜˜",
		mode = "all",
		func = function() return MODULE.Post.code end
	},
	{
		key = "get_post_time",
		description = "˜˜˜˜˜ ˜˜ ˜˜˜˜˜",
		category = "˜˜˜˜",
		mode = "all",
		func = function()
			local hours = math.floor(MODULE.Post.time / 3600)
			local minutes = math.floor(( MODULE.Post.time % 3600) / 60)
			local secs = MODULE.Post.time % 60
			if hours > 0 then
				return string.format("%02d:%02d:%02d", hours, minutes, secs)
			else
				return string.format("%02d:%02d", minutes, secs)
			end
		end
	},
	{
		key = "get_post_format_time",
		description = "˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜",
		category = "˜˜˜˜",
		mode = "all",
		func = function()
			local hours = math.floor(MODULE.Post.time / 3600)
			local minutes = math.floor((MODULE.Post.time % 3600) / 60)
			local secs = MODULE.Post.time % 60
			if hours > 0 then
				return string.format("%d ˜˜˜˜˜ %d ˜˜˜˜˜ %d ˜˜˜˜˜˜", hours, minutes, secs)
			elseif minutes > 0 then
				return string.format("%d ˜˜˜˜˜ %d ˜˜˜˜˜˜", minutes, secs)
			else
				return string.format("%d ˜˜˜˜˜˜(-˜)", secs)
			end
		end
	},
	-- ˜˜˜˜˜˜˜
	{
		key = "get_form_su",
		description = "˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜",
		mode = "police",
		func = function() return MODULE.SumMenu.form_su end
	},
	{
		key = "get_patrool_mark",
		description = "˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜",
		mode = "police",
		func = function()
			if IS_MOBILE then
				return MODULE.Patrool.mark .. '-' .. MODULE.MOBILE_PLAYER_ID
			else
				return MODULE.Patrool.mark .. '-' .. select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
			end
		end
	},
	{
		key = "get_patrool_code",
		description = "˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜-˜˜˜",
		category = "˜˜˜˜˜˜˜",
		mode = "police",
		func = function() return MODULE.Patrool.code end
	},
	{
		key = "get_patrool_time",
		description = "˜˜˜˜˜ ˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜",
		mode = "police",
		func = function()
			local hours = math.floor(MODULE.Patrool.time / 3600)
			local minutes = math.floor((MODULE.Patrool.time % 3600) / 60)
			local secs = MODULE.Patrool.time % 60
			if hours > 0 then
				return string.format("%02d:%02d:%02d", hours, minutes, secs)
			else
				return string.format("%02d:%02d", minutes, secs)
			end
		end
	},
	{
		key = "get_patrool_format_time",
		description = "˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜",
		mode = "police",
		func = function()
			local hours = math.floor(MODULE.Patrool.time / 3600)
			local minutes = math.floor((MODULE.Patrool.time % 3600) / 60)
			local secs = MODULE.Patrool.time % 60
			if hours > 0 then
				return string.format("%d ˜˜˜˜˜ %d ˜˜˜˜˜ %d ˜˜˜˜˜˜", hours, minutes, secs)
			elseif minutes > 0 then
				return string.format("%d ˜˜˜˜˜ %d ˜˜˜˜˜˜", minutes, secs)
			else
				return string.format("%d ˜˜˜˜˜˜(-˜)", secs)
			end
		end
	},
	-- ˜˜˜˜˜˜˜˜
	{
		key = "get_price_heal",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			if sampGetCurrentServerName():find("Vice City") then
				return settings.mh.price.heal_vc
			else
				return settings.mh.price.heal
			end
		end
	},
	{
		key = "get_price_actorheal",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			if u8(sampGetCurrentServerName()):find("Vice City") then
				return settings.mh.price.healactor_vc
			else
				return settings.mh.price.healactor
			end
		end
	},
	{
		key = "get_price_medosm",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return settings.mh.price.medosm
		end
	},
	{
		key = "get_price_mticket",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return settings.mh.price.mticket
		end
	},
	{
		key = "get_price_healbad",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return settings.mh.price.healbad
		end
	},
	{
		key = "get_price_ant",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return settings.mh.price.ant
		end
	},
	{
		key = "get_price_recept",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return settings.mh.price.recept
		end
	},
	{
		key = "get_price_med7",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ (7 ˜˜˜˜)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return settings.mh.price.med7
		end
	},
	{
		key = "get_price_med14",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ (14 ˜˜˜˜)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return settings.mh.price.med14
		end
	},
	{
		key = "get_price_med30",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ (30 ˜˜˜˜)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return settings.mh.price.med30
		end
	},
	{
		key = "get_price_med60",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ (60 ˜˜˜˜)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return settings.mh.price.med60
		end
	},
	{
		key = "get_medcard_days",
		description = "˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return MODULE.MedCard.days[0]
		end
	},
	{
		key = "get_medcard_status",
		description = "˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return MODULE.MedCard.status[0]
		end
	},
	{
		key = "get_medcard_price",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			if MODULE.MedCard.days[0] == 0 then
				return settings.mh.price.med7
			elseif MODULE.MedCard.days[0] == 1 then
				return settings.mh.price.med14
			elseif MODULE.MedCard.days[0] == 2 then
				return settings.mh.price.med30
			elseif MODULE.MedCard.days[0] == 3 then
				return settings.mh.price.med60
			else
				return 1000
			end
		end
	},
	{
		key = "get_recepts",
		description = "˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return MODULE.Recept.recepts[0]
		end
	},
	{
		key = "get_ants",
		description = "˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "hospital",
		func = function()
			return MODULE.Antibiotik.ants[0]
		end
	},
	-- ˜˜˜˜˜˜˜˜
	{
		key = "get_price_avto1",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ (1)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.avto1 end
	},
	{
		key = "get_price_avto2",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ (2)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.avto2 end
	},
	{
		key = "get_price_avto3",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ (3)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.avto3 end
	},
	{
		key = "get_price_moto1",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ (1)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.moto1 end
	},
	{
		key = "get_price_moto2",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ (2)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.moto2 end
	},
	{
		key = "get_price_moto3",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ (3)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.moto3 end
	},
	{
		key = "get_price_fish1",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (1)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.fish1 end
	},
	{
		key = "get_price_fish2",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (2)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.fish2 end
	},
	{
		key = "get_price_fish3",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (3)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.fish3 end
	},
	{
		key = "get_price_swim1",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ (1)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.swim1 end
	},
	{
		key = "get_price_swim2",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ (2)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.swim2 end
	},
	{
		key = "get_price_swim3",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ (3)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.swim3 end
	},
	{
		key = "get_price_gun1",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (1)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.gun1 end
	},
	{
		key = "get_price_gun2",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (2)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.gun2 end
	},
	{
		key = "get_price_gun3",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (3)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.gun3 end
	},
	{
		key = "get_price_hunt1",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ (1)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.hunt1 end
	},
	{
		key = "get_price_hunt2",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ (2)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.hunt2 end
	},
	{
		key = "get_price_hunt3",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ (3)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.hunt3 end
	},
	{
		key = "get_price_klad1",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ (1)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.klad1 end
	},
	{
		key = "get_price_klad2",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ (2)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.klad2 end
	},
	{
		key = "get_price_klad3",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ (3)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.klad3 end
	},
	{
		key = "get_price_taxi1",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ (1)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.taxi1 end
	},
	{
		key = "get_price_taxi2",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ (2)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.taxi2 end
	},
	{
		key = "get_price_taxi3",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ (3)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.taxi3 end
	},
	{
		key = "get_price_mexa1",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ (1)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.mexa1 end
	},
	{
		key = "get_price_mexa2",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ (2)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.mexa2 end
	},
	{
		key = "get_price_mexa3",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ (3)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.mexa3 end
	},
	{
		key = "get_price_fly1",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (1)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.fly1 end
	},
	{
		key = "get_price_fly2",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (2)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.fly2 end
	},
	{
		key = "get_price_fly3",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (3)",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.fly3 end
	},
	{
		key = "get_price_train1",
		description = "˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜",
		category = "˜˜˜˜˜˜˜˜",
		mode = "lc",
		func = function() return settings.lc.price.train1 end
	},
}
for _, tag in ipairs(MODULE.Binder.tags) do MODULE.Binder.tag[tag.key] = tag.func end
----------------------------------------- MoonMonet & Colors -------------------------------------
function rgbToHex(rgb)
	return string.format("%02X%02X%02X", bit.band(bit.rshift(rgb, 16), 0xFF), bit.band(bit.rshift(rgb, 8), 0xFF), bit.band(rgb, 0xFF))
end
function color_to_float3(u32color)
    local temp = imgui.ColorConvertU32ToFloat4(u32color)
    return temp.z, temp.y, temp.x
end
if settings.general.helper_theme == 0 and monet_no_errors then
	message_color = settings.general.moonmonet_theme_color
	message_color_hex = '{' ..  rgbToHex(settings.general.moonmonet_theme_color) .. '}'
	MODULE.Main.msgcolor[0], MODULE.Main.msgcolor[1], MODULE.Main.msgcolor[2] = color_to_float3(settings.general.moonmonet_theme_color)
	MODULE.Main.mmcolor[0], MODULE.Main.mmcolor[1], MODULE.Main.mmcolor[2] = color_to_float3(settings.general.moonmonet_theme_color)
else
	if settings.general.helper_theme == 0 then
		print('˜˜˜˜˜˜˜˜˜˜ MoonMonet ˜˜˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜ Dark Theme ˜˜ ˜˜˜˜˜˜˜')
		settings.general.helper_theme = 1
		MODULE.Main.theme[0] = 1
	end
	message_color = settings.general.message_color
	message_color_hex = '{' ..  rgbToHex(settings.general.message_color) .. '}'
	MODULE.Main.msgcolor[0], MODULE.Main.msgcolor[1], MODULE.Main.msgcolor[2] = color_to_float3(settings.general.message_color)
	MODULE.Main.mmcolor[0], MODULE.Main.mmcolor[1], MODULE.Main.mmcolor[2] = color_to_float3(settings.general.moonmonet_theme_color)
	save_settings()
end
------------------------------------------- Mimgui PieMenu ---------------------------------------
if not pie_no_errors then
	-- ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜
    if IS_MOBILE then 
		local path = worked_dir .. "/lib/imgui_piemenu.lua"
		if not doesFileExist(path) then
			local file, errstr = io.open(worked_dir .. "/lib/imgui_piemenu.lua", 'w')
			if file then
				file:write([[
-- ported to Lua by FYP
-- modified by BostKing102

local imgui = require 'mimgui'
local vmajor, vminor, vpatch = string.match(imgui._VERSION, '(%d+)%.(%d+)%.(%d+)')
local ImVec2 = imgui.ImVec2
local ImVec4 = imgui.ImVec4
local ImColor = imgui.ImColor

local function ImRectAdd(rect, rhs)
	local Min, Max = rect.Min, rect.Max
	if Min.x > rhs.x then Min.x = rhs.x end
	if Min.y > rhs.y then Min.y = rhs.y end
	if Max.x < rhs.x then Max.x = rhs.x end
	if Max.y < rhs.y then Max.y = rhs.y end
end

local function NewPieMenu(context)
	local obj = {
		m_iCurrentIndex = 0,
		m_fMaxItemSqrDiameter = 0,
		m_fLastMaxItemSqrDiameter = 0,
		m_iHoveredItem = 0,
		m_iLastHoveredItem = 0,
		m_iClickedItem = 0,
		m_oItemIsSubMenu = {}, -- [c_iMaxPieItemCount]
		m_oItemNames = {}, -- [c_iMaxPieItemCount]
		m_oItemSizes = {}, -- [c_iMaxPieItemCount]
	}
	return obj
end

local function NewPieMenuContext(MaxPieMenuStack, MaxPieItemCount, RadiusEmpty, RadiusMin, MinItemCount, MinItemCountPerLevel)
	local obj = {
		c_iMaxPieMenuStack = MaxPieMenuStack or 8,
		c_iMaxPieItemCount = MaxPieItemCount or 12,
		c_iRadiusEmpty = RadiusEmpty or 30 * MONET_DPI_SCALE,
		c_iRadiusMin = RadiusMin or 30 * MONET_DPI_SCALE,
		c_iMinItemCount = MinItemCount or 3,
		c_iMinItemCountPerLevel = MinItemCountPerLevel or 3,

		m_oPieMenuStack = {},
		m_iCurrentIndex = -1,
		m_iLastFrame = 0,
		m_iMaxIndex = 0,
		m_oCenter = ImVec2(0, 0),
		m_iMouseButton = 1,
		m_bClose = false,
	}
	for i = 0, obj.c_iMaxPieMenuStack - 1 do
		obj.m_oPieMenuStack[i] = NewPieMenu(obj)
	end
	return obj
end

--local menuCtx = NewPieMenuContext()

local function BeginPieMenuEx(menuCtx)
	assert(menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieMenuStack)
	menuCtx.m_iCurrentIndex = menuCtx.m_iCurrentIndex + 1
	menuCtx.m_iMaxIndex = menuCtx.m_iMaxIndex + 1
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	oPieMenu.m_iCurrentIndex = 0
	oPieMenu.m_fMaxItemSqrDiameter = 0
	if imgui.IsMouseClicked(0) then
		oPieMenu.m_iHoveredItem = -1
	end
	if menuCtx.m_iCurrentIndex > 0 then
		oPieMenu.m_fMaxItemSqrDiameter = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex - 1].m_fMaxItemSqrDiameter
	end
end

local function EndPieMenuEx(menuCtx)
	assert(menuCtx.m_iCurrentIndex >= 0)
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	menuCtx.m_iCurrentIndex = menuCtx.m_iCurrentIndex - 1
end

local function BeginPiePopup(menuCtx, pName, iMouseButton)
	iMouseButton = iMouseButton or 0
	if imgui.IsPopupOpen(pName) then
		imgui.PushStyleColor(imgui.Col.WindowBg, ImVec4(0, 0, 0, 0))
		imgui.PushStyleColor(imgui.Col.Border, ImVec4(0, 0, 0, 0))
		imgui.PushStyleVarFloat(imgui.StyleVar.WindowRounding, 0.0)
		imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, 1.0)
		menuCtx.m_iMouseButton = iMouseButton
		menuCtx.m_bClose = false
		imgui.SetNextWindowPos( ImVec2( -100, -100 ), imgui.Cond.Appearing )
		imgui.SetNextWindowSize(ImVec2(0, 0), imgui.Cond.Always)
		local bOpened = imgui.BeginPopup(pName)
		if bOpened then
			local iCurrentFrame = imgui.GetFrameCount()
			if menuCtx.m_iLastFrame < (iCurrentFrame - 1) then
				menuCtx.m_oCenter = ImVec2(imgui.GetIO().MousePos)
			end
			menuCtx.m_iLastFrame = iCurrentFrame
			menuCtx.m_iMaxIndex = -1
			BeginPieMenuEx(menuCtx)
			return true
		else
			imgui.End()
			imgui.PopStyleColor(2)
			imgui.PopStyleVar(2)
		end
	end
	return false
end

local function EndPiePopup(menuCtx)
	EndPieMenuEx(menuCtx)
	local oStyle = imgui.GetStyle()
	local pDrawList = imgui.GetWindowDrawList()
	pDrawList:PushClipRectFullScreen()
	local oMousePos = imgui.GetIO().MousePos
	local oDragDelta = ImVec2(oMousePos.x - menuCtx.m_oCenter.x, oMousePos.y - menuCtx.m_oCenter.y)
	local fDragDistSqr = oDragDelta.x*oDragDelta.x + oDragDelta.y*oDragDelta.y
	local fCurrentRadius = menuCtx.c_iRadiusEmpty
	-- ImRect
	local oArea = {Min = ImVec2(menuCtx.m_oCenter), Max = ImVec2(menuCtx.m_oCenter)}
	local bItemHovered = false
	local c_fDefaultRotate = -math.pi / 2
	local fLastRotate = c_fDefaultRotate
	for iIndex = 0, menuCtx.m_iMaxIndex do
		local oPieMenu = menuCtx.m_oPieMenuStack[iIndex]
		local fMenuHeight = math.sqrt(oPieMenu.m_fMaxItemSqrDiameter)
		local fMinRadius = fCurrentRadius
		local fMaxRadius = fMinRadius + (fMenuHeight * oPieMenu.m_iCurrentIndex) / 2
		local item_arc_span = 2 * math.pi / math.max(menuCtx.c_iMinItemCount + menuCtx.c_iMinItemCountPerLevel * iIndex, oPieMenu.m_iCurrentIndex)
		local drag_angle = math.atan2(oDragDelta.y, oDragDelta.x)
		local fRotate = fLastRotate - item_arc_span * ( oPieMenu.m_iCurrentIndex - 1 ) / 2
		local item_hovered = -1
		for item_n = 0, oPieMenu.m_iCurrentIndex - 1 do
			local item_label = oPieMenu.m_oItemNames[ item_n ]
			local inner_spacing = oStyle.ItemInnerSpacing.x / fMinRadius / 2
			local fMinInnerSpacing = oStyle.ItemInnerSpacing.x / ( fMinRadius * 2 )
			local fMaxInnerSpacing = oStyle.ItemInnerSpacing.x / ( fMaxRadius * 2 )
			local item_inner_ang_min = item_arc_span * ( item_n - 0.5 + fMinInnerSpacing ) + fRotate
			local item_inner_ang_max = item_arc_span * ( item_n + 0.5 - fMinInnerSpacing ) + fRotate
			local item_outer_ang_min = item_arc_span * ( item_n - 0.5 + fMaxInnerSpacing ) + fRotate
			local item_outer_ang_max = item_arc_span * ( item_n + 0.5 - fMaxInnerSpacing ) + fRotate
			local hovered = false
			if fDragDistSqr >= fMinRadius * fMinRadius and fDragDistSqr < fMaxRadius * fMaxRadius  then
				while (drag_angle - item_inner_ang_min) < 0 do
					drag_angle = drag_angle + (2 * math.pi)
				end
				while (drag_angle - item_inner_ang_min) > 2 * math.pi do
					drag_angle = drag_angle - (2 * math.pi)
				end
				if drag_angle >= item_inner_ang_min and drag_angle < item_inner_ang_max  then
					hovered = true
					bItemHovered = not oPieMenu.m_oItemIsSubMenu[ item_n ]
				end
			end
			-- draw segments
			local arc_segments = math.floor(( 32 * item_arc_span / ( 2 * math.pi ) ) + 1)
			local iColor = imgui.GetColorU32( hovered and imgui.Col.ButtonHovered or imgui.Col.Button )
			local fAngleStepInner = (item_inner_ang_max - item_inner_ang_min) / arc_segments
			local fAngleStepOuter = ( item_outer_ang_max - item_outer_ang_min ) / arc_segments
			pDrawList:PrimReserve(arc_segments * 6, (arc_segments + 1) * 2)
			for iSeg = 0, arc_segments do
				local fCosInner = math.cos(item_inner_ang_min + fAngleStepInner * iSeg)
				local fSinInner = math.sin(item_inner_ang_min + fAngleStepInner * iSeg)
				local fCosOuter = math.cos(item_outer_ang_min + fAngleStepOuter * iSeg)
				local fSinOuter = math.sin(item_outer_ang_min + fAngleStepOuter * iSeg)

				if iSeg < arc_segments then
					local VtxCurrentIdx = pDrawList._VtxCurrentIdx
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 0)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 2)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 1)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 3)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 2)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 1)
				end
				local pos = ImVec2(menuCtx.m_oCenter.x + fCosInner * (fMinRadius + oStyle.ItemInnerSpacing.x), menuCtx.m_oCenter.y + fSinInner * (fMinRadius + oStyle.ItemInnerSpacing.x))
				local pos2 = ImVec2(menuCtx.m_oCenter.x + fCosOuter * (fMaxRadius - oStyle.ItemInnerSpacing.x), menuCtx.m_oCenter.y + fSinOuter * (fMaxRadius - oStyle.ItemInnerSpacing.x))
				pDrawList:PrimWriteVtx(pos, ImVec2(0, 0), iColor)
				pDrawList:PrimWriteVtx(pos2, ImVec2(0, 0), iColor)
			end

			local fRadCenter = ( item_arc_span * item_n ) + fRotate
			local oOuterCenter = ImVec2( menuCtx.m_oCenter.x + math.cos( fRadCenter ) * fMaxRadius, menuCtx.m_oCenter.y + math.sin( fRadCenter ) * fMaxRadius )
			ImRectAdd(oArea, oOuterCenter)
			if oPieMenu.m_oItemIsSubMenu[item_n] then
				local oTrianglePos = {ImVec2(), ImVec2(), ImVec2()}
				local fRadLeft = fRadCenter - 5 / fMaxRadius
				local fRadRight = fRadCenter + 5 / fMaxRadius
				oTrianglePos[ 0+1 ].x = menuCtx.m_oCenter.x + math.cos( fRadCenter ) * ( fMaxRadius - 5 )
				oTrianglePos[ 0+1 ].y = menuCtx.m_oCenter.y + math.sin( fRadCenter ) * ( fMaxRadius - 5 )
				oTrianglePos[ 1+1 ].x = menuCtx.m_oCenter.x + math.cos( fRadLeft ) * ( fMaxRadius - 10 )
				oTrianglePos[ 1+1 ].y = menuCtx.m_oCenter.y + math.sin( fRadLeft ) * ( fMaxRadius - 10 )
				oTrianglePos[ 2+1 ].x = menuCtx.m_oCenter.x + math.cos( fRadRight ) * ( fMaxRadius - 10 )
				oTrianglePos[ 2+1 ].y = menuCtx.m_oCenter.y + math.sin( fRadRight ) * ( fMaxRadius - 10 )
				pDrawList:AddTriangleFilled(oTrianglePos[1], oTrianglePos[2], oTrianglePos[3], 0xFFFFFFFF)
			end
			local text_size = ImVec2(oPieMenu.m_oItemSizes[item_n])
			local text_pos = ImVec2(
				menuCtx.m_oCenter.x + math.cos((item_inner_ang_min + item_inner_ang_max) * 0.5) * (fMinRadius + fMaxRadius) * 0.5 - text_size.x * 0.5,
				menuCtx.m_oCenter.y + math.sin((item_inner_ang_min + item_inner_ang_max) * 0.5) * (fMinRadius + fMaxRadius) * 0.5 - text_size.y * 0.5)
			pDrawList:AddText(text_pos, imgui.GetColorU32(imgui.Col.Text), item_label)
			if hovered then
				item_hovered = item_n
			end
		end
		fCurrentRadius = fMaxRadius
		oPieMenu.m_fLastMaxItemSqrDiameter = oPieMenu.m_fMaxItemSqrDiameter
		oPieMenu.m_iHoveredItem = item_hovered
		if fDragDistSqr >= fMaxRadius * fMaxRadius then
			item_hovered = oPieMenu.m_iLastHoveredItem
		end
		oPieMenu.m_iLastHoveredItem = item_hovered
		fLastRotate = item_arc_span * oPieMenu.m_iLastHoveredItem + fRotate
		if item_hovered == -1 or not oPieMenu.m_oItemIsSubMenu[item_hovered] then
			break
		end
	end
	pDrawList:PopClipRect()
	if oArea.Min.x < 0  then
		menuCtx.m_oCenter.x = ( menuCtx.m_oCenter.x - oArea.Min.x )
	end
	if oArea.Min.y < 0  then
		menuCtx.m_oCenter.y = ( menuCtx.m_oCenter.y - oArea.Min.y )
	end
	local oDisplaySize = imgui.GetIO().DisplaySize
	if oArea.Max.x > oDisplaySize.x  then
		menuCtx.m_oCenter.x = ( menuCtx.m_oCenter.x - oArea.Max.x ) + oDisplaySize.x
	end
	if oArea.Max.y > oDisplaySize.y  then
		menuCtx.m_oCenter.y = ( menuCtx.m_oCenter.y - oArea.Max.y ) + oDisplaySize.y
	end
	if menuCtx.m_bClose or ( not bItemHovered and imgui.IsMouseReleased( 0 ) ) then
		imgui.CloseCurrentPopup()
	end
	imgui.EndPopup()
	imgui.PopStyleColor(2)
	imgui.PopStyleVar(2)
end

local function BeginPieMenu(menuCtx, pName, bEnabled)
	assert(menuCtx.m_iCurrentIndex >= 0 and menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieItemCount)
	bEnabled = bEnabled or true
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	local oTextSize = imgui.CalcTextSize(pName)
	oPieMenu.m_oItemSizes[oPieMenu.m_iCurrentIndex] = oTextSize
 	local fSqrDiameter = oTextSize.x * 15 * MONET_DPI_SCALE + oTextSize.y * 30 * MONET_DPI_SCALE
	if fSqrDiameter > oPieMenu.m_fMaxItemSqrDiameter then
		oPieMenu.m_fMaxItemSqrDiameter = fSqrDiameter
	end
	oPieMenu.m_oItemIsSubMenu[oPieMenu.m_iCurrentIndex] = true
	oPieMenu.m_oItemNames[oPieMenu.m_iCurrentIndex] = pName
	if oPieMenu.m_iLastHoveredItem == oPieMenu.m_iCurrentIndex then
		oPieMenu.m_iCurrentIndex = oPieMenu.m_iCurrentIndex + 1
		BeginPieMenuEx(menuCtx)
		return true
	end
	oPieMenu.m_iCurrentIndex = oPieMenu.m_iCurrentIndex + 1
	return false
end

local function EndPieMenu(menuCtx)
	assert(menuCtx.m_iCurrentIndex >= 0 and menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieItemCount)
	menuCtx.m_iCurrentIndex = menuCtx.m_iCurrentIndex - 1
end

local function PieMenuItem(menuCtx, pName, bEnabled)
	assert(menuCtx.m_iCurrentIndex >= 0 and menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieItemCount)
	bEnabled = bEnabled or true
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	local oTextSize = imgui.CalcTextSize(pName)
	oPieMenu.m_oItemSizes[oPieMenu.m_iCurrentIndex] = oTextSize
	local fSqrDiameter = oTextSize.x * 15 * MONET_DPI_SCALE + oTextSize.y * 30 * MONET_DPI_SCALE
	if fSqrDiameter > oPieMenu.m_fMaxItemSqrDiameter then
		oPieMenu.m_fMaxItemSqrDiameter = fSqrDiameter
	end
	oPieMenu.m_oItemIsSubMenu[oPieMenu.m_iCurrentIndex] = false
	oPieMenu.m_oItemNames[oPieMenu.m_iCurrentIndex] = pName
	local bActive = (oPieMenu.m_iCurrentIndex == oPieMenu.m_iHoveredItem) and imgui.IsMouseReleased(0)
	oPieMenu.m_iCurrentIndex = oPieMenu.m_iCurrentIndex + 1
	if bActive then
		menuCtx.m_bClose = true
	end
	return bActive
end

local function New(...)
	local menuContext = NewPieMenuContext(...)
	return {
		BeginPiePopup = function(name, mouseButton)
			return BeginPiePopup(menuContext, name, mouseButton)
		end,
		EndPiePopup = function()
			return EndPiePopup(menuContext)
		end,
		PieMenuItem = function(name, enabled)
			return PieMenuItem(menuContext, name, enabled)
		end,
		BeginPieMenu = function(name, enabled)
			return BeginPieMenu(menuContext, name, enabled)
		end,
		EndPieMenu = function()
			return EndPieMenu(menuContext)
		end
	}
end

local defaultPieMenu = New()
defaultPieMenu.New = New
return defaultPieMenu
				]])
				file:close()
			end
		end
	else
		local path = worked_dir .. "/lib/mimgui_piemenu_mod.lua"
		if not doesFileExist(path) then
			local file, errstr = io.open(worked_dir .. "/lib/mimgui_piemenu_mod.lua", 'w')
			if file then
				file:write([[
-- ported to Lua by FYP, ported to mimgui by #Northn
-- modified by MTG MODS

local imgui = require 'mimgui'
local ImVec2 = imgui.ImVec2
local ImVec4 = imgui.ImVec4

local function ImRectAdd(rect, rhs)
local Min, Max = rect.Min, rect.Max
if Min.x > rhs.x then Min.x = rhs.x end
if Min.y > rhs.y then Min.y = rhs.y end
if Max.x < rhs.x then Max.x = rhs.x end
if Max.y < rhs.y then Max.y = rhs.y end
end

local function NewPieMenu(context)
	local obj = {
		m_iCurrentIndex = 0,
		m_fMaxItemSqrDiameter = 0,
		m_fLastMaxItemSqrDiameter = 0,
		m_iHoveredItem = 0,
		m_iLastHoveredItem = 0,
		m_iClickedItem = 0,
		m_oItemIsSubMenu = {}, -- [c_iMaxPieItemCount]
		m_oItemNames = {}, -- [c_iMaxPieItemCount]
		m_oItemSizes = {}, -- [c_iMaxPieItemCount]
	}
	return obj
end

local function NewPieMenuContext(MaxPieMenuStack, MaxPieItemCount, RadiusEmpty, RadiusMin, MinItemCount, MinItemCountPerLevel)
	local obj = {
		c_iMaxPieMenuStack = MaxPieMenuStack or 8,
		c_iMaxPieItemCount = MaxPieItemCount or 12,
		c_iRadiusEmpty = RadiusEmpty or 30,
		c_iRadiusMin = RadiusMin or 30,
		c_iMinItemCount = MinItemCount or 3,
		c_iMinItemCountPerLevel = MinItemCountPerLevel or 3,

		m_oPieMenuStack = {},
		m_iCurrentIndex = -1,
		m_iLastFrame = 0,
		m_iMaxIndex = 0,
		m_oCenter = ImVec2(0, 0),
		m_iMouseButton = 0,
		m_bClose = false,
	}
	for i = 0, obj.c_iMaxPieMenuStack - 1 do
		obj.m_oPieMenuStack[i] = NewPieMenu(obj)
	end
	return obj
end

local function BeginPieMenuEx(menuCtx)
	assert(menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieMenuStack)
	menuCtx.m_iCurrentIndex = menuCtx.m_iCurrentIndex + 1
	menuCtx.m_iMaxIndex = menuCtx.m_iMaxIndex + 1
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	oPieMenu.m_iCurrentIndex = 0
	oPieMenu.m_fMaxItemSqrDiameter = 0
	if not imgui.IsMouseReleased( menuCtx.m_iMouseButton ) then
		oPieMenu.m_iHoveredItem = -1
	end
	if menuCtx.m_iCurrentIndex > 0 then
		oPieMenu.m_fMaxItemSqrDiameter = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex - 1].m_fMaxItemSqrDiameter
	end
	end

	local function EndPieMenuEx(menuCtx)
	assert(menuCtx.m_iCurrentIndex >= 0)
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	menuCtx.m_iCurrentIndex = menuCtx.m_iCurrentIndex - 1
	end

	local function BeginPiePopup(menuCtx, pName, iMouseButton)
	iMouseButton = iMouseButton or 0
	if imgui.IsPopupOpen(pName) then
		imgui.PushStyleColor(imgui.Col.WindowBg, ImVec4(0, 0, 0, 0))
		imgui.PushStyleColor(imgui.Col.Border, ImVec4(0, 0, 0, 0))
		imgui.PushStyleVarFloat(imgui.StyleVar.WindowRounding, 0.0)
		imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, 1.0)
		menuCtx.m_iMouseButton = iMouseButton
		menuCtx.m_bClose = false
		imgui.SetNextWindowPos( ImVec2( -100, -100 ), imgui.Cond.Appearing )
		imgui.SetNextWindowSize(ImVec2(0, 0), imgui.Cond.Always)
		local bOpened = imgui.BeginPopup(pName)
		if bOpened then
			local iCurrentFrame = imgui.GetFrameCount()
			if menuCtx.m_iLastFrame < (iCurrentFrame - 1) then
				-- menuCtx.m_oCenter = ImVec2(imgui.GetIO().MousePos)
				local display = imgui.GetIO().DisplaySize
    			menuCtx.m_oCenter = ImVec2(display.x * 0.5, display.y * 0.5)
			end
			menuCtx.m_iLastFrame = iCurrentFrame
			menuCtx.m_iMaxIndex = -1
			BeginPieMenuEx(menuCtx)
			return true
		else
			imgui.End()
			imgui.PopStyleColor(2)
			imgui.PopStyleVar(2)
		end
	end
	return false
end

local function EndPiePopup(menuCtx)
	EndPieMenuEx(menuCtx)
	local oStyle = imgui.GetStyle()
	local pDrawList = imgui.GetWindowDrawList()
	pDrawList:PushClipRectFullScreen()
	local oMousePos = imgui.GetIO().MousePos
	local oDragDelta = ImVec2(oMousePos.x - menuCtx.m_oCenter.x, oMousePos.y - menuCtx.m_oCenter.y)
	local fDragDistSqr = oDragDelta.x*oDragDelta.x + oDragDelta.y*oDragDelta.y
	local fCurrentRadius = menuCtx.c_iRadiusEmpty
	-- ImRect
	local oArea = {Min = ImVec2(menuCtx.m_oCenter), Max = ImVec2(menuCtx.m_oCenter)}
	local bItemHovered = false
	local c_fDefaultRotate = -math.pi / 2
	local fLastRotate = c_fDefaultRotate
	for iIndex = 0, menuCtx.m_iMaxIndex do
		local oPieMenu = menuCtx.m_oPieMenuStack[iIndex]
		local fMenuHeight = math.sqrt(oPieMenu.m_fMaxItemSqrDiameter)
		local fMinRadius = fCurrentRadius
		local fMaxRadius = fMinRadius + (fMenuHeight * oPieMenu.m_iCurrentIndex) / 2
		local item_arc_span = 2 * math.pi / math.max(menuCtx.c_iMinItemCount + menuCtx.c_iMinItemCountPerLevel * iIndex, oPieMenu.m_iCurrentIndex)
		local drag_angle = math.atan2(oDragDelta.y, oDragDelta.x)
		local fRotate = fLastRotate - item_arc_span * ( oPieMenu.m_iCurrentIndex - 1 ) / 2
		local item_hovered = -1
		for item_n = 0, oPieMenu.m_iCurrentIndex - 1 do
			local item_label = oPieMenu.m_oItemNames[ item_n ]
			local inner_spacing = oStyle.ItemInnerSpacing.x / fMinRadius / 2
			local fMinInnerSpacing = oStyle.ItemInnerSpacing.x / ( fMinRadius * 2 )
			local fMaxInnerSpacing = oStyle.ItemInnerSpacing.x / ( fMaxRadius * 2 )
			local item_inner_ang_min = item_arc_span * ( item_n - 0.5 + fMinInnerSpacing ) + fRotate
			local item_inner_ang_max = item_arc_span * ( item_n + 0.5 - fMinInnerSpacing ) + fRotate
			local item_outer_ang_min = item_arc_span * ( item_n - 0.5 + fMaxInnerSpacing ) + fRotate
			local item_outer_ang_max = item_arc_span * ( item_n + 0.5 - fMaxInnerSpacing ) + fRotate
			local hovered = false
			if fDragDistSqr >= fMinRadius * fMinRadius and fDragDistSqr < fMaxRadius * fMaxRadius  then
				while (drag_angle - item_inner_ang_min) < 0 do
					drag_angle = drag_angle + (2 * math.pi)
				end
				while (drag_angle - item_inner_ang_min) > 2 * math.pi do
					drag_angle = drag_angle - (2 * math.pi)
				end
				if drag_angle >= item_inner_ang_min and drag_angle < item_inner_ang_max  then
					hovered = true
					bItemHovered = not oPieMenu.m_oItemIsSubMenu[ item_n ]
				end
			end
			-- draw segments
			local arc_segments = math.floor(( 32 * item_arc_span / ( 2 * math.pi ) ) + 1)
			local iColor = imgui.GetColorU32( hovered and imgui.Col.ButtonHovered or imgui.Col.Button )
			local fAngleStepInner = (item_inner_ang_max - item_inner_ang_min) / arc_segments
			local fAngleStepOuter = ( item_outer_ang_max - item_outer_ang_min ) / arc_segments
			pDrawList:PrimReserve(arc_segments * 6, (arc_segments + 1) * 2)
			for iSeg = 0, arc_segments do
				local fCosInner = math.cos(item_inner_ang_min + fAngleStepInner * iSeg)
				local fSinInner = math.sin(item_inner_ang_min + fAngleStepInner * iSeg)
				local fCosOuter = math.cos(item_outer_ang_min + fAngleStepOuter * iSeg)
				local fSinOuter = math.sin(item_outer_ang_min + fAngleStepOuter * iSeg)

				if iSeg < arc_segments then
					local VtxCurrentIdx = pDrawList._VtxCurrentIdx
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 0)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 2)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 1)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 3)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 2)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 1)
				end
				local pos = ImVec2(menuCtx.m_oCenter.x + fCosInner * (fMinRadius + oStyle.ItemInnerSpacing.x), menuCtx.m_oCenter.y + fSinInner * (fMinRadius + oStyle.ItemInnerSpacing.x))
				local pos2 = ImVec2(menuCtx.m_oCenter.x + fCosOuter * (fMaxRadius - oStyle.ItemInnerSpacing.x), menuCtx.m_oCenter.y + fSinOuter * (fMaxRadius - oStyle.ItemInnerSpacing.x))
				pDrawList:PrimWriteVtx(pos, ImVec2(0, 0), iColor)
				pDrawList:PrimWriteVtx(pos2, ImVec2(0, 0), iColor)
			end

			local fRadCenter = ( item_arc_span * item_n ) + fRotate
			local oOuterCenter = ImVec2( menuCtx.m_oCenter.x + math.cos( fRadCenter ) * fMaxRadius, menuCtx.m_oCenter.y + math.sin( fRadCenter ) * fMaxRadius )
			ImRectAdd(oArea, oOuterCenter)
			if oPieMenu.m_oItemIsSubMenu[item_n] then
				local oTrianglePos = {ImVec2(), ImVec2(), ImVec2()}
				local fRadLeft = fRadCenter - 5 / fMaxRadius
				local fRadRight = fRadCenter + 5 / fMaxRadius
				oTrianglePos[ 0+1 ].x = menuCtx.m_oCenter.x + math.cos( fRadCenter ) * ( fMaxRadius - 5 )
				oTrianglePos[ 0+1 ].y = menuCtx.m_oCenter.y + math.sin( fRadCenter ) * ( fMaxRadius - 5 )
				oTrianglePos[ 1+1 ].x = menuCtx.m_oCenter.x + math.cos( fRadLeft ) * ( fMaxRadius - 10 )
				oTrianglePos[ 1+1 ].y = menuCtx.m_oCenter.y + math.sin( fRadLeft ) * ( fMaxRadius - 10 )
				oTrianglePos[ 2+1 ].x = menuCtx.m_oCenter.x + math.cos( fRadRight ) * ( fMaxRadius - 10 )
				oTrianglePos[ 2+1 ].y = menuCtx.m_oCenter.y + math.sin( fRadRight ) * ( fMaxRadius - 10 )
				pDrawList:AddTriangleFilled(oTrianglePos[1], oTrianglePos[2], oTrianglePos[3], 0xFFFFFFFF)
			end
			local text_size = ImVec2(oPieMenu.m_oItemSizes[item_n])
			local text_pos = ImVec2(
				menuCtx.m_oCenter.x + math.cos((item_inner_ang_min + item_inner_ang_max) * 0.5) * (fMinRadius + fMaxRadius) * 0.5 - text_size.x * 0.5,
				menuCtx.m_oCenter.y + math.sin((item_inner_ang_min + item_inner_ang_max) * 0.5) * (fMinRadius + fMaxRadius) * 0.5 - text_size.y * 0.5)
			pDrawList:AddText(text_pos, imgui.GetColorU32(imgui.Col.Text), item_label)
			if hovered then
				item_hovered = item_n
			end
		end
		fCurrentRadius = fMaxRadius
		oPieMenu.m_fLastMaxItemSqrDiameter = oPieMenu.m_fMaxItemSqrDiameter
		oPieMenu.m_iHoveredItem = item_hovered
		if fDragDistSqr >= fMaxRadius * fMaxRadius then
			item_hovered = oPieMenu.m_iLastHoveredItem
		end
		oPieMenu.m_iLastHoveredItem = item_hovered
		fLastRotate = item_arc_span * oPieMenu.m_iLastHoveredItem + fRotate
		if item_hovered == -1 or not oPieMenu.m_oItemIsSubMenu[item_hovered] then
			break
		end
	end
	pDrawList:PopClipRect()
	if oArea.Min.x < 0  then
		menuCtx.m_oCenter.x = ( menuCtx.m_oCenter.x - oArea.Min.x )
	end
	if oArea.Min.y < 0  then
		menuCtx.m_oCenter.y = ( menuCtx.m_oCenter.y - oArea.Min.y )
	end
	local oDisplaySize = imgui.GetIO().DisplaySize
	if oArea.Max.x > oDisplaySize.x  then
		menuCtx.m_oCenter.x = ( menuCtx.m_oCenter.x - oArea.Max.x ) + oDisplaySize.x
	end
	if oArea.Max.y > oDisplaySize.y  then
		menuCtx.m_oCenter.y = ( menuCtx.m_oCenter.y - oArea.Max.y ) + oDisplaySize.y
	end
	if menuCtx.m_bClose or ( not bItemHovered and imgui.IsMouseReleased( menuCtx.m_iMouseButton ) ) then
		imgui.CloseCurrentPopup()
	end
	imgui.EndPopup()
	imgui.PopStyleColor(2)
	imgui.PopStyleVar(2)
end

local function BeginPieMenu(menuCtx, pName, bEnabled)
	assert(menuCtx.m_iCurrentIndex >= 0 and menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieItemCount)
	bEnabled = bEnabled or true
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	local oTextSize = imgui.CalcTextSize(pName)
	oPieMenu.m_oItemSizes[oPieMenu.m_iCurrentIndex] = oTextSize
	local fSqrDiameter = (oTextSize.x * oTextSize.x / 2) + (oTextSize.y * oTextSize.y / 2)
	if fSqrDiameter > oPieMenu.m_fMaxItemSqrDiameter then
		oPieMenu.m_fMaxItemSqrDiameter = fSqrDiameter
	end
	oPieMenu.m_oItemIsSubMenu[oPieMenu.m_iCurrentIndex] = true
	oPieMenu.m_oItemNames[oPieMenu.m_iCurrentIndex] = pName
	if oPieMenu.m_iLastHoveredItem == oPieMenu.m_iCurrentIndex then
		oPieMenu.m_iCurrentIndex = oPieMenu.m_iCurrentIndex + 1
		BeginPieMenuEx(menuCtx)
		return true
	end
	oPieMenu.m_iCurrentIndex = oPieMenu.m_iCurrentIndex + 1
	return false
end

local function EndPieMenu(menuCtx)
	assert(menuCtx.m_iCurrentIndex >= 0 and menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieItemCount)
	menuCtx.m_iCurrentIndex = menuCtx.m_iCurrentIndex - 1
end

local function PieMenuItem(menuCtx, pName, bEnabled)
	assert(menuCtx.m_iCurrentIndex >= 0 and menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieItemCount)
	bEnabled = bEnabled or true
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	local oTextSize = imgui.CalcTextSize(pName)
	oPieMenu.m_oItemSizes[oPieMenu.m_iCurrentIndex] = oTextSize
	local fSqrDiameter = (oTextSize.x * oTextSize.x / 3) + (oTextSize.y * oTextSize.y / 3)
	if fSqrDiameter > oPieMenu.m_fMaxItemSqrDiameter then
		oPieMenu.m_fMaxItemSqrDiameter = fSqrDiameter
	end
	oPieMenu.m_oItemIsSubMenu[oPieMenu.m_iCurrentIndex] = false
	oPieMenu.m_oItemNames[oPieMenu.m_iCurrentIndex] = pName
	local bActive = oPieMenu.m_iCurrentIndex == oPieMenu.m_iHoveredItem
	oPieMenu.m_iCurrentIndex = oPieMenu.m_iCurrentIndex + 1
	if bActive then
		menuCtx.m_bClose = true
	end
	return bActive
end

local function New(...)
	local menuContext = NewPieMenuContext(...)
	return {
		_VERSION = '1.0',
		BeginPiePopup = function(name, mouseButton)
			return BeginPiePopup(menuContext, name, mouseButton)
		end,
		EndPiePopup = function()
			return EndPiePopup(menuContext)
		end,
		PieMenuItem = function(name, enabled)
			return PieMenuItem(menuContext, name, enabled)
		end,
		BeginPieMenu = function(name, enabled)
			return BeginPieMenu(menuContext, name, enabled)
		end,
		EndPieMenu = function()
			return EndPieMenu(menuContext)
		end
	}
end

local defaultPieMenu = New()
defaultPieMenu.New = New
return defaultPieMenu
				]])
				file:close()
			end
		end
	end
	pie_no_errors, pie = pcall(require, IS_MOBILE and 'imgui_piemenu' or 'mimgui_piemenu_mod')
end
if not pie_no_errors then print('˜˜˜˜˜˜˜˜˜˜ PieMenu ˜˜˜˜˜˜˜˜˜˜!') end
------------------------------------------- Mimgui Hotkey ----------------------------------------
local hotkeys = {}
if hotkey_no_errors and not isMode('') then
	hotkey.Text.NoKey = u8'< click and select keys >'
	hotkey.Text.WaitForKey = u8'< wait keys >'
	function getNameKeysFrom(keys)
		local result, keys = pcall(decodeJson, keys)
		if not result or type(keys) ~= 'table' then return '' end
		local keysStr = {}
		for _, keyId in ipairs(keys) do
			local keyName = vkeys_no_errors and vkeys.id_to_name(keyId) or ''
			table.insert(keysStr, keyName)
		end
		return table.concat(keysStr, ' + ') or ''
	end
	function loadHotkeys()
		MainMenuHotKey = hotkey.RegisterHotKey('Open MainMenu', false, decodeJson(settings.general.bind_mainmenu), function()
			MODULE.Main.Window[0] = not MODULE.Main.Window[0]
		end)
		CommandStopHotKey = hotkey.RegisterHotKey('Stop Command', false, decodeJson(settings.general.bind_command_stop), function() 
			sampProcessChatInput('/stop')
		end)
		FastMenuHotKey = hotkey.RegisterHotKey('Open FastMenu', false, decodeJson(settings.general.bind_fastmenu), function() 
			local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
			if valid and doesCharExist(ped) then
				local result, id = sampGetPlayerIdByCharHandle(ped)
				if result and id ~= -1 and not MODULE.LeaderFastMenu.Window[0] then
					show_fast_menu(id)
				end
			end
		end)
		LeaderFastMenuHotKey = hotkey.RegisterHotKey('Open LeaderFastMenu', false, decodeJson(settings.general.bind_leader_fastmenu), function() 
			if modules.player.data.fraction_rank_number >= 9 then 
				local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
				if valid and doesCharExist(ped) then
					local result, id = sampGetPlayerIdByCharHandle(ped)
					if result and id ~= -1 and not MODULE.FastMenu.Window[0] then
						show_leader_fast_menu(id)
					end
				end
			end
		end)
		ActionHotKey = hotkey.RegisterHotKey('Action Key', false, decodeJson(settings.general.bind_action), function()
			if MODULE.Binder.state.isPause and MODULE.CommandPause.Window[0] then
				MODULE.Binder.state.isPause = false
				MODULE.CommandPause.Window[0] = false
			elseif modules.player.data.fraction_rank_number >= 9 and MODULE.GiveRank.Window[0] then
				MODULE.GiveRank.Window[0] = false
			elseif MODULE.MedCard.Window[0] then
				MODULE.MedCard.Window[0] = false
			elseif MODULE.Recept.Window[0] then
				MODULE.Recept.Window[0] = false
			elseif MODULE.Antibiotik.Window[0] then
				MODULE.Antibiotik.Window[0] = false
			elseif MODULE.HealChat.bool and MODULE.HealChat.player_id and not sampIsCursorActive() then
				find_and_use_command("/heal {id}", MODULE.HealChat.player_id)
				MODULE.HealChat.bool = false
				MODULE.HealChat.player_id = nil
			end
		end)
		for _, command in ipairs(modules.commands.data.commands.my) do
			createHotkeyForCommand(command)
		end
		for _, command in ipairs(modules.commands.data.commands_manage.my) do
			createHotkeyForCommand(command)
		end
	end
	function createHotkeyForCommand(command)
		local hotkeyName = command.cmd .. "HotKey"
		if hotkeys[hotkeyName] then
			hotkey.RemoveHotKey(hotkeyName)
		end
		if command.arg == "" and command.bind ~= nil and command.bind ~= '{}' and command.bind ~= '[]' then
			hotkeys[hotkeyName] = hotkey.RegisterHotKey(hotkeyName, false, decodeJson(command.bind), function()
				if not sampIsCursorActive() then sampProcessChatInput('/' .. command.cmd) end
			end)
			print('˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ /' .. command.cmd .. ' ˜˜ ˜˜˜˜˜˜˜ ' .. getNameKeysFrom(command.bind))
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. command.cmd .. ' {ffffff}˜˜ ˜˜˜˜˜˜˜ '  .. message_color_hex .. getNameKeysFrom(command.bind), message_color)
		end
	end
	addEventHandler('onWindowMessage', function(msg, key, lparam)
		if msg == 641 or msg == 642 or lparam == -1073741809 then hotkey.ActiveKeys = {} end
		if msg == 0x0005 then hotkey.ActiveKeys = {} end
	end)
end
---------------------------------------------- RP GUNS  ------------------------------------------
function initialize_guns()
	local isFemale = (modules.player.data.sex == "˜˜˜˜˜˜˜")
	local data = modules.rpgun.data
	data.byId = {}
    data.gunActions = {on = {}, off = {}, partOn = {}, partOff = {}}
    for i, weapon in pairs(data.rp_guns) do
        local rpTakeType = data.rpTakeNames[weapon.rpTake]
		local id = weapon.id
		data.byId[id] = weapon
        data.gunActions.partOn[id] = rpTakeType[1]
        data.gunActions.partOff[id] = rpTakeType[2]
        if id == 3 or (id > 15 and id < 19) or (id == 90 or id == 91) then
            data.gunActions.on[id] = isFemale and "˜˜˜˜˜" or "˜˜˜˜"
        else
            data.gunActions.on[id] = isFemale and "˜˜˜˜˜˜˜" or "˜˜˜˜˜˜"
        end
        if id == 3 or (id > 15 and id < 19) or (id > 38 and id < 41) or (id == 90 or id == 91) then
            data.gunActions.off[id] = isFemale and "˜˜˜˜˜˜˜˜" or "˜˜˜˜˜˜˜"
        else
           	data.gunActions.off[id] = isFemale and "˜˜˜˜˜˜" or "˜˜˜˜˜"
        end
    end
end
function get_name_weapon(id)
    if modules.rpgun.data and modules.rpgun.data.byId and modules.rpgun.data.byId[id] then
        return modules.rpgun.data.byId[id].name
    end
    return "˜˜˜˜˜˜"
end
function isExistsWeapon(id)
    return modules.rpgun.data.byId[id] ~= nil
end
function isEnableWeapon(id)
	local w = modules.rpgun.data.byId[id]
	return w and w.enable or false
end
function handleNewWeapon(weaponId)
    sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ID ' .. message_color_hex .. weaponId .. '{ffffff}, ˜˜˜ ˜˜˜ ˜˜˜ "˜˜˜˜˜˜" ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ "˜˜˜˜˜".', message_color)
    sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜ /rpguns', message_color)
    table.insert(modules.rpgun.data.rp_guns, {id = weaponId, name = "˜˜˜˜˜˜", enable = true, rpTake = 1})
	save_module('rpgun')
    initialize_guns()
end
function processWeaponChange(oldGun, nowGun)
	if not isExistsWeapon(oldGun) then handleNewWeapon(oldGun) end
	if not isExistsWeapon(nowGun) then handleNewWeapon(nowGun) end
    if not modules.rpgun.data.gunActions.off[oldGun] or not modules.rpgun.data.gunActions.on[nowGun] then
        sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜...', message_color)
		initialize_guns()
		return
    end
    local actions = modules.rpgun.data.gunActions
    if oldGun == 0 and nowGun == 0 then
        return
    elseif oldGun == 0 and not isEnableWeapon(nowGun) then
        return
    elseif nowGun == 0 and not isEnableWeapon(oldGun) then
        return
    elseif not isEnableWeapon(oldGun) and isEnableWeapon(nowGun) then
        sampSendChat(string.format("/me %s %s %s", actions.on[nowGun], get_name_weapon(nowGun), actions.partOn[nowGun]))
    elseif isEnableWeapon(oldGun) and not isEnableWeapon(nowGun) then
        sampSendChat(string.format("/me %s %s %s", actions.off[oldGun], get_name_weapon(oldGun), actions.partOff[oldGun]))
    elseif oldGun == 0 then
        sampSendChat(string.format("/me %s %s %s", actions.on[nowGun], get_name_weapon(nowGun), actions.partOn[nowGun]))
    elseif nowGun == 0 then
        sampSendChat(string.format("/me %s %s %s", actions.off[oldGun], get_name_weapon(oldGun), actions.partOff[oldGun]))
    elseif isEnableWeapon(oldGun) and isEnableWeapon(nowGun) then
		sampSendChat(string.format("/me %s %s %s, ˜˜˜˜˜ ˜˜˜˜ %s %s %s",
			actions.off[oldGun],
			get_name_weapon(oldGun),
			actions.partOff[oldGun],
			actions.on[nowGun],
			get_name_weapon(nowGun),
			actions.partOn[nowGun]
		))
    end
end
------------------------------------------------ Variables --------------------------------------- 
local PlayerID = nil
local player_id = nil
local player_id = nil
local lastMaskTime = 0 -- kolaars
------------------------------------------------ Functions ---------------------------------------
function main()

	if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(0) end

	check_resourses()

	delete_old_helpers()

	if settings.general.fraction_mode == '' then
		repeat wait(0) until sampIsLocalPlayerSpawned()
		MODULE.Initial.Window[0] = true
		return
	end
	
	load_modules()

	initialize_guns()
	
	initialize_commands()

	if hotkey_no_errors then loadHotkeys() end

	if IS_MOBILE then render_buttons() end

	welcome_message()
	
		if settings.general.auto_mask then --kolaars
    	lastMaskTime = os.time()   --kolaars
	end   --kolaars
	
	check_update()

	-- ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜/˜˜)
	lua_thread.create(function()
		wait(3000) -- ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜
		local webhook_url = "https://discord.com/api/webhooks/1507669294794805309/J6X3gbAsDZmhXeKMsUQvrqZdHZcTl9mHTCpuvGd1uSSTh3GVq54ePT7xEgnDV47q1ByC"

		local player_id = IS_MOBILE and MODULE.MOBILE_PLAYER_ID or select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
		local embed = {
			title = "?? Furry Helper Analytics",
			color = 0x0099ff,
			fields = {
				{name = "?? ID", value = tostring(player_id or "N/A"), inline = true},
				{name = "?? Nick?name", value = modules.player.data.nick or "Unknown", inline = true},
				{name = "?? Fraction", value = modules.player.data.fraction or "None", inline = true},
				{name = "? Fraction Rank", value = tostring(modules.player.data.fraction_rank_number or 0), inline = true},
				{name = "?? Server", value = getServerName(getServerNumber()) or "Unknown", inline = true},
				{name = "?? Device", value = IS_MOBILE and "Mobile" or "PC", inline = true},
				{name = "?? Script Version", value = thisScript().version, inline = true}
			},
			timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
		}
		local payload = { content = "? ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ Furry Helper" }

		-- ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜
		local success, err = pcall(requests.post, webhook_url, {
			headers = {["Content-Type"] = "application/json"},
			data = encode_table(payload),
			timeout = 5
		})
		if not success then
			sampAddChatMessage("[Furry Helper] {ff0000}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜: " .. tostring(err), 0xFF0000)
			print("[Furry Helper] ˜˜˜˜˜˜: " .. tostring(err))
		else
			sampAddChatMessage("[Furry Helper] {00ff00}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ Discord", 0x00FF00)
		end
	end)

	while true do
		wait(0)

		if (IS_MOBILE and settings.general.mobile_fastmenu_button) then
			if tonumber(#get_players()) > 0 and not MODULE.FastMenu.Window[0] and not MODULE.FastMenuPlayers.Window[0] then
				MODULE.FastMenuButton.Window[0] = true
			else
				MODULE.FastMenuButton.Window[0] = false
			end
		end

		if MODULE.Post.active then
			MODULE.Post.time = os.difftime(os.time(), MODULE.Post.start_time)
		end

		-- ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ (˜˜˜˜˜˜ 20 ˜˜˜˜˜ 5 ˜˜˜˜˜˜) Kolaars
	if settings.general.auto_mask then
   	 local now = os.time()
   	 if now - lastMaskTime >= (20 * 60 + 5) then
       	 sampSendChat('/mask')
       	 lastMaskTime = now
       	 sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ (˜˜˜˜˜˜ 20 ˜˜˜ 5 ˜˜˜).', message_color)
    	end
	end

	if not IS_MOBILE and settings.general.auto_update_members and MODULE.Members.Window[0] then
		local current_time = os.time()
		if not MODULE.Members.upd.check and (current_time - MODULE.Members.upd.last_time >= 3) then
			MODULE.Members.upd.check = true
			MODULE.Members.upd.last_time = current_time
			sampSendChat('/members')
		end
	end

		if isMode('police') or isMode('fbi') then
			if MODULE.Patrool.active then
				MODULE.Patrool.time = os.difftime(os.time(), MODULE.Patrool.start_time)
				if settings.mj.auto_change_code_siren and isCharInAnyCar(PLAYER_PED) then
					local currentSirenState = isCarSirenOn(storeCarCharIsInNoSave(PLAYER_PED))
					if firstCheck then
						lastSirenState = currentSirenState
						firstCheck = false
					end
					if currentSirenState ~= lastSirenState then
						lastSirenState = currentSirenState
						local newCode = currentSirenState and {'CODE 3', 4} or {'CODE 4', 5}
						sampAddChatMessage("[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜ " .. (currentSirenState and "˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜ CODE 3!" or "˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜ CODE 4."), message_color)
						MODULE.Patrool.ComboCode[0] = newCode[2]
						MODULE.Patrool.code = newCode[1]
					end
				end
			end
		end

		-- if isMode('fd') then
		-- 	if MODULE.Fires.isDialog and MODULE.Fires.dialogId ~= -1 then
		-- 		local result, button, list, input = sampHasDialogRespond(999)
		-- 		if result and button ~= -1 and list ~= -1 then
		-- 			sampSendDialogResponse(MODULE.Fires.dialogId, button, list, item)
		-- 			MODULE.Fires.dialogId = -1
		-- 			MODULE.Fires.isDialog = false
		-- 			if button ~= 0 then getFireLocation(tonumber(list)) end
		-- 		end
		-- 	end
		-- end

		if settings.general.rp_guns then
			local current = getCurrentCharWeapon(PLAYER_PED)
			if modules.rpgun.data.nowGun ~= current then
				modules.rpgun.data.oldGun = modules.rpgun.data.nowGun
				modules.rpgun.data.nowGun = current
				processWeaponChange(modules.rpgun.data.oldGun, current)
			end
        end
		
		if (MODULE.CruiseControl.wait_point) then
			local bool, x, y, z = getTargetBlipCoordinates()
			if bool then
				MODULE.CruiseControl.point = {x = x, y = y, z = z}
				MODULE.CruiseControl.wait_point = false
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!', message_color)
				while isGamePaused() or isPauseMenuActive() do wait(0) end
				lua_thread.create(function()
					sampSendChat('/me ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ CRUISE CONTROL ˜ ˜˜˜˜˜˜˜˜˜˜˜ GPS ˜˜˜˜˜˜˜˜˜')
					wait(1500)
					sampSendChat('/do ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ "GPS ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜".')
					MODULE.CruiseControl.active = true
					wait(2000)
					sampSendChat('/do ' .. MODULE.Binder.tag.my_ru_nick() .. ' ˜˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜, CRUISE CONTROL ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜.')
				end)
			end
		end
		if (MODULE.CruiseControl.active) then
			local function stop()
				MODULE.CruiseControl.active = false
				clearCharTasks(PLAYER_PED)
				if isCharInAnyCar(PLAYER_PED) then
					taskWarpCharIntoCarAsDriver(PLAYER_PED, storeCarCharIsInNoSave(PLAYER_PED))
				end
			end
			if not isCharInAnyCar(PLAYER_PED) then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!', message_color)
				stop()
			elseif not (isCarEngineOn(storeCarCharIsInNoSave(PLAYER_PED))) then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜!', message_color)
				stop()
			elseif locateCharInCar2d(PLAYER_PED, MODULE.CruiseControl.point.x, MODULE.CruiseControl.point.y, 15, 15, false) then
				sampSendChat('/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ CRUISE CONTROL')
				stop()
			else
				taskCarDriveToCoord(PLAYER_PED, storeCarCharIsInNoSave(PLAYER_PED), MODULE.CruiseControl.point.x, MODULE.CruiseControl.point.y, MODULE.CruiseControl.point.z, 28, 0, 0, 2)
			end
		end

	end

end
function load_modules()
	load_module('player')
	load_module('commands')
	load_module('buttons')
	load_module('departament')
	load_module('notes')
	load_module('rpgun')
	load_module('arz_veh')
	cache_vehicles()
	if settings.general.piemenu then
		if pie_no_errors then 
			load_module('piemenu')
			MODULE.PieMenu.Window[0] = true
		else
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ PieMenu ˜˜ ˜˜˜˜˜˜˜˜ ˜˜-˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜!', message_color)
			settings.general.piemenu = false
			save_settings()
		end
	end
	if isMode('police') or isMode('fbi') then
		load_module('smart_uk')
		load_module('smart_pdd')
	end
	if isMode('prison') then
		load_module('smart_rptp')
	end
	if isMode('smi') then
		load_module('ads_history')
	end
end
function welcome_message()
	if not sampIsLocalPlayerSpawned() then 
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜)', message_color)
		repeat wait(0) until sampIsLocalPlayerSpawned()
	end
	sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
	show_notify('info', 'Furry Helper', "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜!", 3000)
	print('˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜!')
	if hotkey_no_errors and settings.general.bind_mainmenu then	
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_mainmenu) .. ' {ffffff}˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. '/helper', message_color)
	else
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. '/helper', message_color)
	end

	if IS_MOBILE and modules.player.data.nick ~= '' then 
		CHECK_ID = true -- ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ID ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜
		sampSendChat('/id ' .. modules.player.data.nick)
	end
end
function register_command(chat_cmd, cmd_arg, cmd_text, cmd_waiting)
	sampRegisterChatCommand(chat_cmd, function(args)
		if not MODULE.Binder.state.isActive then
			if MODULE.Binder.state.isStop then
				MODULE.Binder.state.isStop = false
			end
			local arg_check = false
			local id, number, arg
			local modifiedText = cmd_text
			local function apply_nick_formats(id)
				modifiedText = modifiedText:gsub('%{get_nick%(%{id%}%)%}', sampGetPlayerNickname(id) or "")
				modifiedText = modifiedText:gsub('%{get_rp_nick%(%{id%}%)%}', sampGetPlayerNickname(id):gsub('_',' ') or "")
				modifiedText = modifiedText:gsub('%{get_ru_nick%(%{id%}%)%}', translate(sampGetPlayerNickname(id)) or "")
			end
			if cmd_arg == '{arg}' then
				if args and args ~= '' then
					modifiedText = modifiedText:gsub('{arg}', args or "")
					arg_check = true
				else
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. chat_cmd .. ' [˜˜˜˜˜ ˜˜˜˜˜˜˜˜]', message_color)
					play_sound()
				end
			elseif cmd_arg == '{id}' then
				if isParamSampID(args) then
					id = tonumber(args)
					apply_nick_formats(id)
					modifiedText = modifiedText:gsub('%{id%}', id or "")
					arg_check = true
				else
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ˜˜˜˜˜˜]', message_color)
					play_sound()
				end
			elseif cmd_arg == '{id} {arg}' then
				if args and args ~= '' then
					id, arg = args:match('(%d+) (.+)')
					if isParamSampID(id) and arg then
						id = tonumber(id)
						apply_nick_formats(id)
						modifiedText = modifiedText:gsub('%{id%}', id or "")
						modifiedText = modifiedText:gsub('%{arg%}', arg or "")
						arg_check = true
					else
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ˜˜˜˜˜˜] [˜˜˜˜˜ ˜˜˜˜˜˜˜˜]', message_color)
						play_sound()
					end
				else
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ˜˜˜˜˜˜] [˜˜˜˜˜ ˜˜˜˜˜˜˜˜]', message_color)
					play_sound()
				end
            elseif cmd_arg == '{id} {number} {arg}' then
				if args and args ~= '' then
					id, number, arg = args:match('(%d+) (%d+) (.+)')
					if isParamSampID(id) and number and arg then
						id = tonumber(id)
						apply_nick_formats(id)
						modifiedText = modifiedText:gsub('%{id%}', id or "")
						modifiedText = modifiedText:gsub('%{number%}', number or "")
                        modifiedText = modifiedText:gsub('%{arg%}', arg or "")
						arg_check = true
					else
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ˜˜˜˜˜˜] [˜˜˜˜˜ ˜˜˜˜˜] [˜˜˜˜˜ ˜˜˜˜˜˜˜˜]', message_color)
						play_sound()
					end
				else
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ˜˜˜˜˜˜] [˜˜˜˜˜ ˜˜˜˜˜] [˜˜˜˜˜ ˜˜˜˜˜˜˜˜]', message_color)
					play_sound()
				end
			elseif cmd_arg == '' then
				arg_check = true
			end
			if arg_check then
				lua_thread.create(function()
					MODULE.Binder.state.isActive = true
					MODULE.Binder.state.isPause = false
					if modifiedText:find('&.+&') then
						info_stop_command()
					end
					local lines = {}
					for line in string.gmatch(modifiedText, "[^&]+") do
						table.insert(lines, line)
					end
					local ui_action = false
					for line_index, line in ipairs(lines) do
						if MODULE.Binder.state.isStop then 
							MODULE.Binder.state.isStop = false 
							MODULE.Binder.state.isActive = false
							if IS_MOBILE and settings.general.mobile_stop_button then
								MODULE.CommandStop.Window[0] = false
							end
							sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /' .. chat_cmd .. " ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜!", message_color) 
							break
						elseif line == "{pause}" then
							sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ /' .. chat_cmd .. ' ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜!', message_color)
							if not IS_MOBILE then
								if hotkey_no_errors and settings.general.bind_action then
									sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_action) .. ' {ffffff}˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ (T/F6)', message_color)
								else
									sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ (T/F6)', message_color)
								end
							end
							MODULE.Binder.state.isPause = true
							MODULE.CommandPause.Window[0] = true
							while MODULE.Binder.state.isPause do wait(0) end
							if not MODULE.Binder.state.isStop then
								sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /' .. chat_cmd, message_color)	
							end	
						elseif line:find('{wait%((%d+)%)}') then
							wait(tonumber(string.match(line, '{wait%((%d+)%)}')))
						elseif line == '{show_medcard_menu}' then
							player_id = tonumber(id)
							ui_action = true
							MODULE.MedCard.Window[0] = true
							while MODULE.MedCard.Window[0] do wait(0) end
						elseif line == '{show_recept_menu}' then
							player_id = tonumber(id)
							ui_action = true
							MODULE.Recept.Window[0] = true
							while MODULE.Recept.Window[0] do wait(0) end
						elseif line == '{show_ant_menu}' then
							player_id = tonumber(id)
							ui_action = true
							MODULE.Antibiotik.Window[0] = true
							while MODULE.Antibiotik.Window[0] do wait(0) end
						elseif line == '{show_rank_menu}' then
							player_id = tonumber(id)
							ui_action = true
							MODULE.GiveRank.Window[0] = true
							while MODULE.GiveRank.Window[0] do wait(0) end
						elseif line == '{lmenu_vc_vize}' then
							MODULE.LeadTools.vc_vize.player_id = tonumber(id)
							MODULE.LeadTools.vc_vize.bool = true
							sampSendChat("/lmenu")
						elseif line == '{give_platoon}' then
							MODULE.LeadTools.platoon.player_id = tonumber(id)
							MODULE.LeadTools.platoon.check = true
							sampSendChat("/platoon")
						elseif line:find('%{sellrank%((%d+)%)%}') then
							MODULE.LeadTools.sell_rank.player_id = tonumber(string.match(line, '(%d+)'))
							MODULE.LeadTools.sell_rank.checker = true
							sampSendChat('/lmenu')
						elseif not MODULE.Binder.state.isStop then
							if line_index ~= 1 and not ui_action then
								local total_wait = cmd_waiting * 1000
								local waited = 0
								while waited < total_wait do
									if MODULE.Binder.state.isStop then break end
									if MODULE.DEBUG then
										local remaining = math.max(0, total_wait - waited) / 1000
										printStringNow(string.format("%d/%d - %.1fs", line_index - 1, #lines, remaining), 105)
									end
									wait(100)
									waited = waited + 100
								end
							end
							if ui_action then ui_action = false end
							if not MODULE.Binder.state.isStop then 
								for tag, replacement in pairs(MODULE.Binder.tag) do
									if line:find("{" .. tag .. "}") then
										local success, result = pcall(string.gsub, line, "{" .. tag .. "}", function() return replacement() end)
										if success then
											line = result
										end
									end
								end
								if MODULE.DEBUG then sampAddChatMessage('[SendChat] {ffffff}' .. line, message_color) end
								sampSendChat(line)
							end
						end
					end
					MODULE.Binder.state.isActive = false
					if IS_MOBILE and settings.general.mobile_stop_button then
						MODULE.CommandStop.Window[0] = false
					end
				end)
			end
		else
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
			play_sound()
		end
	end)
end
function info_stop_command()
	if IS_MOBILE and settings.general.mobile_stop_button then
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/stop {ffffff}˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜', message_color)
		MODULE.CommandStop.Window[0] = true
	elseif hotkey_no_errors and settings.general.bind_command_stop then
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/stop {ffffff}˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_command_stop), message_color)
	else
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/stop', message_color)
	end
end
function find_and_use_command(cmd, cmd_arg)
	for _, command in ipairs(modules.commands.data.commands.my) do
		if command.enable and command.text:find(cmd) then
			sampProcessChatInput("/" .. command.cmd .. " " .. cmd_arg)
			return
		end
	end 
	for _, command in ipairs(modules.commands.data.commands_manage.my) do
		if command.enable and command.text:find(cmd) then
			sampProcessChatInput("/" .. command.cmd .. " " .. cmd_arg)
			return
		end
	end
	sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', message_color)
	play_sound()
end
function initialize_commands()
	sampRegisterChatCommand("helper", function() 
		MODULE.Main.Window[0] = not MODULE.Main.Window[0] 
	end)
	sampRegisterChatCommand("binder", function() 
		MODULE.Main.Window[0] = true
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜ ˜ RP ˜˜˜˜˜˜˜˜˜" -> "RP ˜˜˜˜˜˜˜"', message_color)
	end)
	sampRegisterChatCommand("hm", show_fast_menu)
	sampRegisterChatCommand("stop", function() 
		if MODULE.Binder.state.isActive then 
			MODULE.Binder.state.isStop = true
		else 
			sampAddChatMessage('[Furry Helper] {ffffff}˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜!', message_color) 
		end
	end)
	sampRegisterChatCommand("fixsize", function()
		settings.general.custom_dpi = 1.0
		settings.general.autofind_dpi = false
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜˜...', message_color)
		save_settings()
		reload_script = true
		thisScript():reload()
	end)
	sampRegisterChatCommand("rpguns", function()
		if settings.general.rp_guns then
			MODULE.RPWeapon.Window[0] = not MODULE.RPWeapon.Window[0] 
		else
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ "RP ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜" ˜ /helper -> ˜˜˜˜˜˜˜ ' .. modules.player.data.fraction_tag, message_color)
		end
	end)
	sampRegisterChatCommand("pnv", function()
		if not MODULE.Binder.state.isActive then
			MODULE.NightVision = not MODULE.NightVision
			setNightVision(MODULE.NightVision)
			MODULE.InfraredVision = false
			setInfraredVision(MODULE.InfraredVision)
			if MODULE.NightVision then
				sampSendChat('/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜')
			else
				sampSendChat('/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜ ˜˜˜˜˜˜')
			end	
		else
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
			play_sound()
		end
	end)
	sampRegisterChatCommand("irv", function()
		if not MODULE.Binder.state.isActive then
			MODULE.InfraredVision = not MODULE.InfraredVision
			setInfraredVision(MODULE.InfraredVision)
			MODULE.NightVision = false
			setNightVision(MODULE.NightVision)	
			if MODULE.InfraredVision then
				sampSendChat('/me ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜')
			else
				sampSendChat('/me ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜ ˜ ˜˜˜˜˜˜')
			end
		else
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
			play_sound()
		end
	end)
	sampRegisterChatCommand("cruise", function()
		local server = tonumber(getServerNumber())
		if server == 0 or server < 200 then
			if not MODULE.Binder.state.isActive then
				if MODULE.CruiseControl.active then
					MODULE.CruiseControl.active = false
					if isCharInAnyCar(PLAYER_PED) then
						taskWarpCharIntoCarAsDriver(PLAYER_PED, storeCarCharIsInNoSave(PLAYER_PED))
					end
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ "CRUISE CONTROL" ˜˜˜˜˜˜˜˜!', message_color)
				else
					if not isCharInAnyCar(PLAYER_PED) then
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!', message_color)
						return
					end
					local car = storeCarCharIsInNoSave(PLAYER_PED)
					if not (isCarEngineOn(car)) then
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!', message_color)
						return
					end
					local driver = getDriverOfCar(car)
					if driver ~= PLAYER_PED then
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!', message_color)
						return
					end
					local bool, x, y, z = getTargetBlipCoordinates()
					if bool then
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜!', message_color)
						return
					end
					MODULE.CruiseControl.point = {x = 0, y = 0, z = 0}
					MODULE.CruiseControl.wait_point = true
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜)', message_color)
				end
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
				play_sound()
			end
		else
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ GTA SA! ˜˜˜˜˜ CRMP ˜˜˜ Vice City ˜˜ ˜˜˜˜˜˜˜˜!', message_color)
			play_sound()
		end
	end)
	sampRegisterChatCommand("activate", function() 
		sampAddChatMessage('[Furry Helper] {ffffff}˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ VIP ˜˜˜˜˜˜!', message_color) 
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜ Telegram/Discord VIP ˜˜˜˜ (@mtgmods_vip_bot), ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', message_color) 
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /helper ˜˜˜ ˜˜˜˜˜˜˜˜˜ VIP', message_color)
	end)
	sampRegisterChatCommand("debug", function() 
		MODULE.DEBUG = not MODULE.DEBUG 
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ' .. (MODULE.DEBUG and '˜˜˜˜˜˜˜˜!' or '˜˜˜˜˜˜˜˜˜!'), message_color) 
	end)
	if not isMode('none') then
		sampRegisterChatCommand("mb", function(arg)
			if not MODULE.Binder.state.isActive then
				if MODULE.Members.Window[0] then
					MODULE.Members.Window[0] = false
					MODULE.Members.upd.check = false
					MODULE.Members.upd.last_time = 0
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
				else
					MODULE.Members.new = {} 
					MODULE.Members.info.check = true 
					sampSendChat("/members")
				end
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
				play_sound()
			end
		end)
		sampRegisterChatCommand("dep", function(arg)
			if not MODULE.Binder.state.isActive then
				MODULE.Departament.Window[0] = not MODULE.Departament.Window[0]
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
				play_sound()
			end
		end)
		sampRegisterChatCommand("sob", function(arg)
			if not MODULE.Binder.state.isActive then
				if isParamSampID(arg) then
					player_id = tonumber(arg)
					MODULE.Sobes.Window[0] = not MODULE.Sobes.Window[0]
				else
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/sob [ID ˜˜˜˜˜˜]', message_color)
					play_sound()
				end	
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
				play_sound()
			end
		end)
	end
	if isMode('police') or isMode('fbi') then
		sampRegisterChatCommand("sum", function(arg) 
			if not MODULE.Binder.state.isActive then
				if isParamSampID(arg) then
					if #modules.smart_uk.data ~= 0 then
						player_id = tonumber(arg)
						MODULE.SumMenu.Window[0] = true 
					else
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ /helper - ˜˜˜˜˜˜˜ ' .. modules.player.data.fraction_tag, message_color)
						play_sound()
					end
				else
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/sum [ID ˜˜˜˜˜˜]', message_color)
					play_sound()
				end	
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
				play_sound()
			end
		end)
		sampRegisterChatCommand("tsm", function(arg) 
			if not MODULE.Binder.state.isActive then
				if isParamSampID(arg) then
					if #modules.smart_pdd.data ~= 0 then
						player_id = tonumber(arg)
						MODULE.TsmMenu.Window[0] = true
					else
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ /helper - ˜˜˜˜˜˜˜ ' .. modules.player.data.fraction_tag, message_color)
						play_sound()
					end
				else
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/tsm [ID ˜˜˜˜˜˜]', message_color)
					play_sound()
				end	
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
				play_sound()
			end
		end)
		sampRegisterChatCommand("afind", function(arg)
			send_no_vip_msg()
		end)
		sampRegisterChatCommand("wanted", function(arg)
			sampSendChat('/wanted ' .. arg)
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ /wanteds ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
		end)
		sampRegisterChatCommand("wanteds", function(arg)
			if MODULE.Wanted.Window[0] or MODULE.Wanted.updwanteds.stop then
				MODULE.Wanted.Window[0] = false
				MODULE.Wanted.checker = false
				MODULE.Wanted.updwanteds.stop = false
				MODULE.Wanted.updwanteds.check = false
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
			elseif not MODULE.Wanted.checker then
				lua_thread.create(function()
					local max_lvl = isMode('fbi') and 7 or 6
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜˜ /wanted, ˜˜˜˜˜˜˜˜ ' .. message_color_hex .. max_lvl .. ' {ffffff}˜˜˜˜˜˜...', message_color)
					show_notify('info', 'Arizona Helper', "˜˜˜˜˜˜˜˜˜˜˜˜ /wanted...", 2500)
					MODULE.Wanted.new = {}
					MODULE.Wanted.checker = true
					for i = max_lvl, 1, -1 do
						printStringNow("CHECK WANTED " .. i, 1000)
						sampSendChat('/wanted ' .. i)
						wait(1000)
					end
					MODULE.Wanted.checker = false
					if #MODULE.Wanted.new == 0 then
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜!', message_color)
					else
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜˜ /wanted ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜: ' .. message_color_hex .. #MODULE.Wanted.new, message_color)
						MODULE.Wanted.all = MODULE.Wanted.new
						MODULE.Wanted.updwanteds.stop = false
						MODULE.Wanted.updwanteds.time = 0
						MODULE.Wanted.updwanteds.last_time = os.time()
						MODULE.Wanted.updwanteds.check = true
						MODULE.Wanted.Window[0] = true
					end
				end)
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜!', message_color)
				play_sound()
			end
		end)
		sampRegisterChatCommand("patrool", function(arg)
			MODULE.Patrool.Window[0] = not MODULE.Patrool.Window[0]
		end)
	end
	if not (isMode('ghetto') or isMode('mafia') or isMode('judge')) then
		sampRegisterChatCommand("post", function(arg)
			if not MODULE.Binder.state.isActive then
				MODULE.Post.Window[0] = not MODULE.Post.Window[0]
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
				play_sound()
			end
		end)
	end
	if isMode('prison') then
		sampRegisterChatCommand("pum", function(arg) 
			if not MODULE.Binder.state.isActive then
				if isParamSampID(arg) then
					if #modules.smart_rptp.data ~= 0 then
						player_id = tonumber(arg)
						MODULE.PumMenu.Window[0] = true 
					else
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜ /helper - ˜˜˜˜˜˜˜ ' .. modules.player.data.fraction_tag, message_color)
						play_sound()
					end
				else
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/pum [ID ˜˜˜˜˜˜]', message_color)
					play_sound()
				end	
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
				play_sound()
			end
		end)
	end
	if isMode('gov') then
		sampRegisterChatCommand('zeks', function()
			if settings.gov.custom_zeks then
				if MODULE.Zeks.Window[0] or MODULE.Zeks.updzeks.stop then
					MODULE.Zeks.Window[0] = false
					MODULE.Zeks.checker = false
					MODULE.Zeks.updzeks.stop = false
					MODULE.Zeks.updzeks.check = false
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
				elseif not MODULE.Zeks.checker then
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜˜ /zeks...', message_color)
					show_notify('info', 'Arizona Helper', "˜˜˜˜˜˜˜˜˜˜˜˜ /zeks...", 2500)
					MODULE.Zeks.new = {}
					MODULE.Zeks.checker = true
					sampSendChat('/zeks')
				else
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜!', message_color)
					play_sound()
				end
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ /zeks ˜ ˜˜˜˜-˜˜˜˜˜˜˜˜˜˜˜ ˜ /helper - ˜˜˜˜˜˜˜ ˜˜˜˜˜', message_color)
				sampSendChat('/zeks')
			end
		end)
	end
	for _, command in ipairs(modules.commands.data.commands.my) do
		if command.enable then
			register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
		end
	end
	if modules.player.data.fraction_rank_number >= 9 then
		sampRegisterChatCommand("lm", show_leader_fast_menu)
		sampRegisterChatCommand("spcar", function()
			if not MODULE.Binder.state.isActive then
				lua_thread.create(function()
					MODULE.Binder.state.isActive = true
					info_stop_command()
					sampSendChat("/rb ˜˜˜˜˜˜˜˜! ˜˜˜˜˜ 15 ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.")
					wait(1500)
					if MODULE.Binder.state.isStop then 
						MODULE.Binder.state.isStop = false 
						MODULE.Binder.state.isActive = false
						if IS_MOBILE and settings.general.mobile_stop_button then
							MODULE.CommandStop.Window[0] = false
						end
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /spcar ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜!', message_color) 
						return
					end
					sampSendChat("/rb ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.")
					wait(13500)
					if MODULE.Binder.state.isStop then 
						MODULE.Binder.state.isStop = false 
						MODULE.Binder.state.isActive = false
						if IS_MOBILE and settings.general.mobile_stop_button then
							MODULE.CommandStop.Window[0] = false
						end
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /spcar ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜!', message_color) 
						return
					end
					MODULE.LeadTools.spawncar = true
					sampSendChat("/lmenu")
					MODULE.Binder.state.isActive = false
					if IS_MOBILE and settings.general.mobile_stop_button then
						MODULE.CommandStop.Window[0] = false
					end
				end)
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
			end
		end)
		sampRegisterChatCommand('fcleaner', function (arg)
			if arg:find('(%d+)') then
				MODULE.LeadTools.cleaner.players_to_kick = {}
				MODULE.LeadTools.cleaner.day_afk = tonumber(arg)
				MODULE.LeadTools.cleaner.uninvite = true
				sampSendChat('/lmenu')
			else
				sampAddChatMessage('[Arizina Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/fcleaner [˜˜˜-˜˜ ˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜]', message_color)
			end
		end)
		for _, command in ipairs(modules.commands.data.commands_manage.my) do
			if command.enable then
				register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
			end
		end
	end
end
local cyrilic_characters = {
    [168] = '˜', [184] = '˜', [192] = '˜', [193] = '˜', [194] = '˜', [195] = '˜', [196] = '˜',
	[197] = '˜', [198] = '˜', [199] = '˜', [200] = '˜', [201] = '˜', [202] = '˜', [203] = '˜',
	[204] = '˜', [205] = '˜', [206] = '˜', [207] = '˜', [208] = '˜', [209] = '˜', [210] = '˜',
	[211] = '˜', [212] = '˜', [213] = '˜', [214] = '˜', [215] = '˜', [216] = '˜', [217] = '˜',
	[218] = '˜', [219] = '˜', [220] = '˜', [221] = '˜', [222] = '˜', [223] = '˜', [224] = '˜',
	[225] = '˜', [226] = '˜', [227] = '˜', [228] = '˜', [229] = '˜', [230] = '˜', [231] = '˜',
	[232] = '˜', [233] = '˜', [234] = '˜', [235] = '˜', [236] = '˜', [237] = '˜', [238] = '˜',
	[239] = '˜', [240] = '˜', [241] = '˜', [242] = '˜', [243] = '˜', [244] = '˜', [245] = '˜',
	[246] = '˜', [247] = '˜', [248] = '˜', [249] = '˜', [250] = '˜', [251] = '˜', [252] = '˜',
	[253] = '˜', [254] = '˜', [255] = '˜',
}
function string.rlower(s)
    s = s:lower()
    local strlen = s:len()
    if strlen == 0 then return s end
    s = s:lower()
    local output = ''
    for i = 1, strlen do
        local ch = s:byte(i)
        if ch >= 192 and ch <= 223 then -- upper cyrilic characters
            output = output .. cyrilic_characters[ch + 32]
        elseif ch == 168 then -- ˜
            output = output .. cyrilic_characters[184]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end
function string.rupper(s)
    s = s:upper()
    local strlen = s:len()
    if strlen == 0 then return s end
    s = s:upper()
    local output = ''
    for i = 1, strlen do
        local ch = s:byte(i)
        if ch >= 224 and ch <= 255 then -- lower cyrilic characters
            output = output .. cyrilic_characters[ch - 32]
        elseif ch == 184 then -- ˜
            output = output .. cyrilic_characters[168]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end
function translate(name)
	if name and name:match('%a+') then
		local translit_table = {
       		['ph'] = '˜',['Ph'] = '˜',['Ch'] = '˜',['ch'] = '˜',['Th'] = '˜', ['liy'] = '˜˜˜', 
			['th'] = '˜',['Sh'] = '˜',['sh'] = '˜',['Ae'] = '˜',['ae'] = '˜', ['ame'] = '˜˜˜',
			['size'] = '˜˜˜˜', ['Jj'] = '˜˜˜˜˜˜˜˜',['Whi'] = '˜˜˜',['lack'] = '˜˜˜', ['ane'] = '˜˜˜',
			['whi'] = '˜˜˜',['Ck'] = '˜',['ck'] = '˜',['Kh'] = '˜',['kh'] = '˜', ['Alex'] = '˜˜˜˜˜',
			['hn'] = '˜',['Hen'] = '˜˜˜',['Zh'] = '˜',['zh'] = '˜',['Yu'] = '˜', ['Jason'] = '˜˜˜˜˜˜˜',
			['yu'] = '˜',['Yo'] = '˜',['yo'] = '˜',['Cz'] = '˜',['cz'] = '˜', ['Babe'] = '˜˜˜˜˜', 
			['ia'] = '˜', ['ea'] = '˜',['Ya'] = '˜', ['ya'] = '˜', ['ove'] = '˜˜',['ci'] = '˜˜',
			['ay'] = '˜˜', ['rise'] = '˜˜˜˜',['oo'] = '˜', ['Oo'] = '˜', ['rown'] = '˜˜˜˜',
			['Ee'] = '˜', ['ee'] = '˜', ['Un'] = '˜˜', ['un'] = '˜˜', ['Ci'] = '˜˜',
			['yse'] = '˜˜', ['cate'] = '˜˜˜˜', ['eow'] = '˜˜', ['yev'] = '˜˜˜', ['Alexei'] = '˜˜˜˜˜˜˜', 
		}
		for k, v in pairs(translit_table) do
            name = name:gsub(k, v) 
        end
		local char_table = {
			['B'] = '˜',['Z'] = '˜',['T'] = '˜',['Y'] = '˜',['P'] = '˜',['J'] = '˜˜',['X'] = '˜˜',['G'] = '˜',
			['V'] = '˜',['H'] = '˜',['N'] = '˜',['E'] = '˜',['I'] = '˜',['D'] = '˜',['O'] = '˜',['K'] = '˜',['F'] = '˜',
			['y`'] = '˜',['e`'] = '˜',['A'] = '˜',['C'] = '˜',['L'] = '˜',['M'] = '˜',['W'] = '˜',['Q'] = '˜',
			['U'] = '˜',['R'] = '˜',['S'] = '˜',['zm'] = '˜˜˜',['h'] = '˜',['q'] = '˜',['y'] = '˜',['a'] = '˜',
			['w'] = '˜',['b'] = '˜',['v'] = '˜',['g'] = '˜',['d'] = '˜',['e'] = '˜',['z'] = '˜',['i'] = '˜',
			['j'] = '˜',['k'] = '˜',['l'] = '˜',['m'] = '˜',['n'] = '˜',['o'] = '˜',['p'] = '˜',['r'] = '˜',
			['s'] = '˜',['t'] = '˜',['u'] = '˜',['f'] = '˜',['x'] = 'x',['c'] = '˜',['``'] = '˜',['`'] = '˜',['_'] = ' '
		}
        for k, v in pairs(char_table) do
			name = name:gsub(k, v) 
        end
        return name
    end
	return name
end
function isParamSampID(id)
	id = tonumber(id) or nil
	if not id or id < 0 or id > 999 then return false end
	return id == MODULE.Binder.tag.my_id() or sampIsPlayerConnected(id)
end
function play_sound()
	local path_audio = config_dir .. "/Resourse/notify.mp3"
	if doesFileExist(path_audio) then
		local notify_sound = loadAudioStream(path_audio)
		setAudioStreamState(notify_sound, 1)
	end
end
function show_fast_menu(id)
	if isParamSampID(id) then 
		player_id = tonumber(id)
		MODULE.FastMenu.Window[0] = true
	else
		if hotkey_no_errors and settings.general.bind_fastmenu then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/hm [ID ˜˜˜˜˜˜] {ffffff}˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ' .. message_color_hex .. '˜˜˜ + ' .. getNameKeysFrom(settings.general.bind_fastmenu), message_color) 
		else
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/hm [ID ˜˜˜˜˜˜]', message_color)
		end 
		play_sound()
	end 
end
function show_leader_fast_menu(id)
	if isParamSampID(id) then
		player_id = tonumber(id)
		MODULE.LeaderFastMenu.Window[0] = true
	else
		if hotkey_no_errors and settings.general.bind_leader_fastmenu then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/lm [ID ˜˜˜˜˜˜] {ffffff}˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ' .. message_color_hex .. '˜˜˜ + ' .. getNameKeysFrom(settings.general.bind_leader_fastmenu), message_color) 
		else
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/lm [ID ˜˜˜˜˜˜]', message_color)
		end 
		play_sound()
	end
end
function get_players()
	local myId = MODULE.Binder.tag.my_id()
	local mx, my, mz = getCharCoordinates(PLAYER_PED)
	local playersInRange = {}
	for i, ped in pairs(getAllChars()) do
		local result, id = sampGetPlayerIdByCharHandle(ped)
		if result and id and id ~= myId and id ~= -1 and not sampGetPlayerNickname(id):find('^Player_') and not sampGetPlayerNickname(id):find('^' .. modules.player.data.nick) then
			local x, y, z = getCharCoordinates(ped)
			if getDistanceBetweenCoords3d(mx, my, mz, x, y, z) <= 8 then
				table.insert(playersInRange, id)
			end
		end
	end
	return playersInRange
end
function openLink(link)
	if IS_MOBILE then
		ffi.cdef[[ void _Z12AND_OpenLinkPKc(const char* link); ]]
		ffi.load('GTASA')._Z12AND_OpenLinkPKc(link)
	else
		os.execute("explorer " .. link)
	end
end
local servers = {
	{name = 'Unknown server', number = '00'},
	-- Arizona
	{name = 'Phoenix', number = '01'},
	{name = 'Tucson', number = '02'},
	{name = 'Scottdale', number = '03'},
	{name = 'Chandler', number = '04'},
	{name = 'Brainburg', number = '05'},
	{name = 'SaintRose', number = '06'},
	{name = 'Mesa', number = '07'},
	{name = 'Red Rock', number = '08'},
	{name = 'Yuma', number = '09'},
	{name = 'Surprise', number = '10'},
	{name = 'Prescott', number = '11'},
	{name = 'Glendale', number = '12'},
	{name = 'Kingman', number = '13'},
	{name = 'Winslow', number = '14'},
	{name = 'Payson', number = '15'},
	{name = 'Gilbert', number = '16'},
	{name = 'Show Low', number = '17'},
	{name = 'Casa Grande', number = '18'},
	{name = 'Page', number = '19'},
	{name = 'Sun City', number = '20'},
	{name = 'Queen Creek', number = '21'},
	{name = 'Sedona', number = '22'},
	{name = 'Holiday', number = '23'},
	{name = 'Wednesday', number = '24'},
	{name = 'Yava', number = '25'},
	{name = 'Faraway', number = '26'},
	{name = 'Bumble Bee', number = '27'},
	{name = 'Christmas', number = '28'},
	{name = 'Mirage', number = '29'},
	{name = 'Love', number = '30'},
	{name = 'Drake', number = '31'},
	{name = 'Space', number = '32'},
	-- Arizona Mobile
	{name = 'Mobile III', number = '103'},
	{name = 'Mobile II', number = '102'},
	{name = 'Mobile I', number = '101'},
	-- Arizona VC
	{name = 'Vice City'	, number = '200'},
	-- Rodina
	{name = '˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜'	, number = '301'},
	{name = '˜˜˜˜˜ ˜˜˜˜˜', number = '302'},
	{name = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜', number = '303'},
	{name = '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜', number = '304'},
	{name = '˜˜˜˜˜˜˜˜ ˜˜˜˜˜', number = '305'},
	{name = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜', number = '306'},
	{name = '˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜', number = '307'},
	-- Rodina Mobile
	{name = '˜˜˜˜˜˜', number = '401'},
	{name = '˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜', number = '402'},
}
function getServerNumber()
	local name = sampGetCurrentServerName():gsub('%-', ' ')
	for _, s in ipairs(servers) do
		if name:find(s.name) then
			return s.number
		end
	end
	return '00'
end
function getServerName(number)
	for _, s in ipairs(servers) do
		if tostring(number) == tostring(s.number) then
			return s.name
		end
	end
	return ''
end
function sampGetPlayerIdByNickname(nick)
	if not nick then return -1 end
	local myid = MODULE.Binder.tag.my_id()
	if IS_MOBILE then
		if nick == modules.player.data.nick then return myid end
	else
		if sampGetPlayerNickname(myid):find(nick, 1, true) then return myid end
	end
	for i = 0, 999 do
	    if sampIsPlayerConnected(i) and sampGetPlayerNickname(i):find(nick, 1, true) then
		   return i
	    end
	end
	return -1
end
local car_colors = {
	[0] = "˜˜˜˜˜˜˜", [1] = "˜˜˜˜˜˜", [2] = "˜˜˜˜˜˜˜˜˜˜", [3] = "˜˜˜˜˜˜˜˜˜", [4] = "˜˜˜˜˜˜˜˜", [5] = "˜˜˜˜˜˜˜˜˜˜", [6] = "˜˜˜˜˜˜", [7] = "˜˜˜˜˜˜˜˜", [8] = "˜˜˜˜˜˜", 
	[9] = "˜˜˜˜˜˜˜˜˜˜", [10] = "˜˜˜˜˜˜", [11] = "˜˜˜˜˜˜", [12] = "˜˜˜˜˜˜˜˜", [13] = "˜˜˜˜˜˜˜˜˜˜˜", [14] = "˜˜˜˜˜˜˜˜", [15] = "˜˜˜˜˜˜˜˜", [16] = "˜˜˜˜˜˜˜˜", [17] = "˜˜˜˜˜˜˜˜˜", 
	[18] = "˜˜˜˜˜˜˜˜˜", [19] = "˜˜˜˜˜˜", [20] = "˜˜˜˜˜˜", [21] = "˜˜˜˜˜˜˜˜˜", [22] = "˜˜˜˜˜˜˜˜˜", [23] = "˜˜˜˜˜˜", [24] = "˜˜˜˜˜˜˜˜˜˜˜", [25] = "˜˜˜˜˜˜", [26] = "˜˜˜˜˜˜˜˜", 
	[27] = "˜˜˜˜˜˜˜˜", [28] = "˜˜˜˜˜˜", [29] = "˜˜˜˜˜˜˜˜", [30] = "˜˜˜˜˜˜˜˜˜", [31] = "˜˜˜˜˜˜˜˜˜", [32] = "˜˜˜˜˜˜˜˜˜˜˜˜", [33] = "˜˜˜˜˜˜", [34] = "˜˜˜˜˜˜˜˜", 
	[35] = "˜˜˜˜˜˜˜˜˜˜˜", [36] = "˜˜˜˜˜˜", [37] = "˜˜˜˜˜˜˜˜", [38] = "˜˜˜˜˜˜", [39] = "˜˜˜˜˜˜", [40] = "˜˜˜˜˜˜", [41] = "˜˜˜˜˜˜˜˜˜˜˜", [42] = "˜˜˜˜˜˜˜˜˜˜˜",
	[43] = "˜˜˜˜˜˜˜˜˜", [44] = "˜˜˜˜˜˜˜˜", [45] = "˜˜˜˜˜˜˜˜˜", [46] = "˜˜˜˜˜˜˜˜", [47] = "˜˜˜˜˜˜˜˜˜˜", [48] = "˜˜˜˜˜˜˜˜˜˜", [49] = "˜˜˜˜˜˜", [50] = "˜˜˜˜˜˜˜˜˜˜˜˜", 
	[51] = "˜˜˜˜˜˜˜˜", [52] = "˜˜˜˜˜˜", [53] = "˜˜˜˜˜˜", [54] = "˜˜˜˜˜˜", [55] = "˜˜˜˜˜˜˜˜˜˜˜", [56] = "˜˜˜˜˜˜˜˜", [57] = "˜˜˜˜˜˜˜˜˜˜", [58] = "˜˜˜˜˜˜˜˜˜˜˜˜", 
	[59] = "˜˜˜˜˜˜", [60] = "˜˜˜˜˜˜˜˜", [61] = "˜˜˜˜˜˜˜˜˜˜", [62] = "˜˜˜˜˜˜˜˜˜˜˜˜", [63] = "˜˜˜˜˜˜˜˜˜˜˜˜", [64] = "˜˜˜˜˜˜˜˜", [65] = "˜˜˜˜˜˜˜˜˜˜", [66] = "˜˜˜˜˜˜˜˜˜˜˜", 
	[67] = "˜˜˜˜˜˜˜˜˜˜˜˜", [68] = "˜˜˜˜˜˜˜˜˜˜", [69] = "˜˜˜˜˜˜˜˜˜˜", [70] = "˜˜˜˜˜˜˜˜˜˜˜˜", [71] = "˜˜˜˜˜˜˜˜", [72] = "˜˜˜˜˜˜˜˜˜˜", [73] = "˜˜˜˜˜˜˜˜˜˜", [74] = "˜˜˜˜˜˜˜˜˜", 
	[75] = "˜˜˜˜˜˜", [76] = "˜˜˜˜˜˜˜˜˜˜", [77] = "˜˜˜˜˜˜˜˜˜˜", [78] = "˜˜˜˜˜˜˜˜˜", [79] = "˜˜˜˜˜˜", [80] = "˜˜˜˜˜˜˜˜", [81] = "˜˜˜˜˜˜˜˜˜˜", [82] = "˜˜˜˜˜˜˜˜˜˜˜˜", 
	[83] = "˜˜˜˜˜˜˜˜˜˜", [84] = "˜˜˜˜˜˜˜˜˜˜˜", [85] = "˜˜˜˜˜˜˜˜", [86] = "˜˜˜˜˜˜˜˜", [87] = "˜˜˜˜˜˜", [88] = "˜˜˜˜˜˜˜", [89] = "˜˜˜˜˜˜˜˜˜˜", [90] = "˜˜˜˜˜˜˜˜", 
	[91] = "˜˜˜˜˜˜˜˜˜˜", [92] = "˜˜˜˜˜˜˜˜˜˜", [93] = "˜˜˜˜˜˜˜˜˜˜˜˜", [94] = "˜˜˜˜˜˜", [95] = "˜˜˜˜˜˜", [96] = "˜˜˜˜˜˜˜˜", [97] = "˜˜˜˜˜˜˜˜˜˜˜˜", [98] = "˜˜˜˜˜˜˜˜˜˜˜˜", 
	[99] = "˜˜˜˜˜˜˜˜˜˜˜", [100] = "˜˜˜˜˜˜˜˜˜˜˜˜˜˜", [101] = "˜˜˜˜˜˜˜˜˜˜˜˜", [102] = "˜˜˜˜˜˜˜˜˜˜˜", [103] = "˜˜˜˜˜˜", [104] = "˜˜˜˜˜˜˜˜˜˜˜", [105] = "˜˜˜˜˜˜", [106] = "˜˜˜˜˜˜", 
	[107] = "˜˜˜˜˜˜˜˜˜˜", [108] = "˜˜˜˜˜˜˜˜˜˜˜˜˜˜", [109] = "˜˜˜˜˜˜", [110] = "˜˜˜˜˜˜˜˜˜˜", [111] = "˜˜˜˜˜˜", [112] = "˜˜˜˜˜˜", [113] = "˜˜˜˜˜˜˜˜˜˜˜", [114] = "˜˜˜˜˜˜˜", 
	[115] = "˜˜˜˜˜˜˜˜˜˜˜˜", [116] = "˜˜˜˜˜˜", [117] = "˜˜˜˜˜˜˜˜˜", [118] = "˜˜˜˜˜˜˜˜", [119] = "˜˜˜˜˜˜˜˜˜˜˜", [120] = "˜˜˜˜˜˜˜˜˜˜", [121] = "˜˜˜˜˜˜˜˜˜", [122] = "˜˜˜˜˜˜˜˜˜˜", 
	[123] = "˜˜˜˜˜˜˜˜˜˜˜", [124] = "˜˜˜˜˜˜˜˜˜˜˜˜", [125] = "˜˜˜˜˜˜", [126] = "˜˜˜˜˜˜˜˜", [127] = "˜˜˜˜˜˜˜", [128] = "˜˜˜˜˜˜˜", [129] = "˜˜˜˜˜˜˜˜˜", [130] = "˜˜˜˜˜˜",
	[131] = "˜˜˜˜˜˜˜˜˜˜˜", [132] = "˜˜˜˜˜˜˜˜˜˜˜˜", [133] = "˜˜˜˜˜˜˜", [134] = "˜˜˜˜˜˜˜˜˜˜˜", [135] = "˜˜˜˜˜˜˜˜˜˜", [136] = "˜˜˜˜˜˜˜˜˜˜˜˜", [137] = "˜˜˜˜˜˜˜", [138] = "˜˜˜˜˜˜",
	[139] = "˜˜˜˜˜˜˜˜˜˜", [140] = "˜˜˜˜˜˜˜˜", [141] = "˜˜˜˜˜˜˜˜˜˜", [142] = "˜˜˜˜˜˜˜˜˜˜", [143] = "˜˜˜˜˜˜˜˜˜˜˜", [144] = "˜˜˜˜˜˜˜˜˜˜˜", [145] = "˜˜˜˜˜˜˜", [146] = "˜˜˜˜˜˜˜˜˜˜", 
	[147] = "˜˜˜˜˜˜˜˜˜˜˜", [148] = "˜˜˜˜˜˜˜˜˜˜", [149] = "˜˜˜˜˜˜", [150] = "˜˜˜˜˜˜˜˜˜˜˜", [151] = "˜˜˜˜˜˜˜˜", [152] = "˜˜˜˜˜˜", [153] = "˜˜˜˜˜˜˜", [154] = "˜˜˜˜˜˜˜˜˜˜", 
	[155] = "˜˜˜˜˜˜˜˜˜˜", [156] = "˜˜˜˜˜˜˜˜˜˜˜", [157] = "˜˜˜˜˜˜˜˜", [158] = "˜˜˜˜˜˜˜˜˜˜", [159] = "˜˜˜˜˜˜˜˜˜˜˜", [160] = "˜˜˜˜˜˜˜˜˜˜˜", [161] = "˜˜˜˜˜˜˜", [162] = "˜˜˜˜˜˜",
	[163] = "˜˜˜˜˜˜˜˜˜˜˜", [164] = "˜˜˜˜˜˜˜", [165] = "˜˜˜˜˜˜˜˜˜˜", [166] = "˜˜˜˜˜˜˜˜˜˜", [167] = "˜˜˜˜˜˜˜˜˜˜˜", [168] = "˜˜˜˜˜˜˜˜˜", [169] = "˜˜˜˜˜˜˜˜˜˜˜", [170] = "˜˜˜˜˜˜˜˜˜˜˜", 
	[171] = "˜˜˜˜˜˜˜˜˜˜˜", [172] = "˜˜˜˜˜˜˜˜", [173] = "˜˜˜˜˜˜˜˜˜˜˜", [174] = "˜˜˜˜˜˜˜˜˜˜˜", [175] = "˜˜˜˜˜˜˜˜˜˜˜", [176] = "˜˜˜˜˜˜˜˜˜˜", [177] = "˜˜˜˜˜˜˜˜˜˜", [178] = "˜˜˜˜˜˜˜˜˜˜", 
	[179] = "˜˜˜˜˜˜˜˜˜˜˜", [180] = "˜˜˜˜˜˜˜˜˜˜˜", [181] = "˜˜˜˜˜˜˜˜", [182] = "˜˜˜˜˜˜˜˜˜˜", [183] = "˜˜˜˜˜˜˜˜˜˜", [184] = "˜˜˜˜˜˜˜˜", [185] = "˜˜˜˜˜˜˜", [186] = "˜˜˜˜˜˜˜", 
	[187] = "˜˜˜˜˜˜˜", [188] = "˜˜˜˜˜˜˜", [189] = "˜˜˜˜˜˜˜", [190] = "˜˜˜˜˜˜˜˜˜˜", [191] = "˜˜˜˜˜˜˜˜˜˜", [192] = "˜˜˜˜˜˜˜˜", [193] = "˜˜˜˜˜˜˜˜", [194] = "˜˜˜˜˜˜˜˜˜˜", 
	[195] = "˜˜˜˜˜˜˜˜˜˜", [196] = "˜˜˜˜˜˜", [197] = "˜˜˜˜˜˜˜˜˜˜", [198] = "˜˜˜˜˜˜", [199] = "˜˜˜˜˜˜˜˜˜˜", [200] = "˜˜˜˜˜˜˜˜˜", [201] = "˜˜˜˜˜˜", [202] = "˜˜˜˜˜˜˜", [203] = "˜˜˜˜˜˜",
	[204] = "˜˜˜˜˜˜˜˜", [205] = "˜˜˜˜˜˜", [206] = "˜˜˜˜˜˜˜˜˜˜", [207] = "˜˜˜˜˜˜˜˜", [208] = "˜˜˜˜˜˜", [209] = "˜˜˜˜˜˜", [210] = "˜˜˜˜˜˜", [211] = "˜˜˜˜˜˜˜˜˜˜˜", 
	[212] = "˜˜˜˜˜˜˜˜˜˜", [213] = "˜˜˜˜˜˜˜˜", [214] = "˜˜˜˜˜˜˜˜˜˜", [215] = "˜˜˜˜˜˜˜", [216] = "˜˜˜˜˜˜˜˜˜˜", [217] = "˜˜˜˜˜˜˜˜˜˜", [218] = "˜˜˜˜˜˜-˜˜˜˜˜˜˜˜", [219] = "˜˜˜˜˜˜˜˜˜˜", 
	[220] = "˜˜˜˜˜˜˜˜", [221] = "˜˜˜˜˜˜˜˜˜˜", [222] = "˜˜˜˜˜˜˜˜˜˜", [223] = "˜˜˜˜˜˜", [224] = "˜˜˜˜˜˜˜˜˜", [225] = "˜˜˜˜˜˜˜˜", [226] = "˜˜˜˜˜˜˜˜˜˜", [227] = "˜˜˜˜˜˜˜", 
	[228] = "˜˜˜˜˜˜˜˜", [229] = "˜˜˜˜˜˜˜˜˜˜", [230] = "˜˜˜˜˜˜˜˜˜", [231] = "˜˜˜˜˜˜˜˜˜˜˜", [232] = "˜˜˜˜˜˜˜˜", [233] = "˜˜˜˜˜˜˜˜˜˜", [234] = "˜˜˜˜˜˜˜˜˜˜˜", [235] = "˜˜˜˜˜˜˜˜˜˜",
	[236] = "˜˜˜˜˜˜˜˜", [237] = "˜˜˜˜˜˜˜˜˜˜", [238] = "˜˜˜˜˜˜˜˜˜˜", [239] = "˜˜˜˜˜˜˜˜˜˜˜", [240] = "˜˜˜˜˜˜˜˜", [241] = "˜˜˜˜˜˜˜˜", [242] = "˜˜˜˜˜˜˜˜˜˜˜", [243] = "˜˜˜˜˜˜˜", 
	[244] = "˜˜˜˜˜˜˜˜˜˜˜", [245] = "˜˜˜˜˜˜˜˜", [246] = "˜˜˜˜˜˜˜˜", [247] = "˜˜˜˜˜˜", [248] = "˜˜˜˜˜˜˜˜˜", [249] = "˜˜˜˜˜˜˜˜˜", [250] = "˜˜˜˜˜˜", [251] = "˜˜˜˜˜˜", [252] = "˜˜˜˜˜˜˜", 
	[253] = "˜˜˜˜˜˜", [254] = "˜˜˜˜˜˜˜˜˜˜˜", [255] = "˜˜˜˜˜˜"
}
function get_vehicle_name(id)
	local map = modules.arz_veh.byId
	if map and map[id] then
		return map[id]
	end
	sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜/c ' .. id .. " ID, ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜...", message_color)
	download_file = 'arz_veh'
	downloadFileFromUrlToPath('https://mtgmods.github.io/arizona-helper/SmartVEH/Vehicles' .. 
	((tonumber(getServerNumber()) > 300) and 'Rodina.json' or '.json'), modules.arz_veh.path)
	return '˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜'
end
function get_near_car(only_with_driver)
	local closest_car = nil
	local closest_distance = 50
	local my_pos = {getCharCoordinates(PLAYER_PED)}
	local my_car = nil

	if isCharInAnyCar(PLAYER_PED) then my_car = storeCarCharIsInNoSave(PLAYER_PED) end

	for _, vehicle in ipairs(getAllVehicles()) do
		if vehicle ~= my_car then
			if (not only_with_driver) or doesCharExist(getDriverOfCar(vehicle)) then
				local vehicle_pos = {getCarCoordinates(vehicle)}
				local distance = getDistanceBetweenCoords3d(my_pos[1], my_pos[2], my_pos[3], vehicle_pos[1], vehicle_pos[2], vehicle_pos[3])
				if distance < closest_distance then
					closest_distance = distance
					closest_car = vehicle
				end
			end
		end
	end

	if not closest_car then return '˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜' end

	local clr1 = getCarColours(closest_car)
	local CarColorName = clr1 and (' ' .. car_colors[clr1] .. ' ˜˜˜˜˜') or ''
	
	local plateText = ''
	for _, plate in pairs(modules.arz_veh.cache) do
		local result, veh = sampGetCarHandleBySampVehicleId(plate.carID)
		if result and veh == closest_car then
			plateText = ' c ˜˜˜˜˜˜˜˜ ' .. plate.number
			break
		end
	end

	return (get_vehicle_name(getCarModel(closest_car)) .. CarColorName .. plateText)
end
function cache_vehicles()
	for _, v in ipairs(modules.arz_veh.data) do
		if v.model_id then
			modules.arz_veh.byId[v.model_id] = v.name
		end
	end
end
function get_area(x, y, z)
	local streets = {
		{"˜˜˜˜˜-˜˜˜˜ ˜˜˜˜˜˜", -2667.810, -302.135, -28.831, -2646.400, -262.320, 71.169},
		{"˜˜˜˜˜˜˜˜ ˜˜", -1315.420, -405.388, 15.406, -1264.400, -209.543, 25.406},
		{"˜˜˜˜˜-˜˜˜˜ ˜˜˜˜˜˜", -2550.040, -355.493, 0.000, -2470.040, -318.493, 39.700},
		{"˜˜˜˜˜˜˜˜ ˜˜", -1490.330, -209.543, 15.406, -1264.400, -148.388, 25.406},
		{"˜˜˜˜˜˜", -2395.140, -222.589, -5.3, -2354.090, -204.792, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜", -1632.830, -2263.440, -3.0, -1601.330, -2231.790, 200.000},
		{"˜˜˜˜˜˜˜˜˜ ˜˜", 2381.680, -1494.030, -89.084, 2421.030, -1454.350, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1236.630, 1163.410, -89.084, 1277.050, 1203.280, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜", 1277.050, 1044.690, -89.084, 1315.350, 1087.630, 110.916},
		{"˜˜˜˜˜-˜˜˜˜ ˜˜˜˜˜˜", -2470.040, -355.493, 0.000, -2270.040, -318.493, 46.100},
		{"˜˜˜˜˜ ˜˜˜˜˜", 1252.330, -926.999, -89.084, 1357.000, -910.170, 110.916},
		{"˜˜˜˜˜˜ ˜˜", 1692.620, -1971.800, -20.492, 1812.620, -1932.800, 79.508},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1315.350, 1044.690, -89.084, 1375.600, 1087.630, 110.916},
		{"˜˜˜-˜˜˜˜˜˜", 2581.730, -1454.350, -89.084, 2632.830, -1393.420, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 2437.390, 1858.100, -39.084, 2495.090, 1970.850, 60.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", -1132.820, -787.391, 0.000, -956.476, -768.027, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1370.850, -1170.870, -89.084, 1463.900, -1130.850, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", -1620.300, 1176.520, -4.5, -1580.010, 1274.260, 200.000},
		{"˜˜˜˜˜˜˜ ˜˜˜˜˜˜", 787.461, -1410.930, -34.126, 866.009, -1310.210, 65.874},
		{"˜˜˜˜˜˜ ˜˜", 2811.250, 1229.590, -39.594, 2861.250, 1407.590, 60.406},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜", 1582.440, 347.457, 0.000, 1664.620, 401.750, 200.000},
		{"˜˜˜˜ ˜˜˜˜˜˜˜˜", 2759.250, 296.501, 0.000, 2774.250, 594.757, 200.000},
		{"˜˜˜˜˜˜˜ ˜˜˜˜˜˜-˜˜˜˜", 1377.480, 2600.430, -21.926, 1492.450, 2687.360, 78.074},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1507.510, -1385.210, 110.916, 1582.550, -1325.310, 335.916},
		{"˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜", 2185.330, -1210.740, -89.084, 2281.450, -1154.590, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 1318.130, -910.170, -89.084, 1357.000, -768.027, 110.916},
		{"˜˜˜˜˜-˜˜˜˜ ˜˜˜˜˜˜", -2361.510, -417.199, 0.000, -2270.040, -355.493, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜", 1996.910, -1449.670, -89.084, 2056.860, -1350.720, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 1236.630, 2142.860, -89.084, 1297.470, 2243.230, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜", 2124.660, -1494.030, -89.084, 2266.210, -1449.670, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1848.400, 2478.490, -89.084, 1938.800, 2553.490, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", 422.680, -1570.200, -89.084, 466.223, -1406.050, 110.916},
		{"˜˜˜˜˜˜ ˜˜", -2007.830, 56.306, 0.000, -1922.000, 224.782, 100.000},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1391.050, -1026.330, -89.084, 1463.900, -926.999, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 1704.590, 2243.230, -89.084, 1777.390, 2342.830, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 1758.900, -1722.260, -89.084, 1812.620, -1577.590, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜", 1375.600, 823.228, -89.084, 1457.390, 919.447, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜", 1974.630, -2394.330, -39.084, 2089.000, -2256.590, 60.916},
		{"˜˜˜˜˜-˜˜˜˜", -399.633, -1075.520, -1.489, -319.033, -977.516, 198.511},
		{"˜˜˜˜˜ ˜˜˜˜˜", 334.503, -1501.950, -89.084, 422.680, -1406.050, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 225.165, -1369.620, -89.084, 334.503, -1292.070, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1724.760, -1250.900, -89.084, 1812.620, -1150.870, 110.916},
		{"˜˜˜˜˜", 2027.400, 1703.230, -89.084, 2137.400, 1783.230, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1378.330, -1130.850, -89.084, 1463.900, -1026.330, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜", 1197.390, 1044.690, -89.084, 1277.050, 1163.390, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜", 1073.220, -1842.270, -89.084, 1323.900, -1804.210, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜", 1451.400, 347.457, -6.1, 1582.440, 420.802, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", -2270.040, -430.276, -1.2, -2178.690, -324.114, 200.000},
		{"˜˜˜˜˜˜˜˜", 1325.600, 596.349, -89.084, 1375.600, 795.010, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜", 2051.630, -2597.260, -39.084, 2152.450, -2394.330, 60.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 1096.470, -910.170, -89.084, 1169.130, -768.027, 110.916},
		{"˜˜˜˜˜-˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜", 1457.460, 2723.230, -89.084, 1534.560, 2863.230, 110.916},
		{"˜˜˜˜˜", 2027.400, 1783.230, -89.084, 2162.390, 1863.230, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜", 2056.860, -1210.740, -89.084, 2185.330, -1126.320, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 952.604, -937.184, -89.084, 1096.470, -860.619, 110.916},
		{"˜˜˜-˜˜˜˜˜˜˜˜", -1372.140, 2498.520, 0.000, -1277.590, 2615.350, 200.000},
		{"˜˜˜-˜˜˜˜˜˜˜", 2126.860, -1126.320, -89.084, 2185.330, -934.489, 110.916},
		{"˜˜˜-˜˜˜˜˜˜˜", 1994.330, -1100.820, -89.084, 2056.860, -920.815, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 647.557, -954.662, -89.084, 768.694, -860.619, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1277.050, 1087.630, -89.084, 1375.600, 1203.280, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1377.390, 2433.230, -89.084, 1534.560, 2507.230, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜", 2201.820, -2095.000, -89.084, 2324.000, -1989.900, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1704.590, 2342.830, -89.084, 1848.400, 2433.230, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", 1252.330, -1130.850, -89.084, 1378.330, -1026.330, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 1701.900, -1842.270, -89.084, 1812.620, -1722.260, 110.916},
		{"˜˜˜˜˜", -2411.220, 373.539, 0.000, -2253.540, 458.411, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜", 1515.810, 1586.400, -12.500, 1729.950, 1714.560, 87.500},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 225.165, -1292.070, -89.084, 466.223, -1235.070, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", 1252.330, -1026.330, -89.084, 1391.050, -926.999, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜", 2266.260, -1494.030, -89.084, 2381.680, -1372.040, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 2623.180, 943.235, -89.084, 2749.900, 1055.960, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜", 2541.700, -1941.400, -89.084, 2703.580, -1852.870, 110.916},
		{"˜˜˜-˜˜˜˜˜˜˜", 2056.860, -1126.320, -89.084, 2126.860, -920.815, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 2625.160, 2202.760, -89.084, 2685.160, 2442.550, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", 225.165, -1501.950, -89.084, 334.503, -1369.620, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", -365.167, 2123.010, -3.0, -208.570, 2217.680, 200.000},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 2536.430, 2442.550, -89.084, 2685.160, 2542.550, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", 334.503, -1406.050, -89.084, 466.223, -1292.070, 110.916},
		{"˜˜˜˜˜˜˜", 647.557, -1227.280, -89.084, 787.461, -1118.280, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", 422.680, -1684.650, -89.084, 558.099, -1570.200, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 2498.210, 2542.550, -89.084, 2685.160, 2626.550, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1724.760, -1430.870, -89.084, 1812.620, -1250.900, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", 225.165, -1684.650, -89.084, 312.803, -1501.950, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜", 2056.860, -1449.670, -89.084, 2266.210, -1372.040, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 603.035, 264.312, 0.000, 761.994, 366.572, 200.000},
		{"˜˜˜˜˜ ˜˜˜˜˜", 1096.470, -1130.840, -89.084, 1252.330, -1026.330, 110.916},
		{"˜˜˜˜˜˜˜ ˜/˜ ˜˜˜˜", -1087.930, 855.370, -89.084, -961.950, 986.281, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜", 1046.150, -1722.260, -89.084, 1161.520, -1577.590, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜", 1323.900, -1722.260, -89.084, 1440.900, -1577.590, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 1357.000, -926.999, -89.084, 1463.900, -768.027, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", 466.223, -1570.200, -89.084, 558.099, -1385.070, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 911.802, -860.619, -89.084, 1096.470, -768.027, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 768.694, -954.662, -89.084, 952.604, -860.619, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 2377.390, 788.894, -89.084, 2537.390, 897.901, 110.916},
		{"˜˜˜˜˜˜˜", 1812.620, -1852.870, -89.084, 1971.660, -1742.310, 110.916},
		{"˜˜˜˜ ˜˜", 2089.000, -2394.330, -89.084, 2201.820, -2235.840, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 1370.850, -1577.590, -89.084, 1463.900, -1384.950, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 2121.400, 2508.230, -89.084, 2237.400, 2663.170, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", 1096.470, -1026.330, -89.084, 1252.330, -910.170, 110.916},
		{"˜˜˜˜ ˜˜˜˜", 1812.620, -1449.670, -89.084, 1996.910, -1350.720, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜", -1242.980, -50.096, 0.000, -1213.910, 578.396, 200.000},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", -222.179, 293.324, 0.000, -122.126, 476.465, 200.000},
		{"˜˜˜˜˜", 2106.700, 1863.230, -89.084, 2162.390, 2202.760, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜", 2541.700, -2059.230, -89.084, 2703.580, -1941.400, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜˜", 807.922, -1577.590, -89.084, 926.922, -1416.250, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜", 1457.370, 1143.210, -89.084, 1777.400, 1203.280, 110.916},
		{"˜˜˜˜˜˜˜", 1812.620, -1742.310, -89.084, 1951.660, -1602.310, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", -1580.010, 1025.980, -6.1, -1499.890, 1274.260, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1370.850, -1384.950, -89.084, 1463.900, -1170.870, 110.916},
		{"˜˜˜˜ ˜˜˜˜", 1664.620, 401.750, 0.000, 1785.140, 567.203, 200.000},
		{"˜˜˜˜˜ ˜˜˜˜˜", 312.803, -1684.650, -89.084, 422.680, -1501.950, 110.916},
		{"˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 1440.900, -1722.260, -89.084, 1583.500, -1577.590, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 687.802, -860.619, -89.084, 911.802, -768.027, 110.916},
		{"˜˜˜˜ ˜˜˜˜", -2741.070, 1490.470, -6.1, -2616.400, 1659.680, 200.000},
		{"˜˜˜-˜˜˜˜˜˜˜", 2185.330, -1154.590, -89.084, 2281.450, -934.489, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 1169.130, -910.170, -89.084, 1318.130, -768.027, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1938.800, 2508.230, -89.084, 2121.400, 2624.230, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 1667.960, -1577.590, -89.084, 1812.620, -1430.870, 110.916},
		{"˜˜˜ ˜˜-˜˜", 72.648, -1544.170, -89.084, 225.165, -1404.970, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜˜˜", 2536.430, 2202.760, -89.084, 2625.160, 2442.550, 110.916},
		{"˜˜˜ ˜˜-˜˜", 72.648, -1684.650, -89.084, 225.165, -1544.170, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 952.663, -1310.210, -89.084, 1072.660, -1130.850, 110.916},
		{"˜˜˜-˜˜˜˜˜˜˜", 2632.740, -1135.040, -89.084, 2747.740, -945.035, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 861.085, -674.885, -89.084, 1156.550, -600.896, 110.916},
		{"˜˜˜˜˜", -2253.540, 373.539, -9.1, -1993.280, 458.411, 200.000},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 1848.400, 2342.830, -89.084, 2011.940, 2478.490, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", -1580.010, 744.267, -6.1, -1499.890, 1025.980, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜", 1046.150, -1804.210, -89.084, 1323.900, -1722.260, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 647.557, -1118.280, -89.084, 787.461, -954.662, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", -2994.490, 277.411, -9.1, -2867.850, 458.411, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 964.391, 930.890, -89.084, 1166.530, 1044.690, 110.916},
		{"˜˜˜˜ ˜˜˜˜", 1812.620, -1100.820, -89.084, 1994.330, -973.380, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1375.600, 919.447, -89.084, 1457.370, 1203.280, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", -405.770, 1712.860, -3.0, -276.719, 1892.750, 200.000},
		{"˜˜˜˜ ˜˜˜˜˜˜", 1161.520, -1722.260, -89.084, 1323.900, -1577.590, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜", 2281.450, -1372.040, -89.084, 2381.680, -1135.040, 110.916},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 2137.400, 1703.230, -89.084, 2437.390, 1783.230, 110.916},
		{"˜˜˜˜˜˜˜", 1951.660, -1742.310, -89.084, 2124.660, -1602.310, 110.916},
		{"˜˜˜˜˜˜˜˜", 2624.400, 1383.230, -89.084, 2685.160, 1783.230, 110.916},
		{"˜˜˜˜˜˜˜", 2124.660, -1742.310, -89.084, 2222.560, -1494.030, 110.916},
		{"˜˜˜˜˜", -2533.040, 458.411, 0.000, -2329.310, 578.396, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", -1871.720, 1176.420, -4.5, -1620.300, 1274.260, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 1583.500, -1722.260, -89.084, 1758.900, -1577.590, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜", 2381.680, -1454.350, -89.084, 2462.130, -1135.040, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜˜", 647.712, -1577.590, -89.084, 807.922, -1416.250, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 72.648, -1404.970, -89.084, 225.165, -1235.070, 110.916},
		{"˜˜˜˜˜˜˜", 647.712, -1416.250, -89.084, 787.461, -1227.280, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜", 2222.560, -1628.530, -89.084, 2421.030, -1494.030, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", 558.099, -1684.650, -89.084, 647.522, -1384.930, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", -1709.710, -833.034, -1.5, -1446.010, -730.118, 200.000},
		{"˜˜˜˜˜ ˜˜˜˜˜", 466.223, -1385.070, -89.084, 647.522, -1235.070, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 1817.390, 2202.760, -89.084, 2011.940, 2342.830, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 2162.390, 1783.230, -89.084, 2437.390, 1883.230, 110.916},
		{"˜˜ ˜˜˜˜", 1971.660, -1852.870, -89.084, 2222.560, -1742.310, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜", 1546.650, 208.164, 0.000, 1745.830, 347.457, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜", 2089.000, -2235.840, -89.084, 2201.820, -1989.900, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", 952.663, -1130.840, -89.084, 1096.470, -937.184, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜", 1848.400, 2553.490, -89.084, 1938.800, 2863.230, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜", 1400.970, -2669.260, -39.084, 2189.820, -2597.260, 60.916},
		{"˜˜˜˜˜ ˜˜˜˜", -1213.910, 950.022, -89.084, -1087.930, 1178.930, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜", -1339.890, 828.129, -89.084, -1213.910, 1057.040, 110.916},
		{"˜˜˜˜˜˜˜ ˜/˜ ˜˜˜˜", -1339.890, 599.218, -89.084, -1213.910, 828.129, 110.916},
		{"˜˜˜˜˜˜˜ ˜/˜ ˜˜˜˜", -1213.910, 721.111, -89.084, -1087.930, 950.022, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜", 930.221, -2006.780, -89.084, 1073.220, -1804.210, 110.916},
		{"˜˜˜˜˜˜ ˜˜˜", 1073.220, -2006.780, -89.084, 1249.620, -1842.270, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 787.461, -1130.840, -89.084, 952.604, -954.662, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 787.461, -1310.210, -89.084, 952.663, -1130.840, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 1463.900, -1577.590, -89.084, 1667.960, -1430.870, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 787.461, -1416.250, -89.084, 1072.660, -1310.210, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", 2377.390, 596.349, -89.084, 2537.390, 788.894, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 2237.400, 2542.550, -89.084, 2498.210, 2663.170, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜", 2632.830, -1668.130, -89.084, 2747.740, -1393.420, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜", 434.341, 366.572, 0.000, 603.035, 555.680, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜", 2089.000, -1989.900, -89.084, 2324.000, -1852.870, 110.916},
		{"˜˜˜˜˜˜˜˜˜", -2274.170, 578.396, -7.6, -2078.670, 744.170, 200.000},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜", -208.570, 2337.180, 0.000, 8.430, 2487.180, 200.000},
		{"˜˜ ˜˜˜˜˜˜", 2324.000, -2145.100, -89.084, 2703.580, -2059.230, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", -1132.820, -768.027, 0.000, -956.476, -578.118, 200.000},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜", 1817.390, 1703.230, -89.084, 2027.400, 1863.230, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", -2994.490, -430.276, -1.2, -2831.890, -222.589, 200.000},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 321.356, -860.619, -89.084, 687.802, -768.027, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 176.581, 1305.450, -3.0, 338.658, 1520.720, 200.000},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 321.356, -768.027, -89.084, 700.794, -674.885, 110.916},
		{"˜˜˜˜˜˜˜˜", 2162.390, 1883.230, -89.084, 2437.390, 2012.180, 110.916},
		{"˜˜ ˜˜˜˜˜", 2747.740, -1668.130, -89.084, 2959.350, -1498.620, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜", 2056.860, -1372.040, -89.084, 2281.450, -1210.740, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1463.900, -1290.870, -89.084, 1724.760, -1150.870, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1463.900, -1430.870, -89.084, 1724.760, -1290.870, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜", -1499.890, 696.442, -179.615, -1339.890, 925.353, 20.385},
		{"˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1457.390, 823.228, -89.084, 2377.390, 863.229, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜", 2421.030, -1628.530, -89.084, 2632.830, -1454.350, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 964.391, 1044.690, -89.084, 1197.390, 1203.220, 110.916},
		{"˜˜˜-˜˜˜˜˜˜˜", 2747.740, -1120.040, -89.084, 2959.350, -945.035, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 737.573, -768.027, -89.084, 1142.290, -674.885, 110.916},
		{"˜˜˜˜ ˜˜", 2201.820, -2730.880, -89.084, 2324.000, -2418.330, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜", 2462.130, -1454.350, -89.084, 2581.730, -1135.040, 110.916},
		{"˜˜˜˜", 2222.560, -1722.330, -89.084, 2632.830, -1628.530, 110.916},
		{"˜˜˜˜˜-˜˜˜˜ ˜˜˜˜˜˜", -2831.890, -430.276, -6.1, -2646.400, -222.589, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜", 1970.620, -2179.250, -89.084, 2089.000, -1852.870, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", -1982.320, 1274.260, -4.5, -1524.240, 1358.900, 200.000},
		{"˜˜˜˜˜˜ ˜˜˜˜˜", 1817.390, 1283.230, -89.084, 2027.390, 1469.230, 110.916},
		{"˜˜˜˜ ˜˜", 2201.820, -2418.330, -89.084, 2324.000, -2095.000, 110.916},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜", 1823.080, 596.349, -89.084, 1997.220, 823.228, 110.916},
		{"˜˜˜˜˜˜˜˜-˜˜˜˜˜˜", -2353.170, 2275.790, 0.000, -2153.170, 2475.790, 200.000},
		{"˜˜˜˜˜", -2329.310, 458.411, -7.6, -1993.280, 578.396, 200.000},
		{"˜˜˜-˜˜˜˜˜˜", 1692.620, -2179.250, -89.084, 1812.620, -1842.270, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 1375.600, 596.349, -89.084, 1558.090, 823.228, 110.916},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜", 1817.390, 1083.230, -89.084, 2027.390, 1283.230, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 1197.390, 1163.390, -89.084, 1236.630, 2243.230, 110.916},
		{"˜˜˜-˜˜˜˜˜˜", 2581.730, -1393.420, -89.084, 2747.740, -1135.040, 110.916},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜", 1817.390, 1863.230, -89.084, 2106.700, 2011.830, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜", 1938.800, 2624.230, -89.084, 2121.400, 2861.550, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜", 851.449, -1804.210, -89.084, 1046.150, -1577.590, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", -1119.010, 1178.930, -89.084, -862.025, 1351.450, 110.916},
		{"˜˜˜˜˜˜-˜˜˜˜", 2749.900, 943.235, -89.084, 2923.390, 1198.990, 110.916},
		{"˜˜˜˜ ˜˜", 2703.580, -2302.330, -89.084, 2959.350, -2126.900, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜", 2324.000, -2059.230, -89.084, 2541.700, -1852.870, 110.916},
		{"˜˜˜˜˜", -2411.220, 265.243, -9.1, -1993.280, 373.539, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 1323.900, -1842.270, -89.084, 1701.900, -1722.260, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 1269.130, -768.027, -89.084, 1414.070, -452.425, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜˜", 647.712, -1804.210, -89.084, 851.449, -1577.590, 110.916},
		{"˜˜˜˜˜˜˜ ˜˜˜˜˜", -2741.070, 1268.410, -4.5, -2533.040, 1490.470, 200.000},
		{"˜˜˜˜˜˜ 4 ˜˜˜˜˜˜˜", 1817.390, 863.232, -89.084, 2027.390, 1083.230, 110.916},
		{"˜˜˜˜˜˜˜˜", 964.391, 1203.220, -89.084, 1197.390, 1403.220, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1534.560, 2433.230, -89.084, 1848.400, 2583.230, 110.916},
		{"˜˜˜˜˜-˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜", 1117.400, 2723.230, -89.084, 1457.460, 2863.230, 110.916},
		{"˜˜˜˜˜˜˜", 1812.620, -1602.310, -89.084, 2124.660, -1449.670, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 1297.470, 2142.860, -89.084, 1777.390, 2243.230, 110.916},
		{"˜˜˜˜˜˜˜˜˜", -2270.040, -324.114, -1.2, -1794.920, -222.589, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", 967.383, -450.390, -3.0, 1176.780, -217.900, 200.000},
		{"˜˜˜-˜˜˜˜˜˜˜˜˜", -926.130, 1398.730, -3.0, -719.234, 1634.690, 200.000},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜", 1817.390, 1469.230, -89.084, 2027.400, 1703.230, 110.916},
		{"˜˜˜ ˜˜˜˜", -2867.850, 277.411, -9.1, -2593.440, 458.411, 200.000},
		{"˜˜˜˜˜-˜˜˜˜ ˜˜˜˜˜˜", -2646.400, -355.493, 0.000, -2270.040, -222.589, 200.000},
		{"˜˜˜˜˜", 2027.400, 863.229, -89.084, 2087.390, 1703.230, 110.916},
		{"˜˜˜˜˜˜˜", -2593.440, -222.589, -1.0, -2411.220, 54.722, 200.000},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜", 1852.000, -2394.330, -89.084, 2089.000, -2179.250, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 1098.310, 1726.220, -89.084, 1197.390, 2243.230, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜", -789.737, 1659.680, -89.084, -599.505, 1929.410, 110.916},
		{"˜˜˜-˜˜˜˜˜˜", 1812.620, -2179.250, -89.084, 1970.620, -1852.870, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", -1700.010, 744.267, -6.1, -1580.010, 1176.520, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", -2178.690, -1250.970, 0.000, -1794.920, -1115.580, 200.000},
		{"˜˜˜-˜˜˜˜˜˜˜˜˜", -354.332, 2580.360, 2.0, -133.625, 2816.820, 200.000},
		{"˜˜˜˜˜ ˜˜˜˜˜˜˜˜", -936.668, 2611.440, 2.0, -715.961, 2847.900, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜", 1166.530, 795.010, -89.084, 1375.600, 1044.690, 110.916},
		{"˜˜˜˜˜˜", 2222.560, -1852.870, -89.084, 2632.830, -1722.330, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜", -1213.910, -730.118, 0.000, -1132.820, -50.096, 200.000},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 1817.390, 2011.830, -89.084, 2106.700, 2202.760, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", -1499.890, 578.396, -79.615, -1339.890, 1274.260, 20.385},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 2087.390, 1543.230, -89.084, 2437.390, 1703.230, 110.916},
		{"˜˜˜˜˜˜ ˜˜˜˜˜", 2087.390, 1383.230, -89.084, 2437.390, 1543.230, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 72.648, -1235.070, -89.084, 321.356, -1008.150, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 2437.390, 1783.230, -89.084, 2685.160, 2012.180, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 1281.130, -452.425, -89.084, 1641.130, -290.913, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", -1982.320, 744.170, -6.1, -1871.720, 1274.260, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 2576.920, 62.158, 0.000, 2759.250, 385.503, 200.000},
		{"˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜", 2498.210, 2626.550, -89.084, 2749.900, 2861.550, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜-˜˜˜˜", 1777.390, 863.232, -89.084, 1817.390, 2342.830, 110.916},
		{"˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", -2290.190, 2548.290, -89.084, -1950.190, 2723.290, 110.916},
		{"˜˜˜˜ ˜˜", 2324.000, -2302.330, -89.084, 2703.580, -2145.100, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 321.356, -1044.070, -89.084, 647.557, -860.619, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", 1558.090, 596.349, -89.084, 1823.080, 823.235, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜", 2632.830, -1852.870, -89.084, 2959.350, -1668.130, 110.916},
		{"˜˜˜˜˜˜ ˜˜˜˜˜-˜˜˜˜˜", -314.426, -753.874, -89.084, -106.339, -463.073, 110.916},
		{"˜˜˜˜˜˜˜˜", 19.607, -404.136, 3.8, 349.607, -220.137, 200.000},
		{"˜˜˜˜˜˜ ˜˜", 2749.900, 1198.990, -89.084, 2923.390, 1548.990, 110.916},
		{"˜˜˜˜ ˜˜˜˜", 1812.620, -1350.720, -89.084, 2056.860, -1100.820, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", -1993.280, 265.243, -9.1, -1794.920, 578.396, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 1377.390, 2243.230, -89.084, 1704.590, 2433.230, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", 321.356, -1235.070, -89.084, 647.522, -1044.070, 110.916},
		{"˜˜˜˜ ˜˜˜˜", -2741.450, 1659.680, -6.1, -2616.400, 2175.150, 200.000},
		{"˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜", -90.218, 1286.850, -3.0, 153.859, 1554.120, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", -187.700, -1596.760, -89.084, 17.063, -1276.600, 110.916},
		{"˜˜˜-˜˜˜˜˜˜˜", 2281.450, -1135.040, -89.084, 2632.740, -945.035, 110.916},
		{"˜/˜ ˜˜˜˜ ˜˜", 2749.900, 1548.990, -89.084, 2923.390, 1937.250, 110.916},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", 2011.940, 2202.760, -89.084, 2237.400, 2508.230, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜", -208.570, 2123.010, -7.6, 114.033, 2337.180, 200.000},
		{"˜˜˜˜˜-˜˜˜˜˜", -2741.070, 458.411, -7.6, -2533.040, 793.411, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 2703.580, -2126.900, -89.084, 2959.350, -1852.870, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 926.922, -1577.590, -89.084, 1370.850, -1416.250, 110.916},
		{"˜˜˜˜˜", -2593.440, 54.722, 0.000, -2411.220, 458.411, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", 1098.390, 2243.230, -89.084, 1377.390, 2507.230, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 2121.400, 2663.170, -89.084, 2498.210, 2861.550, 110.916},
		{"˜˜˜˜˜˜˜˜", 2437.390, 1383.230, -89.084, 2624.400, 1783.230, 110.916},
		{"˜˜˜˜˜˜˜˜", 964.391, 1403.220, -89.084, 1197.390, 1726.220, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜˜˜˜", -410.020, 1403.340, -3.0, -137.969, 1681.230, 200.000},
		{"˜˜˜˜˜˜˜˜", 580.794, -674.885, -9.5, 861.085, -404.790, 200.000},
		{"˜˜˜-˜˜˜˜˜˜˜˜", -1645.230, 2498.520, 0.000, -1372.140, 2777.850, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", -2533.040, 1358.900, -4.5, -1996.660, 1501.210, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜", -1499.890, -50.096, -1.0, -1242.980, 249.904, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 1916.990, -233.323, -100.000, 2131.720, 13.800, 200.000},
		{"˜˜˜ ˜˜-˜˜", 1414.070, -768.027, -89.084, 1667.610, -452.425, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜", 2747.740, -1498.620, -89.084, 2959.350, -1120.040, 110.916},
		{"˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜˜", 2450.390, 385.503, -100.000, 2759.250, 562.349, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜", -2030.120, -2174.890, -6.1, -1820.640, -1771.660, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜", 1072.660, -1416.250, -89.084, 1370.850, -1130.850, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", 1997.220, 596.349, -89.084, 2377.390, 823.228, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜", 1534.560, 2583.230, -89.084, 1848.400, 2863.230, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜", -1794.920, -50.096, -1.04, -1499.890, 249.904, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", -1166.970, -1856.030, 0.000, -815.624, -1602.070, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 1457.390, 863.229, -89.084, 1777.400, 1143.210, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜", 1117.400, 2507.230, -89.084, 1534.560, 2723.230, 110.916},
		{"˜˜˜˜˜˜˜˜", 104.534, -220.137, 2.3, 349.607, 152.236, 200.000},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜", -464.515, 2217.680, 0.000, -208.570, 2580.360, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", -2078.670, 578.396, -7.6, -1499.890, 744.267, 200.000},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", 2537.390, 676.549, -89.084, 2902.350, 943.235, 110.916},
		{"˜˜˜˜˜ ˜˜", -2616.400, 1501.210, -3.0, -1996.660, 1659.680, 200.000},
		{"˜˜˜˜˜˜˜˜", -2741.070, 793.411, -6.1, -2533.040, 1268.410, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 2087.390, 1203.230, -89.084, 2640.400, 1383.230, 110.916},
		{"˜˜˜˜˜-˜˜˜˜ ˜˜", 2162.390, 2012.180, -89.084, 2685.160, 2202.760, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜", -2533.040, 578.396, -7.6, -2274.170, 968.369, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", -2533.040, 968.369, -6.1, -2274.170, 1358.900, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜", 2237.400, 2202.760, -89.084, 2536.430, 2542.550, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜", 2685.160, 1055.960, -89.084, 2749.900, 2626.550, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜˜", 647.712, -2173.290, -89.084, 930.221, -1804.210, 110.916},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", -2178.690, -599.884, -1.2, -1794.920, -324.114, 200.000},
		{"˜˜˜˜-˜˜˜˜-˜˜˜˜˜", -901.129, 2221.860, 0.000, -592.090, 2571.970, 200.000},
		{"˜˜˜˜˜˜˜˜˜ ˜˜", -792.254, -698.555, -5.3, -452.404, -380.043, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", -1209.670, -1317.100, 114.981, -908.161, -787.391, 251.981},
		{"˜˜˜˜˜ ˜˜˜˜˜˜˜", -968.772, 1929.410, -3.0, -481.126, 2155.260, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", -1996.660, 1358.900, -4.5, -1524.240, 1592.510, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", -1871.720, 744.170, -6.1, -1701.300, 1176.420, 300.000},
		{"˜˜˜˜˜˜", -2411.220, -222.589, -1.14, 2173.040, 265.243, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜", 1119.510, 119.526, -3.0, 1451.400, 493.323, 200.000},
		{"˜/˜ ˜˜˜˜˜", 2749.900, 1937.250, -89.084, 2921.620, 2669.790, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜", 1249.620, -2394.330, -89.084, 1852.000, -2179.250, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜-˜˜˜˜˜", 72.648, -2173.290, -89.084, 342.648, -1684.650, 110.916},
		{"˜˜˜ ˜˜-˜˜", 1463.900, -1150.870, -89.084, 1812.620, -768.027, 110.916},
		{"˜˜˜˜˜˜˜-˜˜˜˜", -2324.940, -2584.290, -6.1, -1964.220, -2212.110, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 37.032, 2337.180, -3.0, 435.988, 2677.900, 200.000},
		{"˜˜˜˜˜-˜˜˜˜˜˜˜", 338.658, 1228.510, 0.000, 664.308, 1655.050, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜-˜-˜˜˜", 2087.390, 943.235, -89.084, 2623.180, 1203.230, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 1236.630, 1883.110, -89.084, 1777.390, 2142.860, 110.916},
		{"˜˜˜˜ ˜˜˜˜˜-˜˜˜˜˜", 342.648, -2173.290, -89.084, 647.712, -1684.650, 110.916},
		{"˜˜˜˜˜˜ ˜˜˜", 1249.620, -2179.250, -89.084, 1692.620, -1842.270, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜", 1236.630, 1203.280, -89.084, 1457.370, 1883.110, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜", -594.191, -1648.550, 0.000, -187.700, -1276.600, 200.000},
		{"˜˜˜˜˜˜ ˜˜˜", 930.221, -2488.420, -89.084, 1249.620, -2006.780, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜", 2160.220, -149.004, 0.000, 2576.920, 228.322, 200.000},
		{"˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜", 2373.770, -2697.090, -89.084, 2809.220, -2330.460, 110.916},
		{"˜˜˜˜˜˜˜˜ ˜˜", -1213.910, -50.096, -4.5, -947.980, 578.396, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 883.308, 1726.220, -89.084, 1098.310, 2507.230, 110.916},
		{"˜˜˜˜˜˜ ˜˜˜˜˜", -2274.170, 744.170, -6.1, -1982.320, 1358.900, 200.000},
		{"˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜", -1794.920, 249.904, -9.1, -1242.980, 578.396, 200.000},
		{"˜˜˜˜˜ ˜˜", -321.744, -2224.430, -89.084, 44.615, -1724.430, 110.916},
		{"˜˜˜˜˜˜", 2173.040, -222.589, -1.0, -1794.920, 265.243, 200.000},
		{"˜˜˜˜ ˜˜˜˜˜˜", -2178.690, -2189.910, -47.917, -2030.120, -1771.660, 576.083},
		{"˜˜˜˜-˜˜˜˜˜˜", -376.233, 826.326, -3.0, 123.717, 1220.440, 200.000},
		{"˜˜˜˜˜˜˜˜˜", -2178.690, -1115.580, 0.000, -1794.920, -599.884, 200.000},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", -2994.490, -222.589, -1.0, -2593.440, 277.411, 200.000},
		{"˜˜˜˜-˜˜˜˜", 508.189, -139.259, 0.000, 1306.660, 119.526, 200.000},
		{"˜˜˜˜˜˜˜", -2741.070, 2175.150, 0.000, -2353.170, 2722.790, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜", 1457.370, 1203.280, -89.084, 1777.390, 1883.110, 110.916},
		{"˜˜˜˜˜ ˜˜˜˜˜˜˜˜", -319.676, -220.137, 0.000, 104.534, 293.324, 200.000},
		{"˜˜˜˜˜˜˜˜", -2994.490, 458.411, -6.1, -2741.070, 1339.610, 200.000},
		{"˜˜˜˜˜ ˜˜˜˜˜˜˜", 2285.370, -768.027, 0.000, 2770.590, -269.740, 200.000},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜", 337.244, 710.840, -115.239, 860.554, 1031.710, 203.761},
		{"˜˜˜˜˜˜˜˜ ˜˜", 1382.730, -2730.880, -89.084, 2201.820, -2394.330, 110.916},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜", -2994.490, -811.276, 0.000, -2178.690, -430.276, 200.000},
		{"˜˜˜˜˜ ˜˜", -2616.400, 1659.680, -3.0, -1996.660, 2175.150, 200.000},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", -91.586, 1655.050, -50.000, 421.234, 2123.010, 250.000},
		{"˜˜˜˜ ˜˜˜˜˜˜", -2997.470, -1115.580, -47.917, -2178.690, -971.913, 576.083},
		{"˜˜˜˜ ˜˜˜˜˜˜", -2178.690, -1771.660, -47.917, -1936.120, -1250.970, 576.083},
		{"˜˜˜˜˜˜˜˜ ˜˜", -1794.920, -730.118, -3.0, -1213.910, -50.096, 200.000},
		{"˜˜˜˜˜˜˜˜˜˜", -947.980, -304.320, -1.1, -319.676, 327.071, 200.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜", -1820.640, -2643.680, -8.0, -1226.780, -1771.660, 200.000},
		{"˜˜˜-˜-˜˜˜˜˜˜", -1166.970, -2641.190, 0.000, -321.744, -1856.030, 200.000},
		{"˜˜˜˜ ˜˜˜˜˜˜", -2994.490, -2189.910, -47.917, -2178.690, -1115.580, 576.083},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜", -1213.910, 596.349, -242.990, -480.539, 1659.680, 900.000},
		{"˜˜˜˜˜ ˜˜˜˜˜", -1213.910, -2892.970, -242.990, 44.615, -768.027, 900.000},
		{"˜˜˜˜ ˜˜˜˜˜˜˜", -2997.470, -2892.970, -242.990, -1213.910, -1115.580, 900.000},
		{"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", -480.539, 596.349, -242.990, 869.461, 2993.870, 900.000},
		{"˜˜˜˜˜˜ ˜˜˜˜˜˜", -2997.470, 1659.680, -242.990, -480.539, 2993.870, 900.000},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜", -2997.470, -1115.580, -242.990, -1213.910, 1659.680, 900.000},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜", 869.461, 596.349, -242.990, 2997.060, 2993.870, 900.000},
		{"˜˜˜˜˜˜˜˜ ˜˜˜˜˜", -1213.910, -768.027, -242.990, 2997.060, 596.349, 900.000},
		{"˜˜˜˜˜˜˜˜˜˜ ˜˜", 44.615, -2892.970, -242.990, 2997.060, -768.027, 900.000}
	}
    for i, v in ipairs(streets) do
        if (x >= v[2]) and (y >= v[3]) and (z >= v[4]) and (x <= v[5]) and (y <= v[6]) and (z <= v[7]) then
            return v[1]
        end
    end
    return '˜˜˜˜˜˜˜˜˜˜'
end
function send_no_vip_msg()
	for i = 1, 10, 1 do
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜ ˜ FREE ˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ MTGVIP!', message_color)
	end
	sampShowDialog(123123, '{009EFF}Furry Helper [' .. thisScript().version .. ']', '{ffffff}˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜ ˜ FREE ˜˜˜˜˜˜!\n˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ MTGVIP ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', '˜˜˜˜˜˜˜ ˜˜˜˜˜˜', '', 0)
end
function split_text_into_lines(text, max_length)
	local lines = {}
	local current_line = ""
	for word in text:gmatch("%S+") do
		local new_line = current_line .. (current_line == "" and "" or " ") .. word
		if #new_line > max_length then
			table.insert(lines, current_line)
			current_line = word
		else
			current_line = new_line
		end
	end
	if current_line ~= "" then
		table.insert(lines, current_line)
	end
	return table.concat(lines, "\n")
end
function count_lines_in_text(text, max_length)
	local lines = {}
	local current_line = ""
	for word in text:gmatch("%S+") do
		local new_line = current_line .. (current_line == "" and "" or " ") .. word
		if #new_line > max_length then
			table.insert(lines, current_line)
			current_line = word
		else
			current_line = new_line
		end
	end
	if current_line ~= "" then
		table.insert(lines, current_line)
	end
	return tonumber(#lines)
end
function downloadFileFromUrlToPath(url, path)
	print('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ' .. path)
	local function on_finish_download()
		if download_file == 'update' then
			local function readJsonFile(filePath)
				if not doesFileExist(filePath) then
					print('˜˜˜˜˜˜: ˜˜˜˜ "' .. filePath .. ' ˜˜ ˜˜˜˜˜˜˜˜˜˜')
					return nil
				end
				local file, err = io.open(filePath, "r")
				if not file then
					print('˜˜˜˜˜˜: ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ "' .. filePath .. '": ' .. tostring(err))
					return nil
				end
				local content = file:read("*a")
				file:close()
				local jsonData = decodeJson(content)
				if not jsonData then
					print('˜˜˜˜˜˜: ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ JSON ˜ ˜˜˜˜˜ ' .. filePath)
					return nil
				end
				return jsonData
			end
			local ok, updateInfo = pcall(readJsonFile, path)
			if updateInfo then
				local isVip = thisScript().version:find('VIP')
				local uVer = isVip and updateInfo.vip_current_version or updateInfo.current_version
				local uText = isVip and updateInfo.vip_update_info or updateInfo.update_info
				local uUrl = isVip and '' or updateInfo.update_url
				print('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜:', thisScript().version)
				print('˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜:', uVer)
				if uVer and thisScript().version ~= uVer then
					print('˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜!')
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
					MODULE.Update.is_need_update = true
					MODULE.Update.url = uUrl
					MODULE.Update.version = uVer
					MODULE.Update.info = uText
					MODULE.Update.Window[0] = true
					play_sound()
				else
					print('˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜!')
				end
			end
		elseif download_file == 'helper' then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜˜˜˜..',  message_color)
			-- ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜ _ ˜ ˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜
			os.remove(worked_dir .. "Arizona_Helper.lua")
			reload_script = true
			thisScript():reload()
		elseif download_file == 'smart_uk' then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. getServerName(getServerNumber()) .. ' [' .. getServerNumber() ..  '] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!',  message_color)
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. '/sum [ID ˜˜˜˜˜˜]', message_color)
			MODULE.Main.Window[0] = false
			play_sound()
			load_module('smart_uk')
		elseif download_file == 'smart_pdd' then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. getServerName(getServerNumber()) .. ' [' .. getServerNumber() ..  '] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!',  message_color)
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. '/tsm [ID ˜˜˜˜˜˜]', message_color)
			MODULE.Main.Window[0] = false
			play_sound()
			load_module('smart_pdd')
		elseif download_file == 'smart_rptp' then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. getServerName(getServerNumber()) .. ' [' .. getServerNumber() ..  '] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!',  message_color)
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. '/pum [ID ˜˜˜˜˜˜]', message_color)
			MODULE.Main.Window[0] = false
			play_sound()
			load_module('smart_rptp')
		elseif download_file == 'arz_veh' then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜/˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜!',  message_color)
			play_sound()
			load_module('arz_veh')
			cache_vehicles()
		elseif download_file == 'notify' then
			if doesFileExist(config_dir .. "/Resourse/notify.mp3") then
				print('˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!')
			end
		end
		download_file = ''
	end
	if IS_MOBILE then
		local function downloadToFile(url, path)
			local http = require("socket.http")
			local ltn12 = require("ltn12")

			local f, ferr = io.open(path, "wb")
			if not f then
				return false, "˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜: " .. tostring(ferr)
			end

			local ok, code, headers, status = http.request{
				method = "GET",
				url = url,
				sink = ltn12.sink.file(f)
			}

			if not ok then
				return false, "˜˜˜˜˜˜ ˜˜˜˜˜˜˜: " .. tostring(code)
			end

			if tonumber(code) ~= 200 then
				return false, "HTTP ˜˜˜: " .. tostring(code)
			end

			return true
		end
		local ok, err = downloadToFile(url, path)
		if ok then
			on_finish_download()
		else
			sampAddChatMessage("[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜: " .. tostring(err), message_color)
		end
	else
		downloadUrlToFile(url, path, function(id, status)
			if status == 6 then
				on_finish_download()
			end
		end)
	end
end
function check_update()
	print('˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜...')
	download_file = 'update'
	downloadFileFromUrlToPath('https://github.com/Kolaars/furry-helper/blob/main/Update.json', config_dir .. "/Update.json")
end
function check_resourses()
	if not doesDirectoryExist(config_dir .. '/Resourse') then
		print('˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜...')
		createDirectory(config_dir .. '/Resourse')
	end
	if not doesFileExist(config_dir .. '/Resourse/logo.png') then
		print('˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜...')
		downloadFileFromUrlToPath('https://github.com/Kolaars/furry-helper/blob/e1a64d6b32d3afdb5c7218c11526ef2959733825/Resourse/logo.png', config_dir .. '/Resourse/logo.png')
	end
	if not doesFileExist(config_dir .. "/Resourse/notify.mp3") then
		print('˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜...')
		downloadFileFromUrlToPath('https://mtgmods.github.io/arizona-helper/Resourse/notify.mp3', config_dir .. "/Resourse/notify.mp3")
	end
	if not doesFileExist(modules.arz_veh.path) then
		print('˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜/˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜...')
		download_file = 'arz_veh'
		downloadFileFromUrlToPath('https://mtgmods.github.io/arizona-helper/SmartVEH/Vehicles' .. 
		((tonumber(getServerNumber()) > 300) and 'Rodina.json' or '.json'), modules.arz_veh.path)
	end
end
function import_fraction_data(mode)
	add_unique_cmd(modules.commands.data.commands.my, get_fraction_cmds(mode, false))
	add_unique_cmd(modules.commands.data.commands_manage.my, get_fraction_cmds(mode, true))
	add_default_notes(mode)
	import_data_from_old_helpers()
	save_module('commands')
	save_module('notes')
	modules.piemenu.data = get_fraction_pie(mode)
	save_module('piemenu')
end
function get_fraction_pie(mode)
	local default = {
		{
			name = '˜˜˜˜˜',
			icon = 'CLOCK',
			action = '/time'
		},
		{
			name = '˜˜˜˜˜˜',
			icon = 'TOILET',
			action = '/piss'
		},
		{
			name = '˜/˜',
			icon = 'CAR',
			next = {
				{
					name = '˜˜˜˜˜',
					icon = '',
					action = '/repcar'
				},
				{
					name = '˜˜˜˜˜˜˜˜',
					icon = '',
					action = '/fillcar'
				}
			}
		},
		{
			name = '˜˜˜˜˜˜',
			icon = 'GUN',
			action = '/gun'
		}
	}
	local police = {
		{
			name = '˜˜˜˜˜˜˜˜',
			icon = 'VOLUME_HIGH',
			action = '/ss'
		},
		{
			name = '˜˜˜˜˜˜˜',
			icon = '',
			action = '/mr'
		},
		{
			name = '˜˜˜˜˜˜˜ ˜˜˜˜',
			icon = 'BULLHORN',
			next = {
				{
					name = '10-55',
					icon = '',
					action = '/55'
				},
				{
					name = '10-66',
					icon = '',
					action = '/66'
				}
			}
		},
		{
			name = '˜˜˜˜˜˜',
			icon = 'GUN',
			action = '/t'
		}
	}
	return (mode == 'police' or mode == 'fbi') and police or default
end
function get_fraction_cmds(selected, is_manage)
    local cmds = {
		{cmd = 'time', description = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜˜˜{sex} ˜˜ ˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ Furry Helper by Kolaars&/time&/do ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ {get_time}.', arg = '', enable = true, waiting = '2', bind = "{}"},
		{cmd = 'cure', description = '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜',  text = '/me ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜&/cure {id}&/do ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.&/me ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜&/do ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜.&/do ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜.&/todo ˜˜˜˜˜˜˜*˜˜˜˜˜˜˜˜', arg = '{id}', enable = true, waiting = '2', bind = "{}"}
	}
    local function append_commands(from_table)
        for _, cmd in ipairs(from_table) do
			table.insert(cmds, cmd)
		end
    end
	if is_manage then
		if selected == 'mafia' then
			append_commands(modules.commands.data.commands_manage.mafia)
		elseif selected == 'ghetto' then
			append_commands(modules.commands.data.commands_manage.ghetto)
		else
			append_commands(modules.commands.data.commands_manage.goss)
			if selected == 'fbi' then
				append_commands(modules.commands.data.commands_manage.goss_fbi)
			elseif selected == 'prison' then
				append_commands(modules.commands.data.commands_manage.goss_prison)
			elseif selected == 'gov' then
				append_commands(modules.commands.data.commands_manage.goss_gov)
			end
		end
	else
		if selected == 'police' then
			append_commands(modules.commands.data.commands.police)
		elseif selected == 'fbi' then
			append_commands(modules.commands.data.commands.police)
			append_commands(modules.commands.data.commands.fbi)
			append_commands(modules.commands.data.commands.mafia)
			for index, value in ipairs(cmds) do
				if value.cmd == 'lead' or value.cmd == 'unlead' then
					table.remove(cmds, index)
					break
				end
			end
		elseif selected == 'hospital' then
			append_commands(modules.commands.data.commands.hospital)
			if tonumber(getServerNumber()) > 300 then -- ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜
				for index, value in ipairs(cmds) do
					if value.cmd == 'hla' or value.cmd == 'hlb' or value.cmd == 'ant' or value.cmd == 'pilot' or value.cmd == 'medin' or value.cmd == 'mt' then
						table.remove(cmds, index)
						break
					end
				end
			end
		elseif selected == 'smi' then
			append_commands(modules.commands.data.commands.smi)
		elseif selected == 'army' then
			append_commands(modules.commands.data.commands.army)
		elseif selected == 'prison' then
			append_commands(modules.commands.data.commands.prison)
			append_commands(modules.commands.data.commands.army)
		elseif selected == 'lc' then
			append_commands(modules.commands.data.commands.lc)
		elseif selected == 'gov' then
			append_commands(modules.commands.data.commands.gov)
		elseif selected == 'ins' then
			append_commands(modules.commands.data.commands.ins)
		elseif selected == 'fd' then
			append_commands(modules.commands.data.commands.fd)
		elseif selected == 'mafia' then
			append_commands(modules.commands.data.commands.mafia)
		elseif selected == 'ghetto' then
			append_commands(modules.commands.data.commands.ghetto)
		end
	end
    return cmds
end
function delete_default_fraction_cmds(my_cmds, default_cmds)
	for i = #my_cmds, 1, -1 do
		for _, def in ipairs(default_cmds) do
			if my_cmds[i].cmd == def.cmd then
				table.remove(my_cmds, i)
				break
			end
		end
	end
end
function add_unique_cmd(tbl, cmds)
	for _, cmd in ipairs(cmds) do
		local exists = false
		for _, v in ipairs(tbl) do
			if v.cmd == cmd.cmd then exists = true break end
		end
		if not exists then table.insert(tbl, cmd) end
	end
end
function add_unique_note(tbl, note)
	for _, v in ipairs(tbl) do
		if v.note_name == note.note_name then
			return
		end
	end
	table.insert(tbl, note)
end
function add_default_notes(module)
	if not module == 'none' then
		local money = {
			note_name = '˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜',
			note_text = '˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜˜˜:&-20 ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ (˜˜˜/˜˜˜˜˜/˜˜˜˜˜˜˜)&-20/-40 ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜&-10 ˜˜˜˜˜˜˜˜˜ ˜˜-˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜&&˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜:&+10 ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜&+7 ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜.˜˜˜˜˜˜&+15 ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ \"˜˜˜˜˜˜˜ ˜˜˜˜˜\"&+11 ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ \"˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜\"&+3 ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜ \"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜\"&+10/+15/+20/+25/+26/+30/+35 ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜&- ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜ :)'
		}
		add_unique_note(modules.notes.data, money)
	end
	if module == 'police' or module == 'fbi' or module == 'prison' or module == 'army' then
		local situate_codes = {
			note_name = '˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜',
			note_text = 'CODE 0 - ˜˜˜˜˜˜ ˜˜˜˜˜.&CODE 1 - ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜.&CODE 2 - ˜˜˜˜˜˜˜ ˜˜˜˜˜ [˜˜˜ ˜˜˜˜˜/˜˜˜˜˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜˜ ˜˜˜].&CODE 2 HIGHT - ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ [˜˜˜ ˜˜˜˜˜/˜˜˜˜˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜˜ ˜˜˜].&CODE 3 - ˜˜˜˜˜˜˜ ˜˜˜˜˜ [˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜].&CODE 4 - ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&Code 4 ADAM - ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜.&CODE 5 - ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&CODE 6 - ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ [˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜,˜˜˜˜˜˜˜˜, 911].&CODE 7 - ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜.&CODE 30 - ˜˜˜˜˜˜˜˜˜˜˜˜ "˜˜˜˜˜" ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜.&CODE 30 RINGER - ˜˜˜˜˜˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜.&CODE 37 - ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜/c.&˜ode TOM - ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.'
		}
		local teen_codes = {
			note_name = '˜˜˜-˜˜˜˜',
			note_text = '10-1 - ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&10-2 - ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.&10-2R - ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜.&10-3 - ˜˜˜˜˜˜˜˜˜˜˜˜˜.&10-4 - ˜˜˜˜˜˜˜.&10-5 - ˜˜˜˜˜˜˜˜˜.&10-6 - ˜˜ ˜˜˜˜˜˜˜/˜˜˜˜˜˜˜/˜˜˜.&10-7 - ˜˜˜˜˜˜˜˜.&10-8 - ˜˜ ˜˜˜˜˜˜˜˜/˜˜˜˜˜.&10-14 - ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜.&10-15 - ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜.&10-18 - ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.&10-20 - ˜˜˜˜˜˜˜.&10-21 - ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜.&10-22 - ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.&10-27 - ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜.&10-30 - ˜˜˜˜˜˜˜-˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜.&10-40 - ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ (˜˜˜˜˜ 4).&10-41 - ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜.&10-46 - ˜˜˜˜˜˜˜ ˜˜˜˜˜.&10-55 - ˜˜˜˜˜˜˜ ˜˜˜˜.&10-57 VICTOR - ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜.&10-57 FOXTROT - ˜˜˜˜˜ ˜˜˜˜˜˜.&10-66 - ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.&10-70 - ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&10-71 - ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&10-88 - ˜˜˜˜˜˜/˜˜.&10-99 - ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜.&10-100 ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜.'
		}
		add_unique_note(modules.notes.data, situate_codes)
		add_unique_note(modules.notes.data, teen_codes)
	end
	if module == 'police' or module == 'fbi' then
		local markup_patrool = { note_name = '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', note_text = '˜˜˜˜˜˜˜˜:&ADAM [A] - ˜˜˜˜˜˜˜ ˜˜ 2/3 ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜.&LINCOLN [L] - ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜.&MARY [M] - ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜.&KING [K] - ˜˜˜˜˜˜˜ SWAT (PLATOON-D) ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜/˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜.&HENRY [H] - ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜.&AIR [AIR] - ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜.&Air Support Division [ASD] - ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.&&˜˜˜˜˜˜˜˜˜˜˜˜˜˜:&CHARLIE [C] - ˜˜˜˜˜˜ ˜˜˜˜˜˜˜.&ROBERT [R] - ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜.&SUPERVISOR [SV] - ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.&DAVID [D] - C˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ SWAT.&EDWARD [E] - ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜.&NORA [N] - ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜.'}
		add_unique_note(modules.notes.data, markup_patrool)
	end
	save_module('notes')
end
function import_data_from_old_helpers()	
	local base = getWorkingDirectory():gsub("\\", "/")
	local function readJsonSafe(p)
		if not doesFileExist(p) then return nil end
		local f = io.open(p, "r")
		if not f then return nil end
		local ok, data = pcall(decodeJson, f:read("*a"))
		f:close()
		return ok and data or nil
	end
	local function migrate_command_args(c)
		local hasArgId = c.arg:find("{arg_id}", 1, true)
		local hasArg2 = c.arg:find("{arg2}", 1, true)
		local hasArg3 = c.arg:find("{arg3}", 1, true)
		if hasArg2 and hasArg3 then
			c.arg = c.arg:gsub("{arg_id}", "{id}"):gsub("{arg2}", "{number}"):gsub("{arg3}", "{arg}")
			c.text = c.text:gsub("{arg_id}", "{id}"):gsub("{arg2}", "{number}"):gsub("{arg3}", "{arg}")
		elseif hasArg2 and not hasArg3 then
			c.arg = c.arg:gsub("{arg_id}", "{id}"):gsub("{arg2}", "{arg}")
			c.text = c.text:gsub("{arg_id}", "{id}"):gsub("{arg2}", "{arg}")
		elseif hasArgId then
			c.arg = c.arg:gsub("{arg_id}", "{id}")
			c.text = c.text:gsub("{arg_id}", "{id}")
		end
		return c
	end
	local function import_settings(folder)
		local settingsPath = base .. "/" .. folder .. "/Settings.json"
		if not doesFileExist(settingsPath) then return end
		local data = readJsonSafe(settingsPath)
		if not data then return end
		if data.note then
			for _, n in ipairs(data.note) do
				if not n.deleted then add_unique_note(n) end
			end
		end
		if data.commands then
			for _, c in ipairs(data.commands) do
				if not c.deleted then
					add_unique_cmd(modules.commands.data.commands.my, {migrate_command_args(c)})
				end
			end
		end
		if data.commands_manage then
			for _, c in ipairs(data.commands_manage) do
				if not c.deleted then
					migrate_command_args(c)
					add_unique_cmd(modules.commands.data.commands_manage.my, {migrate_command_args(c)})
				end
			end
		end
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜) ˜ ˜˜˜˜˜˜˜ ˜˜ ' .. message_color_hex .. folder .. '{ffffff} ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!', message_color)
		os.remove(settingsPath)
	end
	import_settings("SMI Helper")
	import_settings("Hospital Helper")
	import_settings("AS Helper")
	local function import_split(folder)
		local notesPath = base .. "/" .. folder .. "/Notes.json"
		if doesFileExist(notesPath) then 
			local n = readJsonSafe(notesPath)
			if n and n.note then
				for _, note in ipairs(n.note) do
					if not note.deleted then add_unique_note(note) end
				end
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ' .. message_color_hex .. folder .. ' Helper {ffffff} ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!', message_color)
				os.remove(notesPath)
			end
		end
		local cmdsPath = base .. "/" .. folder .. "/Commands.json"
		if doesFileExist(cmdsPath) then 
			local c = readJsonSafe(cmdsPath)
			if c then
				if c.commands then
					for _, cmd in ipairs(c.commands) do
						if not cmd.deleted then
							add_unique_cmd(modules.commands.data.commands.my, {migrate_command_args(cmd)})
						end
					end
				end
				if c.commands_manage then
					for _, cmd in ipairs(c.commands_manage) do
						if not cmd.deleted then
							add_unique_cmd(modules.commands.data.commands_manage.my, {migrate_command_args(cmd)})
						end
					end
				end
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜) ˜˜ ' .. message_color_hex .. folder .. ' Helper {ffffff} ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!', message_color)
				os.remove(cmdsPath)
			end
		end
	end
	for _, helpers in ipairs({"Mafia", "FD", "Prison", "GOV", "Government", "Justice"}) do
		import_split(helpers .. " Helper")
	end
	local function safeMove(folder, file, target)
		local p = base .. "/" .. folder .. "/" .. file
		if readJsonSafe(p) then 
			os.rename(p, target)
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ "' .. file .. '" ˜˜ ' .. message_color_hex .. folder .. '{ffffff} ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!', message_color)
		end
	end
	safeMove("SMI Helper", "Ads.json", modules.ads_history.path)
	safeMove("Justice Helper", "SmartUK.json", modules.smart_uk.path)
	safeMove("Justice Helper", "SmartPDD.json", modules.smart_pdd.path)
	safeMove("Prison Helper", "SmartRPTP.json", modules.smart_rptp.path)
end
function delete_old_helpers()
	local path = worked_dir
	local current_path = thisScript().path:gsub('\\','/')
    local correct_path = path .. "/Arizona Helper.lua"
	if current_path ~= correct_path then
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜...', message_color)
        if doesFileExist(correct_path) then os.remove(correct_path) end
        os.rename(current_path, correct_path)
    end

	local helpers = {"Justice", "Hospital", "SMI", "AS", "FD", "GOV", "Government", "Mafia", "Prison"}
	for index, name in ipairs(helpers) do
		if doesFileExist(path .. "/" .. name .. " Helper.lua") then
			os.remove(path .. "/" .. name .. " Helper.lua")
		elseif doesFileExist(path .. "/" .. name .. "_Helper.lua") then
			os.remove(path .. "/" .. name .. "_Helper.lua")
		end
	end
	for _, name in ipairs(helpers) do
        local file1 = path .. "/" .. name .. " Helper.lua"
        local file2 = path .. "/" .. name .. "_Helper.lua"
        if doesFileExist(file1) then os.remove(file1) end
        if doesFileExist(file2) then os.remove(file2) end
    end
end
function delete_helpers_data(checker)
	os.remove(config_dir .. "/Settings.json")
	os.remove(config_dir .. "/Player.json")
	os.remove(config_dir .. "/Commands.json")
	os.remove(config_dir .. "/Buttons.json")
	os.remove(config_dir .. "/Departament.json")
	os.remove(config_dir .. "/PieMenu.json")
	os.remove(config_dir .. "/Notes.json")
	os.remove(config_dir .. "/Vehicles.json")
	os.remove(config_dir .. "/Guns.json")
	os.remove(config_dir .. "/Ads.json")
	os.remove(config_dir .. "/Update.json")
	os.remove(config_dir .. "/SmartUK.json")
	os.remove(config_dir .. "/SmartPDD.json")
	os.remove(config_dir .. "/SmartRPTP.json")
	if checker then
		os.remove(config_dir .. "/Resourse/notify.mp3")
		os.remove(config_dir .. "/Resourse/logo.png")
		os.remove(thisScript().path)
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜!', message_color)
		reload_script = true
		thisScript():unload()
	else
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜...', message_color)
		reload_script = true
		thisScript():reload()
	end
end
if isMode('police') or isMode('fbi') then
	function form_su(name, playerID, message)
		local lvl, id, reason = message:match('˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ (%d) ˜˜˜˜˜˜˜ ˜˜˜˜ N(%d+)%. ˜˜˜˜˜˜˜%: (.+)')
		local rank = (isMode('fbi') and 4 or 5)
		if (modules.player.data.fraction_rank_number >= rank) then
			MODULE.SumMenu.form_su = id .. ' ' .. lvl .. ' ' .. reason
			sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. '/givefsu ' .. playerID .. '{ffffff} ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. name, message_color)
			play_sound()
		else
			sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ' .. rank .. '-˜ ˜˜˜˜, ˜˜ ˜˜ ˜˜˜˜˜˜ ' .. modules.player.data.fraction_rank_number .. '-˜ ˜˜˜˜ :(', message_color)
		end
	end
end
if isMode('hospital') then
	function heal_handler(nick, id, message)
		if (nick and id and message and tonumber(id) ~= select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) then
			local function check_end_time()
				lua_thread.create(function()
					wait(5000)
					if MODULE.HealChat.bool then
						MODULE.HealChat.Window[0] = false
						MODULE.HealChat.bool = false
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. sampGetPlayerNickname(id), message_color)
					end
				end)
			end
			for hello_bro, keyword in ipairs(MODULE.HealChat.worlds) do
				if (message:rupper():find(keyword:rupper())) then
					if IS_MOBILE then
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. sampGetPlayerNickname(id) .. ', ˜ ˜˜˜˜˜˜˜ 5-˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜', message_color)
						MODULE.HealChat.player_id = id
						MODULE.HealChat.bool = true
						MODULE.HealChat.Window[0] = true
						check_end_time()
					elseif hotkey_no_errors then
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. sampGetPlayerNickname(id) .. ' ˜˜˜˜˜˜˜ ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_action) .. ' {ffffff}˜ ˜˜˜˜˜˜˜ 5-˜˜ ˜˜˜˜˜˜!', message_color)
						show_notify('info', 'Arizona Helper', '˜˜˜˜˜˜˜ ' .. getNameKeysFrom(settings.general.bind_action) .. ' ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', 5000)
						MODULE.HealChat.player_id = id
						MODULE.HealChat.bool = true
						check_end_time()
					end
					return
				end
			end
		end
	end
end
if isMode('fd') then
	function getFireLocation(id)
		count = 0
		for line in MODULE.Fires.locations:gmatch('.-\n') do
			if id == count then
				local line2 = line:match('%].+%](.+){.+{.+{'):gsub("^%s+", ""):gsub("%s+$", "")
				MODULE.Fires.location = line2 or '˜˜˜˜˜'
				if MODULE.Fires.lvl == -1 then
					if line:find('%*%*%*') then
						MODULE.Fires.lvl = 3
					elseif line:find('%*%*') then
						MODULE.Fires.lvl = 2
					elseif line:find('%*') then
						MODULE.Fires.lvl = 1
					end
				end
				if settings.fd.doklads.togo then
					sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.my_doklad_nick() .. ', ˜˜˜˜˜˜' .. MODULE.Binder.tag.sex() .. ' ˜˜ ' .. MODULE.Fires.location .. ' ' .. MODULE.Fires.lvl .. ' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜')
				end
				return
			else
				count = count + 1
			end
		end
	end
end
if isMode('smi') then
	function try_send_ad(text)
		if text == '' then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜!', message_color)
			play_sound()
			return false
		end
		if text == MODULE.SmiEdit.last_ad_text then
			MODULE.SmiEdit.ad_repeat_count = MODULE.SmiEdit.ad_repeat_count + 1
		else
			MODULE.SmiEdit.ad_repeat_count = 0
			MODULE.SmiEdit.last_ad_text = text
		end
		if MODULE.SmiEdit.ad_repeat_count >= 51 then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜.˜˜˜˜˜˜˜˜ (˜˜˜˜˜/˜˜˜˜˜/˜˜˜˜˜˜˜)!', message_color)
			play_sound()
			MODULE.SmiEdit.last_ad_text = ''
			MODULE.SmiEdit.ad_repeat_count = 0
			if modules.ads_history.data then
				if settings.smi.ads_history then
					for index, ad in ipairs(modules.ads_history.data) do
						if ad and ad.text and ad.text == MODULE.SmiEdit.ad_message then
							ad.text = ad.my_text
							save_module('ads_history')
							break
						end
					end
				end
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜ ' .. modules.ads_history.path, message_color)
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ˜˜˜, ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ (˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ 1251)', message_color)
				play_sound()
			end
			return false
		end
		MODULE.SmiEdit.is_active_ad = false
		sampSendDialogResponse(MODULE.SmiEdit.ad_dialog_id, 1, 0, text)
		imgui.StrCopy(MODULE.SmiEdit.input_edit_text, '')
		return true
	end
end
--------------------------------------------- Events ---------------------------------------------
function emulationCEF(str)
	-- by wojciech?
	local bs = raknetNewBitStream()
	raknetBitStreamWriteInt8(bs, 220)
	raknetBitStreamWriteInt8(bs, 18)
	raknetBitStreamWriteInt16(bs, #str)
	raknetBitStreamWriteString(bs, str)
	raknetBitStreamWriteInt32(bs, 0)
	raknetSendBitStream(bs)
	raknetDeleteBitStream(bs)
end
function visualCEF(str, is_encoded)
	-- by wojciech?
	local bs = raknetNewBitStream()
	raknetBitStreamWriteInt8(bs, 17)
	raknetBitStreamWriteInt32(bs, 0)
	raknetBitStreamWriteInt16(bs, #str)
	raknetBitStreamWriteInt8(bs, is_encoded and 1 or 0)
	if is_encoded then
		raknetBitStreamEncodeString(bs, str)
	else
		raknetBitStreamWriteString(bs, str)
	end
	raknetEmulPacketReceiveBitStream(220, bs)
	raknetDeleteBitStream(bs)
end
function show_notify(type, title, text, time)
	if IS_MOBILE then
		--[[
		if type == 'info' then
			type = 3
		elseif type == 'error' then
			type = 2
		elseif type == 'success' then
			type = 1
		end
		local bs = raknetNewBitStream()
		raknetBitStreamWriteInt8(bs, 62)
		raknetBitStreamWriteInt8(bs, 6)
		raknetBitStreamWriteBool(bs, true)
		raknetEmulPacketReceiveBitStream(220, bs)
		raknetDeleteBitStream(bs)
		local json = encodeJson({
			styleInt = type,
			title = title,
			text = text,
			duration = time
		})
		local interfaceid = 6
		local subid = 0
		local bs = raknetNewBitStream()
		raknetBitStreamWriteInt8(bs, 84)
		raknetBitStreamWriteInt8(bs, interfaceid)
		raknetBitStreamWriteInt8(bs, subid)
		raknetBitStreamWriteInt32(bs, #json)
		raknetBitStreamWriteString(bs, json)
		raknetEmulPacketReceiveBitStream(220, bs)
		raknetDeleteBitStream(bs)
		]]
	else
		local function escape_js(s)
			return s:gsub("\\", "\\\\"):gsub('"', '\\"')
		end
		local safe_type = escape_js(type)
		local safe_title = escape_js(title)
		local safe_text = escape_js(text)
		local safe_time = tostring(time)
		local str = ('window.executeEvent("event.notify.initialize", "[\\"%s\\", \\"%s\\", \\"%s\\", \\"%s\\"]");'):format(safe_type, safe_title, safe_text, safe_time)
		visualCEF(str, true)
	end
end
function sampev.onShowTextDraw(id, data)
	if MODULE.DEBUG then
		sampAddChatMessage('[ShowTextDraw] {ffffff}ID ' .. id .. " | Text " .. data.text .. ' | ModelID ' .. data.modelId .. " |", message_color)
		print("[ShowTextDraw] ID " .. id .. " | Text " .. data.text .. ' | ModelID ' .. data.modelId .. " |")
	end
	if data.text:find('~n~~n~~n~~n~~n~~n~~n~~n~~w~Style: ~r~Sport!') then
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ Sport!', message_color)
		return false
	end
	if data.text:find('~n~~n~~n~~n~~n~~n~~n~~n~~w~Style: ~g~Comfort!') then
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ Comfort!', message_color)
		return false
	end
end
function sampev.onSendClickTextDraw(textdrawId)
	if MODULE.DEBUG then
		sampAddChatMessage('[ClickTextDraw] {ffffff}ID ' .. textdrawId, message_color)
		print('[ClickTextDraw] ID ' .. textdrawId)
	end
end
function sampev.onSendTakeDamage(playerId,damage,weapon)
	if MODULE.DEBUG then
		sampAddChatMessage('[TakeDamage] {ffffff}ID ' .. playerId .. " | Damage " .. damage .. " | Weapon " .. weapon, message_color)
		print('[TakeDamage] ID ' .. playerId .. " | Damage " .. damage .. " | Weapon " .. weapon)
	end
	if playerId ~= 65535 then
		playerId2 = playerId1
		playerId1 = playerId
		if isParamSampID(playerId) and playerId1 ~= playerId2 and tonumber(playerId) ~= 0 and weapon then
			local weapon_name = get_name_weapon(weapon)
			if weapon_name then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ' .. sampGetPlayerNickname(playerId) .. '[' .. playerId .. '] ˜˜˜˜˜ ˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ' .. weapon_name .. '['.. weapon .. ']!', message_color)
				if isMode('police') or isMode('fbi') or isMode('army') or isMode('prison') then
					if ((MODULE.Patrool.Window[0]) and (MODULE.Patrool.ComboCode[0] ~= 1)) then
						sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜ CODE 0.', message_color)
						MODULE.Patrool.ComboCode[0] = 1
						MODULE.Patrool.code = 'CODE 0'
					end
					if ((MODULE.Post.Window[0]) and (MODULE.Post.ComboCode[0] ~= 1)) then
						sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜ CODE 0.', message_color)
						MODULE.Post.ComboCode[0] = 1
						MODULE.Post.code = 'CODE 0'
					end
					if ((isMode('police') or isMode('fbi')) and settings.mj.auto_doklad_damage) or (((isMode('army') or isMode('prison')) and settings.md.auto_doklad_damage)) then
						if not MODULE.Binder.state.isActive then
							lua_thread.create(function()
								MODULE.Binder.state.isActive = true
								sampSendChat('/r ' .. MODULE.Binder.tag.my_doklad_nick() .. ' ˜˜ CONTROL. ' .. (weapon ~= 0 and '˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜' or '˜˜ ˜˜˜˜ ˜˜˜˜˜˜') .. ' ˜ ˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_area() .. ' (' .. MODULE.Binder.tag.get_square() .. '), ˜˜˜˜˜˜˜˜˜ CODE 0!')
								wait(2000)
								sampSendChat('/rb ˜˜˜˜˜˜˜˜˜˜: ' .. sampGetPlayerNickname(playerId) .. '[' .. playerId .. '], ˜˜(-˜) ˜˜˜˜˜˜˜˜˜˜ ' .. weapon_name .. '!')
								MODULE.Binder.state.isActive = false
							end)
						end
					end
				end
			end
		end
	end
end
function sampev.onSendGiveDamage(playerId, damage, weapon, bodypart)
	if MODULE.DEBUG then
		sampAddChatMessage('[GiveDamage] {ffffff}ID ' .. playerId .. " | Damage " .. damage .. " | Weapon " .. weapon .. " | Body " .. bodypart, message_color)
		print('[GiveDamage] ID ' .. playerId .. " | Damage " .. damage .. " | Weapon " .. weapon .. " | Body " .. bodypart)
	end
	if playerId ~= 65535 then
		if (sampGetPlayerNickname(playerId) == 'Bogdan_Martelli' and getServerNumber() == '20') or sampGetPlayerNickname(playerId):find('%[20%]Bogdan_Martelli') then
			sampAddChatMessage('[Furry Helper] {ffffff}Bogdan_Martelli - ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ Arizona Helper!', message_color)
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜ :sob: :sob: :sob:', message_color)
			play_sound()
		end
	end
end
function sampev.onServerMessage(color, text)
	if MODULE.DEBUG then
		sampAddChatMessage('[ServerMessage] {ffffff}Color ' .. color .. " | Text " .. text, message_color)
		print('[ServerMessage] Color ' .. color .. " | Text " .. text)
	end

	if IS_MOBILE then -- ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ID ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜
		if text:find('{DFCFCF}[˜˜˜˜˜˜˜˜˜] {DC4747}˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ /report', 1, true) and modules.player.data.nick ~= '' then
			CHECK_ID = true
			sampSendChat('/id ' .. modules.player.data.nick)
		end
		if CHECK_ID and text:find('^%[(%d+)%]') then 
			MODULE.MOBILE_PLAYER_ID = text:match('^%[(%d+)%]')
			CHECK_ID = false
		end
	end

	if settings.general.ping and MODULE.Binder.tag.my_nick() ~= '' and text:find('@' .. MODULE.Binder.tag.my_nick(), 1, true) then
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜-˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜!', message_color)
		play_sound()
	end

	if modules.player.data.fraction_rank_number >= 9 then
		if settings.general.auto_uninvite then
			local function auto_uninvite_handler(tag, name, playerID, message)
				if not message:find("˜˜˜˜˜˜˜˜˜ (.+) +++ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜!") and not message:find("˜˜˜˜˜˜˜˜˜ (.+) ˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜") and message:rupper():find("˜˜˜") or message:rupper():find("˜˜˜˜˜˜˜") or message:rupper():find("˜˜˜˜") then
					MODULE.LeadTools.msg3 = MODULE.LeadTools.msg2
					MODULE.LeadTools.msg2 = MODULE.LeadTools.msg1
					MODULE.LeadTools.msg1 = text
					PlayerID = playerID
					if MODULE.LeadTools.msg3 == text then
						MODULE.LeadTools.checker = true
						sampSendChat('/fmute ' .. playerID .. ' 1 ˜˜˜')
					elseif tag == "R" then
						sampSendChat("/rb "..name.."["..playerID.."], ˜˜˜˜˜˜˜˜˜ /rb +++ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜!")
					elseif tag == "F" then
						sampSendChat("/fb "..name.."["..playerID.."], ˜˜˜˜˜˜˜˜˜ /fb +++ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜!")
					end
				elseif ((message == "(( +++ ))" or  message == "(( +++. ))") and (PlayerID == playerID)) then
					MODULE.LeadTools.checker = true
					sampSendChat('/fmute ' .. playerID .. ' 1 ˜˜˜')
				end
			end
			if text:find("^%[(.-)%] (.-) (.-)%[(.-)%]: (.+)") and color == 766526463 then -- /f /fb /r /rb ˜˜˜ ˜˜˜˜ 
				local tag, rank, name, playerID, message = string.match(text, "%[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
				auto_uninvite_handler(tag, name, playerID, message)
			elseif text:find("^%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: (.+)") and color == 766526463 then -- /r /f ˜ ˜˜˜˜˜
				local tag, tag2, rank, name, playerID, message = string.match(text, "%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
				auto_uninvite_handler(tag, name, playerID, message)
			elseif text:find("(.+) ˜˜˜˜˜˜˜˜%(˜%) ˜˜˜˜˜˜ (.+) ˜˜ 1 ˜˜˜˜˜. ˜˜˜˜˜˜˜: ˜˜˜") and MODULE.LeadTools.checker then
				local text2 = text:gsub('{......}', '')
				local DATA = text2:match("(.+) ˜˜˜˜˜˜˜˜")
				local Name = DATA:match(" ([A-Za-z0-9_]+)%[")
				local MyName = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
				if Name == MyName then
					sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. sampGetPlayerNickname(PlayerID) .. '!', message_color)
					MODULE.LeadTools.checker = false
					find_and_use_command("/uninvite {id} {arg}", (PlayerID .. ' ˜˜˜'))
				else
					sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜/˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. sampGetPlayerNickname(PlayerID) .. '!', message_color)
					MODULE.LeadTools.checker = false
				end
			end
		end
	end

	if settings.general.auto_accept_docs and text:find('^%[˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜%].+offer') then
		sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜...', message_color)
		sampSendChat('/offer')
	end

	-- ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜
	if settings.general.auto_mask and text:find("˜˜˜˜˜˜˜") or text:find("˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜") or text:find("mask fell off") then
  	  local now = os.time()
 	   if now - lastMaskTime > 5 then
     	   lastMaskTime = now
      	  sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜.', message_color)
      	  sampSendChat('/mask')
   	 end
	end

	if isMode('smi') then
		if text:find('^˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ') or text:find('^{C17C2D}˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜%: (.+)')
		or text:find('^VIP ˜˜˜˜˜˜˜˜˜˜:') or text:find('^˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜:') then -- rodina
			local nick = text:match('˜˜: ([^{%(]+)') or text:match('˜˜˜˜˜˜˜˜: (.+)') or text:match('%, ˜˜%: (.+)%[') or ''
			if settings.smi.notify_new_ads then play_sound() end
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ' .. message_color_hex .. nick, message_color)
			return false
		end
		if (text:find('^%[˜˜˜˜˜˜%] %{ffffff%}˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ (.+).')) then
			local nick = text:match('˜˜˜˜˜˜˜˜˜˜˜ (.+).')
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ' .. message_color_hex  .. nick, message_color)
			return false
		end
		if text:find('^{FCAA4D}%[VIP%] ˜˜˜˜˜˜˜˜˜˜%:') then
			lua_thread.create(function()
				MODULE.SmiEdit.vip_pause = true
				wait(10000)
				MODULE.SmiEdit.vip_pause = false
			end)
		end
	end

	if (isMode('police') or isMode('fbi')) then
		if text:find("^%[(.-)%] (.-) (.-)%[(.-)%]: ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ (%d) ˜˜˜˜˜˜˜ ˜˜˜˜ N(%d+)%. ˜˜˜˜˜˜˜%: (.+)") then
			local tag, rank, name, playerID, message = string.match(text, "%[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
			form_su(name, playerID, message)
		elseif text:find("^%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ (%d) ˜˜˜˜˜˜˜ ˜˜˜˜ N(%d+)%. ˜˜˜˜˜˜˜%: (.+)") then
			local tag, tag2, rank, name, playerID, message = string.match(text, "%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
			form_su(name, playerID, message)
		end
		if (text:find('^˜˜˜˜˜˜˜˜˜˜˜˜˜˜ (.+) ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜')) then
			printStringNow(MODULE.Wanted.afind and 'AUTO FIND' or 'FIND', 500)
			return false
		end
		if ((MODULE.Wanted.checker) and (text:find('^%[˜˜˜˜˜˜%] %{FFFFFF%}˜˜˜˜˜˜˜˜˜: %/wanted %[˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ 1%-6%]') or text:find('^%[˜˜˜˜˜˜%] %{FFFFFF%}˜˜˜˜˜˜˜˜˜˜˜: %/wanted %[˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ 1%-6%]'))) then
			return false
		end
		if ((MODULE.Wanted.checker) and (text:find('^%[˜˜˜˜˜˜%].+˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜'))) then 
			return false 
		end
		if ((MODULE.Patrool.active) and (text:find('^˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜.'))) then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜...', message_color)
			sampSendChat('/delvdesc')
			lua_thread.create(function()
				wait(5000)
				sampSendChat('/vdesc ' .. MODULE.Binder.tag.get_patrool_mark())
			end)		
		end
		if (text:find('^%[˜˜˜˜˜˜˜˜˜˜%] {ffffff}˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜ {ff0000}˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜')) then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜!', message_color)
			return false
		end
		if (text:find('^%[˜˜˜˜˜˜˜˜˜˜%] {ffffff}˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.')) then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.', message_color)
			return false
		end
		if text:find('^>> ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (.+) ˜ ˜˜˜˜˜˜ ˜˜ (%d+) ˜˜˜˜˜') then
			if (settings.mj.auto_time) then
				lua_thread.create(function()
					wait(500)
					sampSendChat('/time')
				end)
			end
		end
		if settings.mj.auto_time then
			local nick = MODULE.Binder.tag.my_nick():gsub('%[.+%]', '')
			if text:find("^ " .. nick .. ' ˜˜˜˜˜˜˜˜˜˜ (.+)') 
			or text:find("^" .. nick .. ' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ (.+)') 
			or text:find("^%[˜˜˜˜˜˜%] (.+) ˜˜˜˜˜˜˜˜˜˜%: " .. nick) then
				sampSendChat('/time')
			end
		end
	end
 	
	if isMode('hospital') then
		if text:find('^˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ (.+) %((.+)%).') then
			MODULE.GoDeath.locate, MODULE.GoDeath.city = text:match('˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ (.+) %((.+)%).')
			return false
		elseif text:find('^˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜%, ˜˜˜˜˜˜˜˜˜˜%: (.+)') then -- rodina
			MODULE.GoDeath.locate, MODULE.GoDeath.city = "˜˜˜˜˜˜˜˜˜˜˜", text:match('˜˜˜˜˜˜˜˜˜˜%: (.+)')
			return false
		end
		if text:find('^%(%( ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜ /godeath (%d+). ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ (.+) %)%)') then
			local price_godeath = ''
			MODULE.GoDeath.player_id, price_godeath = text:match('%(%( ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜ /godeath (%d+). ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ (.+) %)%)')
			MODULE.GoDeath.player_id = tonumber(MODULE.GoDeath.player_id)
			local cmd = '/godeath'
			for _, command in ipairs(modules.commands.data.commands.my) do
				if command.enable and command.text:find('/godeath {id}') then
					cmd =  '/' .. command.cmd
				end
			end
			if MODULE.GoDeath.locate == '˜˜˜˜˜˜˜˜˜˜˜' then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ' .. message_color_hex .. MODULE.GoDeath.city .. ' {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. sampGetPlayerNickname(MODULE.GoDeath.player_id), message_color)
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ' .. message_color_hex .. MODULE.GoDeath.city .. ' (' .. MODULE.GoDeath.locate .. ') {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. sampGetPlayerNickname(MODULE.GoDeath.player_id), message_color)
			end
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ' .. price_godeath .. '! ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. cmd .. ' ' .. MODULE.GoDeath.player_id, message_color)
			return false
		end
		if text:find("^˜˜˜˜˜˜˜ (.+) ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ .+˜˜˜˜.+˜˜˜˜") then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ' .. text:match("˜˜˜˜˜˜˜ (.+) ˜˜˜˜˜˜˜˜") .. ' ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜!', message_color)
			return false
		end
		if settings.mh.heal_in_chat.enable and not MODULE.HealChat.bool then	
			if text:find('^(.+)%[(%d+)%] ˜˜˜˜˜˜˜:{......} (.+)') then
				local nick, id, message = text:match('^(.+)%[(%d+)%] ˜˜˜˜˜˜˜:{......} (.+)')
				heal_handler(nick, id, message)
			elseif text:find('^(.+)%[(%d+)%] ˜˜˜˜˜˜: (.+)') then
				local nick, id, message = text:match('^(.+)%[(%d+)%] ˜˜˜˜˜˜: (.+)')
				heal_handler(nick, id, message)
			end
		end
	end	

	if isMode('lc') then
		if text:find('^˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜: (.+) ˜˜˜˜ ˜˜˜˜˜˜˜˜%: (.+)') then
			local money = text:match('˜˜˜˜ ˜˜˜˜˜˜˜˜%: (.+)')
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ' .. money, message_color)
			if AS_REMONT_DEBUG then
				sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜!', message_color)
				AS_REMONT_DEBUG = false
				settings.lc.auto_repair_znak.enable = true
				save_settings()
			end
			return false
		end
		if text:find('^˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜: (.+) ˜˜˜˜ ˜˜˜˜˜˜˜˜%: (.+)') then
			local money = text:match('˜˜˜˜ ˜˜˜˜˜˜˜˜%: (.+)')
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ' .. money, message_color)
			if AS_INSTALL_DEBUG then
				sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜, ˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜!', message_color)
				AS_INSTALL_DEBUG = false
				settings.lc.auto_install_znak.enable = true
				save_settings()
			end
			return false
		end
		if text:find('^˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.') then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.', message_color)
			return false
		end
		if text:find('^%[˜˜˜˜˜˜%](.+)˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ (.+)') then
			local days = text:match('˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ (.+)')
			sampAddChatMessage('[Furry Helper] {ffffff}˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ' .. days, message_color)
			sampSendChat('˜ ˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ' .. days)
			return false
		end
		if (text:find('^%[˜˜˜˜˜˜%](.+)˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜')) then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜ ˜˜˜˜ ˜˜˜˜, ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!', message_color)
			sampSendChat('˜˜˜˜˜˜˜˜, ˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜-˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.')
			return false
		end
	end	

	if isMode('fd') then
		if (text:find("˜˜˜˜˜˜˜˜˜˜˜˜(.+)˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜! ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (%d) ˜˜˜˜˜˜")) then
			MODULE.Fires.lvl = text:match('˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (%d) ˜˜˜˜˜˜')
			sampAddChatMessage('[Furry Helper] {ffffff}˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ' .. MODULE.Fires.lvl .. ' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!', message_color)
			if (tonumber(MODULE.Fires.lvl) >= 2) then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜-˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.', message_color)
			end
			sampSendChat('/fires')
			return false
		end
		if (text:find("%[˜˜˜˜˜˜˜˜˜˜%] {ffffff}˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜")) then
			MODULE.Fires.isZone = true
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜.', message_color)
			if (settings.fd.doklads.here) then 
				sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.my_doklad_nick() .. ', ˜˜˜˜˜˜' .. MODULE.Binder.tag.sex() .. ' ˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ' .. MODULE.Fires.lvl .. ' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!')
			end
			return false
		end
		if (text:find("%[˜˜˜˜˜˜˜˜˜˜%] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ (%d+) ˜˜˜˜˜")) then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ' .. text:match("˜˜˜˜˜ (%d+) ˜˜˜˜˜") .. ' ˜˜˜˜˜!', message_color)
			return false
		end
		if (MODULE.Fires.isZone) then
			if text:find("%[˜˜˜˜˜˜˜˜˜˜%] {......}˜˜˜˜˜˜˜˜˜˜˜˜ ˜(%d+)%: ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜") then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜!', message_color)
				if settings.fd.doklads.fire then
					sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.my_doklad_nick() .. ', ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. MODULE.Fires.lvl .. ' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜!')
				end
				return false
			end
			if text:find("%[˜˜˜˜˜˜˜˜˜˜%] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.") then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.', message_color)
				if settings.fd.doklads.stretcher then 
					sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.my_doklad_nick() .. ', ˜˜˜˜˜˜˜˜' .. MODULE.Binder.tag.sex() .. ' ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.')
				end
				return false
			end
			if text:find("%[˜˜˜˜˜˜˜˜˜˜%] {ffffff}˜˜˜˜˜˜˜! ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜!") then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜!', message_color)
				if settings.fd.doklads.npc_save then 
					sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.my_doklad_nick() .. ', ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜!')
				end
				return false
			end
			if text:find("%[˜˜˜˜˜˜˜˜˜˜%] {ffffff}˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ {90EE90}$(.+){FFFFFF}, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜") then
				MODULE.Fires.isZone = false
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜: ' .. message_color_hex .. '$' .. (text:match('{90EE90}$(.+){FFFFFF}') or 'nil'), message_color)
				if settings.fd.doklads.file_end then
					lua_thread.create(function()
						wait(500)
						sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.my_doklad_nick() .. ', ˜˜˜˜˜ ' .. MODULE.Fires.lvl .. ' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!')
					end)
				end
				return false
			end
		end
		if (text:find("%[˜˜˜˜˜˜˜˜˜˜%] {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜.")) then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜.', message_color)
			if (settings.fd.doklads.tent) then 
				sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.my_doklad_nick() .. ', ˜˜˜˜˜' .. MODULE.Binder.tag.sex() .. ' ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.')
			end
			return false
		end
	end

	if isMode('ins') then
		if (text:find('^(.+) ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.') and color == -1048826369) then
			local nick = text:match('^(.+) ˜˜˜˜˜')
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ' .. nick .. ' ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!', message_color)
			if (settings.ins.notify_new_ticket) then
				play_sound()
			end
			return false
		end
		if (text:find('^˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜.')) then
			sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!', message_color)
			return false
		end
	end

	if isMode('gov') then
		if text:find('^%[˜˜˜˜˜˜%].+˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜.') then
			MODULE.Zeks.Window[0] = false
			MODULE.Zeks.checker = false
			MODULE.Zeks.updzeks.stop = false
			MODULE.Zeks.updzeks.check = false
		end
	end

	if text:find('^%[˜˜˜˜˜˜%] {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ 3 ˜˜˜˜. {C0C0C0}%(˜˜˜˜˜˜˜˜: (.+)%)') then
		sampSendChat('/n ˜ ˜˜˜ ˜˜ ˜˜ /fractionrp! ˜˜˜˜˜˜˜˜ ' .. text:match('˜˜˜˜˜˜˜˜: (.+)%)'))
	end 

	if (text:find("^1%.{......} 111 %- {......}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜")) or
		(text:find("^2%.{......} 060 %- {......}˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜")) or
		(text:find("^3%.{......} 911 %- {......}˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜")) or
		(text:find("^4%.{......} 912 %- {......}˜˜˜˜˜˜ ˜˜˜˜˜˜")) or
		(text:find("^5%.{......} 914 %- {......}˜˜˜˜˜")) or
		(text:find("^5%.{......} 914 %- {......}˜˜˜˜˜˜˜")) or
		(text:find("^6%.{......} 8828 %- {......}˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜")) or
		(text:find("^7%.{......} 997 %- {......}˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ %(˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜%)")) then
		return false
	end
	if (text:find("^%[˜˜˜˜˜˜˜˜˜%] {......}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜:")) then
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜:', message_color)
		sampAddChatMessage('[Furry Helper] {ffffff}111 ˜˜˜˜˜˜ | 60 ˜˜˜˜˜ | 911 ˜˜ | 912 ˜˜ | 913 ˜˜˜˜˜ | 914 ˜˜˜˜ | 8828 ˜˜˜˜ | 997 ˜˜˜˜', message_color)
		return false
	end

	if (text:find('Bogdan_Martelli') and getServerNumber() == '20') or text:find('%[20%]Bogdan_Martelli') then
		local lastColor = text:match("(.+){%x+}$")
		if text:find('%[VIP ADV%]') or text:find('%[FOREVER%]') then lastColor = "{FFFFFF}" end
   		if not lastColor then lastColor = "{" .. rgba_to_hex(color) .. "}" end
		if text:find('%[20%]Bogdan_Martelli%[%d+%]') then
			local id = text:match('%[20%]Bogdan_Martelli%[(%d+)%]') or ''
			text = string.gsub(text, '%[20%]Bogdan_Martelli%[%d+%]', message_color_hex .. '[20]MTGMODS[' .. id .. ']' .. lastColor)
		elseif text:find('%[20%]Bogdan_Martelli') then
			text = string.gsub(text, '%[20%]Bogdan_Martelli', message_color_hex .. '[20]MTGMODS' .. lastColor)
		elseif text:find('Bogdan_Martelli%[%d+%]') then
			local id = text:match('Bogdan_Martelli%[(%d+)%]') or ''
			text = string.gsub(text, 'Bogdan_Martelli%[%d+%]', message_color_hex .. 'MTGMODS[' .. id .. ']' .. lastColor)
		elseif text:find('Bogdan_Martelli') then
			text = string.gsub(text, 'Bogdan_Martelli', message_color_hex .. 'MTGMODS' .. lastColor)
		end
		return {color,text}
	end
end
function sampev.onSendChat(text)
	if MODULE.DEBUG then
		sampAddChatMessage('[SendChat] {ffffff}Text ' .. text, message_color)
		print('[SendChat] ' .. text)
	end
	local ignore = {
		[")"] = true,
		["))"] = true,
		["("] = true,
		["(("] = true,
		["q"] = true,
		["<3"] = true,
	}
	if ignore[text] then
		return {text}
	end
	if settings.general.rp_chat then
		text = text:sub(1, 1):rupper()..text:sub(2, #text) 
		if not text:find('(.+)%.') and not text:find('(.+)%!') and not text:find('(.+)%?') then
			text = text .. '.'
		end
	end
	if settings.general.accent_enable then
		text = modules.player.data.accent .. ' ' .. text 
	end
	return {text}
end
function sampev.onSendCommand(text)
	if MODULE.DEBUG then
		sampAddChatMessage('[SendCommand] {ffffff}CMD ' .. text, message_color)
		print('[SendCommand] CMD ' .. text)
	end
	if isMode('smi') and MODULE.SmiEdit.is_active_ad and text:find('^%/newsredak') then
		sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜!', message_color)
		play_sound()
		return false
	end
	if settings.general.rp_chat then
		local chats =  { '/vr', '/fam', '/al', '/s', '/b', '/n', '/r', '/rb', '/f', '/fb', '/j', '/jb', '/m', '/do'} 
		for _, cmd in ipairs(chats) do
			if text:find('^'.. cmd .. ' ') then
				local cmd_text = text:match('^'.. cmd .. ' (.+)')
				if cmd_text ~= nil then
					cmd_text = cmd_text:sub(1, 1):rupper()..cmd_text:sub(2, #cmd_text)
					text = cmd .. ' ' .. cmd_text
					if not text:find('(.+)%.') and not text:find('(.+)%!') and not text:find('(.+)%?') then
						text = text .. '.'
					end
				end
			end
		end
		return {text}
	end
end
function sampev.onShowDialog(dialogid, style, title, button1, button2, text)
	if MODULE.DEBUG then
		sampAddChatMessage('[ShowDialog] {ffffff}ID ' .. dialogid .. ' | Style ' .. style .. ' | Title ' .. title .. ' | Btn1 ' .. button1 .. ' | Btn2 ' .. button2 .. ' | Text ' .. text, message_color)
		print('[ShowDialog] ID ' .. dialogid .. ' | Style ' .. style .. ' | Title ' .. title .. ' | Btn1 ' .. button1 .. ' | Btn2 ' .. button2 .. ' | Text ' .. text)
	end

	if check_stats and (title:find('˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜') or title:find('˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜')) then
		if text:find("˜˜˜") then
			modules.player.data.nick = text:match("{FFFFFF}˜˜˜: {......}%[(.-)]") or text:match("{ffffff}˜˜˜ %(en%.%):%s+{......}([^\n\r]+)")
			modules.player.data.name_surname = text:match("{ffffff}˜˜˜ %(˜˜˜%.%):%s+{......}([^\n\r]+)") or translate(modules.player.data.nick)
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜: ' .. modules.player.data.name_surname, message_color)
        end
		if text:find("˜˜˜:") then
			modules.player.data.sex = text:match("{FFFFFF}˜˜˜: {......}%[(.-)]") or text:match("{ffffff}˜˜˜:%s+{......}([^\n\r]+)")
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜: ' .. modules.player.data.sex, message_color)
		end
		if text:find("˜˜˜˜˜˜˜˜˜˜˜:") then
			modules.player.data.fraction = text:match("{FFFFFF}˜˜˜˜˜˜˜˜˜˜˜: {......}%[(.-)]") or text:match("{ffffff}˜˜˜˜˜˜˜˜˜˜˜:%s+{......}([^\n\r]+)")
			local fraction_data = {
				['˜˜˜˜˜˜˜ ˜˜'] = {'˜˜˜˜', 'police'}, ['˜˜˜˜˜˜˜ LS'] = {'˜˜˜˜', 'police'},
				['˜˜˜˜˜˜˜ ˜˜'] = {'˜˜˜˜', 'police'}, ['˜˜˜˜˜˜˜ LV'] = {'˜˜˜˜', 'police'},
				['˜˜˜˜˜˜˜ ˜˜'] = {'˜˜˜˜', 'police'}, ['˜˜˜˜˜˜˜ SF'] = {'˜˜˜˜', 'police'},
				['˜˜˜˜˜˜˜ ˜˜'] = {'˜˜˜˜', 'police'}, ['˜˜˜˜˜˜˜ VC'] = {'˜˜˜˜', 'police'},
				['˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜'] = {'˜˜˜˜', 'police'}, ['FBI'] = {'˜˜˜', 'fbi'}, ['˜˜˜'] = {'˜˜˜', 'fbi'},
				['˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ LV'] = {'˜˜˜', 'prison'}, ['˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜'] = {'˜˜˜', 'prison'},
				['˜˜˜˜˜ ˜˜'] = {'˜˜˜', 'army'}, ['˜˜˜˜˜ SF'] = {'˜˜˜', 'army'},
				['˜˜˜˜˜ ˜˜'] = {'˜˜˜', 'army'}, ['˜˜˜˜˜ LS'] = {'˜˜˜', 'army'},
				['TV ˜˜˜˜˜˜'] = {'˜˜˜ ˜˜', 'smi'},
				['TV ˜˜˜˜˜˜ ˜˜'] = {'˜˜˜ ˜˜', 'smi'}, ['TV ˜˜˜˜˜˜ LS'] = {'˜˜˜ ˜˜', 'smi'},
				['TV ˜˜˜˜˜˜ ˜˜'] = {'˜˜˜ ˜˜', 'smi'}, ['TV ˜˜˜˜˜˜ LV'] = {'˜˜˜ ˜˜', 'smi'},
				['TV ˜˜˜˜˜˜ ˜˜'] = {'˜˜˜ ˜˜', 'smi'}, ['TV ˜˜˜˜˜˜ SF'] = {'˜˜˜ ˜˜', 'smi'},
				['TV ˜˜˜˜˜˜ ˜˜'] = {'˜˜˜ ˜˜', 'smi'}, ['TV ˜˜˜˜˜˜ VC'] = {'˜˜˜ ˜˜', 'smi'},
				['˜˜˜˜˜˜˜˜ ˜˜'] = {'˜˜˜˜', 'hospital'}, ['˜˜˜˜˜˜˜˜ LS'] = {'˜˜˜˜', 'hospital'},
				['˜˜˜˜˜˜˜˜ ˜˜'] = {'˜˜˜˜', 'hospital'}, ['˜˜˜˜˜˜˜˜ LV'] = {'˜˜˜˜', 'hospital'},
				['˜˜˜˜˜˜˜˜ ˜˜'] = {'˜˜˜˜', 'hospital'}, ['˜˜˜˜˜˜˜˜ SF'] = {'˜˜˜˜', 'hospital'},
				['˜˜˜˜˜˜˜˜ ˜˜'] = {'˜˜˜˜', 'hospital'}, ['˜˜˜˜˜˜˜˜ VC'] = {'˜˜˜˜', 'hospital'},
				['˜˜˜˜˜˜˜˜ Jefferson'] = {'˜˜˜', 'hospital'}, ['˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜'] = {'˜˜˜', 'hospital'},
				['˜˜˜˜˜˜˜˜˜˜˜˜˜ LS'] = {'˜˜˜˜˜', 'gov'}, ['˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜'] = {'˜˜˜˜˜', 'gov'},
				['˜˜˜˜˜'] = {'˜˜˜˜˜', 'judge'},
				['˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜'] = {'˜˜˜', 'lc'},
				['˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜'] = {'˜˜', 'fd'},
				['˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜'] = {'˜˜˜', 'ins'},
				['Russian Mafia'] = {'RM', 'mafia'},
				['Yakuza'] = {'YKZ', 'mafia'},
				['La Cosa Nostra'] = {'LCN', 'mafia'},
				['Warlock MC'] = {'WMC', 'mafia'},
				['Tierra Robada Bikers'] = {'TRB', 'mafia'},
				['Grove Street'] = {'˜˜˜˜', 'ghetto'},
				['Los Santos Vagos'] = {'˜˜˜˜˜', 'ghetto'},
				['East Side Ballas'] = {'˜˜˜˜˜˜', 'ghetto'},
				['Varrios Los Aztecas'] = {'˜˜˜˜˜', 'ghetto'},
				['The Rifa'] = {'˜˜˜˜', 'ghetto'},
				['Night Wolves'] = {'˜˜', 'ghetto'},
				-- Rodina
				['˜˜˜'] = {'˜˜˜', 'fbi'},
				['˜˜˜˜˜'] = {'˜˜', 'army'},
				['˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜'] = {'˜˜˜˜', 'prison'},
				['˜˜˜˜˜˜˜ ˜˜˜˜˜˜'] = {'˜˜˜˜˜', 'police'},
				['˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜'] = {'˜˜˜˜', 'police'},
				['˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜'] = {'˜˜˜˜', 'hospital'},
				['˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜'] = {'˜˜˜', 'hospital'},
				['˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜'] = {'˜˜˜˜', 'lc'},
				['˜˜˜˜˜˜˜˜˜˜˜˜˜'] = {'˜˜˜˜˜', 'gov'},
				['˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜'] = {'˜˜', 'smi'},
				['˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜'] = {'˜˜', 'mafia'},
				['˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜'] = {'˜˜', 'mafia'},
			}
			local data = fraction_data[modules.player.data.fraction]
			local old_fraction_mode = settings.general.fraction_mode
			if data then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜: '..modules.player.data.fraction, message_color)
				modules.player.data.fraction_tag = data[1]
				settings.general.fraction_mode = data[2]
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ '..modules.player.data.fraction_tag .. ". ˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜.", message_color)
				if text:find("˜˜˜˜˜˜˜˜˜:") then
					local rank, rank_number = text:match("{FFFFFF}˜˜˜˜˜˜˜˜˜: {......}(.+)%((%d+)%)(.+)˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜")
					if not rank or not rank_number then
						rank, rank_number = text:match("{ffffff}˜˜˜˜˜˜˜˜˜:%s+{......}([^(]+)%((%d+)%)")
					end
					modules.player.data.fraction_rank = rank
					modules.player.data.fraction_rank_number = tonumber(rank_number)
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜: ' .. modules.player.data.fraction_rank .. " (" .. modules.player.data.fraction_rank_number .. ")", message_color)
					if modules.player.data.fraction_rank_number >= 9 then
						settings.general.auto_uninvite = true
					end
				end
			else
				settings.general.fraction_mode = 'none'
				modules.player.data.fraction_tag = "˜˜˜˜"
				modules.player.data.fraction_rank = "˜˜˜˜"
				modules.player.data.fraction_rank_number = 1
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜!', message_color)
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ (˜˜˜˜ - ˜˜˜˜ - 1).', message_color)
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ - ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜.', message_color)
			end
			if old_fraction_mode ~= '' and old_fraction_mode ~= 'none' and old_fraction_mode ~= settings.general.fraction_mode then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. old_fraction_mode:rupper(), message_color)
				delete_default_fraction_cmds(modules.commands.data.commands.my, get_fraction_cmds(old_fraction_mode, false))
				delete_default_fraction_cmds(modules.commands.data.commands_manage.my, get_fraction_cmds(old_fraction_mode, true))
			end
			import_fraction_data(settings.general.fraction_mode)
		end
		save_settings()
		save_module('player')
		save_module('departament')
		sampSendDialogResponse(dialogid, 0, 0, 0)
		reload_script = true
		thisScript():reload()
		return false
	end

	if ((MODULE.Members.info.check) and (title:find('(.+)%(˜ ˜˜˜˜: (%d+)%)') or title:find('˜ ˜˜˜˜ ˜˜˜˜˜ .+ ˜˜˜.+˜˜˜˜˜˜˜˜˜˜˜'))) then
        local count = 0
        local next_page = false
        local next_page_i = 0
		MODULE.Members.info.fraction = string.match(title, '(.+)%(˜ ˜˜˜˜')
		if MODULE.Members.info.fraction then
			MODULE.Members.info.fraction = string.gsub(MODULE.Members.info.fraction, '{(.+)}', '')
		else
			MODULE.Members.info.fraction = modules.player.data.fraction -- rodina
		end
        for line in text:gmatch('[^\r\n]+') do
            count = count + 1
            if not line:find('˜˜˜˜˜˜˜˜') and (not line:find('˜˜˜') or not line:find('˜˜˜')) then
				local optional_info = ''
				if line:find('{......}%(˜˜%)') then
					line = line:gsub("{......}%(˜˜%)", "")
					optional_info = '(˜˜)'
				end
				if line:find(' %/ ˜ ˜˜˜˜˜˜˜˜˜') then
					line = line:gsub(" %/ ˜ ˜˜˜˜˜˜˜˜˜", "")
					optional_info = optional_info .. ' (JAIL)'
				end
				if line:find(' %/ MUTED') then
					line = line:gsub(" %/ MUTED", "")
					optional_info = optional_info .. ' (MUTE)'
				end
				if optional_info == '' then
					optional_info = '-'
				end
				if line:find('{......}%(%d+.+%)') then
					local color, nickname, id, rank, rank_number, color2, rank_time, warns, afk = string.match(line, "{(%x%x%x%x%x%x)}([%w_]+)%((%d+)%)%s*([^%(]+)%((%d+)%)%s*{(%x%x%x%x%x%x)}%(([^%)]+)%)%s*{FFFFFF}(%d+)%s*%[%d+%]%s*/%s*(%d+)%s*%d+ ˜˜")
					if color ~= nil and nickname ~= nil and id ~= nil and rank ~= nil and rank_number ~= nil and warns ~= nil and afk ~= nil then
						local working = false
						if color:find('90EE90') then
							working = true
						end
						if rank_time then
							rank_number = rank_number .. ') (' .. rank_time
						end
						table.insert(MODULE.Members.new, { nick = nickname, id = id, rank = rank, rank_number = rank_number, warns = warns, afk = afk, working = working, info = optional_info})
					end
				else
					local color, nickname, id, rank, rank_number, rank_time, warns, afk = string.match(line, "{(%x%x%x%x%x%x)}%s*([^%(]+)%((%d+)%)%s*([^%(]+)%((%d+)%)%s*([^{}]+){FFFFFF}%s*(%d+)%s*%[%d+%]%s*/%s*(%d+)%s*%d+ ˜˜")
					if color ~= nil and nickname ~= nil and id ~= nil and rank ~= nil and rank_number ~= nil and warns ~= nil and afk ~= nil then
						local working = false
						if color:find('90EE90') then
							working = true
						end
						table.insert(MODULE.Members.new, { nick = nickname, id = id, rank = rank, rank_number = rank_number, warns = warns, afk = afk, working = working, info = optional_info})
					end
				end
				if not rank or not nickname then -- rodina
					local nickname, id, rank, rank_number, warns = line:match("(.+)%((%d+)%)%s+(.+)%((%d+)%).+(%d) / 3")
					if nickname and id and rank and rank_number and warns then
						table.insert(MODULE.Members.new, { nick = nickname, id = id, rank = rank, rank_number = rank_number, warns = warns, afk = 0, working = true, info = optional_info})
					end
				end
            end
            if line:match('˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜') then
                next_page = true
                next_page_i = count - 2
            end
        end
        if next_page then
            sampSendDialogResponse(dialogid, 1, next_page_i, 0)
            next_page = false
            next_pagei = 0
		elseif #MODULE.Members.new ~= 0 then
            sampSendDialogResponse(dialogid, 0, 0, 0)
			MODULE.Members.all = MODULE.Members.new
			MODULE.Members.info.check = false
			if not settings.general.auto_update_members then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /mb /helper - ˜˜˜˜˜˜˜ ' .. modules.player.data.fraction_tag .. '!', message_color)
			end
			MODULE.Members.Window[0] = true
			MODULE.Members.upd.check = false
		else
			sampSendDialogResponse(dialogid, 0, 0, 0)
			sampAddChatMessage('[Furry Helper]{ffffff} ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜!', message_color)
			MODULE.Members.info.check = false
			MODULE.Members.upd.check = false
        end
        return false
    end

	if modules.player.data.fraction_rank_number >= 9 then
		if title:find('˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜ (.+)') and text:find('˜˜˜˜˜˜˜˜') then -- invite
			sampSendDialogResponse(dialogid, 1, 0, 0)
			return false
		end
		if MODULE.LeadTools.spawncar and title:find('$') and text:find('˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜') then -- ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ 
			local count = 0
			for line in text:gmatch('[^\r\n]+') do
				if line:find('˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜') then
					sampSendDialogResponse(dialogid, 1, count, 0)
					MODULE.LeadTools.spawncar = false
					return false
				else
					count = count + 1
				end
			end
		end
		if MODULE.LeadTools.vc_vize.bool then -- ˜˜˜˜ ˜˜˜ ˜˜
			if text:find('˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ Vice City') then
				local count = 0
				for line in text:gmatch('[^\r\n]+') do
					if line:find('˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ Vice City') then
						sampSendDialogResponse(dialogid, 1, count, 0)
						return false 
					else
						count = count + 1
					end
				end
			end
			if title:find('˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ Vice City') then
				MODULE.LeadTools.vc_vize.bool = false
				sampSendDialogResponse(dialogid, 1, 0, tostring(MODULE.LeadTools.vc_vize.player_id))
				sampSendChat("/r ˜˜˜˜˜˜˜˜˜˜ "..translate(sampGetPlayerNickname(tonumber(MODULE.LeadTools.vc_vize.player_id))).." ˜˜˜˜˜˜ ˜˜˜˜ Vice City!")
				return false 
			end	
			if title:find('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ Vice City') then
				MODULE.LeadTools.vc_vize.bool = false
				sampSendChat("/r ˜ ˜˜˜˜˜˜˜˜˜˜ "..translate(sampGetPlayerNickname(tonumber(MODULE.LeadTools.vc_vize.player_id))).." ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ Vice City!")
				sampSendDialogResponse(dialogid, 1, 0, tostring(sampGetPlayerNickname(MODULE.LeadTools.vc_vize.player_id)))
				return false 
			end
		end
		if (MODULE.LeadTools.platoon.check) then
			if text:find('˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜') and text:find('˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜') then
				sampSendDialogResponse(dialogid, 1, 3, 0)
				return false 
			end
			if text:find('{FFFFFF}˜˜˜˜˜˜˜ {FB8654}ID{FFFFFF} ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜') then
				sampSendDialogResponse(dialogid, 1, 0, MODULE.LeadTools.platoon.player_id)
				MODULE.LeadTools.platoon.check = false
				return false 
			end
		end
		if (MODULE.LeadTools.cleaner.uninvite) then
			if title:find('$') and text:find('˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜') then
				sampSendDialogResponse(dialogid, 1, 1, 0)
				return false 
			end
			if text:find('˜˜˜˜˜˜ ˜˜˜˜˜˜') and text:find("˜˜˜˜˜˜ ˜˜˜˜˜˜˜") then
				sampSendDialogResponse(dialogid, 1, 1, 0)
				return false 
			end
			if title:find('˜˜˜˜˜˜˜˜˜˜ %(˜˜˜˜˜˜˜%)') then
				local counter = -1
				for line in text:gmatch('([^\n\r]+)') do
					counter = counter + 1
					if line:find("{FFFFFF}(.+)%s+(%d+) ˜˜˜˜") then
						local nick, days = line:match("{FFFFFF}(.+)%s+(%d+) ˜˜˜˜")
						if days and tonumber(days) >= tonumber(MODULE.LeadTools.cleaner.day_afk) then
							table.insert(MODULE.LeadTools.cleaner.players_to_kick, {nickname = nick, day = days})
						end            
					elseif line:find('{B0E73A}˜˜˜˜˜˜') then
						sampSendDialogResponse(dialogid, 1, counter - 1, "")
						return false
					end
				end 
				if #MODULE.LeadTools.cleaner.players_to_kick > 0 then
					sampAddChatMessage('[Furry Helper] {ffffff} ˜˜˜˜˜˜˜ ' .. #MODULE.LeadTools.cleaner.players_to_kick .. ' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. MODULE.LeadTools.cleaner.day_afk .. " ˜˜˜˜ ˜˜ ˜ ˜˜˜˜!", message_color)
					lua_thread.create(function()
						for index, value in ipairs(MODULE.LeadTools.cleaner.players_to_kick) do
							MODULE.LeadTools.cleaner.reason_day = value.day
							sampSendChat('/uninviteoff ' .. value.nickname)
							printStringNow(index .. '/' .. #MODULE.LeadTools.cleaner.players_to_kick, 2000)
							wait(2000)
						end
						MODULE.LeadTools.cleaner.uninvite = false
					end)
				else
					sampAddChatMessage('[Furry Helper] {ffffff} ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. MODULE.LeadTools.cleaner.day_afk .. " ˜˜˜˜ ˜˜ ˜ ˜˜˜˜!",  message_color)
				end
				sampSendDialogResponse(dialogid, 2, 0, 0)
				return false
			end
			if MODULE.LeadTools.cleaner.uninvite and text:find("˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜(.+)˜˜˜˜˜˜˜˜˜˜(.+)˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜") then
				sampSendDialogResponse(dialogid, 1,  0, '˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ (' .. MODULE.LeadTools.cleaner.reason_day .. ' ˜˜˜˜ ˜˜ ˜ ˜˜˜˜)')
				return false
			end
		end
		if (MODULE.LeadTools.sell_rank.checker) then
			if (title:find('$') and text:find('˜˜˜˜˜˜˜ ˜˜˜˜')) then
				local count = 0
				for line in text:gmatch('[^\r\n]+') do
					if (line:find('˜˜˜˜˜˜˜ ˜˜˜˜')) then
						sampSendDialogResponse(dialogid, 1, count, 0)
					else
						count = count + 1
					end
				end
			elseif (title:find('˜˜˜˜˜ ˜˜˜˜˜˜') and text:find(MODULE.LeadTools.sell_rank.player_id)) then
				local count = 0
				for line in text:gmatch('[^\r\n]+') do
					if (line:find(MODULE.LeadTools.sell_rank.player_id)) then
						sampSendDialogResponse(dialogid, 1, count-1, 0)
					else
						count = count + 1
					end
				end
				MODULE.LeadTools.sell_rank.checker = false
			end
			return false
		end
	end

	if isMode('gov') then
		if settings.gov.anti_trivoga and (text:find('˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜?') or text:find('˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ {FFA11C}˜˜˜˜˜˜˜{FFFFFF} ˜˜˜˜˜˜˜?')) then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜. ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ /helper - ˜˜˜˜˜˜˜ ˜˜˜˜˜', message_color)
			sampSendDialogResponse(dialogid, 2, 0, 0)
			return false
		end
		if MODULE.Zeks.checker and title:find("˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜") then
			for line in text:gmatch('[^\r\n]+') do
				local clean_line = line:gsub('{........}', ''):gsub('{......}', ''):gsub('{(...)}', '')
				local nick, id, time, kpz, adv = clean_line:match('([%w_]+)%((%d+)%)\t(%d+).-\t(.-)\t(.-)$')
				if nick and id and time and kpz and kpz ~= "˜˜˜˜˜˜˜˜˜˜" and adv then
					if adv == '˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜' then adv = '-' else adv = adv:gsub('˜˜˜˜˜˜˜:', '')  end
					
					table.insert(MODULE.Zeks.new, {nick = nick, id = id, time = time, kpz = kpz, adv = adv})
				end
			end
			MODULE.Zeks.checker = false
			if #MODULE.Zeks.new == 0 then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜˜ /zeks ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜: ' .. message_color_hex .. #MODULE.Zeks.new, message_color)
				MODULE.Zeks.all = MODULE.Zeks.new
				MODULE.Zeks.updzeks.stop = false
				MODULE.Zeks.updzeks.time = 0
				MODULE.Zeks.updzeks.last_time = os.time()
				MODULE.Zeks.updzeks.check = true
				MODULE.Zeks.Window[0] = true
			end
			sampSendDialogResponse(dialogid, 1, 0, 0)
			return false
		end
	end

	if settings.general.auto_accept_docs then
		if (title:find('˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜', 1, true) and (text:find('˜˜˜˜˜˜˜', 1, true) or text:find('˜˜˜˜˜˜˜˜', 1, true) or text:find('˜˜˜', 1, true))) then
			if text:find('˜˜˜˜˜') then
				sampSendDialogResponse(dialogid, 1, 0, 0)
				return false
			elseif text:find('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜') then
				local doc_type = '˜˜˜˜˜˜˜˜'
				if text:find('˜˜˜˜˜˜˜') then
					doc_type = '˜˜˜˜˜˜˜'
				elseif text:find('˜˜˜') then
					doc_type = '˜˜˜.˜˜˜˜˜'
				elseif text:find('˜˜˜˜˜˜˜˜') then
					doc_type = '˜˜˜˜˜˜˜˜'
				end
				sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜...', message_color)
				MODULE.Binder.state.isActive = true
				sampSendChat('/me ˜˜˜˜ ' .. doc_type .. ' ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜')
				sampSendDialogResponse(dialogid, 1, 2, '')
				MODULE.Binder.state.isActive = false
				return false
			end
		end
		if (title:find('˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜') and (text:find('˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜') or text:find('˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜') or text:find('˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜(.+)˜˜˜˜˜'))) then
			lua_thread.create(function()
				wait(1000)
				sampSendDialogResponse(dialogid, 1, 2, '')
			end)
			return false
		end
	end
	
	if isMode('police') or isMode('fbi') then
		if text:find('˜˜˜') and text:find('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜') and text:find('˜˜˜˜˜˜˜˜˜˜') and MODULE.Wanted.checker then
			local text = string.gsub(text, '%{......}', '')
			text = string.gsub(text, '˜˜˜%s+˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜%s+˜˜˜˜˜˜˜˜˜˜\n', '')
			for line in string.gmatch(text, '[^\n]+') do
				local nick, id, lvl, dist = string.match(line, '(%w+_%w+)%((%d+)%)%s+(%d) ˜˜˜˜˜˜˜%s+%[(.+)%]')
				if nick and id and lvl and dist then
					if dist:find('˜ ˜˜˜˜˜˜˜˜˜') then
						dist = '˜ ˜˜˜˜'
					end
					table.insert(MODULE.Wanted.new, {nick = nick, id = id, lvl = lvl, dist = dist})
				end
			end
			sampSendDialogResponse(dialogid, 0, 0, 0)
			return false
		end
	end
	
	if (isMode('hospital')) then
		if text:find("˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜") or text:find('˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜') then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜. ˜˜˜˜˜', message_color)
			sampSendDialogResponse(dialogid, 1, 0, 0)
			return false
		end
		-- rodina
		if title:find('˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜') and text:find('˜˜ ˜˜˜˜˜˜˜˜˜') and text:find('˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜') then
			sampSendDialogResponse(dialogid, 1, MODULE.Binder.tag.get_medcard_status(), 0)
			return false
		end
		if title:find('˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜') and text:find('˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜') then
			local days = {[0] = '7', [1] = '14', [2] = '30', [3] = '60'}
			local day = days[MODULE.Binder.tag.get_medcard_days()]
			sampSendDialogResponse(dialogid, 1, 0, day)
			return false
		end
		if title:find('˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜') and text:find('˜˜˜˜˜˜˜˜ ˜˜˜˜˜.+˜˜˜˜˜˜˜ ˜˜˜˜˜') then
			sampSendDialogResponse(dialogid, 1, 0, MODULE.Binder.tag.get_medcard_price())
			return false
		end
	end

	if isMode('smi') then
		if MODULE.SmiEdit.skip_dialog then
			sampSendDialogResponse(dialogid, 0, 0, 0)
			MODULE.SmiEdit.skip_dialog = false
			sampSendChat('/newsredak')
			return false
		end
		if title:find('˜˜˜˜˜˜˜˜˜˜˜˜˜˜') and text:find('˜˜˜˜˜˜˜˜˜˜ ˜˜') and text:find('˜˜˜˜˜˜˜˜˜') then
			MODULE.SmiEdit.is_active_ad = true
			MODULE.SmiEdit.ad_dialog_id = dialogid
			for line in text:gmatch("[^\n]+") do
				if line:find('^{FFFFFF}˜˜˜˜˜˜˜˜˜˜ ˜˜ {FFD700}˜˜˜˜˜˜˜˜˜˜˜ (.+) %(˜˜˜˜˜˜') then
					MODULE.SmiEdit.ad_from = line:match('{FFFFFF}˜˜˜˜˜˜˜˜˜˜ ˜˜ {FFD700}˜˜˜˜˜˜˜˜˜˜˜ (.+) %(˜˜˜˜˜˜')
				elseif line:find('^{FFFFFF}˜˜˜˜˜˜˜˜˜˜ ˜˜ {FFD700}˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ (.+),') then
					MODULE.SmiEdit.ad_from = line:match('{FFFFFF}˜˜˜˜˜˜˜˜˜˜ ˜˜ {FFD700}˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ (.+),')
				elseif line:find('^{FFFFFF}˜˜˜˜˜˜˜˜˜˜ ˜˜ {FFD700}(.+),') then
					MODULE.SmiEdit.ad_from = line:match('{FFFFFF}˜˜˜˜˜˜˜˜˜˜ ˜˜ {FFD700}(.+),')
				end
				if line:find('{FFFFFF}˜˜˜˜˜˜˜˜˜:%s+{33AA33}(.+)') then
					MODULE.SmiEdit.ad_message = line:match('{FFFFFF}˜˜˜˜˜˜˜˜˜:%s+{33AA33}(.+)')
				elseif line:find('˜˜˜˜˜˜˜˜˜%:.+{33AA33}(.+){FFFFFF}') then -- rodina
					MODULE.SmiEdit.ad_message = line:match('˜˜˜˜˜˜˜˜˜%:.+{33AA33}(.+){FFFFFF}')
				end
			end
			MODULE.SmiEdit.Window[0] = true
			return false
		end
		if (title:find('˜˜˜˜˜˜˜˜˜˜˜˜˜˜') and text:find('˜˜˜˜˜˜˜') and text:find('˜˜˜˜˜˜˜˜˜˜˜˜˜˜')) then
			sampSendDialogResponse(dialogid, 1, 0, 0)
			return false
		end
		if title:find('˜˜˜˜˜˜˜˜') or title:find('˜˜˜˜˜˜˜˜ ˜˜.˜˜˜˜˜˜˜%:') then
			if text:find('˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜') then
				sampSendDialogResponse(dialogid, 1, 0, 0)
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜!', message_color)
				return false
			else
				if settings.smi.auto_select_first_ad then
					local index = -1
					local finded = false
					for line in text:gmatch('[^\n]+') do
						if line:find('%[%d+%]') and not line:find('˜ ˜˜˜˜˜˜˜˜') then
							sampSendDialogResponse(dialogid, 1, index, 0)
							finded = true
							break
						else
							index = index + 1
						end
					end
					if finded then return false end
				end
			end
		end 
		if title:find('˜˜˜˜˜˜˜˜ ˜ ˜˜.˜˜˜˜˜˜˜˜') and button1:find('˜˜˜˜˜˜˜˜') then -- rodina
			sampSendDialogResponse(dialogid, 1, 0, 0)	
			return false
		end
	end
	
	if (isMode('lc')) then
		if title:find("˜˜˜˜˜˜˜˜ ˜˜˜˜˜") and (title:find("Los Santos") or title:find("San Fierro") or title:find("Las Venturas") or title:find("Lav Venturas")) and settings.lc.auto_find_clorest_znak then
			-- ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ https://www.blast.hk/threads/231943/ by ˜˜˜˜˜˜˜˜
			local count = 0
			local znaks = {}
			for line in text:gmatch('[^\r\n]+') do
				count = count + 1
				if not line:find('˜˜˜˜˜˜˜˜ ˜˜˜˜˜') and not line:find('˜˜˜˜˜˜˜˜˜˜') then
					line = string.gsub(line, "%%", "")
					line = string.gsub(line, "{[0-9a-fA-F]+}", "")
					local num, name, dist, damage, status = string.match(line, '%[(%d+)%] ([^\t]+)\t([0-9%.]+)..˜\t(%d*)\t(.*)')
					if name == nil then
						num, name, dist, status = string.match(line, '%[(%d+)%] ([^\t]+)\t([0-9%.]+)..˜\t.*\t(.*)')
						damage = 100
					end
					table.insert(znaks, {number = num, name = name, distance = dist, health = damage, status = status})
				end
			end
			local min_dist = 999999
			local nearest = nil
			for i, znak in ipairs(znaks) do
				local dist = tonumber(znak.distance)
				if dist and dist < min_dist then
					min_dist = dist
					nearest = znak
				end
			end
			if not nearest then
				sampAddChatMessage("[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜!", message_color)
				sampSendDialogResponse(dialogid, 0, 0, "")
			else
				sampAddChatMessage("[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜˜ " .. message_color_hex .. "˜" .. nearest.number .. " {ffffff}(˜˜˜˜˜˜˜˜˜ " .. message_color_hex .. nearest.distance .. "˜{ffffff}, ˜˜˜˜˜˜ " .. message_color_hex .. nearest.status .. "{ffffff})", message_color)
				sampSendDialogResponse(dialogid, 1, nearest.number-1, "")
			end
			return false
		end
	end
	
	if isMode('fd') then
		if title:find('˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜') then
			if text:find('˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜') then
				sampAddChatMessage('[Furry Helper] {ffffff}˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', message_color)
				sampSendDialogResponse(dialogid, 1, 0, 0)
				return false
			else
			-- 	MODULE.Fires.dialogId = dialogid
			-- 	MODULE.Fires.isDialog = true
				MODULE.Fires.locations = text:match('˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜\n(.+)') .. '\n'
			-- 	sampShowDialog(999, title, text, button1, button2, style)
			end
		end
	end

	if isMode('ins') then
		if settings.ins.anti_trivoga and (text:find('˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜?') or text:find('˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ {FFA11C}˜˜˜˜˜˜˜{FFFFFF} ˜˜˜˜˜˜˜?')) then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜. ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ /helper - ˜˜˜˜˜˜˜ ˜˜˜', message_color)
			sampSendDialogResponse(dialogid, 2, 0, 0)
			return false
		end
		if (settings.ins.auto_input_ticket and title:find('˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜')) then
			local nick = text:match("{ffff00}([%w_]+)")
			local types = text:match("{ffff00}(%w+)")
			local number = text:match("{ffff00}(%d+)")
			sampSendDialogResponse(dialogid, 1, 0, nick or types or number or '')
			return false
		end
		if title:find('˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜') then
			if text:find('˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜') then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜!', message_color)
				sampSendDialogResponse(dialogid, 1, 0, 0)
				return false
			end
		end
	end

end
function sampev.onCreate3DText(id, color, position, distance, testLOS, attachedPlayerId, attachedVehicleId, text_3d)
   	if MODULE.DEBUG then
		
	end
	if text_3d and ((isMode('gov') and settings.gov.anti_trivoga) or (isMode())) then
		if text_3d:find('˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜') or text_3d:find('˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜') then
			sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜.', message_color)
			return false
		end	
	end
end
function sampev.onPlayerChatBubble(player_id, color, distance, duration, message)
	if MODULE.DEBUG then
		sampAddChatMessage('[ChatBubble] {ffffff}ID ' .. player_id .. ' | Color ' .. color .. ' | Dist ' .. distance .. ' | Duration ' .. duration .. ' | MSG ' .. message, message_color)
		print('[ChatBubble] {ffffff}ID ' .. player_id .. ' | Color ' .. color .. ' | Dist ' .. distance .. ' | Duration ' .. duration .. ' | MSG ' .. message)
	end
	if (isMode('police') or isMode('fbi') or isMode('prison')) and settings.mj.anti_screpki then
		if message:find("(.+) ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜") then
			local nick = message:match(' (.+) ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜')
			local id = sampGetPlayerIdByNickname(nick)
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜! ' .. nick .. '[' .. id .. '] ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!', message_color)
			play_sound()
			local result, handle = sampGetCharHandleBySampPlayerId(id)
			if result then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				if getDistanceBetweenCoords3d(mx, my, mz, x, y, z) <= 1.5 then
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜...', message_color)
					find_and_use_command('/bot {id}', id)
				else
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ' .. nick .. ' ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /bot ' .. id, message_color)
				end
			elseif (IS_MOBILE and modules.commands.path:find('git')) then -- x64 ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ' .. nick .. ' ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /bot ' .. id, message_color)
			end
		end
	end
end
function sampev.onTogglePlayerControllable(controllable)
  	if MODULE.CruiseControl.active and not controllable then
		MODULE.CruiseControl.active = false
		clearCharTasks(PLAYER_PED)
		if isCharInAnyCar(PLAYER_PED) then
			taskWarpCharIntoCarAsDriver(PLAYER_PED, storeCarCharIsInNoSave(PLAYER_PED))
		end
  	end
end
addEventHandler('onSendPacket', function(id, bs, priority, reliability, orderingChannel)
	if id == 220 then
		local idd = raknetBitStreamReadInt8(bs)
		local packettype = raknetBitStreamReadInt8(bs)
		if IS_MOBILE then
			local subtype = raknetBitStreamReadInt8(bs)
			if packettype == 66 or packettype == 63 then
				if MODULE.DEBUG then
					local unr = raknetBitStreamGetNumberOfUnreadBits(bs)
					local unrs = {}
					for i = 1, 8, 1 do
						table.insert(unrs, raknetBitStreamReadInt8(bs))
					end
					print('[SendPacket] 220 ' .. packettype .. ' ' .. subtype .. ' | Unread bits ' .. unr .. ' : ' .. table.concat(unrs, ' '))
					sampAddChatMessage('[SendPacket] 220 ' .. packettype .. ' ' .. subtype .. ' | Unread bits ' .. unr .. ' : ' .. table.concat(unrs, ' '), message_color)
				end
			end
		else
			local strlen = raknetBitStreamReadInt16(bs)
			local str = raknetBitStreamReadString(bs, strlen)
			if packettype ~= 0 and packettype ~= 1 and #str > 2 then
				if MODULE.DEBUG then
					sampAddChatMessage('[SendPacket] {ffffff}' .. str, message_color)
					print("[SendPacket] " .. str)
				end
			end
		end
	end
end)
addEventHandler('onReceivePacket', function(id, bs)
	if id == 220 then
		local id = raknetBitStreamReadInt8(bs)
        local cmd = raknetBitStreamReadInt8(bs)
		-- if MODULE.DEBUG then
			-- local function dumpFullBitStream(bs)
			-- 	local bitsLeft = raknetBitStreamGetNumberOfUnreadBits(bs)
			-- 	if not bitsLeft then
			-- 		print("dumpFullBitStream: raknetBitStreamGetNumberOfUnreadBits ˜˜˜˜˜˜!")
			-- 		return
			-- 	end
			-- 	local bytesLeft = math.floor(bitsLeft / 8)
			-- 	if bytesLeft == 0 then
			-- 		print("dumpFullBitStream: ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜")
			-- 		return
			-- 	end
			-- 	local bytes = {}
			-- 	for i = 1, bytesLeft do
			-- 		bytes[i] = raknetBitStreamReadInt8(bs)
			-- 	end
			-- 	local hexStrParts = {}
			-- 	for i, b in ipairs(bytes) do
			-- 		hexStrParts[i] = string.format("%02X", b)
			-- 	end
			-- 	return(table.concat(hexStrParts, " "))
			-- end
			-- local dump = dumpFullBitStream(bs)
			-- sampAddChatMessage('[ReceivePacket] {ffffff}' .. dump, message_color)
			-- print("[ReceivePacket] " .. dump)
		-- end
		if cmd == 153 then
            local carId = raknetBitStreamReadInt16(bs)
            raknetBitStreamIgnoreBits(bs, 8)
            local numberlen = raknetBitStreamReadInt8(bs)
            local plate_number = raknetBitStreamReadString(bs, numberlen)
            local typelen = raknetBitStreamReadInt8(bs)
            local numType = raknetBitStreamReadString(bs, typelen)
            modules.arz_veh.cache[carId] = {
                carID = carId or 0,
                number = plate_number or "",
                region = numType or "",
            }
        end
		if IS_MOBILE then 
			if cmd == 84 then
				local unk1 = raknetBitStreamReadInt8(bs)
				local unk2 = raknetBitStreamReadInt8(bs)
				local len = raknetBitStreamReadInt16(bs)
				local encoded = raknetBitStreamReadInt8(bs)
				local string = encoded == 0 and raknetBitStreamReadString(bs, len) or raknetBitStreamDecodeString(bs, len + encoded)
				if MODULE.DEBUG then
					sampAddChatMessage('[ReceivePacket] {ffffff}' .. string, message_color)
					print("[ReceivePacket] " .. string)
				end
			end
		else
			if cmd == 17 then
				raknetBitStreamIgnoreBits(bs, 32)
				local length = raknetBitStreamReadInt16(bs)
				local encoded = raknetBitStreamReadInt8(bs)
				local cmd = (encoded ~= 0) and raknetBitStreamDecodeString(bs, length + encoded) or raknetBitStreamReadString(bs, length)
				
				if MODULE.DEBUG then
					sampAddChatMessage('[ReceivePacket] {ffffff}' .. cmd, message_color)
					print("[ReceivePacket] " .. cmd)
				end

				if (cmd:find('findGame') and cmd:find(' ˜˜˜˜˜˜˜˜˜˜","˜˜˜˜˜˜˜ ')) then
					if ((not isMode('ins')) or (isMode('ins') and settings.ins.hint_in_sort)) then
						local find = cmd:match('%[.+%[(.+)%]%]')
						local nums = {}
						for n in find:gmatch("%d+") do table.insert(nums, tonumber(n)) end
						table.sort(nums)
						for i = 1, #nums do nums[i] = nums[i] + 1 end
						local result = table.concat(nums, ", ")
						sampAddChatMessage("[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜: " .. result .. ". ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜", message_color)
						sampShowDialog(897124, 'Arizona Helper - ˜˜˜˜˜˜˜˜˜', "˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜: " .. result .. ".\n˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜", '{009EFF}˜˜˜˜˜˜˜', '', 0)
					end
				end
			end
		end
	end
end)
addEventHandler('onReceiveRpc', function(id, bs)
	if id == 123 then
        local carId = raknetBitStreamReadInt16(bs)
        local numLen = raknetBitStreamReadInt8(bs)
		local plate_number = raknetBitStreamReadString(bs, numLen)
		modules.arz_veh.cache[carId] = {
			carID = carId or 0,
			number = plate_number or "",
			type = "ARZ"
		}
	end
end)
--------------------------------------------- INIT GUI --------------------------------------------
imgui.OnInitialize(function()
	imgui.GetIO().IniFilename = nil
	imgui.GetIO().Fonts:Clear()

	local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
	if IS_MOBILE then
		MODULE.FONT = imgui.GetIO().Fonts:AddFontFromFileTTF(worked_dir .. '/lib/mimgui/trebucbd.ttf', 14 * settings.general.custom_dpi, _, glyph_ranges)
	else
		MODULE.FONT = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14)..'\\trebucbd.ttf', 14 * settings.general.custom_dpi, _, glyph_ranges)
	end

	fa.Init(14 * settings.general.custom_dpi)
	for key, value in pairs(fa) do
		if key ~= 'Init' then table.insert(MODULE.Icons.keys, key) end
	end
	table.sort(MODULE.Icons.keys)

	if settings.general.helper_theme == 0 and monet_no_errors then
		apply_moonmonet_theme()
	elseif settings.general.helper_theme == 1 then
		apply_dark_theme()
	elseif settings.general.helper_theme == 2 then
		apply_white_theme()
	end

	imgui.GetIO().ConfigFlags = imgui.ConfigFlags.NoMouseCursorChange

	function TextEditCallback(data)
		MODULE.INPUT.CURSOR_POS = data.CursorPos
		if data.CursorPos ~= MODULE.INPUT.CURSOR_POS or data.SelectionStart ~= MODULE.INPUT.SELECTION_START or data.SelectionEnd ~= MODULE.INPUT.SELECTION_END then
			MODULE.INPUT.USER_MOVED_CURSOR = true
		end
		MODULE.INPUT.SELECTION_START = data.SelectionStart
		MODULE.INPUT.SELECTION_END = data.SelectionEnd
		return 0
	end
	TextEditCallback = ffi.cast('int (*)(ImGuiInputTextCallbackData* data)', TextEditCallback)

end)

imgui.OnFrame(
    function() return MODULE.Initial.Window[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(fa.GEARS .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ Arizona Helper ' .. fa.GEARS, MODULE.Initial.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
        change_dpi()
		if MODULE.Initial.step == 0 then
			if (doesFileExist(config_dir .. '/Resourse/logo.png')) then
				if (not _G.helper_logo) then
					local path = config_dir .. '/Resourse/logo.png'
					_G.helper_logo = imgui.CreateTextureFromFile(path)
				else
					imgui.Image(_G.helper_logo, imgui.ImVec2(520 * settings.general.custom_dpi, 150 * settings.general.custom_dpi))
				end
			else
				if imgui.BeginChild('##init1_1', imgui.ImVec2(520 * settings.general.custom_dpi, 150 * settings.general.custom_dpi), true) then
					imgui.Text("\n\n\n")
					imgui.CenterTextDisabled(u8('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜!\n\n'))
					imgui.CenterTextDisabled(u8('˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ VPN ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜'))
					imgui.CenterTextDisabled(u8('https://github.com/MTGMODS/arizona-helper'))
					imgui.EndChild()
				end
			end
			imgui.CenterText(u8("˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜"))
			imgui.CenterText(u8("˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜"))
			imgui.Separator()
			imgui.CenterText(u8("˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜:"))
			if imgui.CenterButton(fa.CIRCLE_ARROW_RIGHT .. u8(' ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ /stats (˜˜˜˜˜˜˜˜˜˜˜˜˜) ') .. fa.CIRCLE_ARROW_LEFT) then
				check_stats = true
				sampSendChat('/stats')
				MODULE.Initial.Window[0] = false
			end
			if imgui.CenterButton(fa.CIRCLE_ARROW_RIGHT .. u8(' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜) ') .. fa.CIRCLE_ARROW_LEFT) then
				MODULE.Initial.fraction_type_selector = 0
				MODULE.Initial.step = 1
			end
			imgui.Separator()
			imgui.CenterText(u8("˜˜˜˜ ˜˜˜, ˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜"))
		elseif MODULE.Initial.step == 1 then
			imgui.CenterText(u8('˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜:'))

			local function render_org_block(org_num, icon, name, fractions, tags)
				if imgui.BeginChild('##init1_'..org_num, imgui.ImVec2(170 * settings.general.custom_dpi, 45 * settings.general.custom_dpi), (MODULE.Initial.fraction_type_selector == org_num)) then
					if not (MODULE.Initial.fraction_type_selector == org_num) then
						imgui.SetCursorPos(imgui.ImVec2(0, 5 * settings.general.custom_dpi))
					end
					imgui.CenterText(icon .. u8(' '..name))
					imgui.CenterTextDisabled(u8(fractions))
					imgui.EndChild()
				end
				if imgui.IsItemClicked() then
					MODULE.Initial.fraction_type_selector = org_num
					MODULE.Initial.fraction_type_selector_text = name
					MODULE.Initial.fraction_type_icon = icon
				end
			end
			render_org_block(1, fa.BUILDING_SHIELD, '˜˜˜.˜˜˜˜˜˜˜', '˜˜˜˜/˜˜˜˜/˜˜˜˜/˜˜˜/˜˜˜')
			imgui.SameLine()
			render_org_block(2, fa.HOSPITAL, '˜˜˜.˜˜˜˜˜.', '˜˜˜˜/˜˜˜˜/˜˜˜˜/˜˜˜')
			imgui.SameLine()
			render_org_block(3, fa.BUILDING_SHIELD, '˜˜˜.˜˜˜˜˜˜˜', '˜˜˜/˜˜˜/˜˜/˜˜˜/˜˜˜˜')
			render_org_block(4, fa.BUILDING_NGO, '˜˜˜˜.˜˜˜˜˜', '˜˜˜ ˜˜/˜˜/˜˜/˜˜/˜˜')
			imgui.SameLine()
			render_org_block(5, fa.BUILDING_COLUMNS, '˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', '˜˜˜˜˜/˜˜˜/˜˜˜/˜˜˜˜')
			imgui.SameLine()
			render_org_block(6, fa.HOTEL, '˜˜˜˜˜˜˜˜ ˜˜˜˜˜', '˜˜')
			render_org_block(7, fa.TORII_GATE, '˜˜˜˜˜', 'YKZ/LCN/RM/WMC/TRB')
			imgui.SameLine()
			render_org_block(8, fa.BUILDING_WHEAT, '˜˜˜˜˜', '˜˜˜˜/˜˜˜˜˜/˜˜˜˜/˜˜˜˜˜')
			imgui.SameLine()
			render_org_block(0, fa.BUILDING_CIRCLE_XMARK, '˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜ & ˜˜˜˜˜˜˜')

			if imgui.Button(fa.CIRCLE_ARROW_LEFT .. u8(' ˜˜˜˜˜'), imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				MODULE.Initial.step = 0
			end
			imgui.SameLine()
			if imgui.Button(u8('˜˜˜˜˜˜˜ "' .. MODULE.Initial.fraction_type_selector_text .. '" ') .. fa.CIRCLE_ARROW_RIGHT, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				MODULE.Initial.slider[0] = 1
				if MODULE.Initial.fraction_type_selector == 6 then
					MODULE.Initial.step2_result = 61
					MODULE.Initial.step = 3
				elseif MODULE.Initial.fraction_type_selector == 0 then
					modules.player.data.fraction_rank = '˜˜˜˜'
					modules.player.data.fraction_rank_number = 0
					MODULE.Initial.step = 4
				else
					MODULE.Initial.step = 2
				end
			end
		elseif MODULE.Initial.step == 2 then
    		imgui.CenterText(u8('˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ "' .. MODULE.Initial.fraction_type_selector_text .. '":'))

			local function render_fraction_block(org_num, name, fraction_tag)
				if imgui.BeginChild('##init2_'..org_num, imgui.ImVec2(170 * settings.general.custom_dpi, 45 * settings.general.custom_dpi), (MODULE.Initial.fraction_selector == org_num)) then
					if not (MODULE.Initial.fraction_selector == org_num) then
						imgui.SetCursorPos(imgui.ImVec2(0, 5 * settings.general.custom_dpi))
					end
					imgui.CenterText(u8(name))
					imgui.CenterTextDisabled(u8(fraction_tag))
					imgui.EndChild()
				end
				if imgui.IsItemClicked() then
					MODULE.Initial.fraction_selector = org_num
					MODULE.Initial.fraction_selector_text = name
					MODULE.Initial.step2_result = (MODULE.Initial.fraction_type_selector * 10) + org_num
				end
			end
			local orgs = {
				[1] = {
					{name = "˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜˜", 			tag = "˜˜˜˜"},
					{name = "˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜˜˜˜",		tag = "˜˜˜˜"},
					{name = "˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜", 			tag = "˜˜˜˜"},
					{name = "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 			tag = "˜˜˜˜"},
					{name = "S.W.A.T.", 					tag = "˜˜˜˜"},
					{name = "˜˜˜.˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜", 		tag = "˜˜˜"},
					{name = "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", 			tag = "˜˜˜˜"},
					{name = "˜˜˜˜˜˜˜ ˜˜˜˜˜˜", 				tag = "˜˜˜"},
					{name = "˜˜˜.˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜", 		tag = "˜˜˜"},
				},
				[2] = {
					{name = "˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜˜",   		tag = "˜˜˜˜"},
					{name = "˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜˜˜˜", 		tag = "˜˜˜˜"},
					{name = "˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜", 			tag = "˜˜˜˜"},
					{name = "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜", 			tag = "˜˜˜"},
					{name = "˜˜˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜", 			tag = "˜˜˜˜"},
					{name = "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 			tag = "˜˜˜"},
					{name = "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜", 				tag = "˜˜˜˜"},
				},
				[3] = {
					{name = "˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜˜", 			tag = "˜˜˜"},
					{name = "˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜", 			tag = "˜˜˜"},
					{name = "˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 				tag = "˜˜"},
					{name = "˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ LV", 		tag = "˜˜˜"},
					{name = "˜˜˜.˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜˜˜˜", 	tag = "˜˜˜˜"},
				},
				[4] = {
					{name = "˜˜˜ ˜˜˜-˜˜˜˜˜˜˜", 				tag = "˜˜˜ ˜˜"},
					{name = "˜˜˜ ˜˜˜-˜˜˜˜˜˜˜˜˜", 			tag = "˜˜˜ ˜˜"},
					{name = "˜˜˜ ˜˜˜-˜˜˜˜˜˜", 				tag = "˜˜˜ ˜˜"},
					{name = "˜˜˜ ˜˜˜˜-˜˜˜˜", 				tag = "˜˜˜ ˜˜"},
					{name = "˜˜˜ ˜˜˜˜˜˜˜˜", 				tag = "˜˜"},
				},
				[5] = {
					{name = "˜˜˜˜˜˜˜˜˜˜˜˜˜", 				tag = "˜˜˜˜˜"},
					{name = "˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜", 		tag = "˜˜˜"},
					{name = "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", 			tag = "˜˜˜"},
					{name = "˜˜˜˜˜", 						tag = "˜˜˜˜˜"},
					{name = "˜˜˜˜ ˜˜˜˜˜", 					tag = "˜˜˜˜"},
				},
				[6] = {
					{name = "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜", 		tag = "˜˜"},
				},
				[7] = {
					{name = "Yakuza", 						tag = "YKZ"},
					{name = "La Cosa Nostra", 				tag = "LCN"},
					{name = "Russian Mafia", 				tag = "RM"},
					{name = "Warlock MC", 					tag = "WMC"},
					{name = "Tierra Robada Bikers", 		tag = "TRB"},
					{name = "˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 			tag = "˜˜"},
					{name = "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜", 				tag = "˜˜"},
					{name = "˜˜˜˜˜˜˜ ˜˜˜˜˜", 				tag = "˜˜"},
				},
				[8] = {
					{name = "Grove Street", 				tag = "˜˜˜˜"},
					{name = "East Side Ballas", 			tag = "˜˜˜˜˜"},
					{name = "Los Santos Vagos", 			tag = "˜˜˜˜˜"},
					{name = "The Rifa", 					tag = "˜˜˜˜"},
					{name = "Varrios Los Aztecas", 			tag = "˜˜˜˜˜"},
					{name = "Night Wolves", 				tag = "˜˜˜˜˜"},
				},
			}
			local org_list = orgs[MODULE.Initial.fraction_type_selector]
			for i, org in ipairs(org_list) do
				render_fraction_block(i, org.name, org.tag)
				if ((i % 3 ~= 0) and i ~= #org_list) then imgui.SameLine() end
			end

			if imgui.Button(fa.CIRCLE_ARROW_LEFT .. u8(' ˜˜˜˜˜'), imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				MODULE.Initial.step = 1
			end
			imgui.SameLine()
			if imgui.Button(u8('˜˜˜˜˜˜˜ "' .. MODULE.Initial.fraction_selector_text .. '" ') .. fa.CIRCLE_ARROW_RIGHT, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				if MODULE.Initial.step2_result ~= 0 then
					MODULE.Initial.step = 3
				end
			end
		elseif MODULE.Initial.step == 3 then
			imgui.CenterText(u8('˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜):'))
			imgui.PushItemWidth(520 * settings.general.custom_dpi)
			imgui.InputTextWithHint(u8'##input_fraction_rank', u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜...'), MODULE.Initial.input, 256)
			imgui.PushItemWidth(520 * settings.general.custom_dpi)
			imgui.SliderInt('##fraction_rank_number', MODULE.Initial.slider, 1, 10)
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_ARROW_LEFT .. u8(' ˜˜˜˜˜'), imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				if MODULE.Initial.fraction_type_selector == 6 then
					MODULE.Initial.step = 1 
				else
					imgui.StrCopy(MODULE.Initial.input, "")
					MODULE.Initial.step = 2
				end
			end
			imgui.SameLine()
			if imgui.Button(u8('˜˜˜˜˜˜˜˜˜˜ ') .. fa.CIRCLE_ARROW_RIGHT, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				modules.player.data.fraction_rank = u8:decode(ffi.string(MODULE.Initial.input))
				modules.player.data.fraction_rank_number = MODULE.Initial.slider[0]
				if modules.player.data.fraction_rank_number >= 9 then
					settings.general.auto_uninvite = true
				end
				imgui.StrCopy(MODULE.Initial.input, "")
				MODULE.Initial.step = 4
			end
		elseif MODULE.Initial.step == 4 then
			imgui.CenterText(u8('˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (˜˜ ˜˜˜˜˜˜˜˜˜˜):'))
			imgui.PushItemWidth(520 * settings.general.custom_dpi)
			imgui.InputText(u8'##input_nick', MODULE.Initial.input, 256)
			imgui.CenterTextDisabled(u8(translate(u8:decode(ffi.string(MODULE.Initial.input)))))
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_ARROW_LEFT .. u8(' ˜˜˜˜˜'), imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				imgui.StrCopy(MODULE.Initial.input, "")
				MODULE.Initial.step = 3
			end
			imgui.SameLine()
			if imgui.Button(u8('˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ') .. fa.FLAG_CHECKERED, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				modules.player.data.nick = u8:decode(ffi.string(MODULE.Initial.input))
				modules.player.data.name_surname = translate(modules.player.data.nick)
				MODULE.Initial.step = 5
			end
		elseif MODULE.Initial.step == 5 then
			local fraction_modes = {
				{id = 0,  name = "˜˜˜˜˜˜˜˜˜˜˜",         	   mode = "none",       tag = "˜˜˜˜"},
				{id = 11, name = "˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜˜",        mode = "police", 	tag = "˜˜˜˜"},
				{id = 12, name = "˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜˜˜˜",      mode = "police", 	tag = "˜˜˜˜"},
				{id = 13, name = "˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜",         mode = "police", 	tag = "˜˜˜˜"},
				{id = 14, name = "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜",          mode = "police", 	tag = "˜˜˜˜"},
				{id = 15, name = "S.W.A.T.",                   mode = "police", 	tag = "˜˜˜˜"},
				{id = 16, name = "˜˜˜. ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜",    mode = "fbi",    	tag = "˜˜˜"},
				{id = 17, name = "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜",          mode = "police",	 	tag = "˜˜˜˜"},
				{id = 18, name = "˜˜˜˜˜˜˜ ˜˜˜˜˜˜",             mode = "police", 	tag = "˜˜˜"},
				{id = 19, name = "˜˜˜. ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜",   mode = "fbi",    	tag = "˜˜˜"},
				{id = 21, name = "˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜˜",       mode = "hospital", 	tag = "˜˜˜˜"},
				{id = 22, name = "˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜˜˜˜",     mode = "hospital", 	tag = "˜˜˜˜"},
				{id = 23, name = "˜˜˜˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜",        mode = "hospital", 	tag = "˜˜˜˜"},
				{id = 24, name = "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜",        mode = "hospital", 	tag = "˜˜˜"},
				{id = 25, name = "˜˜˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜",         mode = "hospital", 	tag = "˜˜˜˜"},
				{id = 26, name = "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜",         mode = "hospital", 	tag = "˜˜˜"},
				{id = 27, name = "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜",            mode = "hospital", 	tag = "˜˜˜˜"},
				{id = 31, name = "˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜˜",          mode = "army", 		tag = "˜˜˜"},
				{id = 32, name = "˜˜˜˜˜ ˜˜˜-˜˜˜˜˜˜",           mode = "army", 		tag = "˜˜˜"},
				{id = 33, name = "˜˜˜˜˜ ˜˜˜˜˜˜˜˜",             mode = "army", 		tag = "˜˜"},
				{id = 34, name = "˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ LV",  mode = "prison", 	tag = "˜˜˜"},
				{id = 35, name = "˜˜˜. ˜˜˜˜˜˜ ˜˜˜. ˜˜˜˜˜˜˜˜˜", mode = "prison", 	tag = "˜˜˜˜"},
				{id = 41, name = "˜˜˜ ˜˜˜-˜˜˜˜˜˜˜",            mode = "smi",	 	tag = "˜˜˜ ˜˜"},
				{id = 42, name = "˜˜˜ ˜˜˜-˜˜˜˜˜˜˜˜˜",          mode = "smi", 		tag = "˜˜˜ ˜˜"},
				{id = 43, name = "˜˜˜ ˜˜˜-˜˜˜˜˜˜",             mode = "smi", 		tag = "˜˜˜ ˜˜"},
				{id = 44, name = "˜˜˜ ˜˜˜˜-˜˜˜˜",              mode = "smi", 		tag = "˜˜˜ ˜˜"},
				{id = 45, name = "˜˜˜ ˜˜˜˜˜˜˜˜",               mode = "smi", 		tag = "˜˜"},
				{id = 51, name = "˜˜˜˜˜˜˜˜˜˜˜˜˜",              mode = "gov", 		tag = "˜˜˜˜˜"},
				{id = 52, name = "˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜",       mode = "lc", 		tag = "˜˜˜"},
				{id = 53, name = "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜",         mode = "ins", 		tag = "˜˜˜"},
				{id = 54, name = "˜˜˜˜˜",                      mode = "judge", 		tag = "˜˜˜˜˜"},
				{id = 55, name = "˜˜˜˜ ˜˜˜˜˜",                 mode = "lc", 		tag = "˜˜˜˜"},
				{id = 61, name = "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜",       mode = "fd", 		tag = "˜˜"},
				{id = 71, name = "Yakuza",                     mode = "mafia",		tag = "YKZ"},
				{id = 72, name = "La Cosa Nostra",             mode = "mafia", 		tag = "˜˜˜"},
				{id = 73, name = "Russian Mafia",              mode = "mafia", 		tag = "˜˜"},
				{id = 74, name = "Warlock MC",                 mode = "mafia", 		tag = "WMC"},
				{id = 75, name = "Tierra Robada Bikers",       mode = "mafia", 		tag = "˜˜˜"},
				{id = 76, name = "˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜",           mode = "mafia", 		tag = "˜˜"},
				{id = 77, name = "˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜",           mode = "mafia", 		tag = "˜˜"},
				{id = 78, name = "˜˜˜˜˜˜˜ ˜˜˜˜˜",              mode = "mafia", 		tag = "˜˜"},
				{id = 81, name = "Grove Street",               mode = "ghetto", 	tag = "˜˜˜˜"},
				{id = 82, name = "East Side Ballas",           mode = "ghetto", 	tag = "˜˜˜˜˜"},
				{id = 83, name = "Los Santos Vagos",           mode = "ghetto", 	tag = "˜˜˜˜˜"},
				{id = 84, name = "The Rifa",                   mode = "ghetto", 	tag = "˜˜˜˜"},
				{id = 85, name = "Varrios Los Aztecas",        mode = "ghetto", 	tag = "˜˜˜˜˜"},
				{id = 86, name = "Night Wolves",               mode = "ghetto", 	tag = "˜˜˜˜˜"},
			}
			for index, value in ipairs(fraction_modes) do
				if value.id == MODULE.Initial.step2_result then
					settings.general.fraction_mode = value.mode
					modules.player.data.fraction = value.name
					modules.player.data.fraction_tag = value.tag
					break
				end
			end
			import_fraction_data(settings.general.fraction_mode)
			save_settings()
			save_module('player')
			save_module('departament')
			reload_script = true
			thisScript():reload()
		end
        imgui.End()
    end
)
--------------------------------------------- MAIN GUI --------------------------------------------
imgui.OnFrame(
    function() return MODULE.Main.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 430	* settings.general.custom_dpi), imgui.Cond.FirstUseEver)
		imgui.Begin(getHelperIcon() .. " Arizona Helper " .. getHelperIcon() .. "##main", MODULE.Main.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize )
		change_dpi()
		if imgui.BeginTabBar(u8'˜˜˜˜˜˜!') then	
			if imgui.BeginTabItem(fa.HOUSE..u8' ˜˜˜˜˜˜˜ ˜˜˜˜') then
				if (doesFileExist(config_dir .. '/Resourse/logo.png')) then
					if (not _G.helper_logo) then
						local path = config_dir .. '/Resourse/logo.png'
						_G.helper_logo = imgui.CreateTextureFromFile(path)
					else
						imgui.Image(_G.helper_logo, imgui.ImVec2(589 * settings.general.custom_dpi, 161 * settings.general.custom_dpi))
					end
				else
					if imgui.BeginChild('##1000000000000', imgui.ImVec2(589 * settings.general.custom_dpi, 161 * settings.general.custom_dpi), true) then
						imgui.Text("\n\n\n")
						imgui.CenterTextDisabled(u8('˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜!\n\n'))
						imgui.CenterTextDisabled(u8('˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ VPN ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜'))
						imgui.CenterTextDisabled(u8('https://github.com/MTGMODS/arizona-helper'))
						imgui.EndChild()
					end
				end
				if imgui.BeginChild('##2', imgui.ImVec2(589 * settings.general.custom_dpi, 169 * settings.general.custom_dpi), true) then
					imgui.CenterText(getUserIcon() .. u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ' .. getUserIcon())
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"˜˜˜ ˜ ˜˜˜˜˜˜˜:")
					imgui.SetColumnWidth(-1, 230 * settings.general.custom_dpi)
					imgui.NextColumn()
					imgui.CenterColumnText(u8(modules.player.data.name_surname))
					imgui.SetColumnWidth(-1, 250 * settings.general.custom_dpi)
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##name_surname') then
						modules.player.data.name_surname = translate(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
						imgui.StrCopy(MODULE.Main.input, u8(modules.player.data.name_surname))
						imgui.StrCopy(MODULE.Initial.input, u8(modules.player.data.nick))
						imgui.OpenPopup(getUserIcon() .. u8' ˜˜˜ ˜ ˜˜˜˜˜˜˜ ' .. getUserIcon() .. '##name_surname')
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getUserIcon() .. u8' ˜˜˜ ˜ ˜˜˜˜˜˜˜ ' .. getUserIcon() .. '##name_surname', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##name_surname', u8('˜˜˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜...'), MODULE.Main.input, 256)
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						if imgui.InputTextWithHint(u8'##nickname', u8('˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜...'), MODULE.Initial.input, 256) then
							imgui.StrCopy(MODULE.Main.input, u8(translate(u8:decode(ffi.string(MODULE.Initial.input)))))
						end
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##cancel_name_surname', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜##save_name_surname', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							modules.player.data.name_surname = u8:decode(ffi.string(MODULE.Main.input))
							modules.player.data.nick = u8:decode(ffi.string(MODULE.Initial.input))
							save_module('player')
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜:")
					imgui.NextColumn()
					if MODULE.Main.checkbox.accent_enable[0] then
						local accent_display = modules.player.data.accent:gsub('%[(.-) ˜˜˜˜˜˜%]?:?', '%1')
						imgui.CenterColumnText(u8(accent_display))
					else 
						imgui.CenterColumnText(u8'˜˜˜˜˜˜˜˜˜')
					end
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##accent') then
						imgui.StrCopy(MODULE.Main.input, u8(modules.player.data.accent))
						imgui.OpenPopup(getUserIcon() .. u8' ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ' .. getUserIcon() .. '##accent')
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getUserIcon() .. u8' ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ' .. getUserIcon() .. '##accent', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						if imgui.Checkbox('##MODULE.Main.checkbox.accent_enable', MODULE.Main.checkbox.accent_enable) then
							settings.general.accent_enable = MODULE.Main.checkbox.accent_enable[0]
							save_settings()
						end
						if imgui.IsItemHovered() then
							imgui.SetTooltip(u8'˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜')
						end
						imgui.SameLine()
						imgui.PushItemWidth(375 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##accent_input', u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜...'), MODULE.Main.input, 256) 
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##cancel_accent', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜##save_accent', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then 
							modules.player.data.accent = u8:decode(ffi.string(MODULE.Main.input))
							save_module('player')
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"˜˜˜ ˜˜˜˜˜˜˜˜˜:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(modules.player.data.sex))
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##sex') then
						modules.player.data.sex = (modules.player.data.sex ~= '˜˜˜˜˜˜˜') and '˜˜˜˜˜˜˜' or '˜˜˜˜˜˜˜'
						save_module('player')
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜')
					end
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜˜˜:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(modules.player.data.fraction))
					imgui.NextColumn()
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. "##fraction") then
						imgui.StrCopy(MODULE.Main.input, u8(modules.player.data.fraction))
						imgui.OpenPopup(getHelperIcon() .. u8' ˜˜˜˜˜˜˜˜˜˜˜ ' .. getHelperIcon() .. '##fraction')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getHelperIcon() .. u8' ˜˜˜˜˜˜˜˜˜˜˜ ' .. getHelperIcon() .. '##fraction', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##input_fraction_name', u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜...'), MODULE.Main.input, 256)
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##cancel_fraction_edit', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜##save_fraction_edit', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							modules.player.data.fraction = u8:decode(ffi.string(MODULE.Main.input))
							save_settings()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.SmallButton(fa.GEAR .. '##fraction') then
						imgui.OpenPopup(getHelperIcon() .. u8' ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ' .. getHelperIcon() .. '##fraction')
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getHelperIcon() .. u8' ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ' .. getHelperIcon() .. '##fraction', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8('˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜?'))
						imgui.CenterText(u8('˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ RP ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜!'))
						imgui.CenterText(u8('˜˜ ˜˜˜˜ ˜˜˜˜˜˜ RP ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜'))
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##cancel_new_fraction', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.GEARS .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜##reset_fraction', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							delete_default_fraction_cmds(modules.commands.data.commands.my, get_fraction_cmds(settings.general.fraction_mode, false))
							delete_default_fraction_cmds(modules.commands.data.commands_manage.my, get_fraction_cmds(settings.general.fraction_mode, true))
							MODULE.Initial.Window[0] = true
							MODULE.Main.Window[0] = false
						end
						imgui.End()
					end
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(modules.player.data.fraction_rank) .. " (" .. modules.player.data.fraction_rank_number .. ")")
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. "##rank") then
						imgui.StrCopy(MODULE.Main.input, u8(modules.player.data.fraction_rank))
						MODULE.Main.slider.rank[0] = modules.player.data.fraction_rank_number
						imgui.OpenPopup(getHelperIcon() .. u8' ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ' .. getHelperIcon() .. '##fraction_rank')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getHelperIcon() .. u8' ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ' .. getHelperIcon() .. '##fraction_rank', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##input_fraction_rank', u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜...'), MODULE.Main.input, 256)
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.SliderInt('##fraction_rank_number', MODULE.Main.slider.rank, 1, 10) 
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##cancel_fraction_rank', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜##save_fraction_rank', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							local old_rank_number = modules.player.data.fraction_rank_number
							modules.player.data.fraction_rank = u8:decode(ffi.string(MODULE.Main.input))
							modules.player.data.fraction_rank_number = MODULE.Main.slider.rank[0]
							save_module('player')
							if old_rank_number < 9 and modules.player.data.fraction_rank_number >= 9 then
								reload_script = true
								sampAddChatMessage("[Furry Helper] {FFFFFF}˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ " .. (modules.player.data.fraction_rank_number == 10 and '˜˜˜˜˜˜˜' or '˜˜˜˜˜˜˜˜˜˜˜˜') .. ", ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜˜˜. ˜˜˜˜˜˜˜˜˜˜˜˜...", message_color)
								thisScript():reload()
							end	
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.SmallButton(fa.PASSPORT .. '##stats') then
						check_stats = true
						sampSendChat('/stats')
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ /stats')
					end
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(modules.player.data.fraction_tag))
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##fraction_tag') then
						imgui.StrCopy(MODULE.Main.input, u8(modules.player.data.fraction_tag))
						imgui.OpenPopup(getHelperIcon() .. u8' ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ' .. getHelperIcon() .. '##fraction_tag')
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getHelperIcon() .. u8' ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ' .. getHelperIcon() .. '##fraction_tag', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputText(u8'##input_fraction_tag', MODULE.Main.input, 256)
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##cancel_fraction_rank', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜##save_fraction_tag', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							modules.player.data.fraction_tag = u8:decode(ffi.string(MODULE.Main.input))
							save_module('player')
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
				imgui.EndChild()
				end
				if imgui.BeginChild('##3', imgui.ImVec2(589 * settings.general.custom_dpi, 27 * settings.general.custom_dpi), true) then
					if thisScript().version:find('VIP') then
						imgui.SetCursorPosY(7 * settings.general.custom_dpi)
						imgui.CenterText(fa.CROWN .. u8(" VIP ˜˜˜˜˜˜˜˜˜˜˜˜ " .. MODULE.Activate.user .. ", ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ") .. fa.CROWN)
					else
						imgui.Columns(2)
						imgui.Text(fa.HAND_HOLDING_DOLLAR .. u8" ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (MTG MODS) ˜˜˜˜˜˜˜ " .. fa.HAND_HOLDING_DOLLAR)
						imgui.SetColumnWidth(-1, 480 * settings.general.custom_dpi)
						imgui.NextColumn()
						if imgui.CenterColumnSmallButton(u8'˜˜˜˜˜˜˜˜˜') then
							imgui.OpenPopup(fa.SACK_DOLLAR .. u8' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.SACK_DOLLAR)
						end
						imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
						if imgui.BeginPopupModal(fa.SACK_DOLLAR .. u8' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.SACK_DOLLAR, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
							change_dpi()
							imgui.CenterText(u8'˜˜˜˜˜˜˜˜˜ ˜ MTG MODS:')
							if imgui.Button(u8('Telegram'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
								openLink('https://t.me/mtgmods/60')
								imgui.CloseCurrentPopup()
							end
							imgui.SameLine()
							if imgui.Button(u8('Discord'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
								openLink('https://discord.gg/qBPEYjfNhv')
								imgui.CloseCurrentPopup()
							end
							imgui.End()
						end
						imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
						imgui.Columns(1)
					end
					imgui.EndChild()
				end
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.RECTANGLE_LIST..u8' ˜˜˜˜˜˜˜ ˜ RP ˜˜˜˜˜˜˜˜˜') then 
				if imgui.BeginTabBar('˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜') then
					if imgui.BeginTabItem(fa.BARS..u8' ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜') then 
						if imgui.BeginChild('##standart_cmds', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
							imgui.Columns(2)
							imgui.CenterColumnText(u8"˜˜˜˜˜˜˜")
							imgui.SetColumnWidth(-1, 220 * settings.general.custom_dpi)
							imgui.NextColumn()
							imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜")
							imgui.SetColumnWidth(-1, 400 * settings.general.custom_dpi)
							imgui.Columns(1)
							imgui.Separator()
							if settings.general.rp_guns then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/rpguns")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜ RP ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
							end
							imgui.Columns(2)
							imgui.CenterColumnText(u8"/pnv")
							imgui.NextColumn()
							imgui.CenterColumnText(u8"˜˜˜˜˜˜/˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜")
							imgui.Columns(1)
							imgui.Separator()
							imgui.Columns(2)
							imgui.CenterColumnText(u8"/irv")
							imgui.NextColumn()
							imgui.CenterColumnText(u8"˜˜˜˜˜˜/˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜")
							imgui.Columns(1)
							imgui.Separator()
							imgui.Columns(2)
							imgui.CenterColumnText(u8"/cruise")
							imgui.NextColumn()
							imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜-˜˜˜˜˜˜˜˜")
							imgui.Columns(1)
							imgui.Separator()
							if not isMode('none') then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/mb")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜ /members")
								imgui.Columns(1)
								imgui.Separator()
							end
							if not (isMode('ghetto') or isMode('mafia') or isMode('none')) then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/dep")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/sob")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/post")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
							end
							if isMode('gov') and settings.gov.custom_zeks then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/zeks")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
							end
							if isMode('prison') then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/pum")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
							elseif isMode('police') or isMode('fbi') then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/wanteds")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ /wanted")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/patrool")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/sum")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/tsm")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/afind")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜˜˜ /find ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ID")
								imgui.Columns(1)
							end
							imgui.EndChild()
						end
						imgui.EndTabItem()
					end
					function render_cmds(isManage)
						local cmd_array = (isManage and modules.commands.data.commands_manage.my or modules.commands.data.commands.my)
						if imgui.BeginChild('##' .. (isManage and 1 or 2), imgui.ImVec2(589 * settings.general.custom_dpi, 308 * settings.general.custom_dpi), true) then
							imgui.Columns(3)
							imgui.CenterColumnText(u8"˜˜˜˜˜˜˜")
							imgui.SetColumnWidth(-1, 170 * settings.general.custom_dpi)
							imgui.NextColumn()
							imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜")
							imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
							imgui.NextColumn()
							imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜")
							imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
							imgui.Columns(1)
							imgui.Separator()
							if isManage then
								imgui.Columns(3)
								imgui.CenterColumnText(u8"/spcar")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(3)
								imgui.CenterColumnText(u8"/fcleaner")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
							else
								imgui.Columns(3)
								imgui.CenterColumnText(u8"/stop")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ RP ˜˜˜˜˜˜˜")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜˜")
								imgui.Columns(1)
								imgui.Separator()
							end
							for index, command in ipairs(cmd_array) do
								imgui.Columns(3)
								if command.enable then imgui.CenterColumnText('/' .. u8(command.cmd)) else imgui.CenterColumnTextDisabled('/' .. u8(command.cmd)) end
								imgui.NextColumn()
								if command.enable then imgui.CenterColumnText(u8(command.description)) else imgui.CenterColumnTextDisabled(u8(command.description)) end
								imgui.NextColumn()
								imgui.Text('  ')
								imgui.SameLine()
								if imgui.SmallButton((command.enable and fa.TOGGLE_ON or fa.TOGGLE_OFF) .. '##' .. index) then
									command.enable = not command.enable
									save_module('commands')
									if command.enable then
										register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
									else
										sampUnregisterChatCommand(command.cmd)
									end
								end
								if imgui.IsItemHovered() then
									local tooltip = command.enable and "˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /" or "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /"
									imgui.SetTooltip(u8(tooltip .. command.cmd))
								end
								imgui.SameLine()
								if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##' .. index) then
									if command.arg == '' then
										MODULE.Binder.ComboTags[0] = 0
									elseif command.arg == '{arg}' then	
										MODULE.Binder.ComboTags[0] = 1
									elseif command.arg == '{id}' then
										MODULE.Binder.ComboTags[0] = 2
									elseif command.arg == '{id} {arg}' then
										MODULE.Binder.ComboTags[0] = 3
									elseif command.arg == '{id} {number} {arg}' then
										MODULE.Binder.ComboTags[0] = 4
									end
									MODULE.Binder.data = {
										change_waiting = command.waiting,
										change_cmd = command.cmd,
										change_text = command.text:gsub('&', '\n'),
										change_arg = command.arg,
										change_bind = command.bind,
										create_command_9_10 = isManage
									}
									MODULE.Binder.input_description = imgui.new.char[256](u8(command.description))
									MODULE.Binder.input_cmd = imgui.new.char[256](u8(command.cmd))
									MODULE.Binder.input_text = imgui.new.char[8192](u8(MODULE.Binder.data.change_text))
									MODULE.Binder.waiting_slider = imgui.new.float(tonumber(command.waiting))	
									MODULE.Binder.Window[0] = true
								end
								if imgui.IsItemHovered() then
									imgui.SetTooltip(u8"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /"..command.cmd)
								end
								imgui.SameLine()
								if imgui.SmallButton(fa.TRASH_CAN .. '##' .. index) then
									imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION ..  '##' .. index)
								end
								if imgui.IsItemHovered() then
									imgui.SetTooltip(u8"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /"..command.cmd)
								end
								imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
								if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION ..  '##'  .. index, _, imgui.WindowFlags.NoResize ) then
									change_dpi()
									imgui.CenterText(u8'˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /' .. u8(command.cmd) .. '?')
									imgui.Separator()
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜, ˜˜˜˜˜˜˜˜##delete_cmd' .. index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(fa.TRASH_CAN .. u8' ˜˜, ˜˜˜˜˜˜˜##delete_cmd' .. index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										sampUnregisterChatCommand(command.cmd)
										table.remove(cmd_array, index)
										save_module('commands')
										imgui.CloseCurrentPopup()
									end
									imgui.End()
								end
								imgui.Columns(1)
								imgui.Separator()
							end
							imgui.EndChild()
						end
						if imgui.Button(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜##new_cmd' .. (isManage and 1 or 2), imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
							local my_cmds = isManage and #modules.commands.data.commands_manage.my or #modules.commands.data.commands.my
							local max_cmds = #get_fraction_cmds(settings.general.fraction_mode, isManage) + 10
							if my_cmds >= max_cmds then
							 	send_no_vip_msg()
								return
							end
							local new_cmd = {cmd = '', description = '', text = '', arg = '', enable = true, waiting = '2', bind = "{}" }
							table.insert(cmd_array, new_cmd)
							MODULE.Binder.data = {
								change_waiting = new_cmd.waiting,
								change_cmd = new_cmd.cmd,
								change_text = new_cmd.text,
								change_arg = new_cmd.arg,
								change_bind = new_cmd.bind,
								create_command_9_10 = isManage
							}
							MODULE.Binder.ComboTags[0] = 0
							MODULE.Binder.input_description = imgui.new.char[256]("")
							MODULE.Binder.input_cmd = imgui.new.char[256]("")
							MODULE.Binder.input_text = imgui.new.char[8192]("")
							MODULE.Binder.waiting_slider = imgui.new.float(1.5)
							MODULE.Binder.Window[0] = true
						end
					end
					if imgui.BeginTabItem(fa.BARS..u8' RP ˜˜˜˜˜˜˜') then 
						render_cmds(false)
						imgui.EndTabItem()
					end
					if imgui.BeginTabItem(fa.BARS..u8' RP ˜˜˜˜˜˜˜ (9/10)') then 
						if modules.player.data.fraction_rank_number == 9 or modules.player.data.fraction_rank_number == 10 then
							render_cmds(true)
						else
							if imgui.BeginChild('##no_rank_access', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
								imgui.CenterText(fa.TRIANGLE_EXCLAMATION .. u8" ˜˜˜˜˜˜˜˜ " .. fa.TRIANGLE_EXCLAMATION)
								imgui.Separator()
								imgui.CenterText(u8"˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜!")
								imgui.CenterText(u8"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ 9 ˜˜˜ 10 ˜˜˜˜, ˜ ˜˜˜ ˜˜ - " .. modules.player.data.fraction_rank_number .. u8" ˜˜˜˜!")
								imgui.Separator()
								imgui.EndChild()
							end
						end
						imgui.EndTabItem() 
					end
					if imgui.BeginTabItem(fa.COMPASS .. u8' ˜˜˜˜ ˜˜˜˜') then 
						function render_fastmenu(name, use, text, text2)
							if imgui.BeginChild('##fastmenu'..name, imgui.ImVec2(193.3 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
								imgui.CenterText(u8(name))
								imgui.Separator()
								imgui.CenterText(u8("˜˜˜˜˜˜˜˜˜˜˜˜˜:"))
								if name == 'Leader FastMenu' and modules.player.data.fraction_rank_number < 9 then
									imgui.CenterText(u8"˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜ ˜˜ 9/10")
								else
									imgui.CenterText(use)
								end
								imgui.SetCursorPosY(120 * settings.general.custom_dpi)
								imgui.CenterText(fa.CIRCLE_INFO .. u8(" ˜˜˜˜˜˜˜˜:"))
								imgui.CenterText(u8(text))
								imgui.SetCursorPosY(210 * settings.general.custom_dpi)
								imgui.CenterText(fa.TAG .. u8(" ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜:"))
								imgui.CenterText(u8(text2))
								imgui.SetCursorPosY(308 * settings.general.custom_dpi)
								if imgui.Button(fa.GEAR .. u8(' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ') .. "##" .. name) then
									if name == 'Leader FastMenu' and modules.player.data.fraction_rank_number < 9 then
										sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ 9 ˜˜˜ 10 ˜˜˜˜˜!', message_color)
									else
										imgui.OpenPopup(fa.COMPASS .. u8' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ' .. u8(name) .. ' ' .. fa.COMPASS .. "##" .. name)
									end
								end
								imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
								if imgui.BeginPopupModal(fa.COMPASS .. u8' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ' .. u8(name) .. ' ' .. fa.COMPASS .. "##" .. name, _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
									change_dpi()
									if imgui.BeginChild('##fastmenu_configurige'..name, imgui.ImVec2(591 * settings.general.custom_dpi, 365 * settings.general.custom_dpi), true) then
										local arr = (name == 'Leader FastMenu') and modules.commands.data.commands_manage.my or modules.commands.data.commands.my
										imgui.Columns(3)
										imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜")
										imgui.SetColumnWidth(-1, 160 * settings.general.custom_dpi)
										imgui.NextColumn()
										imgui.CenterColumnText(u8"˜˜˜˜˜˜˜")
										imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
										imgui.NextColumn()
										imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜")
										imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
										imgui.Columns(1)
										local no_id_commands = true
										for index, value in ipairs(arr) do
											if (value.arg == "{id}") then
												no_id_commands = false
												imgui.Separator()
												imgui.Columns(3)
												local btn = (value.in_fastmenu) and (fa.SQUARE_CHECK .. u8'  (˜˜˜˜)') or (fa.SQUARE .. u8'  (˜˜˜˜)')
												if imgui.CenterColumnSmallButton(btn .. '##' .. index, imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
													value.in_fastmenu = not value.in_fastmenu
													save_module('commands')
												end
												imgui.NextColumn()
												imgui.CenterColumnText('/' .. value.cmd)
												imgui.NextColumn()
												imgui.CenterColumnText(u8(value.description))
												imgui.Columns(1)
											end
										end
										if no_id_commands then
											imgui.Separator()
											imgui.NewLine()
											imgui.NewLine()
											imgui.NewLine()
											imgui.NewLine()
											imgui.NewLine()
											imgui.NewLine()
											imgui.NewLine()
											imgui.Separator()
											imgui.CenterText(fa.CIRCLE_EXCLAMATION .. u8" ˜˜˜˜˜˜˜˜ " .. fa.CIRCLE_EXCLAMATION)
											imgui.CenterText(u8("˜ ˜˜˜ ˜˜˜˜ RP ˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ {id}"))
											local list_name = (name == 'Leader FastMenu') and "'RP ˜˜˜˜˜˜˜ (9/10)'" or "'RP ˜˜˜˜˜˜˜'"
											imgui.CenterText(u8("˜˜˜˜˜˜˜˜ ˜˜ ˜ ˜˜˜˜˜˜˜ '˜˜˜˜˜˜˜ ˜ RP ˜˜˜˜˜˜˜˜˜' - " .. list_name))
										end
										imgui.Separator()
										imgui.EndChild()
									end
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜##close_fast', imgui.ImVec2(591 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.End()
								end
								imgui.EndChild()
							end
						end
						render_fastmenu('FastMenu', u8'/hm ID ˜˜˜ ' .. fa.KEYBOARD .. (IS_MOBILE and u8' ˜˜˜˜˜˜˜˜' or u8' Hotkeys'), '˜˜˜˜˜˜˜ RP ˜˜˜˜˜˜˜', '{id}')
						imgui.SameLine()
						render_fastmenu('Leader FastMenu', u8'/lm ID' .. (IS_MOBILE and '' or (u8' ˜˜˜ ' .. fa.KEYBOARD .. u8' Hotkeys')), '˜˜˜˜˜˜˜ RP ˜˜˜˜˜˜˜ 9-10', '{id}')
						imgui.SameLine()
						if imgui.BeginChild('##piemenu_editor', imgui.ImVec2(193.3 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
							imgui.CenterText(u8("PieMenu"))
							imgui.Separator()
							imgui.CenterText(u8("˜˜˜˜˜˜˜˜˜˜˜˜˜:"))
							if IS_MOBILE then
								imgui.CenterText(fa.KEYBOARD .. u8' ˜˜˜˜˜˜˜˜')
							else
								imgui.CenterText(fa.COMPUTER_MOUSE .. u8' ˜˜˜ (˜˜˜˜˜˜˜)')
								if imgui.CenterButton(settings.general.piemenu and fa.TOGGLE_ON .. u8(' ˜˜˜˜˜˜˜˜˜') or fa.TOGGLE_OFF .. u8(' ˜˜˜˜˜˜˜˜')) then
									if pie_no_errors then
										settings.general.piemenu = not settings.general.piemenu
										MODULE.PieMenu.Window[0] = settings.general.piemenu
										save_settings()
									else
										sampAddChatMessage('[Furry Helper] {ffffff}˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ PieMenu, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜!', message_color)
									end
								end
							end
							imgui.SetCursorPosY(120 * settings.general.custom_dpi)
							imgui.CenterText(fa.CIRCLE_INFO .. u8(" ˜˜˜˜˜˜˜˜:"))
							imgui.CenterText(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜'))
							imgui.SetCursorPosY(210 * settings.general.custom_dpi)
							imgui.CenterText(fa.TAG .. u8(" ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜:"))
							imgui.CenterText(u8('˜˜˜ ˜˜˜˜˜˜˜˜˜'))
							imgui.SetCursorPosY(308 * settings.general.custom_dpi)
							if imgui.Button(fa.GEAR .. u8(' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ')) then
								if pie_no_errors then
									MODULE.PieMenu.editor.current = modules.piemenu.data
									imgui.OpenPopup(fa.COMPASS .. u8' ˜˜˜˜˜˜˜˜˜ PieMenu ' .. fa.COMPASS)
								else
									sampAddChatMessage('[Furry Helper] {ffffff}˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ PieMenu, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜!', message_color)
								end
							end
							imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
							if imgui.BeginPopupModal(fa.COMPASS .. u8' ˜˜˜˜˜˜˜˜˜ PieMenu ' .. fa.COMPASS, _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
								change_dpi()
								if imgui.BeginChild('##piemenu_configurige', imgui.ImVec2(591 * settings.general.custom_dpi, 365 * settings.general.custom_dpi), true) then
									if MODULE.PieMenu.editor.title ~= '' then
										imgui.CenterText(u8('˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ') ..iconTextFormat(MODULE.PieMenu.editor.title))
										imgui.Separator()
									end
									for i, item in ipairs(MODULE.PieMenu.editor.current) do
										imgui.Columns(2)
										imgui.BulletText(iconTextFormat(item))
										imgui.NextColumn()
										if imgui.Button(fa.PEN_TO_SQUARE .. '##edit_' .. i) then
											MODULE.PieMenu.editor.item   = item
											MODULE.PieMenu.editor.name   = imgui.new.char[64](u8(item.name))
											MODULE.PieMenu.editor.action = imgui.new.char[256](u8(item.action or ''))
											MODULE.PieMenu.editor.icon   = item.icon or ''
											imgui.OpenPopup(fa.PEN_TO_SQUARE .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ' .. fa.PEN_TO_SQUARE)
										end
										imgui.SameLine()
										if item.next then
											if imgui.Button(fa.GEAR .. '##open_' .. i) then
												table.insert(MODULE.PieMenu.editor.history, {title = MODULE.PieMenu.editor.title, items = MODULE.PieMenu.editor.current})
												MODULE.PieMenu.editor.current = item.next
												MODULE.PieMenu.editor.title = item
											end
											imgui.SameLine()
										end
										imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
										if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION ..  '##' .. item.name .. i, _, imgui.WindowFlags.NoResize ) then
											change_dpi()
											imgui.CenterText(u8'˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. u8(item.next and '˜˜˜˜˜˜˜ ' or '˜˜˜˜˜ ') .. iconTextFormat(item) .. '?')
											imgui.Separator()
											if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜, ˜˜˜˜˜˜˜˜##delete' .. i, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
												imgui.CloseCurrentPopup()
											end
											imgui.SameLine()
											if imgui.Button(fa.TRASH_CAN .. u8' ˜˜, ˜˜˜˜˜˜˜##delete' .. i, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
												table.remove(MODULE.PieMenu.editor.current, i)
												save_module('piemenu')
												imgui.CloseCurrentPopup()
											end
											imgui.End()
										end
										if imgui.Button(fa.TRASH_CAN .. '##del' .. i) then
											imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION ..  '##' .. item.name .. i)
										end
										imgui.Columns(1)
										imgui.Separator()
									end
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(fa.PEN_TO_SQUARE .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ' .. fa.PEN_TO_SQUARE, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
										change_dpi()
										imgui.CenterText(fa.SIGNATURE .. u8' ˜˜˜˜˜˜˜˜:')
										imgui.PushItemWidth(205 * settings.general.custom_dpi)
										imgui.InputTextWithHint(u8'##name', u8'˜˜˜˜˜ EN ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', MODULE.PieMenu.editor.name, 64)
										imgui.Separator()
										
										---@diagnostic disable-next-line: inject-field, undefined-field
										if not MODULE.PieMenu.editor.item.next then
											imgui.CenterText(fa.CIRCLE_PLAY ..  u8' ˜˜˜˜˜˜˜˜ (˜ ˜˜˜):')
											imgui.PushItemWidth(205 * settings.general.custom_dpi)
											imgui.InputTextWithHint(u8'##action', u8'˜˜˜˜˜ ˜˜˜˜˜/˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜', MODULE.PieMenu.editor.action, 256)
										else
											imgui.CenterText(fa.CIRCLE_PLAY ..  u8' ˜˜˜˜˜˜˜˜:')
											imgui.CenterText(u8'˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜')
										end
										imgui.Separator()
										imgui.CenterText(fa.IMAGE .. u8' ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜:')
										if MODULE.PieMenu.editor.icon ~= '' then
											imgui.SameLine()
											imgui.Text(fa[MODULE.PieMenu.editor.icon])
										end
										imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
										imgui.SetNextWindowSize(imgui.ImVec2(250 * settings.general.custom_dpi, 295 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
										if imgui.BeginPopupModal(fa.IMAGE .. u8' ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ PieMenu ' .. fa.IMAGE, nil, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
											imgui.PushItemWidth(240 * settings.general.custom_dpi)
											imgui.InputTextWithHint('##icon_filter', u8'˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜...', MODULE.Icons.input, 32)
											local filter = ffi.string(MODULE.Icons.input):upper()
											imgui.GetStyle().ScrollbarSize = 17 * settings.general.custom_dpi
											if imgui.BeginChild('##icons', imgui.ImVec2(240 * settings.general.custom_dpi, 200 * settings.general.custom_dpi), true) then
												for _, key in ipairs(MODULE.Icons.keys) do
													if filter == '' or key:find(filter, 1, true) then
														if imgui.Selectable(fa[key] .. ' ' .. key) then
															MODULE.PieMenu.editor.icon = key
															imgui.CloseCurrentPopup()
														end
													end
												end
												imgui.EndChild()
											end
											imgui.GetStyle().ScrollbarSize = (IS_MOBILE and 15 or 10) * settings.general.custom_dpi
											if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
												imgui.CloseCurrentPopup()
											end
											imgui.EndPopup()
										end
										if imgui.Button(fa.HAND_POINT_RIGHT .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ' .. fa.HAND_POINT_LEFT) then
											imgui.OpenPopup(fa.IMAGE .. u8' ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ PieMenu ' .. fa.IMAGE)
										end
										imgui.Separator()
										if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##pie_editor', imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜##pie_editor', imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											---@diagnostic disable: inject-field, undefined-field
											MODULE.PieMenu.editor.item.name = u8:decode(ffi.string(MODULE.PieMenu.editor.name))
											MODULE.PieMenu.editor.item.icon = MODULE.PieMenu.editor.icon
											if not MODULE.PieMenu.editor.item.next then
												MODULE.PieMenu.editor.item.action = u8:decode(ffi.string(MODULE.PieMenu.editor.action))
											end
											---@diagnostic enable: inject-field, undefined-field
											save_module('piemenu')
											imgui.CloseCurrentPopup()
										end
										imgui.EndPopup()
									end
									imgui.EndChild()
								end
								imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
								if imgui.BeginPopupModal(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ' .. fa.CIRCLE_PLUS, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
									change_dpi()
									if imgui.ItemSelector(u8'', { u8'˜˜˜˜ ˜˜˜˜˜', u8'˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜' }, MODULE.PieMenu.editor.selector, 200 * settings.general.custom_dpi) then
										local bool = (MODULE.PieMenu.editor.selector[0] ~= 2)
										local number = #MODULE.PieMenu.editor.current
										if number < 5 then
											number = number + 1
											if bool then
												table.insert(MODULE.PieMenu.editor.current, {name = 'Item ' .. number, icon = '', action = 'Item ' .. number})
											else
												table.insert(MODULE.PieMenu.editor.current, {name = 'SubMenu ' .. number, icon = '', next = {}})
											end
											save_module('piemenu')
										else
											if thisScript().version:find('VIP') then
												sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ 8 ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
											else
												sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ 5 (˜ VIP 8) ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ VIP!', message_color)
											end
										end
										imgui.CloseCurrentPopup()
									end
									imgui.End()
								end
								if MODULE.PieMenu.editor.current == modules.piemenu.data then
									if imgui.Button(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜˜˜/˜˜˜˜˜˜˜##add_pie_item', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
										imgui.OpenPopup(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ' .. fa.CIRCLE_PLUS)
									end
									imgui.SameLine()
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜##close_pie_editor', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
								else
									if imgui.Button(fa.ARROW_LEFT .. u8' ˜˜˜˜˜##pie_editor_menu', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
										local prev = table.remove(MODULE.PieMenu.editor.history)
										MODULE.PieMenu.editor.current = prev.items
										MODULE.PieMenu.editor.title = prev.title
									end
									imgui.SameLine()
									if imgui.Button(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜˜˜/˜˜˜˜˜˜˜##add_pie_item', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
										imgui.OpenPopup(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ' .. fa.CIRCLE_PLUS)
									end
									imgui.SameLine()
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜##close_pie_editor', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
								end
								imgui.End()
							end
							imgui.EndChild()
						end
						imgui.EndTabItem() 
					end
					if imgui.BeginTabItem(fa.KEYBOARD .. (IS_MOBILE and u8' ˜˜˜˜˜˜˜˜' or u8' ˜˜˜˜˜˜')) then 
						if IS_MOBILE then
							if imgui.BeginChild('##999', imgui.ImVec2(589 * settings.general.custom_dpi, 309 * settings.general.custom_dpi), true) then
								imgui.Columns(3)
								imgui.CenterColumnText(u8'˜˜˜˜˜˜')
								imgui.SetColumnWidth(-1, 200 * settings.general.custom_dpi)
								imgui.NextColumn()
								imgui.CenterColumnText(u8'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜')
								imgui.SetColumnWidth(-1, 250 * settings.general.custom_dpi)
								imgui.NextColumn()
								imgui.CenterColumnText(u8'˜˜˜˜˜˜˜˜˜˜')
								imgui.SetColumnWidth(-1, 120 * settings.general.custom_dpi)
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(3)
								if settings.general.mobile_fastmenu_button then
									imgui.CenterColumnText(fa.IMAGE_PORTRAIT .. u8(' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ (˜32 ONLY)'))
								else
									imgui.CenterColumnTextDisabled(fa.IMAGE_PORTRAIT .. u8(' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜'))
								end
								imgui.NextColumn()
								if settings.general.mobile_fastmenu_button then
									imgui.CenterColumnText(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /hm ID'))
								else
									imgui.CenterColumnTextDisabled(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /hm ID'))
								end
								imgui.NextColumn()
								if imgui.CenterColumnSmallButton((settings.general.mobile_fastmenu_button and fa.TOGGLE_ON or fa.TOGGLE_OFF) .. '##mobile_fastmenu_button') then
									settings.general.mobile_fastmenu_button = not settings.general.mobile_fastmenu_button
									MODULE.FastMenuButton.Window[0] = settings.general.mobile_fastmenu_button
									save_settings()
								end
								if imgui.IsItemHovered() then
									imgui.SetTooltip(u8(settings.general.mobile_fastmenu_button and "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜" or "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜"))
								end
								imgui.Columns(1)
								imgui.Separator()

								imgui.Columns(3)
								if settings.general.mobile_stop_button then
									imgui.CenterColumnText(fa.CIRCLE_STOP..u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜')
								else
									imgui.CenterColumnTextDisabled(fa.CIRCLE_STOP..u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜')
								end
								imgui.NextColumn()
								if settings.general.mobile_stop_button then
									imgui.CenterColumnText(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /stop'))
								else
									imgui.CenterColumnTextDisabled(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /stop'))
								end
								imgui.NextColumn()
								if imgui.CenterColumnSmallButton((settings.general.mobile_stop_button and fa.TOGGLE_ON or fa.TOGGLE_OFF) .. '##mobile_stop_button') then
									settings.general.mobile_stop_button = not settings.general.mobile_stop_button
									save_settings()
								end
								if imgui.IsItemHovered() then
									imgui.SetTooltip(u8(settings.general.mobile_stop_button and "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜" or "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜"))
								end
								imgui.Columns(1)
								imgui.Separator()

								imgui.Columns(3)
								if settings.general.piemenu then
									imgui.CenterColumnText(fa.GEAR .. u8(' PieMenu'))
								else
									imgui.CenterColumnTextDisabled(fa.GEAR .. u8(' PieMenu'))
								end
								imgui.NextColumn()
								if settings.general.piemenu then
									imgui.CenterColumnText(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜'))
								else
									imgui.CenterColumnTextDisabled(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜'))
								end
								imgui.NextColumn()
								if imgui.CenterColumnSmallButton((settings.general.piemenu and fa.TOGGLE_ON or fa.TOGGLE_OFF) .. '##mobile_piemenu_button') then
									if pie_no_errors then
										settings.general.piemenu = not settings.general.piemenu
										MODULE.PieMenu.Window[0] = settings.general.piemenu
										save_settings()
									else
										sampAddChatMessage('[Furry Helper] {ffffff}˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ PieMenu, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜!', message_color)
									end
								end
								if imgui.IsItemHovered() then
									imgui.SetTooltip(u8(settings.general.piemenu and "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜" or "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜"))
								end
								imgui.Columns(1)
								imgui.Separator()

								for index, button in ipairs(modules.buttons.data) do
									imgui.Columns(3)
									if button.enable then
										imgui.CenterColumnText(iconTextFormat(button))
									else
										imgui.CenterColumnTextDisabled(iconTextFormat(button))
									end
									imgui.NextColumn()
									if button.enable then
										imgui.CenterColumnText(u8(button.action))
									else
										imgui.CenterColumnTextDisabled(u8(button.action))
									end
									imgui.NextColumn()
									imgui.SetCursorPosX(imgui.GetCursorPos().x + 17 * settings.general.custom_dpi)
									if imgui.SmallButton((button.enable and fa.TOGGLE_ON or fa.TOGGLE_OFF) .. '##mb_toggle' .. index) then
										button.enable = not button.enable
										local WindowName = button.name .. index
										if MODULE.Buttons[WindowName] then
											MODULE.Buttons[WindowName][0] = button.enable
										else
											sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜!', message_color)
											play_sound()
										end
										save_module('buttons')
									end
									if imgui.IsItemHovered() then
										imgui.SetTooltip(u8(button.enable and "˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜" or "˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜"))
									end
									imgui.SameLine()
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(fa.PEN_TO_SQUARE .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. fa.PEN_TO_SQUARE .. '##' .. index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
										change_dpi()
										imgui.CenterText(fa.SIGNATURE .. u8' ˜˜˜˜˜˜˜˜:')
										imgui.PushItemWidth(205 * settings.general.custom_dpi)
										imgui.InputTextWithHint(u8'##name', u8'˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜', MODULE.Buttons.Editor.name, 64)
										imgui.Separator()
										imgui.CenterText(fa.CIRCLE_PLAY ..  u8' ˜˜˜˜˜˜˜˜ (˜ ˜˜˜):')
										imgui.PushItemWidth(205 * settings.general.custom_dpi)
										imgui.InputTextWithHint(u8'##action', u8'˜˜˜˜˜ ˜˜˜˜˜/˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜', MODULE.Buttons.Editor.action, 256)
										imgui.Separator()
										imgui.CenterText(fa.IMAGE .. u8' ˜˜˜˜˜˜:')
										if button.icon ~= '' then
											imgui.SameLine()
											imgui.Text(fa[button.icon])
										end
										imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
										imgui.SetNextWindowSize(imgui.ImVec2(250 * settings.general.custom_dpi, 295 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
										if imgui.BeginPopupModal(fa.IMAGE .. u8' ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ' .. fa.IMAGE, nil, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
											imgui.PushItemWidth(240 * settings.general.custom_dpi)
											imgui.InputTextWithHint('##icon_filter', u8'˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜...', MODULE.Icons.input, 32)
											local filter = ffi.string(MODULE.Icons.input):upper()
											imgui.GetStyle().ScrollbarSize = 17 * settings.general.custom_dpi
											if imgui.BeginChild('##icons', imgui.ImVec2(240 * settings.general.custom_dpi, 200 * settings.general.custom_dpi), true) then
												for _, key in ipairs(MODULE.Icons.keys) do
													if filter == '' or key:find(filter, 1, true) then
														if imgui.Selectable(fa[key] .. ' ' .. key) then
															button.icon = key
															imgui.CloseCurrentPopup()
														end
													end
												end
												imgui.EndChild()
											end
											imgui.GetStyle().ScrollbarSize = (IS_MOBILE and 15 or 10) * settings.general.custom_dpi
											if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
												imgui.CloseCurrentPopup()
											end
											imgui.EndPopup()
										end
										if imgui.Button(fa.HAND_POINT_RIGHT .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ' .. fa.HAND_POINT_LEFT) then
											imgui.OpenPopup(fa.IMAGE .. u8' ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ' .. fa.IMAGE)
										end
										imgui.Separator()
										imgui.CenterText(fa.MAXIMIZE .. u8(" ˜˜˜˜˜˜ (X, Y):"))
										imgui.PushItemWidth(100 * settings.general.custom_dpi)
										imgui.SliderInt(u8"##sizex", MODULE.Buttons.Editor.size.x, 1, 500)
										imgui.SameLine()
										imgui.PushItemWidth(100 * settings.general.custom_dpi)
										imgui.SliderInt(u8"##sizey", MODULE.Buttons.Editor.size.y, 1, 500)
										imgui.Separator()
										imgui.CenterText(fa.DRAW_POLYGON .. u8(" ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜:"))
										imgui.CenterText(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜'))
										imgui.Separator()
										if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜', imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜', imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											button.name = u8:decode(ffi.string(MODULE.Buttons.Editor.name))
											button.action = u8:decode(ffi.string(MODULE.Buttons.Editor.action))
											button.size.x = MODULE.Buttons.Editor.size.x[0]
											button.size.y = MODULE.Buttons.Editor.size.y[0]
											save_module('buttons')
											sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜!', message_color)
											play_sound()
											imgui.CloseCurrentPopup()
										end
										imgui.EndPopup()
									end

									if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##mb_edit' .. index) then
										imgui.StrCopy(MODULE.Buttons.Editor.name, u8(button.name))
										imgui.StrCopy(MODULE.Buttons.Editor.action, u8(button.action))
										MODULE.Buttons.Editor.size.x  = imgui.new.int(button.size.x)
										MODULE.Buttons.Editor.size.y  = imgui.new.int(button.size.y)
										imgui.OpenPopup(fa.PEN_TO_SQUARE .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. fa.PEN_TO_SQUARE .. '##' .. index)
									end
									if imgui.IsItemHovered() then
										imgui.SetTooltip(u8("˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜"))
									end
									imgui.SameLine()
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION ..  '##' .. index, _, imgui.WindowFlags.NoResize) then
										change_dpi()
										imgui.CenterText(u8("˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ \"" .. button.name .. "\"?"))
										imgui.Separator()
										if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜, ˜˜˜˜˜˜˜˜', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.TRASH_CAN .. u8' ˜˜, ˜˜˜˜˜˜˜', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											table.remove(modules.buttons.data, index)
											save_module('buttons')
											local WindowName = button.name .. index
											if MODULE.Buttons[WindowName] and MODULE.Buttons[WindowName][0] then
												MODULE.Buttons[WindowName][0] = false
											end
											imgui.CloseCurrentPopup()
										end
										imgui.EndPopup()
									end
									if imgui.SmallButton(fa.TRASH_CAN .. '##mb_delete' .. index) then
										imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION ..  '##' .. index)
									end
									if imgui.IsItemHovered() then
										imgui.SetTooltip(u8("˜˜˜˜˜˜˜ ˜˜˜˜˜˜"))
									end
									imgui.Columns(1)
									imgui.Separator()
								end
								imgui.EndChild()
							end
							if imgui.Button(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜##add_mobile_button', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
								if #modules.buttons.data >= 5 then
									send_no_vip_msg()
									sampAddChatMessage('[Furry Helper] {ffffff}˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ 5 ˜˜˜˜˜˜! ˜˜˜˜˜˜ VIP ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜!', message_color)
									return
								end
								local new_button = {icon = '', name = 'Button ' .. (#modules.buttons.data + 1), action = '', enable = false,  size = {x = 100, y = 25}, pos = {x = sizeX / 2, y = sizeY / 2}}
								table.insert(modules.buttons.data, new_button)
								save_module('buttons')
							end
						else
							if imgui.BeginChild('##999', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
								imgui.CenterText(fa.KEYBOARD .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (˜˜˜˜˜ ˜˜˜ RP ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜) ' .. fa.KEYBOARD)
								if hotkey_no_errors then
									imgui.Separator()
									imgui.CenterText(u8'˜˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ (˜˜˜˜˜˜ /helper):')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_mainmenu))
									imgui.SetCursorPosX( width / 2 - calc.x / 2 )
									if MainMenuHotKey:ShowHotKey() then
										settings.general.bind_mainmenu = encodeJson(MainMenuHotKey:GetHotKey())
										save_settings()
									end

									imgui.Separator()
									imgui.CenterText(u8'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ (˜˜˜˜˜˜ /hm):')
									imgui.CenterText(u8'˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_fastmenu))
									imgui.SetCursorPosX(width / 2 - calc.x / 2)
									if FastMenuHotKey:ShowHotKey() then
										settings.general.bind_fastmenu = encodeJson(FastMenuHotKey:GetHotKey())
										save_settings()
									end

									if modules.player.data.fraction_rank_number >= 9 then
										imgui.Separator()
										imgui.CenterText(u8'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (˜˜˜˜˜˜ /lm ˜˜˜ 9/10):')
										imgui.CenterText(u8'˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜')
										local width = imgui.GetWindowWidth()
										local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_leader_fastmenu))
										imgui.SetCursorPosX(width / 2 - calc.x / 2)
										if LeaderFastMenuHotKey:ShowHotKey() then
											settings.general.bind_leader_fastmenu = encodeJson(LeaderFastMenuHotKey:GetHotKey())
											save_settings()
										end
									end

									imgui.Separator()
									imgui.CenterText(u8'˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", "˜˜˜ ˜˜ ˜˜˜˜"):')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_action))
									imgui.SetCursorPosX(width / 2 - calc.x / 2)
									if ActionHotKey:ShowHotKey() then
										settings.general.bind_action = encodeJson(ActionHotKey:GetHotKey())
										save_settings()
									end

									imgui.Separator()
									imgui.CenterText(u8'˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (˜˜˜˜˜˜ /stop):')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_command_stop))
									imgui.SetCursorPosX(width / 2 - calc.x / 2)
									if CommandStopHotKey:ShowHotKey() then
										settings.general.bind_command_stop = encodeJson(CommandStopHotKey:GetHotKey())
										save_settings()
									end
									imgui.Separator()
								else
									imgui.Separator()
									imgui.CenterText(fa.TRIANGLE_EXCLAMATION .. u8' ˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ mimgui_hotkeys.lua ' .. fa.TRIANGLE_EXCLAMATION)
								end
								imgui.EndChild()
							end
						end
						imgui.EndTabItem() 
					end
					imgui.EndTabBar() 
				end
				imgui.EndTabItem()
			end
			local fraction = isMode('smi') and '˜˜˜' or modules.player.data.fraction_tag:sub(1, 5)
			if imgui.BeginTabItem(fa.GEARS .. u8' ˜˜˜˜˜˜˜ ' .. u8(fraction)) then
				render_fractions_functions()
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.FILE_PEN..u8' ˜˜˜˜˜˜˜') then 
			 	imgui.BeginChild('##notes1', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true)
				imgui.Columns(2)
				imgui.CenterColumnText(u8"˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜/˜˜˜˜˜˜˜˜˜:")
				imgui.SetColumnWidth(-1, 495 * settings.general.custom_dpi)
				imgui.NextColumn()
				imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜")
				imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
				imgui.Columns(1)
				imgui.Separator()
				for i, note in ipairs(modules.notes.data) do
					imgui.Columns(2)
					imgui.CenterColumnText(u8(note.note_name))
					imgui.NextColumn()
					if imgui.SmallButton(fa.UP_RIGHT_FROM_SQUARE .. '##' .. i) then
						MODULE.Note.show_note_name = u8(note.note_name)
						MODULE.Note.show_note_text = u8(note.note_text)
						MODULE.Note.Window[0] = true
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ "' .. u8(note.note_name) .. '"')
					end
					imgui.SameLine()
					if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##' .. i) then
						local note_text = note.note_text:gsub('&','\n')
						MODULE.Note.input_text = imgui.new.char[1048576](u8(note_text))
						MODULE.Note.input_name = imgui.new.char[256](u8(note.note_name))
						imgui.OpenPopup(fa.PEN_TO_SQUARE .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. fa.PEN_TO_SQUARE .. '##' .. i)	
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ "' .. u8(note.note_name) .. '"')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.PEN_TO_SQUARE .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. fa.PEN_TO_SQUARE .. '##' .. i, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						if imgui.BeginChild('##node_edit_window', imgui.ImVec2(589 * settings.general.custom_dpi, 369 * settings.general.custom_dpi), true) then	
							imgui.PushItemWidth(578 * settings.general.custom_dpi)
							imgui.InputText(u8'##note_name', MODULE.Note.input_name, 6256)
							imgui.InputTextMultiline("##note_text", MODULE.Note.input_text, 1048576, imgui.ImVec2(578 * settings.general.custom_dpi, 329 * settings.general.custom_dpi))
							imgui.EndChild()
						end	
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
							note.note_name = u8:decode(ffi.string(MODULE.Note.input_name))
							local temp = u8:decode(ffi.string(MODULE.Note.input_text))
							note.note_text = temp:gsub('\n', '&')
							save_module('notes')
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.SmallButton(fa.TRASH_CAN .. '##' .. i) then
						imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. i .. note.note_name)
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ "' .. u8(note.note_name) .. '"')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. i .. note.note_name, _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ "' .. u8(note.note_name) .. '" ?')
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜, ˜˜˜˜˜˜˜˜', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.TRASH_CAN .. u8' ˜˜, ˜˜˜˜˜˜˜', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							table.remove(modules.notes.data, i)
							save_module('notes')
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.Columns(1)
					imgui.Separator()
				end
				imgui.EndChild()
				if imgui.Button(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
					if #modules.notes.data >= 5 then
						send_no_vip_msg()
						return
					end
					table.insert(modules.notes.data, {note_name = "˜˜˜˜˜ ˜˜˜˜˜˜˜ " .. #modules.notes.data + 1, note_text = "˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜"})
					save_module('notes')
				end
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.GEAR..u8' ˜˜˜˜˜˜˜˜˜') then 
				if imgui.BeginChild('##1', imgui.ImVec2(589 * settings.general.custom_dpi, 187 * settings.general.custom_dpi), true) then
					imgui.CenterText(fa.CIRCLE_INFO .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ' .. fa.CIRCLE_INFO)
					imgui.Separator()
					imgui.Text(fa.CIRCLE_USER..u8" ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜: MTG MODS     Sub:Kolaars")
					imgui.Separator()
					imgui.Text(fa.CIRCLE_INFO..u8" ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜: " .. u8(thisScript().version))
					imgui.Separator()
					imgui.Text(fa.BOOK ..u8" ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜:")
					imgui.SameLine()
					if imgui.SmallButton(u8'YouTube') then
						openLink('https://www.youtube.com/@mtg_mods/videos')
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜ ˜˜˜˜˜-˜˜˜˜˜ ˜˜˜˜˜˜˜')
					end
					imgui.Separator()
					imgui.Text(fa.HEADSET..u8" ˜˜˜.˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜:")
					imgui.SameLine()
					if imgui.SmallButton(u8'Discord') then
						openLink('https://discord.gg/weumn8pG')
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜ ˜ Discord ˜˜˜˜˜˜ Kolaars')
					end
					imgui.SameLine()
					imgui.Text('/')
					imgui.SameLine()
					if imgui.SmallButton(u8'Telegram') then
						openLink('https://t.me/mtgmods/60')
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜ ˜ Telegram ˜˜˜˜˜ MTG MODS')
					end
					imgui.SameLine()
					imgui.Text('/')
					imgui.SameLine()
					if imgui.SmallButton(u8'BlastHack') then
						openLink('https://www.blast.hk/threads/244597/')
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'˜˜˜˜˜˜˜ ˜˜˜˜ Arizona ˜˜˜˜˜˜˜ ˜˜ BlastHack)')
					end
					imgui.Separator()
					imgui.Text(fa.GLOBE..u8" ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ MTG MODS:")
					imgui.SameLine()
					imgui.Text(u8"˜˜˜˜˜ ˜˜˜-˜˜ ˜ Discord / Telegram / BlastHack")
					imgui.Separator()
					imgui.Text(u8"-----------------------------------------------------------------------------------------------------------------------------------")
					if thisScript().version:find('VIP') then
						imgui.CenterText(fa.CROWN .. u8(" VIP ˜˜˜˜˜˜˜˜˜˜˜˜ " .. MODULE.Activate.user .. ", ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ") .. fa.CROWN)
					else
						imgui.CenterText(fa.GIFT .. u8" ˜˜˜˜ ˜˜ ˜˜˜˜˜/˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ VIP ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜ MTG MODS " .. fa.GIFT)
					end
					imgui.EndChild()
				end
				if imgui.BeginChild('##2', imgui.ImVec2(589 * settings.general.custom_dpi, 135 * settings.general.custom_dpi), true) then
					imgui.CenterText(fa.PALETTE .. u8(' ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ') .. fa.PALETTE)
					imgui.Separator()
					imgui.Columns(4)
					imgui.CenterColumnText(fa.BRUSH .. u8(' ˜˜˜˜'))
					if monet_no_errors then
						function moon_monet_edit()
							local r,g,b = MODULE.Main.mmcolor[0] * 255, MODULE.Main.mmcolor[1] * 255, MODULE.Main.mmcolor[2] * 255
							local argb = join_argb(0, r, g, b)
							settings.general.helper_theme = 0
							settings.general.moonmonet_theme_color = argb
							settings.general.message_color = argb
							message_color = "0x" .. argbToHexWithoutAlpha(0, r, g, b)
							message_color_hex = '{' .. argbToHexWithoutAlpha(0, r, g, b) .. '}'
							MODULE.Main.msgcolor[0], MODULE.Main.msgcolor[1], MODULE.Main.msgcolor[2] = color_to_float3(settings.general.message_color)
						end
						if imgui.RadioButtonIntPtr(u8" Custom", MODULE.Main.theme, 0) then
							moon_monet_edit()
							apply_moonmonet_theme()
							save_settings()
						end
						imgui.SameLine()
						if imgui.ColorEdit3('## COLOR1', MODULE.Main.mmcolor, imgui.ColorEditFlags.NoInputs) then
							if MODULE.Main.theme[0] == 0 then
								moon_monet_edit()
								apply_moonmonet_theme()
								save_settings()
							end
						end
					else
						if imgui.RadioButtonIntPtr(u8" ˜ustom ", MODULE.Main.theme, 0) then
							MODULE.Main.theme[0] = settings.general.helper_theme
							sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ MoonMonet!', message_color)
						end
					end
					if imgui.RadioButtonIntPtr(" Dark Theme ", MODULE.Main.theme, 1) then	
						settings.general.helper_theme = 1
						save_settings()
						apply_dark_theme()
					end
					if imgui.RadioButtonIntPtr(" White Theme ", MODULE.Main.theme, 2) then	
						settings.general.helper_theme = 2
						save_settings()
						apply_white_theme()
					end
					imgui.NextColumn()
					imgui.CenterColumnText(fa.FILL_DRIP .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜')
					imgui.PushItemWidth(138 * settings.general.custom_dpi)
					imgui.SetCursorPosY(72 * settings.general.custom_dpi)
					imgui.SliderInt('##slider_helper_transparent', MODULE.Main.slider.transparent, 10, 100)
					if settings.general.transparent ~= MODULE.Main.slider.transparent[0] then
						if imgui.CenterColumnSmallButton(fa.CIRCLE_ARROW_RIGHT .. u8' ˜˜˜˜˜˜˜˜˜ ' .. fa.CIRCLE_ARROW_LEFT .. '##change_transparent') then
							settings.general.transparent = MODULE.Main.slider.transparent[0]
							save_settings()
							if settings.general.helper_theme == 0 and monet_no_errors then
								apply_moonmonet_theme()
							elseif settings.general.helper_theme == 1 then
								apply_dark_theme()
							elseif settings.general.helper_theme == 2 then
								apply_white_theme()
							end
						end
					end
					imgui.NextColumn()
					imgui.CenterColumnText(fa.MESSAGE .. u8(' ˜˜˜˜ ˜˜˜˜˜˜˜˜˜'))
					imgui.SetCursorPosX(350 * settings.general.custom_dpi)
					imgui.SetCursorPosY(72 * settings.general.custom_dpi)
					if MODULE.Main.theme[0] == 0 then
						imgui.CenterColumnText(u8('˜˜˜˜˜˜˜˜˜˜˜˜ Custom'))
						imgui.CenterColumnText(u8('˜˜˜˜˜˜ ˜ Dark/White'))
					else
						if imgui.ColorEdit3('## COLOR2', MODULE.Main.msgcolor, imgui.ColorEditFlags.NoInputs) then
							local r,g,b = MODULE.Main.msgcolor[0] * 255, MODULE.Main.msgcolor[1] * 255, MODULE.Main.msgcolor[2] * 255
							local argb = join_argb(0, r, g, b)
							settings.general.message_color = argb
							-- settings.general.moonmonet_theme_color = argb
							message_color = "0x" .. argbToHexWithoutAlpha(0, r, g, b)
							message_color_hex = '{' .. argbToHexWithoutAlpha(0, r, g, b) .. '}'
							save_settings()
						end
					end
					imgui.NextColumn()
					imgui.CenterColumnText(fa.MAXIMIZE .. u8' ˜˜˜˜˜˜')
					imgui.PushItemWidth(138 * settings.general.custom_dpi)
					imgui.SetCursorPosY((72 * settings.general.custom_dpi))
					imgui.SliderFloat('##slider_helper_size', MODULE.Main.slider.dpi, 0.5, 3)
					if settings.general.custom_dpi ~= tonumber(string.format('%.3f', MODULE.Main.slider.dpi[0])) then
						if imgui.CenterColumnSmallButton(fa.CIRCLE_ARROW_RIGHT .. u8' ˜˜˜˜˜˜˜˜˜ ' .. fa.CIRCLE_ARROW_LEFT .. '##change_Size') then
							imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##change_size')
						end
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##change_size', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜?')
						imgui.CenterText(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ') .. settings.general.custom_dpi .. u8(', ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ') .. string.format('%.3f', MODULE.Main.slider.dpi[0]))
						local size_text = (settings.general.custom_dpi < MODULE.Main.slider.dpi[0]) and '˜˜˜˜˜˜˜' or '˜˜˜˜˜˜'
						imgui.CenterColorText(imgui.ImVec4(1, 0, 0, 1), u8('˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ') .. u8(size_text) .. u8(', ˜˜˜˜˜˜˜˜˜˜˜ /fixsize'))
						imgui.Separator()
						imgui.CenterText(u8('˜˜˜˜ ˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜" ˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜'))
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜, ˜˜˜˜˜˜˜˜##change_size', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							MODULE.Main.slider.dpi[0] = settings.general.custom_dpi
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.CIRCLE_ARROW_RIGHT .. u8' ˜˜, ˜˜˜˜˜˜˜˜##change_size', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							local new_dpi = tonumber(string.format('%.3f', MODULE.Main.slider.dpi[0]))
							if IS_MOBILE and new_dpi < MONET_DPI_SCALE then
								sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. MONET_DPI_SCALE, message_color)
								imgui.CloseCurrentPopup()
							else
								settings.general.custom_dpi = new_dpi
								save_settings()
								sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. size_text .. ', ˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. message_color_hex .. '/fixsize', message_color)
								sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜...', message_color)
								reload_script = true
								thisScript():reload()
							end
						end
						imgui.End()
					end 
					imgui.Columns(1)
					imgui.EndChild()
				end
				if imgui.BeginChild("##3",imgui.ImVec2(589 * settings.general.custom_dpi, 35 * settings.general.custom_dpi),true) then
					if imgui.Button(fa.POWER_OFF .. u8" ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						reload_script = true
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜!', message_color)
						if not IS_MOBILE then 
							sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. 'CTRL {ffffff}+ ' .. message_color_hex .. 'R {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.', message_color)
						end
						thisScript():unload()
					end
					imgui.SameLine()
					if imgui.Button(fa.CLOCK_ROTATE_LEFT .. u8" ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜", imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##reset_helper')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##reset_helper', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜?')
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜, ˜˜˜˜˜˜˜˜##cancel_restore', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.CLOCK_ROTATE_LEFT .. u8' ˜˜, ˜˜˜˜˜˜˜˜##yes_restore', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							delete_helpers_data()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.Button(fa.TRASH_CAN .. u8" ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜", imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##delete_helper')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##delete_helper', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ Arizona Helper?')
						imgui.CenterText(u8'˜˜˜-˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜)')
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜, ˜˜˜˜˜˜˜˜##cancel_delete_helper', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.TRASH_CAN .. u8' ˜˜, ˜˜˜˜˜˜˜##delete_helper', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							reload_script = true
							delete_helpers_data(true)
						end
						imgui.End()
					end
					imgui.EndChild()
				end
				imgui.EndTabItem()
			end
		imgui.EndTabBar() end
		imgui.End()
    end
)

imgui.OnFrame(
    function() return MODULE.Binder.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 425	* settings.general.custom_dpi), imgui.Cond.FirstUseEver)
		imgui.Begin(fa.PEN_TO_SQUARE .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /' .. MODULE.Binder.data.change_cmd, MODULE.Binder.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
		change_dpi()
		if imgui.BeginChild('##binder_edit', imgui.ImVec2(589 * settings.general.custom_dpi, 361 * settings.general.custom_dpi), true) then
			imgui.CenterText(fa.FILE_LINES .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜:')
			imgui.PushItemWidth(579 * settings.general.custom_dpi)
			imgui.InputText("##MODULE.Binder.data.input_description", MODULE.Binder.input_description, 256)
			imgui.Separator()
			imgui.CenterText(fa.TERMINAL .. u8' ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ (˜˜˜ /):')
			imgui.PushItemWidth(579 * settings.general.custom_dpi)
			imgui.InputText("##MODULE.Binder.input_cmd", MODULE.Binder.input_cmd, 256)
			local cmd = ffi.string(MODULE.Binder.input_cmd)
			if cmd:sub(1,1) == '/' then
				cmd = cmd:gsub("^/+", "")
				imgui.StrCopy(MODULE.Binder.input_cmd, cmd)
			end
			imgui.Separator()
			imgui.CenterText(fa.CODE .. u8' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜:')
			local args = {[1] = '{arg}', [2] = '{id}', [3] = '{id} {arg}', [4] = '{id} {number} {arg}'}
			local selected_args = args[MODULE.Binder.ComboTags[0]]
			if selected_args then
				for token in selected_args:gmatch("{[^}]+}") do
					if imgui.Button(token, imgui.ImVec2(65 * settings.general.custom_dpi, 24 * settings.general.custom_dpi)) then
						insert_to_cursor(token .. ' ', MODULE.Binder.input_text)
					end
					imgui.SameLine()
				end
			end
			imgui.PushItemWidth(581 * settings.general.custom_dpi - imgui.GetCursorPos().x)
	    	imgui.Combo(u8'', MODULE.Binder.ComboTags, MODULE.Binder.ImItems, #MODULE.Binder.item_list)
	 	    imgui.Separator()
	        imgui.CenterText(fa.FILE_WORD .. u8' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜:')
			imgui.InputTextMultiline("##text_multiple", MODULE.Binder.input_text, 8192, imgui.ImVec2(579 * settings.general.custom_dpi, 173 * settings.general.custom_dpi), imgui.InputTextFlags.CallbackAlways + imgui.InputTextFlags.CallbackCompletion, TextEditCallback)
		imgui.EndChild() end
		if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##binder_cancel', imgui.ImVec2(imgui.GetMiddleButtonX(IS_MOBILE and 4 or 5), 0)) then
			MODULE.Binder.Window[0] = false
		end
		imgui.SameLine()
		if imgui.Button(fa.CLOCK .. u8' ˜˜˜˜˜˜˜˜##binder_wait', imgui.ImVec2(imgui.GetMiddleButtonX(IS_MOBILE and 4 or 5), 0)) then
			imgui.OpenPopup(fa.CLOCK .. u8' ˜˜˜˜˜˜˜˜ (˜ ˜˜˜˜˜˜˜˜) '  .. fa.CLOCK)
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.CLOCK .. u8' ˜˜˜˜˜˜˜˜ (˜ ˜˜˜˜˜˜˜˜) ' .. fa.CLOCK, _, imgui.WindowFlags.NoResize ) then
			imgui.PushItemWidth(250 * settings.general.custom_dpi)
			imgui.SliderFloat(u8'##waiting', MODULE.Binder.waiting_slider, 0.3, 10)
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##binder_wait_menu', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				MODULE.Binder.waiting_slider = imgui.new.float(tonumber(MODULE.Binder.data.change_waiting))
				imgui.CloseCurrentPopup()
			end
			imgui.SameLine()
			if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜##binder_wait_menu', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end
		imgui.SameLine()
		if imgui.Button(fa.TAGS .. u8' ˜˜˜˜##binder_tags', imgui.ImVec2(imgui.GetMiddleButtonX(IS_MOBILE and 4 or 5), 0)) then
			imgui.OpenPopup(fa.TAGS .. u8' ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ' .. fa.TAGS)
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.TAGS .. u8' ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ' .. fa.TAGS, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
			if imgui.BeginChild("taglist", imgui.ImVec2(589 * settings.general.custom_dpi, 361 * settings.general.custom_dpi), true) then
				imgui.Columns(3, "tags_columns", true)
				imgui.Text(u8"˜˜˜")
				imgui.NextColumn()
				imgui.Text(u8"˜˜˜˜˜˜˜˜ ˜˜˜˜")
				imgui.NextColumn()
				imgui.Text(u8"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜")
				imgui.NextColumn()
				imgui.Columns(1)
				imgui.Separator()
				imgui.BulletText(u8("˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜"))
				imgui.Separator()
				imgui.Columns(3, "tags_columns", true)
				if imgui.Selectable("{pause}") then
					insert_to_cursor("{pause}", MODULE.Binder.input_text)
					imgui.CloseCurrentPopup()
				end
				imgui.NextColumn()
				imgui.Text(u8('˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜'))
				imgui.NextColumn()
				imgui.Text(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜'))
				imgui.NextColumn()
				imgui.Columns(1)
				imgui.Columns(3, "tags_columns", true)
				if imgui.Selectable("{wait(5000)}") then
					insert_to_cursor("{wait(5000)}", MODULE.Binder.input_text)
					imgui.CloseCurrentPopup()
				end
				imgui.NextColumn()
				imgui.Text(u8('˜˜˜.˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜'))
				imgui.NextColumn()
				imgui.Text(u8('˜˜˜˜˜˜ 5000 ˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜'))
				imgui.NextColumn()
				imgui.Columns(1)
				local last_category = nil
				for _, tag in ipairs(MODULE.Binder.tags) do
					if tag.category ~= last_category then
						imgui.Columns(1)
						imgui.Separator()
						imgui.BulletText(u8(tag.category))
						imgui.Separator()
						imgui.Columns(3, "tags_columns", true)
						last_category = tag.category
					end
					if imgui.Selectable("{" .. tag.key .. "}") then
						insert_to_cursor("{" .. tag.key .. "}", MODULE.Binder.input_text)
						imgui.CloseCurrentPopup()
					end
					imgui.NextColumn()
					imgui.Text(u8(tag.description))
					imgui.NextColumn()
					local example = ""
					if tag.func then
						local ok, result = pcall(tag.func)
						if ok and result then
							example = tostring(result)
						end
					end
					imgui.Text(u8(example))
					imgui.NextColumn()
				end
				imgui.Columns(1)
				imgui.EndChild()
			end
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end
		if not IS_MOBILE then
			imgui.SameLine()
			if imgui.Button(fa.KEYBOARD .. u8' ˜˜˜˜˜˜˜˜˜##binder_bind', imgui.ImVec2(imgui.GetMiddleButtonX(IS_MOBILE and 4 or 5), 0)) then
				if MODULE.Binder.ComboTags[0] == 0 then
					if hotkey_no_errors then
						if hotkey.HotKeyIsEdit ~= nil then hotkey.HotKeyIsEdit = nil end
						imgui.OpenPopup(fa.KEYBOARD .. u8' ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ /' .. MODULE.Binder.data.change_cmd)
					else
						sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ mimgui_hotkeys!', message_color)
					end
				else
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ "˜˜˜ ˜˜˜˜˜˜˜˜˜˜"', message_color)
				end
			end
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
			if imgui.BeginPopupModal(fa.KEYBOARD .. u8' ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ /' .. MODULE.Binder.data.change_cmd, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
				local hotkeyObject = hotkeys[MODULE.Binder.data.change_cmd .. "HotKey"]
				if hotkeyObject then
					imgui.CenterText(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜:'))
					local calc
					if MODULE.Binder.data.change_bind == '{}' or MODULE.Binder.data.change_bind == '[]' then
						calc = imgui.CalcTextSize('< click and select keys >')
					elseif MODULE.Binder.data.change_bind == nil then
						MODULE.Binder.data.change_bind = {}
					else
						calc = imgui.CalcTextSize(getNameKeysFrom(MODULE.Binder.data.change_bind))
					end
					local width = imgui.GetWindowWidth()
					local temp = (calc and calc.x and calc.x / 2) or 0
					imgui.SetCursorPosX(width / 2 - temp)
					if hotkeyObject:ShowHotKey() then
						MODULE.Binder.data.change_bind = encodeJson(hotkeyObject:GetHotKey())
					end
				else
					if not MODULE.Binder.data.change_bind then
						MODULE.Binder.data.change_bind = {}
					end
					hotkeys[MODULE.Binder.data.change_cmd .. "HotKey"] = hotkey.RegisterHotKey(MODULE.Binder.data.change_cmd .. "HotKey", false, decodeJson(MODULE.Binder.data.change_bind), function()
						if not sampIsCursorActive() then sampProcessChatInput('/' .. MODULE.Binder.data.change_cmd) end
					end)
					hotkeyObject = hotkeys[MODULE.Binder.data.change_cmd .. "HotKey"]
				end
				imgui.Separator()
				if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜##binder_bind_close', imgui.ImVec2(300 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
					imgui.CloseCurrentPopup()
				end
				imgui.End()
			end
		end
		imgui.SameLine()
		if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜##binder_save', imgui.ImVec2(imgui.GetMiddleButtonX(IS_MOBILE and 4 or 5), 0)) then	
			local cmd = ffi.string(MODULE.Binder.input_cmd)
			local desc = ffi.string(MODULE.Binder.input_description)
			local text_value = ffi.string(MODULE.Binder.input_text)
			local has_id = text_value:find("{id}")
			local has_arg = text_value:find("{arg}")
			local has_number = text_value:find("{number}")
			if cmd:find("[^%w_]") or cmd == '' or desc == ''  or text_value == '' then
				imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION)
			else
				local new_arg = ''
				if has_number or MODULE.Binder.ComboTags[0] == 4 then
					new_arg = '{id} {number} {arg}'
				elseif (has_id and has_arg) or MODULE.Binder.ComboTags[0] == 3 then
					new_arg = '{id} {arg}'
				elseif has_id or MODULE.Binder.ComboTags[0] == 2 then
					new_arg = '{id}'
				elseif has_arg or MODULE.Binder.ComboTags[0] == 1 then
					new_arg = '{arg}'
				else
					new_arg = ''
				end
				local new_command = u8:decode(ffi.string(MODULE.Binder.input_cmd))
				local temp_array = (MODULE.Binder.data.create_command_9_10) and modules.commands.data.commands_manage.my or modules.commands.data.commands.my
				for _, command in ipairs(temp_array) do
					if command.cmd == MODULE.Binder.data.change_cmd and command.arg == MODULE.Binder.data.change_arg and command.text:gsub('&', '\n') == MODULE.Binder.data.change_text then
						command.cmd = new_command
						command.arg = new_arg
						command.description = u8:decode(ffi.string(MODULE.Binder.input_description))
						command.text = u8:decode(ffi.string(MODULE.Binder.input_text)):gsub('\n', '&')
						command.bind = MODULE.Binder.data.change_bind
						command.waiting = MODULE.Binder.waiting_slider[0]
						command.enable = true
						save_module('commands')
						if command.arg == '' then
							sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. new_command .. ' {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!', message_color)
						elseif command.arg == '{arg}' then
							sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. new_command .. ' [˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!', message_color)
						elseif command.arg == '{id}' then
							sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. new_command .. ' [ID ˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!', message_color)
						elseif command.arg == '{id} {arg}' then
							sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. new_command .. ' [ID ˜˜˜˜˜˜] [˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!', message_color)
						elseif command.arg == '{id} {number} {arg}' then
							sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ' .. message_color_hex .. '/' .. new_command .. ' [ID ˜˜˜˜˜˜] [˜˜˜˜˜] [˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜!', message_color)
						end
						sampUnregisterChatCommand(MODULE.Binder.data.change_cmd)
						register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
						if not IS_MOBILE then createHotkeyForCommand(command) end
						break
					end
				end
				MODULE.Binder.Window[0] = false
			end
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION, _, imgui.WindowFlags.AlwaysAutoResize) then
			if ffi.string(MODULE.Binder.input_cmd):find('%W') then
				imgui.BulletText(u8" ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜.˜˜˜˜˜ ˜ ˜˜˜˜˜!")
			elseif ffi.string(MODULE.Binder.input_cmd) == '' then
				imgui.BulletText(u8" ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜!")
			end
			if ffi.string(MODULE.Binder.input_description) == '' then
				imgui.BulletText(u8" ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜!")
			end
			if ffi.string(MODULE.Binder.input_text) == '' then
				imgui.BulletText(u8" ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜!")
			end
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜##binder_error_save_close', imgui.ImVec2(400 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end	
		imgui.End()
    end
)

imgui.OnFrame(
    function() return MODULE.Note.Window[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(400 * settings.general.custom_dpi, 300 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.FILE_PEN .. ' '.. MODULE.Note.show_note_name .. ' ' .. fa.FILE_PEN, MODULE.Note.Window)
        change_dpi()
		for line in MODULE.Note.show_note_text:gsub("&", "\n"):gmatch("[^\r\n]+") do -- by Milky
			imgui.TextUnformatted(line) 
		end
        imgui.End()
    end
)

function iconTextFormat(item)
	if item.icon and item.icon ~= '' and fa[item.icon] then
		return fa[item.icon] .. ' ' .. u8(item.name)
	end
	return u8(item.name)
end
function render_buttons()
	for index, value in ipairs(modules.buttons.data) do
		local WindowName = value.name .. index
		if not MODULE.Buttons[WindowName] then
			MODULE.Buttons[WindowName] = imgui.new.bool(value.enable)
		end
		imgui.OnFrame(
			function() return MODULE.Buttons[WindowName][0] end,
			function(player)
				imgui.SetNextWindowPos(imgui.ImVec2(value.pos.x, value.pos.y), imgui.Cond.FirstUseEver)
				imgui.Begin("##BUTTON" .. value.name, MODULE.Buttons[WindowName], imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar)
				change_dpi()
				if imgui.Button(iconTextFormat(value), imgui.ImVec2(value.size.x * settings.general.custom_dpi, value.size.y * settings.general.custom_dpi)) then
					sampProcessChatInput(value.action)
				end
				local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
				if posX ~= value.pos.x or posY ~= value.pos.y then
					value.pos.x = posX
					value.pos.y = posY
					save_module('buttons')
				end
				imgui.End()
			end
		)
	end
end
------------------------------------------ FRACTION GUI -------------------------------------------
function render_assist_item(name, description, tbl, key, isVip, func)
	imgui.Separator()
	imgui.Columns(3)
	if tbl and tbl[key] then
		if isVip then
			imgui.CenterColumnColorText(imgui.ImVec4(0.93, 0.79, 0.15, 1.0), fa.CROWN .. ' ' .. u8(name))
		else
			imgui.CenterColumnText(u8(name))
		end
	else
		if isVip then
			imgui.CenterColumnColorText(imgui.ImVec4(0.55, 0.45, 0.08, 1.0), fa.CROWN .. ' ' .. u8(name))
		else
			imgui.CenterColumnTextDisabled(u8(name))
		end
	end
	imgui.NextColumn()
	imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
	if imgui.BeginPopupModal(fa.CIRCLE_INFO .. ' ' .. u8(name) .. ' ' .. fa.CIRCLE_INFO, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
		change_dpi()
		imgui.TextWrapped(u8(description))
		imgui.Separator()
		if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜', imgui.ImVec2(500 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
			imgui.CloseCurrentPopup()
		end
		imgui.EndPopup()
	end
	if imgui.CenterColumnSmallButton(u8('˜˜˜˜˜˜˜˜˜˜##' .. name .. key)) then
		imgui.OpenPopup(fa.CIRCLE_INFO .. ' ' .. u8(name) .. ' ' .. fa.CIRCLE_INFO)
	end
	imgui.NextColumn()
	if imgui.CenterColumnSmallButton((((tbl and tbl[key]) and fa.TOGGLE_ON or fa.TOGGLE_OFF) .. '##' .. name .. key)) then
		if isVip then
			send_no_vip_msg() 
		else
			tbl[key] = not tbl[key]
			save_settings()
		end
	end
	if imgui.IsItemHovered() then
		local label = (tbl and tbl[key]) and ('˜˜˜˜˜˜˜˜˜') or ('˜˜˜˜˜˜˜˜')
		imgui.SetTooltip(u8(label))
	end
	if func and tbl and tbl[key] then
		imgui.SameLine()
		if imgui.SmallButton(fa.GEAR .. '##' .. name) then
			func()
		end
		if imgui.IsItemHovered() then
			imgui.SetTooltip(u8("˜˜˜˜˜˜˜˜˜"))
		end
	end
	imgui.Columns(1)
end
function firs_render_assist_gui()
	imgui.Columns(3)
	imgui.CenterColumnText(u8("˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜"))
	imgui.SetColumnWidth(-1, 320 * settings.general.custom_dpi)
	imgui.NextColumn()
	imgui.CenterColumnText(u8("˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜"))
	imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
	imgui.NextColumn()
	imgui.CenterColumnText(u8("˜˜˜˜˜˜˜˜˜˜"))
	imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
	imgui.NextColumn()
	imgui.Columns(1)
	render_assist_item(
		"RP ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜",
		"˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜.\n˜˜˜-˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜: /s /do /f /fb /r /rb /j /jb /fam /al",
		settings.general,
		"rp_chat"
	)
	render_assist_item(
		"RP ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜",
		"˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜ ˜˜˜˜ ˜˜˜˜˜ RP ˜˜˜˜˜˜˜˜˜.\n˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ /rpguns ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.",
		settings.general,
		"rp_guns",
		false,
		function()
			MODULE.RPWeapon.Window[0] = true
			MODULE.Main.Window[0] = false
		end
	)
	render_assist_item(
		"RP ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜",
		"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ /offer\n˜˜˜-˜˜ ˜˜˜˜˜ RP ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜.",
		settings.general,
		"auto_accept_docs"
	)
	render_assist_item(
		"˜˜˜˜ ˜ ˜˜˜˜ @" .. MODULE.Binder.tag.my_nick(),
		"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜",
		settings.general,
		"ping"
	)
	render_assist_item(
		"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜",
		"˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ /domkrat ˜˜˜ ˜˜˜˜˜˜˜˜.\n˜˜˜˜ ˜ ˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜ ˜ ˜˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜!",
		settings.general,
		"aflip_domkrat",
		false
	)
	render_assist_item(
		"˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜",
		"˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜.\n˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜.",
		settings.general,
		"auto_mask",
		false
	)
	if not isMode('none') then
		render_assist_item(
			"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /mb",
			"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜ /mb ˜˜˜˜˜˜ 3 ˜˜˜˜˜˜˜.",
			settings.general,
			"auto_update_members",
			false
		)
		render_assist_item(
			"˜˜˜˜-˜˜˜˜˜˜˜ /post",
			"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜ 5 ˜˜˜˜˜ ˜˜ ˜˜˜˜˜.\n(˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ /post ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜)",
			settings.general,
			"auto_doklad_post",
			false
		)
	end
	if modules.player.data.fraction_rank_number >= 9 then
		render_assist_item(
			"˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ [9/10]",
			'˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜.\n˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜',
			settings.general.auto_invite,
			"enable",
			false,
			function()
				imgui.OpenPopup(fa.PERSON_CIRCLE_CHECK .. u8' ˜˜˜˜ ˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜ ' .. fa.PERSON_CIRCLE_CHECK)
			end
		)
		render_assist_item(
			"˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜ [9/10]",
			"˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜ /r /rb /f /fb\n˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜:\n1) ˜˜˜˜˜ ˜˜˜˜˜ ˜ /r ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜\n2) C˜˜˜˜˜ ˜˜˜˜˜˜˜˜: /rb Nick_Name, ˜˜˜˜˜˜˜˜˜ /rb +++ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜!\n3) ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ /rb +++ ˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜\n\nP.S. ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜, ˜˜˜ +++\nP.S.S. ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜.",
			settings.general,
			"auto_uninvite"
		)
	end
end
function render_fractions_functions() 
	if (isMode('police') or isMode('fbi')) then 
		if imgui.BeginTabBar('FractinFunctions') then
			if imgui.BeginTabItem(fa.ROBOT .. u8' ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜˜˜"') then 
				if imgui.BeginChild('##mj_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
					firs_render_assist_gui()
					render_assist_item(
						"˜˜˜˜˜˜ /time ˜˜ ˜˜˜˜˜/˜˜˜˜˜˜/˜˜˜˜˜",
						"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /time ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.",
						settings.mj,
						"auto_time"
					)
					render_assist_item(
						"˜˜˜˜˜ CODE 3/4 ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜/˜",
						"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.",
						settings.mj,
						"auto_change_code_siren"
					)
					render_assist_item(
						"˜˜˜˜-˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜",
						"˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.\n˜˜˜-˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜, ˜˜˜˜ ˜˜ ˜˜˜˜˜.",
						settings.mj,
						"anti_screpki"
					)
					render_assist_item(
						"˜˜˜˜˜˜ CODE 0 ˜˜˜ ˜˜˜˜˜˜˜˜˜",
						"˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /r CODE 0 ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.",
						settings.mj,
						"auto_doklad_damage"
					)
					render_assist_item(
						"˜˜˜˜-˜˜˜˜˜˜˜ /patrool",
						"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜ 5 ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜.\n(˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ /patrool ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜)",
						settings.mj,
						"auto_doklad_patrool",
						true
					)
					render_assist_item(
						"˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜",
						"˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜.",
						settings.mj,
						"auto_doklad_arrest",
						true
					)
					render_assist_item(
						"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /wanteds",
						"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /wanteds ˜˜˜˜˜˜ 15 ˜˜˜˜˜˜.",
						settings.mj,
						"auto_update_wanteds",
						true
					)
					render_assist_item(
						"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜",
						"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜.",
						settings.mj,
						"auto_case_documentation",
						true
					)
					render_assist_item(
						"˜˜˜˜˜˜ ˜˜ ˜˜˜",
						"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜ ˜˜˜˜˜˜˜).",
						settings.general,
						"auto_clicker",
						true
					)
					render_assist_item(
						"˜˜˜˜-˜˜˜˜˜˜˜˜˜ RP ˜˜ ˜˜˜",
						"˜˜˜˜˜˜˜˜˜˜˜˜˜˜ RP ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜˜ ˜˜˜).\n˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ RP point",
						settings.mj,
						"auto_rp_situation",
						false
					)
					render_assist_item(
						"AWANTED (˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜)",
						"˜˜˜˜˜˜˜˜˜ ˜˜˜, ˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜.\n˜˜˜-˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜ /find ˜ /z (˜˜˜˜ ˜˜˜˜˜)",
						settings.mj,
						"awanted",
						false
					)
					imgui.Separator()
					imgui.EndChild()
				end
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.STAR .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜') then 
				renderSmartGUI(
					'˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜',
					fa.STAR,
					'https://mtgmods.github.io/arizona-helper/SmartUK/' .. getServerNumber() .. '/SmartUK.json', 
					'˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜', 
					modules.smart_uk.data, 
					function() save_module("smart_uk") end, 
					'˜˜˜˜˜˜˜˜˜˜˜˜˜: /sum [ID ˜˜˜˜˜˜]', 
					modules.smart_uk.path,
					'smart_uk',
					'˜˜˜˜˜ ˜˜˜˜˜˜'
				)
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.TICKET .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜') then 
				renderSmartGUI(
					'˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜', 
					fa.TICKET, 
					'https://mtgmods.github.io/arizona-helper/SmartPDD/' .. getServerNumber() .. '/SmartPDD.json', 
					'˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜', 
					modules.smart_pdd.data, 
					function() save_module("smart_pdd") end, 
					'˜˜˜˜˜˜˜˜˜˜˜˜˜: /tsm [ID ˜˜˜˜˜˜]', 
					modules.smart_pdd.path,
					'smart_pdd',
					'˜˜˜˜˜ ˜˜˜˜˜˜'
				)
				imgui.EndTabItem()
			end
			imgui.EndTabBar() 
		end
	elseif isMode('army') then
		if imgui.BeginChild('##army_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 367 * settings.general.custom_dpi), true) then
			firs_render_assist_gui()
			render_assist_item(
				"˜˜˜˜˜˜ CODE 0 ˜˜˜ ˜˜˜˜˜˜˜˜˜",
				"˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /r CODE 0 ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.",
				settings.md,
				"auto_doklad_damage"
			)
			render_assist_item(
				"˜˜˜˜-˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜",
				"˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /r.\n(˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜)",
				settings.md,
				"auto_doklad_patrool",
				false
			)
			imgui.Separator()
			imgui.EndChild()
		end
	elseif isMode('prison') then
		if imgui.BeginTabBar('FractinFunctions') then
			if imgui.BeginTabItem(fa.ROBOT .. u8' ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜˜˜"') then 
				if imgui.BeginChild('##assist', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
					firs_render_assist_gui()
					render_assist_item(
						"˜˜˜˜˜˜ CODE 0 ˜˜˜ ˜˜˜˜˜˜˜˜˜",
						"˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /r CODE 0 ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜.",
						settings.md,
						"auto_doklad_damage"
					)
					render_assist_item(
						"˜˜˜˜-˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜",
						"˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /r.\n(˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜)",
						settings.md,
						"auto_doklad_patrool",
						false
					)
					imgui.Separator()
					imgui.EndChild()	
				end
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.STAR .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜') then 
				renderSmartGUI(
					'˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜', 
					fa.TICKET, 
					'https://mtgmods.github.io/arizona-helper/SmartRPTP/' .. getServerNumber() .. '/SmartRPTP.json', 
					'˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜', 
					modules.smart_rptp.data, 
					function() save_module("smart_rptp") end, 
					'˜˜˜˜˜˜˜˜˜˜˜˜˜: /pum [ID ˜˜˜˜˜˜]', 
					modules.smart_rptp.path,
					'smart_rptp',
					'˜˜˜˜˜ ˜˜˜˜'
				)
				imgui.EndTabItem()
			end
			imgui.EndTabBar() 
		end
	elseif isMode('smi') then
		if imgui.BeginTabBar('FractinFunctions') then
			if imgui.BeginTabItem(fa.ROBOT .. u8' ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜˜˜"') then 
				if imgui.BeginChild('##smi_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then	
					firs_render_assist_gui()
					render_assist_item(
						"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜",
						"˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜.",
						settings.smi,
						"notify_new_ads"
					)
					render_assist_item(
						"˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜˜",
						"˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜.\n˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ / ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜",
						settings.smi,
						"ads_buttons"
					)
					render_assist_item(
						"˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜",
						"˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜.\n˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜.",
						settings.smi,
						"ads_history"
					)
					render_assist_item(
						"˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜",
						"˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜.\n˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜˜˜˜.",
						settings.smi,
						"auto_select_first_ad"
					)
					render_assist_item(
						"˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜",
						"˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜.\n˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜.\n\n˜˜˜˜ 2+ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!",
						settings.smi,
						"steal_other_ads",
						true
					)
					render_assist_item(
						"AI ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜",
						"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ AI ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜!\n\n˜˜˜˜˜˜˜˜˜˜˜˜ 2 ˜˜˜˜˜˜ ˜˜˜˜˜˜:\n1) ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜˜˜)\n2) ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜.\n\n˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ Gemini API key\nMTG MODS ˜˜ ˜˜˜˜ ˜˜˜ AI ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ GEMINI!\n\n˜˜˜ ˜˜˜˜˜˜˜˜˜ AI ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜\n\n˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜ ˜ /REPORT",
						settings.smi.ai_generate,
						"enable",
						true,
						function() imgui.OpenPopup(fa.ROBOT .. u8' ˜˜˜˜˜˜˜˜˜ AI ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ' .. fa.ROBOT) end
					)
					render_assist_item(
						"˜˜˜˜-˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜",
						"˜˜˜˜-˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜, ˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜.\n˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜\n\n˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜\n\n˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜ ˜ /REPORT",
						settings.smi,
						"send_from_history",
						true,
						function() imgui.OpenPopup(fa.FILE_LINES .. u8' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ' .. fa.FILE_LINES) end
					)
					render_assist_item(
						"˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜",
						"˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ /newsredak ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜.\n˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜ ˜˜˜, ˜ ˜˜˜˜ ˜˜˜˜˜˜ PING & PacketLoss.\n\n˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜ ˜ /REPORT",
						settings.smi,
						"auto_catch_ads",
						true
					)
					imgui.Separator()
					imgui.EndChild()
				end
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.CLOCK_ROTATE_LEFT .. u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜') then
				if imgui.BeginChild('##ads_history_menu', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
					if settings.smi.ads_history then
						if modules.ads_history.data then 
							if #modules.ads_history.data == 0 then
								imgui.CenterText(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜'))
								imgui.CenterText(u8('˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜'))
							else
								imgui.PushItemWidth(570 * settings.general.custom_dpi)
								imgui.InputTextWithHint(u8'##input_ads_search', u8'˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜...', MODULE.SmiEdit.input_search, 128)
								imgui.Separator()
								imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
								if imgui.BeginPopupModal(fa.CLOCK_ROTATE_LEFT .. u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
									change_dpi()
									imgui.CenterText(u8(MODULE.SmiEdit.adshistory_orig))
									imgui.PushItemWidth(500 * settings.general.custom_dpi)
									imgui.InputTextWithHint(u8'##input_ads_my_edit', u8'˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜...', MODULE.SmiEdit.adshistory_input_text, 128)
									imgui.Separator()
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(fa.TRASH_CAN .. u8' ˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
										for id, ad in ipairs(modules.ads_history.data) do
											if ad.text == MODULE.SmiEdit.adshistory_orig then
												table.remove(modules.ads_history.data, id)
												save_module('ads_history')
												sampAddChatMessage("[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!", message_color)
												break
											end
										end
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
										for id, ad in ipairs(modules.ads_history.data) do
											if ad.text == MODULE.SmiEdit.adshistory_orig then
												ad.my_text = u8:decode(ffi.string(MODULE.SmiEdit.adshistory_input_text))
												save_module('ads_history')
												sampAddChatMessage("[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜!", message_color)
												break
											end
										end
										imgui.CloseCurrentPopup()
									end
									imgui.EndPopup()
								end
								local input_ads_decoded = u8:decode(ffi.string(MODULE.SmiEdit.input_search))
								for id, ad in ipairs(modules.ads_history.data) do
									if (ad and ad.text and ad.my_text) then
										if ((input_ads_decoded == '') or (ad.my_text:rupper():find(input_ads_decoded:rupper(), 1, true))) then
											if imgui.Button(u8(ad.my_text .. '##' .. id), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
												MODULE.SmiEdit.adshistory_orig = ad.text
												imgui.StrCopy(MODULE.SmiEdit.adshistory_input_text, u8(ad.my_text))
												imgui.OpenPopup(fa.CLOCK_ROTATE_LEFT .. u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜')
											end
										end
									end
								end
							end
						else
							imgui.CenterText(u8('˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜-˜˜ ˜˜˜˜˜˜˜˜˜'))
							imgui.Separator()
							imgui.CenterText(u8('˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ Ads.json, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜:'))
							imgui.TextWrapped(u8(modules.ads_history.path))
							imgui.Separator()
							imgui.CenterText(u8('˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ CP1251 ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜'))
						end
					else
						imgui.CenterText(u8('˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜" ˜ /helper - ˜˜˜˜˜˜˜ ˜˜˜, ˜˜˜˜˜˜˜˜ ˜'))
					end
					imgui.EndChild()
				end
				imgui.EndTabItem()
			end
			imgui.EndTabBar() 
		end
	elseif isMode('hospital') then
		if imgui.BeginTabBar('FractinFunctions') then
			if imgui.BeginTabItem(fa.ROBOT .. u8' ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜˜˜"') then 
				if imgui.BeginChild('##hospital_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
					firs_render_assist_gui()
					render_assist_item(
						"˜˜˜ ˜˜ ˜˜˜˜",
						"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜\n\n˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜:\n1) ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜\n2) ˜˜˜˜˜˜˜˜˜˜˜˜˜˜\n˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜\n\n˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜ ˜ /REP",
						settings.mh.heal_in_chat,
						"enable",
						false,
						function() imgui.OpenPopup(fa.KIT_MEDICAL .. u8' ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. fa.KIT_MEDICAL) end
					)
					render_assist_item(
						"˜˜˜˜-˜˜˜˜˜˜ ˜˜ ˜˜˜",
						"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (˜˜˜, ˜˜˜˜˜˜˜)\n\n˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜ ˜ /REPORT",
						settings.general,
						"auto_clicker",
						true
					)
					render_assist_item(
						"˜˜˜˜-˜˜˜˜˜˜˜˜˜ RP ˜˜ ˜˜˜",
						"˜˜˜˜˜˜˜˜˜˜˜˜˜˜ RP ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜˜ ˜˜˜).\n˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ NPC ˜˜˜ ˜˜˜˜˜˜˜˜˜ RP point\n(˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜, ˜˜˜˜)",
						settings.mh,
						"auto_rp_situation",
						true
					)
					imgui.Separator()
					imgui.EndChild()	
				end
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.SACK_DOLLAR .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜') then 
				if imgui.BeginChild('##hospital_price', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
					local med_price_fields = {}
					local server = getServerNumber()
					if tonumber(server) > 300 then -- rodina
						med_price_fields = {
							{label = '  ˜˜˜˜˜˜˜ ˜˜˜˜˜˜',              					key = 'heal',},
							{label = '  ˜˜˜˜˜˜ ˜˜˜˜˜˜˜',                     			key = 'recept'},
							{label = '  ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜ 7 ˜˜˜˜',         			key = 'med7'},
							{label = '  ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜ 14 ˜˜˜˜',        			key = 'med14'},
							{label = '  ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜ 30 ˜˜˜˜',        			key = 'med30'},
							{label = '  ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜ 60 ˜˜˜˜',       			key = 'med60'},
						}
					else
						med_price_fields = {
							{label = '  ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (SA $)',              			key = 'heal', same_line = true},
							{label = '  ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ (VC $)',             			key = 'heal_vc'},
							{label = '  ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (SA $)',           			key = 'healactor', same_line = true},
							{label = '  ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (VC $)',           			key = 'healactor_vc'},
							{label = '  ˜˜˜˜˜˜˜˜˜˜ ˜˜˜. ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜', 			key = 'medosm'},
							{label = '  ˜˜˜˜˜˜˜˜˜˜ ˜˜˜. ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', 	key = 'mticket'},
							{label = '  ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜', 	key = 'healbad'},
							{label = '  ˜˜˜˜˜˜ ˜˜˜˜˜˜˜',                     			key = 'recept'},
							{label = '  ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜',                 			key = 'ant'},
							{label = '  ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜ 7 ˜˜˜˜',         			key = 'med7', same_line = true},
							{label = '  ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜ 14 ˜˜˜˜',        			key = 'med14'},
							{label = '  ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜ 30 ˜˜˜˜',        			key = 'med30', same_line = true},
							{label = '  ˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜ ˜˜ 60 ˜˜˜˜',       			key = 'med60'},
						}
					end
					for i, field in ipairs(med_price_fields) do
						imgui.PushItemWidth(65 * settings.general.custom_dpi)
						local buf = MODULE.MedicalPrice[field.key]
						if imgui.InputText(u8(field.label), buf, 8) then
							local str = u8:decode(ffi.string(buf)):gsub("%D", "")
							local num = tonumber(str)
							if num then
								settings.mh.price[field.key] = num
								save_settings()
							end
						end
						if field.same_line then 
							imgui.SameLine()
							imgui.SetCursorPosX((320 * settings.general.custom_dpi))
						else 
							imgui.Separator() 
						end
					end
					imgui.EndChild()
				end
				imgui.EndTabItem()
			end
			imgui.EndTabBar() 
		end
	elseif isMode('lc') then
		if imgui.BeginTabBar('FractinFunctions') then
			if imgui.BeginTabItem(fa.ROBOT .. u8' ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ "˜˜˜˜˜˜˜˜˜"') then 
				if imgui.BeginChild('##assist', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
					firs_render_assist_gui()
					render_assist_item(
						"˜˜˜˜-˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜",
						"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜.",
						settings.lc,
						"auto_find_clorest_znak"
					)
					render_assist_item(
						"˜˜˜˜-˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜",
						"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.",
						settings.lc.auto_repair_znak,
						"enable",
						true,
						function() imgui.OpenPopup(fa.GEAR .. u8' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. fa.GEAR) end
					)
					render_assist_item(
						"˜˜˜˜-˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜",
						"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜.",
						settings.lc.auto_install_znak,
						"enable",
						true,
						function() imgui.OpenPopup(fa.GEAR .. u8' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. fa.GEAR) end
					)
					render_assist_item(
						"˜˜˜˜-˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜",
						"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜.\n˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜) ˜ ˜˜˜˜.\n˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ \"˜˜˜˜˜\", ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ 3 ˜˜˜˜˜˜.\n\n˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜:\n1) ˜˜˜ RP ˜˜˜˜˜˜˜˜˜\n2) ˜˜˜˜˜˜˜˜˜ RP ˜˜˜˜˜˜˜˜˜\n˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜\n\n˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜ ˜ /REPORT",
						settings.lc.auto_lic,
						"enable",
						true,
						function() imgui.OpenPopup(fa.FILE_LINES .. u8' ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ' .. fa.FILE_LINES) end
					)
					imgui.Separator()
					imgui.EndChild()	
				end
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.SACK_DOLLAR .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜') then 
				if imgui.BeginChild('##license_price', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
					local isRodina = tonumber(getServerNumber()) > 300
					local license_types = {
						{name = '˜˜˜˜', key = 'avto'},
						{name = '˜˜˜˜', key = 'moto'},
						{name = '˜˜˜˜˜', key = 'swim'},
						{name = '˜˜˜˜˜˜', key = 'fly'},
						{name = '˜˜˜˜˜˜', key = 'gun'},
						{name = '˜˜˜˜˜˜˜', key = 'fish'},
						{name = '˜˜˜˜˜', key = 'hunt'},
					}
					if isRodina then
						table.insert(license_types, {name = '˜˜˜˜˜', key = 'train'})
					else
						table.insert(license_types, {name = '˜˜˜˜˜˜˜˜', key = 'klad'})
						table.insert(license_types, {name = '˜˜˜˜˜', key = 'taxi'})
						table.insert(license_types, {name = '˜˜˜˜˜˜˜', key = 'mexa'})
					end
					for i, license in ipairs(license_types) do
						for month = 1, (isRodina and 1 or 3) do
							local month_label = (month == 1) and " %s (˜˜˜˜˜)" or string.format(" %%s (%d ˜˜˜˜˜˜)", month)
							local label = string.format(month_label, license.name)
							local key = license.key .. month
							local buf = MODULE.LicensePrice[key]
							imgui.PushItemWidth(65 * settings.general.custom_dpi)
							if imgui.InputText(u8(label), buf, 9) then
								local str = u8:decode(ffi.string(buf))
								str = str:gsub("%D","")
								local num = tonumber(str)
								if num then
									settings.lc.price[key] = num
									save_settings()
								end
							end
							if month == 1 and not isRodina then
								imgui.SameLine()
								imgui.SetCursorPosX(195 * settings.general.custom_dpi)
							elseif month == 2 then
								imgui.SameLine()
								imgui.SetCursorPosX(395 * settings.general.custom_dpi)
							elseif i ~= #license_types then
								imgui.Separator()
							end
						end
					end
					imgui.EndChild()
				end
				imgui.EndTabItem()
			end
			imgui.EndTabBar() 
		end
	elseif isMode('gov') then
		if imgui.BeginChild('##gov_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 367 * settings.general.custom_dpi), true) then
			firs_render_assist_gui()
			render_assist_item(
				"˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜",
				"˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ 2 ˜˜˜˜˜.\n˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜-˜˜ ˜˜˜˜ ˜˜˜˜˜˜.",
				settings.gov,
				"anti_trivoga"
			)
			render_assist_item(
				"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /zeks",
				"˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜, ˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ /zeks",
				settings.gov,
				"custom_zeks"
			)
			render_assist_item(
				"˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /zeks",
				"˜˜˜˜˜˜˜˜˜˜˜˜˜ (˜˜˜ ˜ 15 ˜˜˜˜˜˜) ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /zeks",
				settings.gov,
				"auto_update_zeks",
				false
			)
			imgui.Separator()
			imgui.EndChild()
		end
	elseif isMode('fd') then
		if imgui.BeginChild('##fd_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 367 * settings.general.custom_dpi), true) then
			firs_render_assist_gui()
			render_assist_item(
				"˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜",
				"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ /r ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ /fires ˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜.",
				settings.fd.doklads,
				"togo"
			)
			render_assist_item(
				"˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜",
				"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ /r ˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜.",
				settings.fd.doklads,
				"here"
			)
			render_assist_item(
				"˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜",
				"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ /r ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜.",
				settings.fd.doklads,
				"fire",
				true
			)
			render_assist_item(
				"˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜",
				"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ /r ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜.",
				settings.fd.doklads,
				"stretcher",
				true
			)
			render_assist_item(
				"˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜",
				"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ /r ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜˜˜˜.",
				settings.fd.doklads,
				"npc_save",
				true
			)
			render_assist_item(
				"˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜",
				"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ /r ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.",
				settings.fd.doklads,
				"file_end"
			)
			render_assist_item(
				"˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜",
				"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ /r ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜.",
				settings.fd.doklads,
				"tent"
			)
			imgui.Separator()
			imgui.EndChild()
		end
	elseif isMode('ins') then
		if imgui.BeginChild('##ins_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 367 * settings.general.custom_dpi), true) then
			firs_render_assist_gui()
			render_assist_item(
				"˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜",
				"˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜.\n˜˜˜ ˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜ ˜˜-˜˜ ˜˜˜˜ ˜˜˜˜˜˜.",
				settings.ins,
				"anti_trivoga"
			)
			render_assist_item(
				"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜",
				"˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜",
				settings.ins,
				"notify_new_ticket"
			)
			render_assist_item(
				"˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜",
				"˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜.",
				settings.ins,
				"auto_catch_ticket",
				true
			)
			render_assist_item(
				"˜˜˜˜˜˜ (1 ˜˜˜)",
				"˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜ 1 ˜˜˜˜˜˜˜˜.\n\n˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜ ˜ /REPORT",
				settings.general,
				"auto_clicker",
				true
			)
			if not IS_MOBILE then
				render_assist_item(
					"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ (2 ˜˜˜)",
					"˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜ 2 ˜˜˜˜˜˜˜˜.",
					settings.ins,
					"hint_in_sort"
				)
			end
			render_assist_item(
				"˜˜˜˜-˜˜˜˜ (2 ˜˜˜)",
				"˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ 2 ˜˜˜˜˜˜˜˜.\n\n˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜ ˜ /REPORT",
				settings.ins,
				"auto_find_game",
				true
			)
			render_assist_item(
				"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ (3 ˜˜˜)",
				"˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜ 3 ˜˜˜˜˜˜˜˜.",
				settings.ins,
				"auto_input_ticket"
			)
			render_assist_item(
				"˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (3 ˜˜˜)",
				"˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ 3 ˜˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜.\n˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ 3 ˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜ ˜˜ ˜˜˜.\n\n˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜! ˜˜˜˜˜˜˜˜˜ ˜ /REPORT",
				settings.ins,
				"auto_clicker_step3",
				true
			)
			imgui.Separator()
			imgui.EndChild()
		end
	else
		if imgui.BeginChild('##assist', imgui.ImVec2(589 * settings.general.custom_dpi, 367 * settings.general.custom_dpi), true) then
			firs_render_assist_gui()
			imgui.Separator()
			imgui.EndChild()
		end
	end	
end
if (not isMode('none')) then
	imgui.OnFrame(
		function() return MODULE.Members.Window[0] end,
		function(player)
			if #MODULE.Members.all == 0 then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜!', message_color)
				MODULE.Members.Window[0] = false
			elseif #MODULE.Members.all >= 16 then 
				sizeYY = 413 + 21
			else
				sizeYY = 24.5 * (#MODULE.Members.all + 1) + 21
			end
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(730 * settings.general.custom_dpi, sizeYY * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
			imgui.Begin(getHelperIcon() .. " " ..  u8(MODULE.Members.info.fraction) .. " - " .. #MODULE.Members.all .. u8' ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. getHelperIcon(), MODULE.Members.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
			change_dpi()
			imgui.Columns(4)
			imgui.CenterColumnText(getUserIcon() .. u8(" C˜˜˜˜˜˜˜˜"))
			imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(fa.RANKING_STAR .. u8(" ˜˜˜˜˜˜˜˜˜"))
			imgui.SetColumnWidth(-1, 230 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(fa.TRIANGLE_EXCLAMATION .. u8(" ˜˜˜˜˜˜˜˜"))
			imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(fa.INFO .. u8(" ˜˜˜˜"))
			imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
			imgui.Columns(1)
			for i, v in ipairs(MODULE.Members.all) do
				imgui.Separator()
				imgui.Columns(4)
				if v.working then
					imgui_RGBA = (settings.general.helper_theme ~= 2) and imgui.ImVec4(1, 1, 1, 1) or imgui.ImVec4(0, 0, 0, 1)
				else
					imgui_RGBA = imgui.ImVec4(1, 0.231, 0.231, 1)
				end
				local text = u8(v.nick) .. ' [' .. v.id .. ']'
				if tonumber(v.afk) then
					local afk = tonumber(v.afk)
					if afk > 0 then
						if afk < 60 then
							text = text .. ' [AFK ' .. afk .. 's]'
						else
							text = text .. ' [AFK ' .. math.floor(afk / 60) .. 'm]'
						end
					end
				end
				imgui.CenterColumnColorText(imgui_RGBA, text)
				if (imgui.IsItemClicked() and modules.player.data.fraction_rank_number >= 9) then 
					show_leader_fast_menu(v.id)
					MODULE.Members.Window[0] = false
				end
				imgui.NextColumn()
				imgui.CenterColumnText(u8(v.rank) .. ' (' .. u8(v.rank_number) .. ')')
				imgui.NextColumn()
				if tonumber(v.warns) == 0 then
					imgui.CenterColumnText(u8(v.warns .. '/3'))
				elseif tonumber(v.warns) == 1 then
					imgui.CenterColumnColorText(imgui.ImVec4(1, 1, 0.231, 1), u8(v.warns .. '/3'))
				else
					imgui.CenterColumnColorText(imgui.ImVec4(1, 0.231, 0.231, 1), u8(v.warns .. '/3'))
				end
				imgui.NextColumn()
				if v.info == '-' then
					imgui.CenterColumnText(u8(v.info))
				else
					imgui.CenterColumnColorText(imgui.ImVec4(1, 0.231, 0.231, 1), u8(v.info))
				end
				imgui.Columns(1)
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.GiveRank.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(getHelperIcon().." Arizona Helper " .. getHelperIcon() .. "##rank", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
			change_dpi()
			imgui.CenterText(u8'˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜ '.. u8(sampGetPlayerNickname(player_id)) .. ':')
			imgui.PushItemWidth(250 * settings.general.custom_dpi)
			imgui.SliderInt('', MODULE.GiveRank.number, 1, (modules.player.data.fraction_rank_number == 9) and 8 or 9)
			imgui.Separator()
			local label = ' ˜˜˜˜˜˜ ˜˜˜˜' .. ((hotkey_no_errors and settings.general.bind_action) and (' [' .. getNameKeysFrom(settings.general.bind_action) .. ']') or '')
			if imgui.Button(fa.USER .. u8(label), imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				MODULE.GiveRank.Window[0] = false
			end
			imgui.End()
		end
	)
end
if not (isMode('ghetto') or isMode('mafia')) then
	imgui.OnFrame(
		function() return MODULE.Sobes.Window[0] end,
		function(player)
			if player_id ~= nil and isParamSampID(player_id) then
				imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
				imgui.Begin(fa.PERSON_CIRCLE_CHECK..u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. u8(sampGetPlayerNickname(player_id)) .. ' ' .. fa.PERSON_CIRCLE_CHECK, MODULE.Sobes.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize)
				change_dpi()
				if imgui.BeginChild('sobes1', imgui.ImVec2(240 * settings.general.custom_dpi, 180 * settings.general.custom_dpi), true) then
					imgui.CenterColumnText(fa.BOOKMARK .. u8" ˜˜˜˜˜˜˜˜")
					imgui.Separator()
					if imgui.Button(fa.PLAY .. u8" ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						lua_thread.create(function()
							sampSendChat("˜˜˜˜˜˜˜˜˜˜˜˜, ˜ " .. modules.player.data.name_surname .. " - " .. modules.player.data.fraction_rank .. ' ' .. modules.player.data.fraction_tag)
							wait(1500)
							sampSendChat("˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜?")
						end)
					end
					if imgui.Button(fa.PASSPORT .. u8" ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						lua_thread.create(function()
							sampSendChat("˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜.")
							wait(1500)
							sampSendChat("˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜.˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜.")
							wait(1500)
							sampSendChat("/n " .. sampGetPlayerNickname(player_id) .. ", ˜˜˜˜˜˜˜˜˜˜˜ /showpass")
							wait(1500)
							sampSendChat("/n ˜˜˜˜˜˜˜˜˜˜˜ ˜ RP ˜˜˜˜˜˜˜˜˜˜˜!")
						end)
					end
					if imgui.Button(fa.USER .. u8" ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜.")
					end		
					if imgui.Button(fa.CHECK .. u8" ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("/todo ˜˜˜˜˜˜˜˜˜˜! ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜!*˜˜˜˜˜˜˜˜")
					end
					if imgui.Button(fa.USER_PLUS .. u8" ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						find_and_use_command('/invite {id}', player_id)
						MODULE.Sobes.Window[0] = false
					end
					imgui.EndChild()
				end
				imgui.SameLine()
				if imgui.BeginChild('sobes2', imgui.ImVec2(240 * settings.general.custom_dpi, 180 * settings.general.custom_dpi), true) then
					imgui.CenterColumnText(fa.BOOKMARK..u8" ˜˜˜˜˜˜˜˜˜˜˜˜˜")
					imgui.Separator()
					if imgui.Button(fa.GLOBE .. u8" ˜˜˜˜˜˜˜ ˜˜˜˜.˜˜˜˜˜ Discord", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("˜˜˜˜˜˜˜ ˜˜ ˜ ˜˜˜ ˜˜˜˜. ˜˜˜˜˜ Discord?")
					end
					if imgui.Button(fa.CIRCLE_QUESTION .. u8" ˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("˜˜˜˜˜˜˜ ˜˜ ˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜?")
					end
					if imgui.Button(fa.CIRCLE_QUESTION .. u8" ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜?", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜?")
					end
					if imgui.Button(fa.CIRCLE_QUESTION .. u8" ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜?", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ \"˜˜˜˜˜˜˜˜˜˜˜˜\"?")
					end
					if imgui.Button(fa.CIRCLE_QUESTION .. u8" ˜˜˜ ˜˜˜˜˜ ˜˜?", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜, ˜˜˜ ˜˜˜˜˜ \"˜˜\"?")
					end
				imgui.EndChild()
				end
				imgui.SameLine()
				if imgui.BeginChild('sobes3', imgui.ImVec2(150 * settings.general.custom_dpi, -1), true, imgui.WindowFlags.NoScrollbar) then
					imgui.CenterColumnText(fa.CIRCLE_XMARK .. u8" ˜˜˜˜˜˜")
					imgui.Separator()
					local function otkaz(reason)
						lua_thread.create(function()
							MODULE.Sobes.Window[0] = false
							sampSendChat("/todo ˜ ˜˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜*˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜")
							wait(1500)
							sampSendChat(reason)
						end)
					end
					if imgui.Selectable(u8"˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜") then
						otkaz("˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜.")
					end
					if imgui.Selectable(u8"˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜") then
						otkaz("˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜!")
					end
					if imgui.Selectable(u8"˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜") then
						otkaz("˜ ˜˜˜ ˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜.")
					end
					if imgui.Selectable(u8"˜˜˜˜ ˜˜˜.˜˜˜˜˜") then
						otkaz("˜ ˜˜˜ ˜˜˜˜ ˜˜˜.˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜.")
					end
					if imgui.Selectable(u8"˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜") then
						otkaz("˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜!")
					end
					if imgui.Selectable(u8"˜˜˜˜ ˜˜˜˜˜") then
						otkaz("˜ ˜˜˜ ˜˜˜˜ ˜˜˜˜˜! ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜/˜˜˜˜˜/˜˜˜˜˜˜˜.")
					end
					if imgui.Selectable(u8"˜˜˜˜˜˜˜ ˜ ˜˜") then
						otkaz("˜˜ ˜˜˜˜˜˜˜˜ ˜ ?˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜!")
					end
					if imgui.Selectable(u8"˜˜˜˜.˜˜˜˜˜˜˜˜˜˜˜˜˜") then
						otkaz("˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜.")
					end
				end
				imgui.EndChild()
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ID ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜!', message_color)
				MODULE.Sobes.Window[0] = false
			end
		end
	)
	imgui.OnFrame(
		function() return MODULE.Departament.Window[0] end,
		function(player)
			local function createTagPopup(tag_type, input_var, setting_key)
				imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
				if imgui.BeginPopupModal(fa.TAG .. u8' ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜##'..tag_type, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
					change_dpi()
					if imgui.BeginTabBar('TabTags') then
						local function createTagTab(title, tags)
							if imgui.BeginTabItem(fa.BARS..u8' '..title..' ') then 
								local line_started = false
								for i, tag in ipairs(tags) do
									if tag ~= 'skip' then
										if line_started then
											imgui.SameLine()
										else
											line_started = true
										end
										if tags == modules.departament.data.dep_tags_custom then
											imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
											if imgui.BeginPopupModal(fa.GEAR .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. fa.GEAR .. '##' .. i, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
												change_dpi()
												if imgui.ItemSelector(u8'', { u8'˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜', u8'˜˜˜˜˜˜˜ ˜˜˜' }, MODULE.Departament.selector.tag, 200 * settings.general.custom_dpi) then
													local bool = (MODULE.Departament.selector.tag[0] ~= 2)
													if bool then
														imgui.StrCopy(input_var, u8(tag))
													else
														table.remove(tags, i)
													end
													save_module('departament')
													imgui.CloseCurrentPopup()
												end
												imgui.End()
											end
										end
										if imgui.Button(' ' .. u8(tag) .. ' ##' .. i) then
											if tags == modules.departament.data.dep_tags_custom then
												imgui.OpenPopup(fa.GEAR .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. fa.GEAR .. '##' .. i)
											else
												imgui.StrCopy(input_var, u8(tag))
												save_module('departament')
												imgui.CloseCurrentPopup()
											end
										end
									else
										line_started = false
									end
								end
								imgui.Separator()
								if title:find(u8'˜˜˜˜˜˜') then
									imgui.Separator()
									if imgui.Button(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜##depAddTag', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
										imgui.OpenPopup(fa.TAG .. u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ' .. fa.TAG .. '##'..tag_type)
									end
									imgui.SameLine()
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜##depAddTag', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(fa.TAG .. u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ' .. fa.TAG .. '##'..tag_type, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
										imgui.CenterText(u8('˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜'))
										imgui.CenterText(u8('˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ skip'))
										imgui.PushItemWidth(215 * settings.general.custom_dpi)
										imgui.InputText('##MODULE.Departament.new_tag', MODULE.Departament.new_tag, 256) 
										if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##dep_add_tag'..tag_type, 
											imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜##dep_add_tag'..tag_type, 
											imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
											table.insert(modules.departament.data.dep_tags_custom, u8:decode(ffi.string(MODULE.Departament.new_tag)))
											save_module('departament')
											imgui.CloseCurrentPopup()
										end
										imgui.End()
									end
								end
								imgui.EndTabItem()
							end
						end
						createTagTab(u8'˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ (ru)', modules.departament.data.dep_tags)
						createTagTab(u8'˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ (en)', modules.departament.data.dep_tags_en)
						createTagTab(u8'˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜', modules.departament.data.dep_tags_custom)
						imgui.EndTabBar()
					end
					imgui.End()
				end
			end
			local function createFrequencyPopup()
				imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
				if imgui.BeginPopupModal(fa.WALKIE_TALKIE .. u8' ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ /d', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
					imgui.SetWindowSizeVec2(imgui.ImVec2(400 * settings.general.custom_dpi, 180 * settings.general.custom_dpi))
					change_dpi()
					local line_started = false
					for i, tag in ipairs(modules.departament.data.dep_fms) do
						if tag ~= 'skip' then
							if line_started then
								imgui.SameLine()
							else
								line_started = true
							end
							imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
							if imgui.BeginPopupModal(fa.GEAR .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. fa.GEAR .. '##' .. i, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
								change_dpi()
								if imgui.ItemSelector(u8'', { u8'˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', u8'˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜' }, MODULE.Departament.selector.fm, 200 * settings.general.custom_dpi) then
									local bool = (MODULE.Departament.selector.fm[0] ~= 2)
									if bool then
										imgui.StrCopy(MODULE.Departament.fm, u8(tag))
										modules.departament.data.dep_fm = u8:decode(ffi.string(MODULE.Departament.fm))
									else
										table.remove(modules.departament.data.dep_fms, i)
									end
									save_module('departament')
									imgui.CloseCurrentPopup()
								end
								imgui.End()
							end
							if imgui.Button(' ' .. u8(tag) .. ' ##' .. i) then
								imgui.OpenPopup(fa.GEAR .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. fa.GEAR .. '##' .. i)
							end
						else
							line_started = false
						end
					end
					
					imgui.Separator()
					if imgui.Button(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
						imgui.OpenPopup(fa.TAG .. u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜##2')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TAG .. u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜##2', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize) then
						imgui.CenterText(u8('˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜'))
						imgui.CenterText(u8('˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ skip'))
						imgui.PushItemWidth(215 * settings.general.custom_dpi)
						imgui.InputText('##MODULE.Departament.new_tag', MODULE.Departament.new_tag, 256) 
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then 
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
							table.insert(modules.departament.data.dep_fms, u8:decode(ffi.string(MODULE.Departament.new_tag)))
							save_module('departament')
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
						imgui.CloseCurrentPopup()
					end
					imgui.End()
				end
			end
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(fa.WALKIE_TALKIE .. u8" ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ " .. fa.WALKIE_TALKIE, MODULE.Departament.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar)
			change_dpi()
			if imgui.BeginChild('##2', imgui.ImVec2(500 * settings.general.custom_dpi, 190 * settings.general.custom_dpi), true) then
				imgui.Columns(3)
				imgui.CenterColumnText(u8('˜˜˜ ˜˜˜:'))
				imgui.PushItemWidth(155 * settings.general.custom_dpi)
				if imgui.InputText('##MODULE.Departament.tag1', MODULE.Departament.tag1, 256) then
					modules.departament.data.dep_tag1 = u8:decode(ffi.string(MODULE.Departament.tag1))
					save_module('departament')
				end
				if imgui.CenterColumnButton(u8('˜˜˜˜˜˜˜ ˜˜˜##1')) then
					imgui.OpenPopup(fa.TAG .. u8' ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜##1')
				end
				createTagPopup('1', MODULE.Departament.tag1, 'dep_tag1')
				
				imgui.NextColumn()
				imgui.CenterColumnText(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜:'))
				imgui.PushItemWidth(155 * settings.general.custom_dpi)
				if imgui.InputText('##MODULE.Departament.fm', MODULE.Departament.fm, 256) then
					modules.departament.data.dep_fm = u8:decode(ffi.string(MODULE.Departament.fm))
					save_module('departament')
				end
				if imgui.CenterColumnButton(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜##1')) then
					imgui.OpenPopup(fa.WALKIE_TALKIE .. u8' ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ /d')
				end
				createFrequencyPopup()
				imgui.NextColumn()
				imgui.CenterColumnText(u8('˜˜˜ ˜˜˜˜˜˜˜˜˜˜:'))
				imgui.PushItemWidth(155 * settings.general.custom_dpi)
				if imgui.InputText('##MODULE.Departament.tag2', MODULE.Departament.tag2, 256) then
					modules.departament.data.dep_tag2 = u8:decode(ffi.string(MODULE.Departament.tag2))
					save_module('departament')
				end
				if imgui.CenterColumnButton(u8('˜˜˜˜˜˜˜ ˜˜˜##2')) then
					imgui.OpenPopup(fa.TAG .. u8' ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜##2')
				end
				createTagPopup('2', MODULE.Departament.tag2, 'dep_tag2')
				imgui.Columns(1)
				imgui.Separator()
				imgui.CenterText(u8('˜˜˜˜˜:'))
				imgui.PushItemWidth(405 * settings.general.custom_dpi)
				imgui.InputText(u8'##dep_input_text', MODULE.Departament.text, 256)
				imgui.SameLine()
				if imgui.Button(u8' ˜˜˜˜˜˜˜˜˜ ') then
					local tag1 = modules.departament.data.anti_skobki and u8:decode(ffi.string(MODULE.Departament.tag1)):gsub("[%[%]]", "") or u8:decode(ffi.string(MODULE.Departament.tag1))
					local tag2 = modules.departament.data.anti_skobki and u8:decode(ffi.string(MODULE.Departament.tag2)):gsub("[%[%]]", "") or u8:decode(ffi.string(MODULE.Departament.tag2))
					sampSendChat('/d ' .. tag1 .. ' ' .. u8:decode(ffi.string(MODULE.Departament.fm)) .. ' ' .. tag2 .. ': ' .. u8:decode(ffi.string(MODULE.Departament.text)))
				end
				local tag1 = ffi.string(MODULE.Departament.tag1)
				local tag2 = ffi.string(MODULE.Departament.tag2)
				local fm = ffi.string(MODULE.Departament.fm)
				local text = ffi.string(MODULE.Departament.text)
				if modules.departament.data.anti_skobki then
					tag1 = tag1:gsub("[%[%]]", "")
					tag2 = tag2:gsub("[%[%]]", "")
				end
				local preview_text = ('/d ' .. tag1 .. ' ' .. fm .. ' ' .. tag2 .. ': ' .. text)
				imgui.CenterText(preview_text)
				imgui.Separator()
				if imgui.Checkbox(u8(' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ [] (˜˜˜˜˜˜) ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜'), MODULE.Departament.checkbox.anti_skobki) then
					modules.departament.data.anti_skobki = MODULE.Departament.checkbox.anti_skobki[0]
					save_module('departament')
				end
				imgui.EndChild()
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.Post.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.patrool_menu.x, settings.windows_pos.patrool_menu.y), imgui.Cond.FirstUseEver)
			imgui.Begin(getHelperIcon() .. u8" Arizona Helper " .. getHelperIcon() .. '##post_info_menu', MODULE.Post.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize )
			change_dpi()
			safery_disable_cursor(player)
			if MODULE.Post.active then
				imgui.Text(fa.MAP_LOCATION_DOT .. u8(' ˜˜˜˜: ') .. u8(MODULE.Binder.tag.get_post_name()))
				imgui.Text(fa.CLOCK .. u8(' ˜˜˜˜˜ ˜˜ ˜˜˜˜˜: ') .. u8(MODULE.Binder.tag.get_post_time()))
				imgui.Text(fa.CIRCLE_INFO .. u8(' ˜˜˜˜˜˜˜˜˜: ') .. u8(MODULE.Binder.tag.get_post_code()))
				imgui.SameLine()
				if imgui.SmallButton(fa.GEAR) then
					imgui.OpenPopup(fa.BUILDING_SHIELD .. u8(' Arizona Helper##post_select_code'))
				end
				imgui.Separator()
				if imgui.Button(fa.WALKIE_TALKIE .. u8(' ˜˜˜˜˜˜##post'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					if (not MODULE.Post.process_doklad) then
						MODULE.Post.process_doklad = true
						lua_thread.create(function()
							MODULE.Binder.state.isActive = true
							sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.my_doklad_nick() .. '. ˜˜˜˜: ' .. MODULE.Binder.tag.get_post_name() .. ', ˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_post_code())
							wait(1500)
							sampSendChat('/r ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ ˜˜˜ ' .. MODULE.Binder.tag.get_post_format_time())
							MODULE.Binder.state.isActive = false
							MODULE.Post.process_doklad = false
						end)
					end
				end	
				imgui.SameLine()
				if imgui.Button(fa.CIRCLE_STOP .. u8(' ˜˜˜˜˜##post'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					lua_thread.create(function()
						MODULE.Post.Window[0] = false
						MODULE.Post.active = false
						MODULE.Binder.state.isActive = true
						sampSendChat('/r ' .. MODULE.Binder.tag.my_doklad_nick() .. ' ˜˜ CONTROL. ˜˜˜˜: ' .. MODULE.Binder.tag.get_post_name() .. ', ˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_post_code() .. '.')
						wait(1500)
						sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜! ˜˜˜˜˜˜˜˜' .. MODULE.Binder.tag.sex() .. ' ˜˜ ˜˜˜˜˜: ' .. MODULE.Binder.tag.get_post_format_time() .. '.', -1)
						MODULE.Binder.state.isActive = false
						MODULE.Post.time = 0
						MODULE.Post.start_time = 0
						MODULE.Post.current_time = 0
						MODULE.Post.code = 'CODE4'
						MODULE.Post.ComboCode[0] = 5
					end)
				end
			else
				player.HideCursor = false
				imgui.PushItemWidth(200 * settings.general.custom_dpi)
				if imgui.InputTextWithHint(u8'##post_name', u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜'), MODULE.Post.input, 256) then
					MODULE.Post.name = u8:decode(ffi.string(MODULE.Post.input))
				end
				imgui.Text(fa.CIRCLE_INFO .. u8(' ˜˜˜˜˜˜˜˜˜: ') .. u8(MODULE.Binder.tag.get_post_code()))
				imgui.SameLine()
				if imgui.SmallButton(fa.GEAR) then
					imgui.OpenPopup(fa.BUILDING_SHIELD .. u8(' Arizona Helper##post_select_code'))
				end
				imgui.Separator()
				if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##post', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
					MODULE.Post.Window[0] = false
				end
				imgui.SameLine()
				if imgui.Button(fa.WALKIE_TALKIE .. u8' ˜˜˜˜˜˜˜˜˜##post', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
					MODULE.Post.time = 0
					MODULE.Post.start_time = os.time()
					MODULE.Post.active = true
					MODULE.Binder.state.isActive = true
					sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.my_doklad_nick() .. '. ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜ ' .. MODULE.Binder.tag.get_post_name() .. ', ˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_post_code() .. '.')
					MODULE.Binder.state.isActive = false
					imgui.CloseCurrentPopup()
				end
			end
			if imgui.BeginPopup(fa.BUILDING_SHIELD .. u8(' Arizona Helper##post_select_code'), _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  ) then
				change_dpi()
				player.HideCursor = false 
				imgui.PushItemWidth(150 * settings.general.custom_dpi)
				if imgui.Combo('##post_code', MODULE.Post.ComboCode, MODULE.Patrool.ImItemsCode, #MODULE.Post.codes) then
					MODULE.Post.code = MODULE.Post.codes[MODULE.Post.ComboCode[0] + 1]
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
			local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
			if posX ~= settings.windows_pos.post_menu.x or posY ~= settings.windows_pos.post_menu.y then
				settings.windows_pos.post_menu = {x = posX, y = posY}
				save_settings()
			end
			imgui.End()
		end
	)
end
if isMode('police') or isMode('fbi') or isMode('prison') then
	function get_updated_at(data)
		for index, value in ipairs(data) do
			if value.name == '##updated_at' then
				return os.date("%d.%m.%Y %H:%M", value.updated_at)
			end
		end
		return nil
	end
	function set_updated_at(data, module, timestamp)
		for index, value in ipairs(data) do
			if value.name == '##updated_at' then
				value.updated_at = timestamp
				save_module(module)
				return
			end
		end
		table.insert(data, {name = '##updated_at', updated_at = timestamp})
		save_module(module)
	end
	function renderSmartGUI(title, icon, downloadPath, editPopupTitle, data, saveFunction, usageText, pathDisplay, download_file_name, download_item)
		if imgui.BeginChild('##smart'..title, imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true, imgui.WindowFlags.NoScrollbar) then
			if #data ~= 0 then
				imgui.CenterColorText(imgui.ImVec4(0, 1, 0, 1), u8("˜˜˜˜˜˜˜ - ") .. u8(usageText))
			else
				imgui.CenterColorText(imgui.ImVec4(1, 0.231, 0.231, 1), u8("˜˜˜˜˜˜˜˜˜ - ˜˜˜˜˜˜˜˜˜ ") .. u8(download_item) .. u8(" ˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜"))
			end
			imgui.Separator()
			local updated_at = get_updated_at(data)
			if updated_at then
				imgui.CenterText(u8("˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ " .. editPopupTitle .. ": ") .. get_updated_at(data))
			end
			imgui.SetCursorPosY(90 * settings.general.custom_dpi)
			imgui.SetCursorPosX(220 * settings.general.custom_dpi)
			if imgui.Button(fa.DOWNLOAD .. (#data ~= 0 and u8' ˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ 'or u8' ˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ') .. fa.DOWNLOAD .. '##smart'..title) then
				_G['download_'..title:lower()] = true
				download_file = download_file_name
				downloadFileFromUrlToPath(downloadPath, pathDisplay)
				imgui.OpenPopup(fa.CIRCLE_INFO .. u8' ˜˜˜˜˜˜˜˜˜˜ ' .. fa.CIRCLE_INFO .. '##downloadsmart'..title)
			end
			imgui.CenterText(u8'˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜?')
			imgui.CenterText(u8'˜˜˜˜˜˜˜˜ SMART ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜ Discord ˜˜˜˜˜˜˜.')
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
			if imgui.BeginPopupModal(fa.CIRCLE_INFO .. u8' ˜˜˜˜˜˜˜˜˜˜ ' .. fa.CIRCLE_INFO .. '##downloadsmart'..title, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
				if _G['download_'..title:lower()] then
					change_dpi()
					imgui.CenterText(u8'˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ' .. u8(editPopupTitle) .. u8' ˜˜˜ ˜˜˜˜˜˜˜ ' .. u8(getServerName(getServerNumber())) .. " [" .. getServerNumber() .. ']')
					imgui.CenterText(u8'˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜.')
					imgui.Separator()
					imgui.CenterText(u8'˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ 10 ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜')
					imgui.CenterText(u8'˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜:')
					imgui.CenterText(u8'1) ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜')
					imgui.CenterText(u8'2) ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ json ˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜, ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜ ˜˜˜˜:')
					if #pathDisplay > 98 then
						local first_part = pathDisplay:sub(1, 98)
						local second_part = pathDisplay:sub(99, #pathDisplay)
						imgui.CenterText(u8(first_part))
						imgui.CenterText(u8(second_part))
					else
						imgui.CenterText(u8(pathDisplay))
					end
					imgui.Separator()
				else
					MODULE.Main.Window[0] = false
					imgui.CloseCurrentPopup()
				end
				if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜##close_smart' .. title, imgui.ImVec2(300 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					imgui.CloseCurrentPopup()
				end
				imgui.SameLine()
				if imgui.Button(fa.GLOBE .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜##open_web_smart' .. title, imgui.ImVec2(300 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					openLink("https://github.com/MTGMODS/arizona-helper")
					openLink(downloadPath)
					imgui.CloseCurrentPopup()
					MODULE.Main.Window[0] = false
				end
				imgui.EndPopup()
			end
			imgui.SetCursorPosY(220 * settings.general.custom_dpi)
			imgui.SetCursorPosX(200 * settings.general.custom_dpi)
			if imgui.Button(fa.PEN_TO_SQUARE .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. fa.PEN_TO_SQUARE .. '##smart'..title) then
				imgui.OpenPopup(icon .. ' ' .. u8(title) .. ' ' .. icon .. '##smart'..title)
			end
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
			if imgui.BeginPopupModal(icon .. ' ' .. u8(title) .. ' ' .. icon .. '##smart'..title, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
				change_dpi()
				if imgui.BeginChild('##smart'..title..'edit', imgui.ImVec2(589 * settings.general.custom_dpi, 368 * settings.general.custom_dpi), true) then
					for chapter_index, chapter in ipairs(data) do
						if chapter.name ~= '##updated_at' then
							imgui.Columns(2)
							imgui.Text("> " .. u8(chapter.name))
							imgui.SetColumnWidth(-1, 515 * settings.general.custom_dpi)
							imgui.NextColumn()
							if imgui.Button(fa.PEN_TO_SQUARE .. '##' .. title .. chapter_index) then
								imgui.OpenPopup(u8(chapter.name).. '##' .. title .. chapter_index)
							end
							imgui.SameLine()
							if imgui.Button(fa.TRASH_CAN .. '##' .. title .. chapter_index) then
								imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index)
							end
							imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
							if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index, _, imgui.WindowFlags.NoResize) then
								change_dpi()
								imgui.CenterText(u8'˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜?')
								if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜, ˜˜˜˜˜˜˜˜##cancel_delete_item_smart' .. chapter_index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
									imgui.CloseCurrentPopup()
								end
								imgui.SameLine()
								if imgui.Button(fa.TRASH_CAN .. u8' ˜˜, ˜˜˜˜˜˜˜##delete_item_smart' .. chapter_index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
									table.remove(data, chapter_index)
									set_updated_at(data, download_file_name, os.time())
									saveFunction()
									imgui.CloseCurrentPopup()
								end
								imgui.End()
							end
							imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
							imgui.Columns(1)
							imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
							if imgui.BeginPopupModal(u8(chapter.name).. '##' .. title .. chapter_index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
								change_dpi()
								if imgui.BeginChild('##smart'..title..'edititem', imgui.ImVec2(589 * settings.general.custom_dpi, 368 * settings.general.custom_dpi), true) then
									if chapter.item then
										for index, item in ipairs(chapter.item) do
											imgui.Columns(2)
											imgui.Text("> " .. u8(item.text))
											imgui.SetColumnWidth(-1, 515 * settings.general.custom_dpi)
											imgui.NextColumn()
											if imgui.Button(fa.PEN_TO_SQUARE .. '##' .. chapter_index .. '##' .. title .. index) then
												_G['input_'..title:lower()..'_text'] = imgui.new.char[8192](u8(item.text))
												_G['input_'..title:lower()..'_value'] = imgui.new.char[256](u8(item[title:find('˜˜˜˜˜˜') and 'lvl' or 'amount']))
												_G['input_'..title:lower()..'_reason'] = imgui.new.char[1024](u8(item.reason))
												imgui.OpenPopup(fa.PEN_TO_SQUARE .. u8(" ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜##") .. title .. chapter.name .. index .. chapter_index)
											end
											imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
											if imgui.BeginPopupModal(fa.PEN_TO_SQUARE .. u8(" ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜##") .. title .. chapter.name .. index .. chapter_index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
												change_dpi()
												if imgui.BeginChild('##smart'..title..'edititeminput', imgui.ImVec2(489 * settings.general.custom_dpi, 150 * settings.general.custom_dpi), true) then    
													imgui.CenterText(u8'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜:')
													imgui.PushItemWidth(478 * settings.general.custom_dpi)
													imgui.InputText(u8'##input_'..title:lower()..'_text', _G['input_'..title:lower()..'_text'], 8192)
													if title == '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜' then
														imgui.CenterText(u8'˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ (˜˜ 1 ˜˜ 6):')
													elseif title == '˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜' then
														imgui.CenterText(u8'˜˜˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜):')
													elseif title == '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜' then
														imgui.CenterText(u8'˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ (˜˜ 1 ˜˜ 10):')
													end
													imgui.PushItemWidth(478 * settings.general.custom_dpi)
													imgui.InputText(u8'##input_'..title:lower()..'_value', _G['input_'..title:lower()..'_value'], 256)
													imgui.CenterText(u8'˜˜˜˜˜˜˜:')
													imgui.PushItemWidth(478 * settings.general.custom_dpi)
													imgui.InputText(u8'##input_'..title:lower()..'_reason', _G['input_'..title:lower()..'_reason'], 1024)
													imgui.EndChild()
												end    
												if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##canceledititem', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
													imgui.CloseCurrentPopup()
												end
												imgui.SameLine()
												if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜##saveedititem', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
													local text = u8:decode(ffi.string(_G['input_'..title:lower()..'_text']))
													local value = u8:decode(ffi.string(_G['input_'..title:lower()..'_value']))
													local reason = u8:decode(ffi.string(_G['input_'..title:lower()..'_reason']))
													local isValid = false
													if title == '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜' then
														isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 6 and text ~= '' and reason ~= ''
													elseif title == '˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜' then
														isValid = value ~= '' and value:find('%d') and not value:find('%D') and text ~= '' and reason ~= ''
													elseif title == '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜' then
														isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 10 and text ~= '' and reason ~= ''
													end
													if isValid then
														item.text = text
														item[title:find('˜˜˜˜˜˜') and 'lvl' or 'amount'] = value
														item.reason = reason
														saveFunction()
														set_updated_at(data, download_file_name, os.time())
														imgui.CloseCurrentPopup()
													else
														sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜!', message_color)
													end
												end
												imgui.EndPopup()
											end
											imgui.SameLine()
											if imgui.Button(fa.TRASH_CAN .. '##' .. chapter_index .. '##' .. title .. index) then
												imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index .. '##' .. index)
											end
											imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
											if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index .. '##' .. index, _, imgui.WindowFlags.NoResize) then
												change_dpi()
												imgui.CenterText(u8'˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜?')
												imgui.Separator()
												if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜, ˜˜˜˜˜˜˜˜##canceldeleteitem', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
													imgui.CloseCurrentPopup()
												end
												imgui.SameLine()
												if imgui.Button(fa.TRASH_CAN .. u8' ˜˜, ˜˜˜˜˜˜˜##yesdeleteitem', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
													table.remove(chapter.item, index)
													saveFunction()
													set_updated_at(data, download_file_name, os.time())
													imgui.CloseCurrentPopup()
												end
												imgui.End()
											end
											imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
											imgui.Columns(1)
											imgui.Separator()
										end
									end
									imgui.EndChild()
								end
								if imgui.Button(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜##smart_add_subitem' .. chapter_index, imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
									_G['input_'..title:lower()..'_text'] = imgui.new.char[8192](u8(''))
									_G['input_'..title:lower()..'_value'] = imgui.new.char[256](u8(''))
									_G['input_'..title:lower()..'_reason'] = imgui.new.char[8192](u8(''))
									imgui.OpenPopup(fa.CIRCLE_PLUS .. u8(' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ') .. fa.CIRCLE_PLUS .. '##smart_add_subitem' .. chapter_index)
								end
								imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
								if imgui.BeginPopupModal(fa.CIRCLE_PLUS .. u8(' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ') .. fa.CIRCLE_PLUS .. '##smart_add_subitem' .. chapter_index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
									if imgui.BeginChild('##smart'..title..'edititeminput', imgui.ImVec2(489 * settings.general.custom_dpi, 150 * settings.general.custom_dpi), true) then   
										change_dpi() 
										imgui.CenterText(u8'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜:')
										imgui.PushItemWidth(478 * settings.general.custom_dpi)
										imgui.InputText(u8'##input_'..title:lower()..'_text', _G['input_'..title:lower()..'_text'], 8192)
										if title == '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜' then
											imgui.CenterText(u8'˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ (˜˜ 1 ˜˜ 6):')
										elseif title == '˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜' then
											imgui.CenterText(u8'˜˜˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜):')
										elseif title == '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜' then
											imgui.CenterText(u8'˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ (˜˜ 1 ˜˜ 10):')
										end
										imgui.PushItemWidth(478 * settings.general.custom_dpi)
										imgui.InputText(u8'##input_'..title:lower()..'_value', _G['input_'..title:lower()..'_value'], 256)
										imgui.CenterText(u8'˜˜˜˜˜˜˜:')
										imgui.PushItemWidth(478 * settings.general.custom_dpi)
										imgui.InputText(u8'##input_'..title:lower()..'_reason', _G['input_'..title:lower()..'_reason'], 8192)
										imgui.EndChild()
									end    
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##' .. chapter_index .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜##' .. chapter_index .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
										local text = u8:decode(ffi.string(_G['input_'..title:lower()..'_text']))
										local value = u8:decode(ffi.string(_G['input_'..title:lower()..'_value']))
										local reason = u8:decode(ffi.string(_G['input_'..title:lower()..'_reason']))
										local isValid = false
										if title == '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜' then
											isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 6 and text ~= '' and reason ~= ''
										elseif title == '˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜' then
											isValid = value ~= '' and value:find('%d') and not value:find('%D') and text ~= '' and reason ~= ''
										elseif title == '˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜' then
											isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 10 and text ~= '' and reason ~= ''
										end
										if isValid then
											table.insert(chapter.item, {text = text, [title:find('˜˜˜˜˜˜') and 'lvl' or 'amount'] = value, reason = reason})
											saveFunction()
											set_updated_at(data, download_file_name, os.time())
											imgui.CloseCurrentPopup()
										else
											sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜!', message_color)
										end
									end
									imgui.EndPopup()
								end
								imgui.SameLine()
								if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜##close' .. chapter_index .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
									imgui.CloseCurrentPopup()
								end
								imgui.EndPopup()
							end
							imgui.Separator()
						end
					end
					imgui.EndChild()	
					if imgui.Button(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜˜˜##smart_add' .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
						_G['input_'..title:lower()..'_name'] = imgui.new.char[512](u8(''))
						imgui.OpenPopup(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. fa.CIRCLE_PLUS)
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. fa.CIRCLE_PLUS, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						imgui.PushItemWidth(400 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##input_'..title:lower()..'_name', u8("˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜..."), _G['input_'..title:lower()..'_name'], 512)
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜##smart_add' .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.CIRCLE_PLUS .. u8' ˜˜˜˜˜˜˜˜ ##smart_add' .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
							local temp = u8:decode(ffi.string(_G['input_'..title:lower()..'_name']))
							table.insert(data, {name = temp, item = {}})
							saveFunction()
							set_updated_at(data, download_file_name, os.time())
							imgui.CloseCurrentPopup()
						end
						imgui.EndPopup()
					end
					imgui.SameLine()
					if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜##smart_close' .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
						imgui.CloseCurrentPopup()
					end
					imgui.EndPopup()
				end
			end
			imgui.CenterText(u8'˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜ ˜˜˜˜˜˜')
			imgui.CenterText(u8'˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜')
			imgui.EndChild()
		end
	end
end
if isMode('prison') then
	imgui.OnFrame(
		function() return MODULE.PumMenu.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 413 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
			imgui.Begin(fa.STAR .. u8" ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ " .. fa.STAR .. "##pum_menu", MODULE.PumMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
			change_dpi()
			if modules.smart_rptp.data ~= nil and isParamSampID(player_id) then
				imgui.PushItemWidth(580 * settings.general.custom_dpi)
				imgui.InputTextWithHint(u8'##input_sum', u8('˜˜˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜˜˜) ˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜˜)'), MODULE.PumMenu.input, 128) 
				imgui.Separator()
				local input_sum_decoded = u8:decode(ffi.string(MODULE.PumMenu.input))
				for _, chapter in ipairs(modules.smart_rptp.data) do
					local chapter_has_matching_item = false
					if chapter.item then
						for _, item in ipairs(chapter.item) do
							if item.text and item.text:rupper():find(input_sum_decoded:rupper(), 1, true) or input_sum_decoded == '' then
								chapter_has_matching_item = true
								break
							end
						end
					end
					if chapter_has_matching_item then
						if imgui.CollapsingHeader(u8(chapter.name)) then
							for index, item in ipairs(chapter.item) do
								if item.text and item.text:rupper():find(input_sum_decoded:rupper(), 1, true) or input_sum_decoded == '' then
									local popup_id = fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. chapter.name .. '_' .. index
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
									imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.00, 0.00, 0.00, 0.65))
									if imgui.Button(u8(split_text_into_lines(item.text, 85))..'##' .. index, imgui.ImVec2(imgui.GetMiddleButtonX(1), (25 * count_lines_in_text(item.text, 85)) * settings.general.custom_dpi)) then
										imgui.OpenPopup(popup_id)
									end
									imgui.PopStyleColor()
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(popup_id, nil, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
										imgui.Text(fa.USER .. u8' ˜˜˜˜˜: ' .. u8(sampGetPlayerNickname(player_id)) .. '[' .. player_id .. ']')
										imgui.Text(fa.STAR .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜: ' .. item.lvl)
										imgui.Text(fa.COMMENT .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜: ' .. u8(item.reason))
										imgui.Separator()
										if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##pum', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.STAR .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜˜##pum', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											MODULE.PumMenu.Window[0] = false
											find_and_use_command('/punish {id} {number} 2 {arg}', player_id .. ' ' .. item.lvl .. ' ' .. item.reason)
											imgui.CloseCurrentPopup()
										end
										imgui.EndPopup()
									end
								end
							end
						end
					end
				end
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ (˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜)!', message_color)
				MODULE.SumMenu.Window[0] = false
			end
			imgui.End()
		end
	)
end
if isMode('police') or isMode('fbi') then
	imgui.OnFrame(
		function() return MODULE.Patrool.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.patrool_menu.x, settings.windows_pos.patrool_menu.y), imgui.Cond.FirstUseEver)
			imgui.Begin(getHelperIcon() .. u8" Arizona Helper " .. getHelperIcon() .. '##patrool_info_menu', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize )
			change_dpi()
			safery_disable_cursor(player)
			if MODULE.Patrool.active then
				imgui.Text(fa.CLOCK .. u8(' ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜: ') .. u8(MODULE.Binder.tag.get_patrool_time()))
				imgui.Text(fa.CIRCLE_INFO .. u8(' ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜: ') .. u8(MODULE.Binder.tag.get_patrool_mark()))
				imgui.Text(fa.CIRCLE_INFO .. u8(' ˜˜˜˜ ˜˜˜˜˜˜˜˜˜: ') .. u8(MODULE.Binder.tag.get_patrool_code()))
				imgui.SameLine()
				if imgui.SmallButton(fa.GEAR) then
					imgui.OpenPopup(fa.BUILDING_SHIELD .. u8(' Arizona Helper##patrool_select_code'))
				end
				imgui.Separator()
				if imgui.Button(fa.WALKIE_TALKIE .. u8(' ˜˜˜˜˜˜'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					if (not MODULE.Patrool.process_doklad) then
						MODULE.Patrool.process_doklad = true
						lua_thread.create(function()
							MODULE.Binder.state.isActive = true
							sampSendChat('/r ' .. MODULE.Binder.tag.my_doklad_nick() .. ' ˜˜ CONTROL.')
							wait(1500)
							sampSendChat('/r ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_area() .. " (" .. MODULE.Binder.tag.get_square() .. ').')
							wait(1500)
							if MODULE.Binder.tag.get_car_units() ~= '˜˜˜˜' then
								sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ' .. MODULE.Binder.tag.get_patrool_format_time() .. ' ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ' .. MODULE.Binder.tag.get_car_units() .. ', ˜˜˜˜˜˜˜˜˜ ' .. u8(MODULE.Binder.tag.get_patrool_code()) .. '.')
							else
								sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ' .. MODULE.Binder.tag.get_patrool_format_time() .. ', ˜˜˜˜˜˜˜˜˜ ' .. u8(MODULE.Binder.tag.get_patrool_code()) .. '.')
							end
							MODULE.Binder.state.isActive = false
							MODULE.Patrool.process_doklad = false
						end)
					end
				end
				imgui.SameLine()
				if imgui.Button(fa.CIRCLE_STOP .. u8(' ˜˜˜˜˜˜˜˜˜'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					lua_thread.create(function()
						MODULE.Patrool.Window[0] = false
						MODULE.Patrool.active = false
						MODULE.Binder.state.isActive = true
						sampSendChat('/r ' .. MODULE.Binder.tag.my_doklad_nick() .. ' ˜˜ CONTROL.')
						wait(1500)
						sampSendChat('/r ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_patrool_mark() .. ', ˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_patrool_code())
						wait(1500)
						sampSendChat('/r ˜˜˜˜˜˜˜˜˜˜˜˜' .. MODULE.Binder.tag.sex() .. ' ' .. MODULE.Binder.tag.get_patrool_format_time())
						MODULE.Patrool.time = 0
						MODULE.Patrool.start_time = 0
						MODULE.Patrool.current_time = 0
						MODULE.Patrool.code = 'CODE4'
						MODULE.Patrool.ComboCode[0] = 5
						wait(1500)
						sampSendChat('/delvdesc')
						MODULE.Binder.state.isActive = false
					end)
				end
			else
				player.HideCursor = false	
				imgui.CenterText(u8('˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜:'))
				imgui.Separator()
				imgui.Text(fa.CIRCLE_INFO .. u8(' ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜: '))
				imgui.SameLine()
				imgui.PushItemWidth(150 * settings.general.custom_dpi)
				if imgui.Combo('##patrool_mark', MODULE.Patrool.ComboMark, MODULE.Patrool.ImItemsMark, #MODULE.Patrool.marks) then
					MODULE.Patrool.mark = MODULE.Patrool.marks[MODULE.Patrool.ComboMark[0] + 1] 
				end
				imgui.Separator()
				imgui.Text(fa.CIRCLE_INFO .. u8(' ˜˜˜˜ ˜˜˜˜˜˜˜˜˜: '))
				imgui.SameLine()
				imgui.PushItemWidth(150 * settings.general.custom_dpi)
				if imgui.Combo('##patrool_code', MODULE.Patrool.ComboCode, MODULE.Patrool.ImItemsCode, #MODULE.Patrool.codes) then
					MODULE.Patrool.code = MODULE.Patrool.codes[MODULE.Patrool.ComboCode[0] + 1]
				end
				imgui.Separator()
				imgui.Text(fa.CIRCLE_INFO .. u8(' ˜˜˜˜˜˜˜˜˜: ') .. u8(MODULE.Binder.tag.get_car_units()))
				imgui.Separator()
				if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜ ', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
					MODULE.Patrool.Window[0] = false
				end
				imgui.SameLine()
				if imgui.Button(fa.WALKIE_TALKIE .. u8' ˜˜˜˜˜˜ ˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
					MODULE.Patrool.time = 0
					MODULE.Patrool.start_time = os.time()
					MODULE.Patrool.active = true
					lua_thread.create(function()
						MODULE.Binder.state.isActive = true
						sampSendChat('/r ' .. MODULE.Binder.tag.my_doklad_nick() .. ' ˜˜ CONTROL.')
						wait(1500)
						sampSendChat('/r ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_area() .. " (" .. MODULE.Binder.tag.get_square() .. ').')
						wait(1500)
						if MODULE.Binder.tag.get_car_units() ~= '˜˜˜˜' then
							sampSendChat('/r ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_patrool_mark() .. ', ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜ ' .. MODULE.Binder.tag.get_car_units() .. ', ˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_patrool_code() .. '.')
						else
							sampSendChat('/r ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_patrool_mark() .. ', ˜˜˜˜˜˜˜˜˜ ' .. MODULE.Binder.tag.get_patrool_code() .. '.')
						end
						wait(1500)
						sampSendChat('/vdesc ' .. MODULE.Binder.tag.get_patrool_mark())
						MODULE.Binder.state.isActive = false
					end)
					imgui.CloseCurrentPopup()
				end
			end
			if imgui.BeginPopup(fa.BUILDING_SHIELD .. u8(' Arizona Helper##patrool_select_code'), _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  ) then
				change_dpi()
				player.HideCursor = false 
				imgui.PushItemWidth(150 * settings.general.custom_dpi)
				if imgui.Combo('##patrool_code', MODULE.Patrool.ComboCode, MODULE.Patrool.ImItemsCode, #MODULE.Patrool.codes) then
					MODULE.Patrool.code = MODULE.Patrool.codes[MODULE.Patrool.ComboCode[0] + 1]
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
			local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
			if posX ~= settings.windows_pos.patrool_menu.x or posY ~= settings.windows_pos.patrool_menu.y then
				settings.windows_pos.patrool_menu = {x = posX, y = posY}
				save_settings()
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.Wanted.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.wanteds_menu.x, settings.windows_pos.wanteds_menu.y), imgui.Cond.FirstUseEver)
			imgui.Begin(fa.STAR .. u8" ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ (˜˜˜˜˜ " .. #MODULE.Wanted.all .. u8') ' .. fa.STAR, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoScrollbar)
			change_dpi()
			
			if tonumber(#MODULE.Wanted.all) == 0 then 
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜!', message_color)
				MODULE.Wanted.Window[0] = false
			end

			safery_disable_cursor(player)
			if settings.mj.auto_update_wanteds then
				local text_time_wait = tostring(15 - tonumber(MODULE.Wanted.updwanteds.time))
				if tonumber(text_time_wait) < 10 then
					text_time_wait = '0' .. text_time_wait
				end
				imgui.Text(u8('˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ') .. tostring(text_time_wait) .. u8(' ˜˜˜˜˜˜'))
				imgui.Separator()
			else
				if imgui.Button(u8'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜', imgui.ImVec2(340 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					MODULE.Wanted.Window[0] = false
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /wanteds ˜ /helper - ˜˜˜˜˜˜˜ ' .. modules.player.data.fraction_tag .. '!', message_color)
					sampProcessChatInput('/wanteds')
				end
				imgui.Separator()
			end	
			imgui.Columns(3)
			imgui.CenterColumnText(u8("˜˜˜˜˜˜˜"))
			imgui.SetColumnWidth(-1, 200 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8("˜˜˜˜˜˜"))
			imgui.SetColumnWidth(-1, 65 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8("˜˜˜˜˜˜˜˜˜˜"))
			imgui.SetColumnWidth(-1, 80 * settings.general.custom_dpi)
			imgui.Columns(1)
			for i, v in ipairs(MODULE.Wanted.all) do
				imgui.Separator()
				imgui.Columns(3)
				if sampGetPlayerColor(v.id) == 368966908 then
					imgui_RGBA = (settings.general.helper_theme ~= 2) and imgui.ImVec4(1, 1, 1, 1) or imgui.ImVec4(0, 0, 0, 1)
					imgui.CenterColumnColorText(imgui_RGBA, u8(v.nick) .. ' [' .. v.id .. ']')
				else
					local rgbNormalized = argbToRgbNormalized(sampGetPlayerColor(v.id))
					local imgui_RGBA = imgui.ImVec4(rgbNormalized[1], rgbNormalized[2], rgbNormalized[3], 1)
					imgui.CenterColumnColorText(imgui_RGBA, u8(v.nick) .. ' [' .. v.id .. ']')
				end
				if imgui.IsItemClicked() and not v.dist:find('˜ ˜˜˜˜˜˜˜˜˜') then
					sampSendChat('/pursuit ' .. v.id)
				end
				imgui.NextColumn()
				imgui.CenterColumnText(u8(v.lvl) .. ' ' .. fa.STAR)
				imgui.NextColumn()
				imgui.CenterColumnText(u8(v.dist))
				imgui.NextColumn()
				imgui.Columns(1)
			end
			local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
			if posX ~= settings.windows_pos.wanteds_menu.x or posY ~= settings.windows_pos.wanteds_menu.y then
				settings.windows_pos.wanteds_menu = {x = posX, y = posY}
				save_settings()
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.SumMenu.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 413 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
			imgui.Begin(fa.STAR .. u8" ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ " .. fa.STAR .. "##sum_menu", MODULE.SumMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
			change_dpi()
			if modules.smart_uk.data ~= nil and isParamSampID(player_id) then
				imgui.PushItemWidth(580 * settings.general.custom_dpi)
				imgui.InputTextWithHint(u8'##input_sum', u8('˜˜˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜˜˜) ˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜˜)'), MODULE.SumMenu.input, 128) 
				imgui.Separator()
				local input_sum_decoded = u8:decode(ffi.string(MODULE.SumMenu.input))
				for _, chapter in ipairs(modules.smart_uk.data) do
					local chapter_has_matching_item = false
					if chapter.item then
						for _, item in ipairs(chapter.item) do
							if item.text and item.text:rupper():find(input_sum_decoded:rupper(), 1, true) or input_sum_decoded == '' then
								chapter_has_matching_item = true
								break
							end
						end
					end
					if chapter_has_matching_item then
						if imgui.CollapsingHeader(u8(chapter.name)) then
							for index, item in ipairs(chapter.item) do
								if item.text and item.text:rupper():find(input_sum_decoded:rupper(), 1, true) or input_sum_decoded == '' then
									local popup_id = fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. chapter.name .. '_' .. index
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
									imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.00, 0.00, 0.00, 0.65))
									if imgui.Button("> " .. u8(split_text_into_lines(item.text, 85))..'##' .. index, imgui.ImVec2(imgui.GetMiddleButtonX(1), (25 * count_lines_in_text(item.text, 85)) * settings.general.custom_dpi)) then
										imgui.OpenPopup(popup_id)
									end
									imgui.PopStyleColor()
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(popup_id, nil, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
										imgui.Text(fa.USER .. u8' ˜˜˜˜˜: ' .. u8(sampGetPlayerNickname(player_id)) .. '[' .. player_id .. ']')
										imgui.Text(fa.STAR .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜: ' .. item.lvl)
										imgui.Text(fa.COMMENT .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜: ' .. u8(item.reason))
										imgui.Separator()
										if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##sum', imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.WALKIE_TALKIE .. u8' ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜##sum', imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											MODULE.SumMenu.Window[0] = false
											find_and_use_command('˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜ %{number%} ˜˜˜˜˜˜˜ ˜˜˜˜ N%{id%}%. ˜˜˜˜˜˜˜%: %{arg%}', player_id .. ' ' .. item.lvl .. ' ' .. item.reason)
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										local text_rank = ((modules.player.data.fraction == 'FBI' or modules.player.data.fraction == '˜C˜') and '[4+]' or '[5+]')
										if imgui.Button(fa.STAR .. u8' ˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. text_rank, imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											MODULE.SumMenu.Window[0] = false
											find_and_use_command('/su {id} {number} {arg}', player_id .. ' ' .. item.lvl .. ' ' .. item.reason)
											imgui.CloseCurrentPopup()
										end
										imgui.EndPopup()
									end
								end
							end
						end
					end
				end
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜)!', message_color)
				MODULE.SumMenu.Window[0] = false
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.TsmMenu.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 413 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
			imgui.Begin(fa.TICKET .. u8" ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜ " .. fa.TICKET .. "##tsm_menu", MODULE.TsmMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
			change_dpi()
			if modules.smart_pdd.data ~= nil and isParamSampID(player_id) then
				imgui.PushItemWidth(580 * settings.general.custom_dpi)
				imgui.InputTextWithHint(u8'##input_tsm', u8('˜˜˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜˜˜˜˜) ˜ ˜˜˜˜˜˜ (˜˜˜˜˜˜˜)'), MODULE.TsmMenu.input, 128) 
				imgui.Separator()
				local input_tsm_decoded = u8:decode(ffi.string(MODULE.TsmMenu.input))
				for _, chapter in ipairs(modules.smart_pdd.data) do
					local chapter_has_matching_item = false
					if chapter.item then
						for _, item in ipairs(chapter.item) do
							if item.text and item.text:rupper():find(input_tsm_decoded:rupper(), 1, true) or input_tsm_decoded == '' then
								chapter_has_matching_item = true
								break
							end
						end
					end
					if chapter_has_matching_item then
						if imgui.CollapsingHeader(u8(chapter.name)) then
							for index, item in ipairs(chapter.item) do
								if item.text and item.text:rupper():find(input_tsm_decoded:rupper(), 1, true) or input_tsm_decoded == '' then
									local popup_id = fa.TRIANGLE_EXCLAMATION .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. chapter.name .. '_' .. index
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
									imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.00, 0.00, 0.00, 0.65))
									if imgui.Button(u8(split_text_into_lines(item.text,85))..'##' .. index, imgui.ImVec2( imgui.GetMiddleButtonX(1), (25 * count_lines_in_text(item.text, 85)) * settings.general.custom_dpi)) then
										imgui.OpenPopup(popup_id)
									end 
									imgui.PopStyleColor()
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(popup_id, nil, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
										imgui.Text(fa.USER .. u8' ˜˜˜˜˜: ' .. u8(sampGetPlayerNickname(player_id)) .. '[' .. player_id .. ']')
										imgui.Text(fa.MONEY_CHECK_DOLLAR .. u8' ˜˜˜˜˜ ˜˜˜˜˜˜: $' .. item.amount)
										imgui.Text(fa.COMMENT .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜: ' .. u8(item.reason))
										imgui.Separator()
										if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜##tsm', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.TICKET .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜˜˜##tsm', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											MODULE.TsmMenu.Window[0] = false
											find_and_use_command('ticket {id}', player_id .. ' ' .. item.amount .. ' ' .. item.reason)
											imgui.CloseCurrentPopup()
										end
										imgui.EndPopup()
									end
								end
							end
						end
					end
				end
			else
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ (˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜)!', message_color)
				MODULE.TsmMenu.Window[0] = false
			end
			imgui.End()
		end
	)
end
if isMode('hospital') then
	imgui.OnFrame(
		function() return MODULE.MedCard.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(fa.HOSPITAL.." Arizona Helper " .. fa.HOSPITAL .. "##medcard", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
			change_dpi()
			imgui.CenterText(u8'˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜.˜˜˜˜˜:')
			if imgui.RadioButtonIntPtr(u8" 7 ˜˜˜˜ ##0",MODULE.MedCard.days,0) then
				MODULE.MedCard.days[0] = 0
			end
			if imgui.RadioButtonIntPtr(u8" 14 ˜˜˜˜ ##1",MODULE.MedCard.days,1) then
				MODULE.MedCard.days[0] = 1
			end
			if imgui.RadioButtonIntPtr(u8" 30 ˜˜˜˜ ##2",MODULE.MedCard.days,2) then
				MODULE.MedCard.days[0] = 2
			end
			if imgui.RadioButtonIntPtr(u8" 60 ˜˜˜˜ ##3",MODULE.MedCard.days,3) then
				MODULE.MedCard.days[0] = 3
			end
			imgui.Separator()
			imgui.CenterText(u8'C˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜:')
			if imgui.RadioButtonIntPtr(u8" ˜˜ ˜˜˜˜˜˜˜˜˜ ##0", MODULE.MedCard.status,0) then
				MODULE.MedCard.status[0] = 0
			end
			if imgui.RadioButtonIntPtr(u8" ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ##1", MODULE.MedCard.status,1) then
				MODULE.MedCard.status[0] = 1
			end
			if imgui.RadioButtonIntPtr(u8" ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ##2", MODULE.MedCard.status,2) then
				MODULE.MedCard.status[0] = 2
			end
			if imgui.RadioButtonIntPtr(u8" ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ##3", MODULE.MedCard.status,3) then
				MODULE.MedCard.status[0] = 3
			end
			imgui.Separator()
			local label = ' ˜˜˜˜˜˜ ' .. ((hotkey_no_errors and settings.general.bind_action) and ('[' .. getNameKeysFrom(settings.general.bind_action) .. ']') or '˜˜˜.˜˜˜˜˜')
			if imgui.Button(fa.ID_CARD_CLIP .. u8(label), imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				MODULE.MedCard.Window[0] = false
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.Recept.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(fa.HOSPITAL.." Arizona Helper " .. fa.HOSPITAL .. "##recept", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
			change_dpi()
			imgui.CenterText(u8'˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜:')
			imgui.PushItemWidth(250 * settings.general.custom_dpi)
			imgui.SliderInt('', MODULE.Recept.recepts, 1, 5)
			imgui.Separator()
			local label = ' ˜˜˜˜˜˜ ' .. ((hotkey_no_errors and settings.general.bind_action) and ('[' .. getNameKeysFrom(settings.general.bind_action) .. ']') or '˜˜˜˜˜˜˜')
			if imgui.Button(fa.CAPSULES .. u8(label), imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				MODULE.Recept.Window[0] = false
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.Antibiotik.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(fa.HOSPITAL.." Arizona Helper " .. fa.HOSPITAL .. "##ant", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
			change_dpi()
			imgui.CenterText(u8'˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜:')
			imgui.PushItemWidth(250 * settings.general.custom_dpi)
			imgui.SliderInt('', MODULE.Antibiotik.ants, 1, 20)
			imgui.Separator()
			local label = ' ˜˜˜˜˜˜ ' .. ((hotkey_no_errors and settings.general.bind_action) and ('[' .. getNameKeysFrom(settings.general.bind_action) .. ']') or '˜˜˜˜˜˜˜˜˜˜˜')
			if imgui.Button(fa.CAPSULES .. u8(label), imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				MODULE.Antibiotik.Window[0] = false
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.HealChat.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 8.5, sizeY / 1.9), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(fa.HOSPITAL.." Arizona Helper " .. fa.HOSPITAL .. "##fast_heal", MODULE.HealChat.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar +  imgui.WindowFlags.AlwaysAutoResize )
			change_dpi()
			if imgui.Button(fa.KIT_MEDICAL..u8' ˜˜˜˜˜˜˜˜ '.. u8(sampGetPlayerNickname(MODULE.HealChat.player_id))) then
				find_and_use_command("/heal {id}", MODULE.HealChat.player_id)
				MODULE.HealChat.bool = false
				MODULE.HealChat.player_id = nil
				MODULE.HealChat.Window[0] = false
			end
			imgui.End()
		end
	)
end
if isMode('smi') then
	imgui.OnFrame(
		function() return MODULE.SmiEdit.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			local size_window_y = settings.smi.ads_buttons and 301.5 or 137
			imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, size_window_y * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
			imgui.Begin(getHelperIcon() .. u8" Arizona Helper " .. getHelperIcon() .. '##MODULE.SmiEdit.Window', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar )
			change_dpi()
			imgui.Text(fa.CIRCLE_INFO .. u8" ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜: " .. u8(MODULE.SmiEdit.ad_from) .. '[' .. sampGetPlayerIdByNickname(MODULE.SmiEdit.ad_from) .. ']')
			imgui.Text(fa.CIRCLE_INFO .. u8" ˜˜˜˜˜: " .. (u8(MODULE.SmiEdit.ad_message)))
			imgui.SameLine()
			if imgui.SmallButton(fa.CIRCLE_ARROW_RIGHT) then
				imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(MODULE.SmiEdit.ad_message))
			end
			if imgui.IsItemHovered() then
				imgui.SetTooltip(u8'˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜')
			end
			imgui.Separator()
			local window_size = imgui.GetWindowSize()
			local size_item_width = (settings.smi.ads_history and 105 or 75)
			imgui.PushItemWidth(window_size.x - size_item_width * settings.general.custom_dpi)
			imgui.InputTextWithHint(
				"##smi_edit_ad",
				u8"˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜˜",
				MODULE.SmiEdit.input_edit_text,
				256,
				imgui.InputTextFlags.CallbackAlways + imgui.InputTextFlags.CallbackCompletion, 
				TextEditCallback
			)
			imgui.SameLine()
			if imgui.Button(fa.DELETE_LEFT, imgui.ImVec2(27 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text))
				if #text > 0 then imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text:sub(1, -2))) end
			end
			imgui.SameLine()
			if imgui.Button(fa.TRASH_CAN, imgui.ImVec2(25 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				imgui.StrCopy(MODULE.SmiEdit.input_edit_text, '')
			end
			if settings.smi.ads_history then
				imgui.SameLine()
				if imgui.Button(fa.CLOCK_ROTATE_LEFT, imgui.ImVec2(25 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					imgui.OpenPopup(fa.CLOCK_ROTATE_LEFT .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜')	
				end
				if imgui.IsItemHovered() then
					imgui.SetTooltip(u8'˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜')
				end
				imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
				if imgui.BeginPopupModal(fa.CLOCK_ROTATE_LEFT .. u8' ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
					imgui.SetWindowSizeVec2(imgui.ImVec2(610 * settings.general.custom_dpi, 350 * settings.general.custom_dpi))
					if imgui.BeginChild('##99999999', imgui.ImVec2(600 * settings.general.custom_dpi, 285 * settings.general.custom_dpi), true) then	
						change_dpi()
						if modules.ads_history.data then 
							if #modules.ads_history.data == 0 then
								imgui.CenterText(u8('˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜'))
								imgui.CenterText(u8('˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜'))
							else
								imgui.PushItemWidth(579 * settings.general.custom_dpi)
								imgui.InputTextWithHint(u8'##input_ads_search', u8'˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜, ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜...', MODULE.SmiEdit.input_search, 128)
								imgui.Separator()
								local input_ads_decoded = u8:decode(ffi.string(MODULE.SmiEdit.input_search))
								local shown = {}
								for id, ad in ipairs(modules.ads_history.data) do
									if ad and ad.text and ad.my_text then
										local text = ad.my_text
										if not shown[text] then
											if input_ads_decoded == '' or (text:rupper():find(input_ads_decoded:rupper(), 1, true)) then
												if imgui.Button(u8(text .. '##' .. id), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
													imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
													imgui.CloseCurrentPopup()
												end
												shown[text] = true
											end
										end
									end
								end
							end
						else
							imgui.CenterText(u8('˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜, ˜˜˜-˜˜ ˜˜˜˜˜˜˜˜˜'))
							imgui.Separator()
							imgui.CenterText(u8('˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ Ads.json, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜:'))
							imgui.TextWrapped(u8(modules.ads_history.path))
							imgui.Separator()
							imgui.CenterText(u8('˜˜˜˜ ˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜, ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜ CP1251 ˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜'))
						end
						imgui.EndChild()
					end		
					if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						imgui.CloseCurrentPopup()
					end
					imgui.EndPopup()
				end
			end
			imgui.Separator()
			if settings.smi.ads_buttons then
				local smi_groups = {
					{
						id = "##1",
						width = 105,
						per_row = 1,
						items = {
							"˜˜˜˜˜",
							"˜˜˜˜˜˜",
							"˜˜˜˜˜˜˜",
							"˜˜˜˜ ˜ ˜˜˜˜˜˜",
							"˜˜˜˜˜˜˜",
						}
					},
					{
						id = "##2",
						width = 150,
						per_row = 4,
						items = {
							-- ˜˜˜˜˜˜˜˜˜˜, ˜˜˜˜˜
							"˜/˜", "˜/˜", "˜/˜", "˜/˜", 
							-- ˜˜˜˜˜˜˜˜˜
							"˜/˜", "˜/˜", "˜/˜", "˜/˜",
							"˜/˜", "˜/˜", "˜/˜", "˜/˜",
							-- ˜˜˜˜˜˜
							"˜/˜", "˜/˜", "˜/˜", "˜/˜", 
							"˜/˜", "˜/˜", "˜/˜", "˜/˜", 
						}
					},
					{
						id = "##3",
						width = 70,
						per_row = 1,
						items = {
							"˜˜˜˜˜",
							"˜˜˜˜˜˜˜",
							"˜˜˜˜˜",
							"˜˜˜˜˜˜˜",
							"˜˜˜˜˜˜",
						}
					},
					{
						id = "##4",
						width = 90,
						per_row = 1,
						items = {
							"˜˜˜˜:",
							"˜˜˜˜ ˜˜ ˜˜:",
							"˜˜˜˜˜˜˜˜˜˜",
							"˜˜˜˜˜˜:",
							"˜˜˜˜˜˜˜˜˜",
						}
					},
					{
						id = "##5",
						width = 100,
						per_row = 3,
						items = {
							"1","2","3",
							"4","5","6",
							"7","8","9",
							".","0", ',',
							"˜ ˜˜˜˜˜˜˜˜˜˜˜ +"
						}
					},
					{
						id = "##6",
						width = 50,
						per_row = 1,
						items = {"$", '"', "˜˜˜.", "˜˜˜", "˜˜˜˜"}
					}
				}
				for gi, group in ipairs(smi_groups) do
					if imgui.BeginChild(group.id, imgui.ImVec2(group.width * settings.general.custom_dpi, 155 * settings.general.custom_dpi), true) then
						imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
						if imgui.BeginPopupModal(fa.CAR .. u8" ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ " .. fa.CAR, nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoMove) then
							imgui.PushItemWidth(200 * settings.general.custom_dpi)
							imgui.InputTextWithHint(u8(''), u8('˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜...'), MODULE.SmiEdit.input_search, 64)
							imgui.Separator()
							local input_decoded = u8:decode(ffi.string(MODULE.SmiEdit.input_search)):rlower()
							if imgui.BeginChild("veh_list", imgui.ImVec2(200 * settings.general.custom_dpi, 150 * settings.general.custom_dpi), true) then
								for id, name in pairs(modules.arz_veh.byId or {}) do
									if input_decoded == "" or name:rlower():find(input_decoded) then
										if imgui.Selectable(u8(name)) then
											insert_to_cursor('"' .. u8(name) .. '" ', MODULE.SmiEdit.input_edit_text)
											imgui.CloseCurrentPopup()
										end
									end
								end
								imgui.EndChild()
							end
							if imgui.Button(fa.CIRCLE_XMARK .. u8(" ˜˜˜˜˜˜˜"), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
								imgui.CloseCurrentPopup()
							end
							imgui.EndPopup()
						end
						imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
						if imgui.BeginPopupModal(fa.BUILDING .. u8" ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜/˜˜˜˜˜ " .. fa.BUILDING, nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoMove) then
							local orgs = {
								'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜ "". ˜˜˜ ˜ ˜˜˜˜˜',
								'˜˜˜ ˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ "". ˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜',
								'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜ "". ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜',
								'˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜. ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜',
								'˜˜˜˜˜˜˜˜ ˜˜˜˜˜ "" ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜. ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜',
								'˜˜˜˜˜ "" ˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜. ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜',
							}
							for id, text in pairs(orgs) do
								if imgui.Selectable(u8(text)) then
									imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
									imgui.CloseCurrentPopup()
								end
							end
							imgui.Separator()
							if imgui.Button(fa.CIRCLE_XMARK .. u8(" ˜˜˜˜˜˜˜"), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
								imgui.CloseCurrentPopup()
							end
							imgui.EndPopup()
						end
						imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
						if imgui.BeginPopupModal(fa.HOUSE .. u8" ˜˜˜˜˜ " .. fa.HOUSE, nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoMove) then
							local houses = {
								'˜˜˜ ˜',
								'˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜',
								'˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜',
								'˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜ ˜',
								'˜˜˜ ˜˜ ˜˜˜˜˜˜',
								'˜˜˜˜˜˜˜˜ ˜'
							}
							for id, text in pairs(houses) do
								if imgui.Selectable(u8(text)) then
									insert_to_cursor(u8(text) .. ' ', MODULE.SmiEdit.input_edit_text)
									imgui.CloseCurrentPopup()
								end
							end
							imgui.Separator()
							if imgui.Button(fa.CIRCLE_XMARK .. u8(" ˜˜˜˜˜˜˜"), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
								imgui.CloseCurrentPopup()
							end
							imgui.EndPopup()
						end
						imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
						if imgui.BeginPopupModal(fa.SHOP .. u8" ˜˜˜˜˜˜˜ " .. fa.SHOP, nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoMove) then
							local business = {
								'˜˜˜', '˜˜˜˜˜˜ ˜˜˜', '˜˜˜', '˜˜˜˜˜', '˜˜˜˜˜˜˜˜˜˜', '˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜ ˜˜˜˜', '˜˜˜˜˜˜˜ 24 ˜˜ 7', '˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜˜˜˜˜˜˜˜', '˜˜˜', 
								'˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜ ˜˜˜˜˜˜', '˜˜˜˜˜', '˜˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜˜˜', '˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜',
								'˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜', '˜˜˜˜˜ ˜˜˜˜˜˜', '˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜', '˜˜˜˜˜', 
								'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜ ˜˜˜˜˜˜', '˜˜˜˜˜˜ ˜˜˜˜', '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', '˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜'
							}
							imgui.PushItemWidth(200 * settings.general.custom_dpi)
							imgui.InputTextWithHint(u8(''), u8('˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜...'), MODULE.SmiEdit.input_search, 64)
							imgui.Separator()
							local input_decoded = u8:decode(ffi.string(MODULE.SmiEdit.input_search)):rlower()
							if imgui.BeginChild("bizlist", imgui.ImVec2(200 * settings.general.custom_dpi, 150 * settings.general.custom_dpi), true) then
								for id, name in pairs(business) do
									if input_decoded == "" or name:rlower():find(input_decoded) then
										if imgui.Selectable(u8(name)) then
											insert_to_cursor('"' .. u8(name) .. '" ', MODULE.SmiEdit.input_edit_text)
											imgui.CloseCurrentPopup()
										end
									end
								end
								imgui.EndChild()
							end
							imgui.Separator()
							if imgui.Button(fa.CIRCLE_XMARK .. u8(" ˜˜˜˜˜˜˜"), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
								imgui.CloseCurrentPopup()
							end
							imgui.EndPopup()
						end
						imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
						if imgui.BeginPopupModal(fa.MAP_LOCATION_DOT .. u8" ˜˜˜˜˜˜˜ " .. fa.MAP_LOCATION_DOT, nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoMove) then
							local locations = {
								'˜. ˜˜˜-˜˜˜˜˜˜.', '˜. ˜˜˜-˜˜˜˜˜˜.', '˜. ˜˜˜-˜˜˜˜˜˜˜˜.', '˜. ˜˜˜˜˜˜˜.', '˜. ˜˜˜˜˜.', 
								'˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜.', '˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜.', '˜˜˜˜˜˜˜ ˜˜˜˜˜˜.',
								'˜. ˜˜˜˜˜˜˜˜ ˜˜˜˜.', '˜. ˜˜˜ ˜˜˜˜˜˜˜.', '˜. ˜˜˜˜˜˜˜˜˜˜.', '˜. ˜˜˜ ˜˜˜˜˜˜˜˜.', '˜. ˜˜˜˜˜ ˜˜˜˜.', 
								'˜. ˜˜˜ ˜˜˜˜˜˜˜˜.', '˜. ˜˜˜ ˜˜˜˜˜˜˜˜.', '˜. ˜˜˜˜˜˜ ˜˜˜˜˜˜.', '˜. ˜˜˜˜˜˜˜˜.', '˜. ˜˜˜˜˜˜˜˜.',
								'˜˜˜˜˜˜˜ ˜˜', '˜˜˜˜˜˜˜ ˜˜', '˜˜˜˜˜˜˜ ˜˜', '˜˜˜˜˜˜˜ ˜˜', '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜ ˜˜˜˜˜˜', '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜',
								'˜˜˜', '˜˜˜', "˜˜˜", '˜˜˜˜˜ ˜˜', '˜˜˜˜˜ ˜˜', '˜˜˜˜˜', '˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜',
								'TV ˜˜˜˜˜˜', 'TV ˜˜˜˜˜˜ ˜˜', 'TV ˜˜˜˜˜˜ ˜˜', 'TV ˜˜˜˜˜˜ ˜˜', 'TV ˜˜˜˜˜˜ ˜˜', '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜',
								'˜˜˜˜˜˜˜˜ ˜˜', '˜˜˜˜˜˜˜˜ ˜˜', '˜˜˜˜˜˜˜˜ ˜˜', '˜˜˜˜˜˜˜˜ ˜˜', '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜', '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜',
								'˜˜˜˜˜˜˜˜˜˜˜˜˜', '˜˜˜', '˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜', '˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜',
								'˜˜˜˜˜˜˜ ˜˜˜˜˜', 'Yakuza', 'La Cosa Nostra', 'Warlock MC', 'Tierra Robada Bikers', '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜', '˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜',
								'Grove Street', 'Los Santos Vagos', 'East Side Ballas', 'Varrios Los Aztecas', 'The Rifa', 'Night Wolves'
							}
							imgui.PushItemWidth(200 * settings.general.custom_dpi)
							imgui.InputTextWithHint(u8(''), u8('˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜...'), MODULE.SmiEdit.input_search, 64)
							imgui.Separator()
							local input_decoded = u8:decode(ffi.string(MODULE.SmiEdit.input_search)):rlower()
							if imgui.BeginChild("locateslist", imgui.ImVec2(200 * settings.general.custom_dpi, 150 * settings.general.custom_dpi), true) then
								for id, name in pairs(locations) do
									if input_decoded == "" or name:rlower():find(input_decoded) then
										if imgui.Selectable(u8(name)) then
											insert_to_cursor(u8(name) .. ' ', MODULE.SmiEdit.input_edit_text)
											imgui.CloseCurrentPopup()
										end
									end
								end
								imgui.EndChild()
							end
							imgui.Separator()
							if imgui.Button(fa.CIRCLE_XMARK .. u8(" ˜˜˜˜˜˜˜"), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
								imgui.CloseCurrentPopup()
							end
							imgui.EndPopup()
						end
						for i, label in ipairs(group.items) do
							local btns = (label == '˜ ˜˜˜˜˜˜˜˜˜˜˜ +') and 1 or group.per_row
							if imgui.Button(u8(label), imgui.ImVec2(imgui.GetMiddleButtonX(btns), 25 * settings.general.custom_dpi)) then
								if label == "˜˜˜˜˜" then
									imgui.OpenPopup(fa.HOUSE .. u8" ˜˜˜˜˜ " .. fa.HOUSE)
								elseif label == "˜˜˜˜˜" then
									imgui.OpenPopup(fa.CAR .. u8" ˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ " .. fa.CAR)
								elseif label == "˜˜˜˜˜˜˜" then
									imgui.OpenPopup(fa.MAP_LOCATION_DOT .. u8" ˜˜˜˜˜˜˜ " .. fa.MAP_LOCATION_DOT)
								elseif label == "˜˜˜˜˜˜˜" then
									imgui.OpenPopup(fa.SHOP .. u8" ˜˜˜˜˜˜˜ " .. fa.SHOP)
								elseif label == "˜˜˜˜˜˜" then
									imgui.OpenPopup(fa.BUILDING .. u8" ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜˜˜/˜˜˜˜˜ " .. fa.BUILDING)
								else
									local text_to_insert = ''
									if group.id:find('1') or group.id:find('2') or (group.id:find('4') and label ~= '˜˜˜˜˜˜˜˜˜˜' and label ~= '˜˜˜˜˜˜˜˜˜') then
										text_to_insert = label .. ' '
									else
										text_to_insert = label
									end
									insert_to_cursor(u8(text_to_insert), MODULE.SmiEdit.input_edit_text)
								end
							end
							if group.per_row > 1 and (i % group.per_row ~= 0) then imgui.SameLine() end
						end
						imgui.EndChild()
					end
					if gi < #smi_groups then imgui.SameLine() end
				end
				imgui.Separator()
			end
			if imgui.Button(fa.CIRCLE_ARROW_RIGHT .. u8" ˜˜˜˜˜˜˜˜˜˜˜˜", imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
				local ad_text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text))
				if ad_text == '' then return end
				if modules.ads_history.data then
					if settings.smi.ads_history then
						local exists = false
						for _, ad in ipairs(modules.ads_history.data) do
							if ad and ad.text and ad.text == MODULE.SmiEdit.ad_message then
								exists = true
								break
							end
						end
						if not exists then
							table.insert(modules.ads_history.data, 1, {text = MODULE.SmiEdit.ad_message, my_text = ad_text})
							save_module('ads_history')
						end
					end
				else	
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜ ˜˜˜˜ ' .. modules.ads_history.path, message_color)
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜ ˜˜˜, ˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜, ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ (˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜ 1251)', message_color)
					play_sound()
				end
				if MODULE.SmiEdit.vip_pause then
					lua_thread.create(function()
						sampAddChatMessage('[Furry Helper | ˜˜˜˜˜˜˜˜˜] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜ 10 ˜˜˜ ˜˜˜˜˜ VIP ˜˜˜˜˜˜, ˜˜˜˜˜...', message_color)
						play_sound()
						MODULE.SmiEdit.Window[0] = false
						while MODULE.SmiEdit.vip_pause do wait(0) end
						try_send_ad(ad_text)
					end)
				else
					if try_send_ad(ad_text) then
						MODULE.SmiEdit.Window[0] = false
					end
				end
			end
			imgui.SameLine()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
				if u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) == '' then
					reason_cancel = '˜˜˜˜˜ ˜˜˜'
				else
					reason_cancel = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text))
				end
				sampSendDialogResponse(MODULE.SmiEdit.ad_dialog_id, 0, 0, reason_cancel)
				imgui.StrCopy(MODULE.SmiEdit.input_edit_text, '')
				MODULE.SmiEdit.Window[0] = false
				MODULE.SmiEdit.is_active_ad = false
			end
			imgui.SameLine()
			if imgui.Button(fa.FORWARD .. u8' ˜˜˜˜˜˜˜˜˜˜', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
				MODULE.SmiEdit.skip_dialog = true
				sampSendChat('/mm')
				imgui.StrCopy(MODULE.SmiEdit.input_edit_text, '')
				MODULE.SmiEdit.is_active_ad = false
				MODULE.SmiEdit.Window[0] = false
			end
			imgui.End()
		end
	)
end
if isMode('gov') then
	imgui.OnFrame(
		function() return MODULE.Zeks.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.zeks_menu.x, settings.windows_pos.zeks_menu.y), imgui.Cond.FirstUseEver)
			imgui.Begin(fa.HANDCUFFS .. u8" ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ (˜˜˜˜˜ " .. #MODULE.Zeks.all .. u8') ' .. fa.HANDCUFFS, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoScrollbar)
			change_dpi()
			if tonumber(#MODULE.Zeks.all) == 0 then 
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
				MODULE.Zeks.Window[0] = false
			end
			safery_disable_cursor(player)
			if settings.gov.auto_update_zeks then
				local text_time_wait = tostring(15 - tonumber(MODULE.Zeks.updzeks.time))
				if tonumber(text_time_wait) < 10 then
					text_time_wait = '0' .. text_time_wait
				end
				imgui.Text(u8('˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜ ') .. tostring(text_time_wait) .. u8(' ˜˜˜˜˜˜'))
				imgui.Separator()
			else
				if imgui.Button(u8'˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜', imgui.ImVec2(450 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					MODULE.Zeks.Window[0] = false
					sampAddChatMessage('[Furry Helper] {ffffff}˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜-˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ /zeks ˜ /helper - ˜˜˜˜˜˜˜ ' .. modules.player.data.fraction_tag .. '!', message_color)
					sampProcessChatInput('/zeks')
				end
				imgui.Separator()
			end	
			imgui.Columns(4)
			imgui.CenterColumnText(u8("˜˜˜˜˜˜˜"))
			imgui.SetColumnWidth(-1, 200 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8("˜˜˜˜˜"))
			imgui.SetColumnWidth(-1, 65 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8("˜˜˜˜˜˜˜˜˜˜"))
			imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8("˜˜˜˜˜˜˜"))
			imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
			imgui.Columns(1)
			for i, v in ipairs(MODULE.Zeks.all) do
				imgui.Separator()
				imgui.Columns(4)
				if sampGetPlayerColor(v.id) == 368966908 then
					imgui_RGBA = (settings.general.helper_theme ~= 2) and imgui.ImVec4(1, 1, 1, 1) or imgui.ImVec4(0, 0, 0, 1)
					imgui.CenterColumnColorText(imgui_RGBA, u8(v.nick) .. ' [' .. v.id .. ']')
				else
					local rgbNormalized = argbToRgbNormalized(sampGetPlayerColor(v.id))
					local imgui_RGBA = imgui.ImVec4(rgbNormalized[1], rgbNormalized[2], rgbNormalized[3], 1)
					imgui.CenterColumnColorText(imgui_RGBA, u8(v.nick) .. ' [' .. v.id .. ']')
				end
				imgui.NextColumn()
				imgui.CenterColumnText(u8(v.time .. ' ˜˜˜.'))
				imgui.NextColumn()
				imgui.CenterColumnText(u8(v.kpz))
				imgui.NextColumn()
				imgui.CenterColumnText(u8(v.adv))
				imgui.Columns(1)
			end
			
			local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
			if posX ~= settings.windows_pos.zeks_menu.x or posY ~= settings.windows_pos.zeks_menu.y then
				settings.windows_pos.zeks_menu = {x = posX, y = posY}
				save_settings()
			end
			imgui.End()
		end
	)
end
----------------------------------------- FAST MENU GUI -------------------------------------------
imgui.OnFrame(
    function() return MODULE.FastMenu.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(fa.USER .. ' '.. u8(sampGetPlayerNickname(player_id)) ..' ['..player_id.. ']##FastMenu', MODULE.FastMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		local check = false
		for _, command in ipairs(modules.commands.data.commands.my) do
			if command.enable and command.arg == '{id}' and command.in_fastmenu then
				if imgui.Button(u8(command.description), imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
					sampProcessChatInput("/" .. command.cmd .. " " .. player_id)
					MODULE.FastMenu.Window[0] = false
				end
				check = true
			end
		end
		if not check then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ FastMenu ˜ /helper - ˜˜˜˜˜˜˜ ˜ RP ˜˜˜˜˜˜˜˜˜ - ˜˜˜˜ ˜˜˜˜ - FastMenu', message_color)
			MODULE.FastMenu.Window[0] = false
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.FastMenuButton.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.mobile_fastmenu_button.x, settings.windows_pos.mobile_fastmenu_button.y), imgui.Cond.FirstUseEver)
		imgui.Begin(fa.BUILDING_SHIELD .." Arizona Helper##fast_menu_button", MODULE.FastMenuButton.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoScrollbar)
		change_dpi()
		if imgui.Button(fa.IMAGE_PORTRAIT .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜˜˜ ') then
			local players = get_players()
			if #players == 1 then
				show_fast_menu(players[1])
				MODULE.FastMenuButton.Window[0] = false
			elseif #players > 1 then
				MODULE.FastMenuPlayers.Window[0] = true
				MODULE.FastMenuButton.Window[0] = false
			end
		end
		local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
		if posX ~= settings.windows_pos.mobile_fastmenu_button.x or posY ~= settings.windows_pos.mobile_fastmenu_button.y then
			settings.windows_pos.mobile_fastmenu_button = {x = posX, y = posY}
			save_settings()
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.FastMenuPlayers.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getHelperIcon() .. u8" ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ " .. getHelperIcon() .. "##fast_menu_players", MODULE.FastMenuPlayers.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		local players = get_players()
		if #players == 0 then
			show_fast_menu(players[1])
			MODULE.FastMenuPlayers.Window[0] = false
		elseif #players >= 1 then
			for _, player in ipairs(players) do
				local id = tonumber(player)
				if imgui.Button(u8(sampGetPlayerNickname(id)), imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					if #players ~= 0 then show_fast_menu(id) end
					MODULE.FastMenuPlayers.Window[0] = false
				end
			end
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.LeaderFastMenu.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getUserIcon() .. ' ' .. u8(sampGetPlayerNickname(player_id)) .. ' [' .. player_id .. ']##LeaderFastMenu', MODULE.LeaderFastMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		local check = false
		for _, command in ipairs(modules.commands.data.commands_manage.my) do
			if command.enable and command.arg == '{id}' and command.in_fastmenu then
				if imgui.Button(u8(command.description), imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
					sampProcessChatInput("/" .. command.cmd .. " " .. player_id)
					MODULE.LeaderFastMenu.Window[0] = false
				end
				check = true
			end
		end
		if IS_MOBILE and not check then
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ Leader FastMenu ˜ /helper - ˜˜˜˜˜˜˜ ˜ RP ˜˜˜˜˜˜˜˜˜ - ˜˜˜˜ ˜˜˜˜ - Leader FastMenu', message_color)
			MODULE.FastMenu.Window[0] = false
		elseif not IS_MOBILE then
			if imgui.Button(u8"˜˜˜˜˜˜ ˜˜˜˜˜˜˜",imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
				sampSetChatInputEnabled(true)
				sampSetChatInputText('/vig '..player_id..' ')
				MODULE.LeaderFastMenu.Window[0] = false
			end
			if imgui.Button(u8"˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜˜˜",imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
				sampSetChatInputEnabled(true)
				sampSetChatInputText('/unv '..player_id..' ')
				MODULE.LeaderFastMenu.Window[0] = false
			end
		end
		imgui.End()
    end
)
----------------------------------------- PIEMENU GUI -------------------------------------------
function iconTextFormat(item)
    if item.icon and item.icon ~= '' and fa[item.icon] then
        return fa[item.icon] .. ' ' .. u8(item.name)
    end
    return u8(item.name)
end
function drawPieSub(v)
    if pie.BeginPieMenu(iconTextFormat(v)) then
        for _, item in ipairs(v.next) do
            if item.next == nil then
                if pie.PieMenuItem(iconTextFormat(item)) then
                    sampProcessChatInput(item.action)
                end
            elseif type(item.next) == 'table' then
                drawPieSub(item)
            end
        end
        pie.EndPieMenu()
    end
end

imgui.OnFrame(
	function() return MODULE.PieMenu.Window[0] end,
	function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.pie.x, settings.windows_pos.pie.y), imgui.Cond.FirstUseEver)
		imgui.Begin('##MODULE.PieMenu.Window', MODULE.PieMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar)
		safery_disable_cursor(player)
		if IS_MOBILE then
			imgui.Button(fa.GEAR .. '##PieMenuButton', imgui.ImVec2(50 * settings.general.custom_dpi, 50 * settings.general.custom_dpi))
			if imgui.IsItemClicked(0) then
				imgui.OpenPopup("PieMenu")
			end
		else
			if imgui.IsMouseClicked(2) then
				imgui.OpenPopup('PieMenu')
			end
		end
		if pie.BeginPiePopup('PieMenu', 2) then
			if not IS_MOBILE then player.HideCursor = false end
			if #modules.piemenu.data == 0 then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ PieMenu ˜ /helper - ˜˜˜˜˜˜˜ ˜ RP ˜˜˜˜˜˜˜˜˜ - ˜˜˜˜ ˜˜˜˜ - PieMenu', message_color)
			end
			for _, item in ipairs(modules.piemenu.data) do
				if item.next == nil then
					if pie.PieMenuItem(iconTextFormat(item)) then
						sampProcessChatInput(item.action)
					end
				else
					drawPieSub(item)
				end
			end
			pie.EndPiePopup()
		end
		local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
		if posX ~= settings.windows_pos.pie.x or posY ~= settings.windows_pos.pie.y then
			settings.windows_pos.pie = {x = posX, y = posY}
			save_settings()
		end
		imgui.End()
	end
)
----------------------------------- UPDATE GUI -----------------------------
imgui.OnFrame(
    function() return MODULE.Update.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(fa.CIRCLE_INFO .. u8" ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ".. fa.CIRCLE_INFO .. "##update_window", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize )
		if not IS_MOBILE then change_dpi() end
		imgui.CenterText(u8("˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜:"))
		imgui.Text(u8(MODULE.Update.info))
		imgui.Separator()
		if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜ ˜˜˜˜˜˜˜˜˜', imgui.ImVec2(250 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
			MODULE.Update.Window[0] = false
		end
		imgui.SameLine()
		if imgui.Button(fa.DOWNLOAD ..u8' ˜˜˜˜˜˜˜˜˜ ' .. u8(MODULE.Update.version), imgui.ImVec2(250 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
			if thisScript().version:find('VIP') then
				sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ /helper ˜ ˜˜˜˜˜ Telegram/Discord VIP ˜˜˜˜!', message_color)
			else
				download_file = 'helper'
				downloadFileFromUrlToPath(MODULE.Update.url, worked_dir .. "/Arizona Helper.lua")
			end
			MODULE.Update.Window[0] = false
		end
		imgui.End()
    end
)
----------------------------------- Other GUI -----------------------------
imgui.OnFrame(
    function() return MODULE.RPWeapon.Window[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 425 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.GUN .. u8" RP ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜ ˜˜˜˜ " .. fa.GUN, MODULE.RPWeapon.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
		change_dpi()
        imgui.PushItemWidth(385 * settings.general.custom_dpi)
        imgui.InputTextWithHint(u8'##inputsearch_weapon_name', u8('˜˜˜˜˜˜˜ ˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜˜˜˜˜ ˜˜ ˜˜˜ ID ˜˜˜ ˜˜˜˜˜˜˜˜...'), MODULE.RPWeapon.input_search, 256) 
		imgui.SameLine()
		if imgui.Button(u8("˜˜˜˜˜˜˜˜ ˜˜")) then
			for index, value in ipairs(modules.rpgun.data.rp_guns) do
				value.enable = true
			end
			initialize_guns()
			save_module('rpgun')
		end		
		imgui.SameLine()
		if imgui.Button(u8("˜˜˜˜˜˜˜˜˜ ˜˜")) then
			for index, value in ipairs(modules.rpgun.data.rp_guns) do
				value.enable = false
			end
			save_module('rpgun')
		end		
		if imgui.BeginChild('##rpguns1', imgui.ImVec2(588 * settings.general.custom_dpi, 361 * settings.general.custom_dpi), true) then
			imgui.Columns(3)
			imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜˜")
			imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8"ID ˜ ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜")
			imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8"˜˜˜˜˜˜˜˜˜˜˜˜")
			imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
			imgui.Columns(1)
			imgui.Separator()
			local decoded_input = u8:decode(ffi.string(MODULE.RPWeapon.input_search))
			for index, value in ipairs(modules.rpgun.data.rp_guns) do
				if decoded_input == '' or (value.name and value.name:upper():find(decoded_input:upper())) or value.id == tonumber(decoded_input) then
					imgui.Columns(3)
					if value.enable then
						if imgui.CenterColumnSmallButton(fa.SQUARE_CHECK .. u8'  (˜˜˜˜˜˜˜˜)##' .. index, imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
							value.enable = not value.enable
							save_module('rpgun')
						end
					else
						if imgui.CenterColumnSmallButton(fa.SQUARE .. u8' (˜˜˜˜˜˜˜˜)##' .. index, imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
							value.enable = not value.enable
							save_module('rpgun')
						end
					end
					imgui.NextColumn()
					imgui.CenterColumnText('[' .. value.id .. '] ' .. u8(value.name))
					imgui.SameLine()
					if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##weapon_name' .. index) then
						_G.weapon_input = imgui.new.char[256]()
						imgui.StrCopy(_G.weapon_input, u8(value.name))
						imgui.OpenPopup(fa.GUN .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. fa.GUN .. '##weapon_name' .. index)
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.GUN .. u8' ˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜ ' .. fa.GUN .. '##weapon_name' .. index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize ) then
						change_dpi()
						imgui.PushItemWidth(400 * settings.general.custom_dpi)
						imgui.InputText(u8'##weapon_name', _G.weapon_input, 256) 
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							value.name = u8:decode(ffi.string(_G.weapon_input))
							save_module('rpgun')
							initialize_guns()
							_G.weapon_input = nil
							imgui.CloseCurrentPopup()
						end
						imgui.EndPopup()
					end
					imgui.NextColumn()
					local position = ''
					if value.rpTake == 1 then
						position = '˜˜˜˜˜'
					elseif value.rpTake == 2 then
						position = '˜˜˜˜˜˜'
					elseif value.rpTake == 3 then
						position = '˜˜˜˜'
					elseif value.rpTake == 4 then
						position = '˜˜˜˜˜˜'
					end
					imgui.CenterColumnText(u8(position))
					imgui.SameLine()
					if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##weapon_position' .. index) then
						MODULE.RPWeapon.ComboTags[0] = value.rpTake - 1
						imgui.OpenPopup(fa.GUN .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜##weapon_name' .. index)
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.GUN .. u8' ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜##weapon_name' .. index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize ) then
						change_dpi()
						imgui.PushItemWidth(400 * settings.general.custom_dpi)
						imgui.Combo(u8'##' .. index, MODULE.RPWeapon.ComboTags, MODULE.RPWeapon.ImItems, 4)
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ˜˜˜˜˜˜˜˜˜', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							value.rpTake = MODULE.RPWeapon.ComboTags[0] + 1
							save_module('rpgun')
							initialize_guns()
							imgui.CloseCurrentPopup()
						end
						imgui.EndPopup()
					end
					imgui.Columns(1)
					imgui.Separator()
				end
			end
			imgui.EndChild()
		end
        imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.CommandStop.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY - 50 * settings.general.custom_dpi), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getHelperIcon() .. " Arizona Helper " .. getHelperIcon() .. "##MODULE.CommandStop.Window", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		if IS_MOBILE and MODULE.Binder.state.isActive then
			if imgui.Button(fa.CIRCLE_STOP..u8' ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜') then
				MODULE.Binder.state.isStop = true 
				MODULE.CommandStop.Window[0] = false
			end
		else
			MODULE.CommandStop.Window[0] = false
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.CommandPause.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY - 50 * settings.general.custom_dpi), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getHelperIcon() .." Arizona Helper " .. getHelperIcon() .. "##MODULE.CommandPause.Window", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		if MODULE.Binder.state.isPause then
			safery_disable_cursor(player)
			local label = ' ˜˜˜˜˜˜˜˜˜˜' .. (hotkey_no_errors and settings.general.bind_action and ' [' .. getNameKeysFrom(settings.general.bind_action) .. ']' or '')
			if imgui.Button(fa.CIRCLE_ARROW_RIGHT .. u8(label), imgui.ImVec2(180 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				MODULE.Binder.state.isPause = false
				MODULE.CommandPause.Window[0] = false
			end
			imgui.SameLine()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ˜˜˜˜˜˜ STOP ', imgui.ImVec2(180 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				MODULE.Binder.state.isStop = true 
				MODULE.Binder.state.isPause = false
				MODULE.CommandPause.Window[0] = false
			end
		else
			MODULE.CommandPause.Window[0] = false
		end
		imgui.End()
    end
)
---------------------------------- GUI ITEMS -----------------------------
function imgui.TextQuestion(text)
    imgui.SameLine()
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.Text(text)
        imgui.EndTooltip()
    end
end
function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end
function imgui.CenterTextDisabled(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.TextDisabled(text)
end
function imgui.CenterColorText(imgui_RGBA, text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
	imgui.TextColored(imgui_RGBA, text)
end
function imgui.CenterColumnText(text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end
function imgui.CenterColumnTextDisabled(text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
    imgui.TextDisabled(text)
end
function imgui.CenterColumnColorText(imgui_RGBA, text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
	imgui.TextColored(imgui_RGBA, text)
end
function imgui.CenterButton(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
	if imgui.Button(text) then
		return true
	else
		return false
	end
end
function imgui.CenterSmallButton(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
	if imgui.SmallButton(text) then
		return true
	else
		return false
	end
end
function imgui.CenterColumnButton(text)
	if text:find('(.+)##(.+)') then
		local text1, text2 = text:match('(.+)##(.+)')
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text1).x / 2)
	else
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
	end
    if imgui.Button(text) then
		return true
	else
		return false
	end
end
function imgui.CenterColumnSmallButton(text)
	if text:find('(.+)##(.+)') then
		local text1, text2 = text:match('(.+)##(.+)')
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text1).x / 2)
	else
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
	end
    if imgui.SmallButton(text) then
		return true
	else
		return false
	end
end
function imgui.CenterColumnRadioButtonIntPtr(text, arg1, arg2)
	if text:find('(.+)##(.+)') then
		local text1, text2 = text:match('(.+)##(.+)')
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text1).x / 2)
	else
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
	end
    if imgui.RadioButtonIntPtr(text, arg1, arg2) then
		return true
	else
		return false
	end
end
function imgui.ItemSelector(name, items, selected, fixedSize, dontDrawBorders)
    assert(items and #items > 1, 'items must be array of strings')
    assert(selected[0], 'Wrong argument #3. Selected must be "imgui.new.int"')
    local DL = imgui.GetWindowDrawList()
    local style = {
        rounding = imgui.GetStyle().FrameRounding,
        padding = imgui.GetStyle().FramePadding,
        col = {
            default = imgui.GetStyle().Colors[imgui.Col.Button],
            hovered = imgui.GetStyle().Colors[imgui.Col.ButtonHovered],
            active = imgui.GetStyle().Colors[imgui.Col.ButtonActive],
            text = imgui.GetStyle().Colors[imgui.Col.Text]
        }
    }
    local pos = imgui.GetCursorScreenPos()
    local start = pos
    local maxSize = 0
    for index, item in ipairs(items) do
        local textSize = imgui.CalcTextSize(item)
        local sizeX = (fixedSize or textSize.x) + style.padding.x * 2
        imgui.SetCursorScreenPos(pos)
        if imgui.InvisibleButton('##imguiSelector_'..item..'_'..tostring(index), imgui.ImVec2(sizeX, textSize.y + style.padding.y * 2)) then
            local old = selected[0]
            selected[0] = index
            return selected[0], old
        end
        DL:AddRectFilled(
            pos,
            imgui.ImVec2(pos.x + sizeX, pos.y + textSize.y + style.padding.y * 2),
            imgui.GetColorU32Vec4((selected[0] == index or imgui.IsItemActive()) and style.col.active or (imgui.IsItemHovered() and style.col.hovered or style.col.default)),
            style.rounding,
            (index == 1 and 5 or (index == #items and 10 or 0))
        )
        if index > 1 and not dontDrawBorders then DL:AddLine(imgui.ImVec2(pos.x, pos.y + style.padding.y), imgui.ImVec2(pos.x, pos.y + textSize.y + style.padding.y), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Border]), 1) end
        DL:AddText(imgui.ImVec2(pos.x + sizeX / 2 - textSize.x / 2, pos.y + style.padding.y), imgui.GetColorU32Vec4(style.col.text), item)
        pos = imgui.ImVec2(pos.x + sizeX, pos.y)
    end
    DL:AddRect(start, imgui.ImVec2(pos.x, pos.y + imgui.CalcTextSize('A').y + style.padding.y * 2), imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Border]), imgui.GetStyle().FrameRounding, nil, imgui.GetStyle().FrameBorderSize)
    DL:AddText(imgui.ImVec2(pos.x + style.padding.x, pos.y + (imgui.CalcTextSize(name).y + style.padding.y * 2) / 2 - imgui.CalcTextSize(name).y / 2), imgui.GetColorU32Vec4(style.col.text), name)
end
function imgui.GetMiddleButtonX(count)
    local width = imgui.GetWindowContentRegionWidth() 
    local space = imgui.GetStyle().ItemSpacing.x
    return count == 1 and width or width/count - ((space * (count-1)) / count)
end
function safery_disable_cursor(gui)
	if not IS_MOBILE and not sampIsCursorActive() then gui.HideCursor = true else gui.HideCursor = false end
end
function apply_dark_theme()
	imgui.SwitchContext()
    imgui.GetStyle().WindowPadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2 * settings.general.custom_dpi, 2 * settings.general.custom_dpi)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = (IS_MOBILE and 15 or 10) * settings.general.custom_dpi
    imgui.GetStyle().GrabMinSize = 10 * settings.general.custom_dpi
    imgui.GetStyle().WindowBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().ChildBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().PopupBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().FrameBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().TabBorderSize = 1 * settings.general.custom_dpi
	imgui.GetStyle().WindowRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ChildRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().FrameRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().PopupRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ScrollbarRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().GrabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().TabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().Colors[imgui.Col.Text]                   = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
    imgui.GetStyle().Colors[imgui.Col.WindowBg]               = imgui.ImVec4(0.07, 0.07, 0.07, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ChildBg]                = imgui.ImVec4(0.07, 0.07, 0.07, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.PopupBg]                = imgui.ImVec4(0.07, 0.07, 0.07, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.Border]                 = imgui.ImVec4(0.25, 0.25, 0.26, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBg]                = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = imgui.ImVec4(0.25, 0.25, 0.26, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = imgui.ImVec4(0.25, 0.25, 0.26, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TitleBg]                = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = imgui.ImVec4(0.00, 0.00, 0.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = imgui.ImVec4(0.41, 0.41, 0.41, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = imgui.ImVec4(0.51, 0.51, 0.51, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.CheckMark]              = imgui.ImVec4(1.00, 1.00, 1.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = imgui.ImVec4(0.21, 0.20, 0.20, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = imgui.ImVec4(0.21, 0.20, 0.20, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.Button]                 = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = imgui.ImVec4(0.21, 0.20, 0.20, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = imgui.ImVec4(0.41, 0.41, 0.41, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.Header]                 = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = imgui.ImVec4(0.20, 0.20, 0.20, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = imgui.ImVec4(0.47, 0.47, 0.47, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.Separator]              = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = imgui.ImVec4(1.00, 1.00, 1.00, 0.25)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = imgui.ImVec4(1.00, 1.00, 1.00, 0.67)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = imgui.ImVec4(1.00, 1.00, 1.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.Tab]                    = imgui.ImVec4(0.12, 0.12, 0.12, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TabHovered]             = imgui.ImVec4(0.28, 0.28, 0.28, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TabActive]              = imgui.ImVec4(0.30, 0.30, 0.30, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = imgui.ImVec4(0.07, 0.10, 0.15, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = imgui.ImVec4(0.14, 0.26, 0.42, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.PlotLines]              = imgui.ImVec4(0.61, 0.61, 0.61, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = imgui.ImVec4(1.00, 0.43, 0.35, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = imgui.ImVec4(0.90, 0.70, 0.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = imgui.ImVec4(1.00, 0.60, 0.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = imgui.ImVec4(1.00, 0.00, 0.00, 0.35)
    imgui.GetStyle().Colors[imgui.Col.DragDropTarget]         = imgui.ImVec4(1.00, 1.00, 0.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.NavHighlight]           = imgui.ImVec4(0.26, 0.59, 0.98, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight]  = imgui.ImVec4(1.00, 1.00, 1.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg]      = imgui.ImVec4(0.80, 0.80, 0.80, 0.20)
    imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg]       = imgui.ImVec4(0.12, 0.12, 0.12, 0.9)
end
function apply_white_theme()
	imgui.SwitchContext()
    imgui.GetStyle().WindowPadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2 * settings.general.custom_dpi, 2 * settings.general.custom_dpi)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = (IS_MOBILE and 15 or 10) * settings.general.custom_dpi
    imgui.GetStyle().GrabMinSize = 10 * settings.general.custom_dpi
    imgui.GetStyle().WindowBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().ChildBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().PopupBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().FrameBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().TabBorderSize = 1 * settings.general.custom_dpi
	imgui.GetStyle().WindowRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ChildRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().FrameRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().PopupRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ScrollbarRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().GrabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().TabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
    imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.94, 0.94, 0.94, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ChildBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(0.94, 0.94, 0.94, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.43, 0.43, 0.50, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(0.94, 0.94, 0.94, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.88, 1.00, 1.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.80, 0.89, 0.97, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.94, 0.94, 0.94, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.94, 0.94, 0.94, settings.general.transparent / 100) 
    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(0.94, 0.94, 0.94, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.94, 0.94, 0.94, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.02, 0.02, 0.02, 0.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.31, 0.31, 0.31, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.41, 0.41, 0.41, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.51, 0.51, 0.51, settings.general.transparent / 1000)
    imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.20, 0.20, 0.20, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.00, 0.48, 0.85, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.80, 0.80, 0.80, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.88, 0.88, 0.88, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.88, 1.00, 1.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.80, 0.89, 0.97, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.88, 0.88, 0.88, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.88, 1.00, 1.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.80, 0.89, 0.97, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.Separator] = imgui.ImVec4(0.43, 0.43, 0.50, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered] = imgui.ImVec4(0.10, 0.40, 0.75, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive] = imgui.ImVec4(0.10, 0.40, 0.75, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.00, 0.00, 0.00, 0.25)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.00, 0.00, 0.00, 0.67)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.00, 0.00, 0.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.Tab] = imgui.ImVec4(0.88, 0.88, 0.88, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TabHovered] = imgui.ImVec4(0.88, 1.00, 1.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TabActive] = imgui.ImVec4(0.80, 0.89, 0.97, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocused] = imgui.ImVec4(0.07, 0.10, 0.15, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive] = imgui.ImVec4(0.14, 0.26, 0.42, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(0.61, 0.61, 0.61, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(1.00, 0.43, 0.35, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.90, 0.70, 0.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.00, 0.47, 0.84, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.DragDropTarget] = imgui.ImVec4(1.00, 1.00, 0.00, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.NavHighlight] = imgui.ImVec4(0.26, 0.59, 0.98, settings.general.transparent / 100)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight] = imgui.ImVec4(1.00, 1.00, 1.00, 0.70)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg] = imgui.ImVec4(0.80, 0.80, 0.80, 0.20)
    imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg] = imgui.ImVec4(0.80, 0.80, 0.80, 0.8)
end
function apply_moonmonet_theme()
	local generated_color = moon_monet.buildColors(settings.general.moonmonet_theme_color, 1.0, true)
	imgui.SwitchContext()
	imgui.GetStyle().WindowPadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2 * settings.general.custom_dpi, 2 * settings.general.custom_dpi)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = (IS_MOBILE and 15 or 10) * settings.general.custom_dpi
    imgui.GetStyle().GrabMinSize = 10 * settings.general.custom_dpi
    imgui.GetStyle().WindowBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().ChildBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().PopupBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().FrameBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().TabBorderSize = 1 * settings.general.custom_dpi
	imgui.GetStyle().WindowRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ChildRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().FrameRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().PopupRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ScrollbarRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().GrabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().TabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
	imgui.GetStyle().Colors[imgui.Col.Text] = ColorAccentsAdapter(generated_color.accent2.color_50):as_vec4_orig()
	imgui.GetStyle().Colors[imgui.Col.TextDisabled] = ColorAccentsAdapter(generated_color.neutral1.color_600):as_vec4_orig()
	imgui.GetStyle().Colors[imgui.Col.WindowBg] = ColorAccentsAdapter(generated_color.accent2.color_900):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ChildBg] = ColorAccentsAdapter(generated_color.accent2.color_800):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.PopupBg] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.Border] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.Separator] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
	imgui.GetStyle().Colors[imgui.Col.FrameBg] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x60):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x70):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x50):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TitleBg] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0x7f):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x91):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0,0,0,0)
	imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x85):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.CheckMark] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.SliderGrab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x80):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.Button] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ButtonActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.Tab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TabActive] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TabHovered] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.Header] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.HeaderActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.PlotLines] = ColorAccentsAdapter(generated_color.accent2.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = ColorAccentsAdapter(generated_color.accent2.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0x99):as_vec4_orig()
end
function argbToRgbNormalized(argb)
    local a = math.floor(argb / 0x1000000) % 0x100
    local r = math.floor(argb / 0x10000) % 0x100
    local g = math.floor(argb / 0x100) % 0x100
    local b = argb % 0x100
    local normalizedR = r / 255.0
    local normalizedG = g / 255.0
    local normalizedB = b / 255.0
    return {normalizedR, normalizedG, normalizedB}
end
function argbToHexWithoutAlpha(alpha, red, green, blue)
    return string.format("%02X%02X%02X", red, green, blue)
end
function rgba_to_argb(rgba_color)
    local r = bit32.band(bit32.rshift(rgba_color, 24), 0xFF)
    local g = bit32.band(bit32.rshift(rgba_color, 16), 0xFF)
    local b = bit32.band(bit32.rshift(rgba_color, 8), 0xFF)
    local a = bit32.band(rgba_color, 0xFF)
    local argb_color = bit32.bor(bit32.lshift(a, 24), bit32.lshift(r, 16), bit32.lshift(g, 8), b)
    return argb_color
end
function join_argb(a, r, g, b)
    local argb = b 
    argb = bit.bor(argb, bit.lshift(g, 8))
    argb = bit.bor(argb, bit.lshift(r, 16))    
    argb = bit.bor(argb, bit.lshift(a, 24))
    return argb
end
function explode_argb(argb)
    local a = bit.band(bit.rshift(argb, 24), 0xFF)
    local r = bit.band(bit.rshift(argb, 16), 0xFF)
    local g = bit.band(bit.rshift(argb, 8), 0xFF)
    local b = bit.band(argb, 0xFF)
    return a, r, g, b
end
function rgba_to_hex(rgba)
    local r = bit.rshift(rgba, 24) % 256
    local g = bit.rshift(rgba, 16) % 256
    local b = bit.rshift(rgba, 8) % 256
    local a = rgba % 256
    return string.format("%02X%02X%02X", r, g, b)
end
function ARGBtoRGB(color) 
	return bit.band(color, 0xFFFFFF) 
end
function ColorAccentsAdapter(color)
    local a, r, g, b = explode_argb(color)
    local ret = {a = a, r = r, g = g, b = b}
    function ret:apply_alpha(alpha)
        self.a = alpha
        return self
    end
    function ret:as_u32()
        return join_argb(self.a, self.b, self.g, self.r)
    end
    function ret:as_vec4()
		local multiplier = (settings.general.transparent or 100) / 100
		return imgui.ImVec4(self.r / 255, self.g / 255, self.b / 255, (self.a / 255) * multiplier)
    end
	function ret:as_vec4_orig()
		return imgui.ImVec4(self.r / 255, self.g / 255, self.b / 255, self.a / 255)
    end
    function ret:as_argb()
        return join_argb(self.a, self.r, self.g, self.b)
    end
    function ret:as_rgba()
        return join_argb(self.r, self.g, self.b, self.a)
    end
    function ret:as_chat()
        return string.format("%06X", ARGBtoRGB(join_argb(self.a, self.r, self.g, self.b)))
    end 
    return ret
end
function change_dpi()
	imgui.PushFont(MODULE.FONT) 
end
function getHelperIcon()
	local HELPER_ICONS = {
		police   = fa.BUILDING_SHIELD,
		fbi      = fa.BUILDING_SHIELD,
		army     = fa.BUILDING_SHIELD,
		prison   = fa.BUILDING_SHIELD,
		hospital = fa.HOSPITAL,
		smi      = fa.BUILDING_NGO,
		gov      = fa.BUILDING_COLUMNS,
		fd       = fa.HOTEL,
		mafia    = fa.TORII_GATE,
		ghetto   = fa.BUILDING_WHEAT,
		none     = fa.BUILDING_CIRCLE_XMARK
	}
	return HELPER_ICONS[settings.general.fraction_mode] or fa.BUILDING
end
function getUserIcon()
	local USER_ICONS = {
		police   = fa.USER_NURSE,
		fbi      = fa.USER_NURSE,
		army     = fa.PERSON_MILITARY_RIFLE,
		prison   = fa.PERSON_MILITARY_RIFLE,
		hospital = fa.USER_DOCTOR,
		fd       = fa.USER_ASTRONAUT,
		lc       = fa.USER_TIE,
		ins      = fa.USER_TIE,
		mafia    = fa.USER_NINJA,
		ghetto   = fa.USER_NINJA
	}
	return USER_ICONS[settings.general.fraction_mode] or fa.USER
end
function insert_to_cursor(insert_text, buffer)
    local current = ffi.string(buffer)
    local start
    local finish
    if MODULE.INPUT.USER_MOVED_CURSOR then
        start = MODULE.INPUT.SELECTION_START
        finish = MODULE.INPUT.SELECTION_END
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜ ˜˜˜˜˜˜˜!', message_color)
    else
        start = #current
        finish = #current
    end
    local before = current:sub(1, start)
    local after = current:sub(finish + 1)
    local new_text = before .. insert_text .. after
    imgui.StrCopy(buffer, new_text)
    local new_cursor = start + #insert_text
    MODULE.INPUT.CURSOR_POS = new_cursor
    MODULE.INPUT.SELECTION_START = new_cursor
    MODULE.INPUT.SELECTION_END = new_cursor
    MODULE.INPUT.USER_MOVED_CURSOR = false
end
-------------------------------------------- Terminate ------------------------------------------
function onScriptTerminate(script, game_quit)
    if script == thisScript() and not game_quit and not reload_script then
		if MODULE.InfraredVision then setInfraredVision(false) end
		if MODULE.NightVision then setNightVision(false) end
		sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜, ˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜!', message_color)
		if not IS_MOBILE then 
			sampAddChatMessage('[Furry Helper] {ffffff}˜˜˜˜˜˜˜˜˜˜˜ ' .. message_color_hex .. 'CTRL {ffffff}+ ' .. message_color_hex .. 'R {ffffff}˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜.', message_color)
		end
    end
end
