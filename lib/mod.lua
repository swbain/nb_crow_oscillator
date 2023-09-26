local mod = require 'core/mods'

if note_players == nil then
    note_players = {}
end

local function init() 
    local player = {}

    function player:note_on(note, vel)
        self:play_note(note, vel)
    end

    function player:play_note(note, vel, length)
        -- todo: out to crow
        crow.output[1].action = string.format("oscillate(%f, 4, sine)", note_num_to_freq(note))
        crow.output[1]()
    end

    function player:describe(note)
        return {
            name = "crow oscillator",
            supports_bend = false,
            supports_slew = false,
            modulate_description = "unsupported",
        }
    end

    note_players["crow oscillator"] = player
end

function note_num_to_freq(note_num) -- helper to convert MIDI to Hz
    return 13.75 * (2 ^ ((note_num - 9) / 12))
end

mod.hook.register("script_pre_init", "nb crow oscillator pre init", function()
    init()
end)