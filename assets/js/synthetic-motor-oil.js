// @title Synthetic Motor Oil
// @by Tyler Baker
// Note: distort(1) removed from subBass and synthpad because of local repl error with "distort processor".
// Other than that is as originally written

const songVolume = slider(1, 0.5, 1.5);
const subBass = sound("z_sine")
            .attack(0.10)
            .decay(0.1)
            .sustain(1)
            .release(0.3)
            .add(note("0, 0.05"))
            .distort(1)
            ._scope()

const pad = input => input.sound("z_sawtooth")
            .lpf(2000)
            .attack(0.1)
            .sustain(.05)
            .release(0.15)
            .decay(0.15)
            .velocity(.69)
            ._scope()

            const drumBank = "sakatadpm48";

            const csMinor = "[e3, g#3, c#4]"
            const eMajor = "[e3, g#3, b3]"
            const aMajor = "[c#3, e3, a3]"
            const bMajor = "[d#3, f#3, b3]"



            const drivingBassline = "x*8";
            const rhythmicBassline = "x(5, 16)";
            const melody = "<[0 2 -2 [-2 -1]] [0 2 [0@2 -2] -1]>/4".scale("c#2:minor")
            const chords = cat(
            seq(csMinor, eMajor, aMajor, [aMajor, bMajor]),
            seq(csMinor, eMajor, [csMinor, csMinor, aMajor], bMajor)
            ).slow(4).note()
const drumGroove = (type) => {
  const kickDrum = type == 'basic' ? sound("bd*4") : sound("bd(5,16)")

            return stack(
            kickDrum.gain(1.25),
            sound("hh hh <hh [[oh hh] ~ ]>  hh").gain(.45).room(.2),
            sound("sd(2,4, 1)").room(.1)
            ).bank(drumBank);
}

            const arp = chords.arp("[0 2](3,8) <[1 2]!3 [1*2 2*2]>")
            .sound("piano, gm_acoustic_guitar_nylon")
            .room(.2)
            .gain(.69)
            .hpf(200)
            const synthChords = stack(
            pad(chords).struct("x(5,8)").add(note("0", "0.20")).room(.1).postgain(.5), // .distort(1) before postgain,
            sound("z_sawtooth").note(melody).struct("x(5,8)").add(note("0", "0.1")).gain(.4).lpf(2000).attack(0.10)
            ).room(.15)

            const synthMelody = cat(
            note("[c#5]@2 [~ e5] [c#5 d#5 e5 b5]"),
            note("[b4]@2 [~ e5] [c#5 d#5 e5 b5]"),
            note("[c#5]@2 [~ e5] [c#5 d#5 e5 b5]"),
            note("[d#5]@2 [e5 d#5] [c#5 b5]"),
            )

            // stack(
            //   subBass.note(melody).struct(rhythmicBassline),
            //   drumGroove("other")

            // )

            arp: arrange(
            [32, silence],
            [32, arp]
            )
            synthline: arrange(
            [24, silence],
            [8, synthChords],
            [32, synthChords],
            )
            bassline: arrange(
            [16, subBass.note(melody).struct(drivingBassline).legato(0)],
            [16, subBass.note(melody).struct(rhythmicBassline)],
            [32, subBass.note(melody).struct(rhythmicBassline)],
            ).slow(1)
drums: arrange(
            [8, silence],
            [8, drumGroove('basic')],
            [16, drumGroove('other')],
            [32, drumGroove('other')],
            [1, sound("bd ~ ~ ~").bank(drumBank)]
)
            lead: arrange(
            [32, silence],
            [8, silence],
            [24, synthMelody.sound("gm_synth_brass_2").room(1)],
            [1, note("[c#3!2] ~ ~ ~").sound("gm_synth_brass_2").room(1)]
)
