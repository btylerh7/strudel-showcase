// @title Nighttime Chug
// @by Tyler

samples('github:eddyflux/crate')
samples('github:tidalcycles/Dirt-Samples')

setcpm(90/4)

const songVolume = slider(1, 0.5, 1.5);
const lowpass = slider(10000, 100, 10000)

drums: stack(
  sound("bend*8"),
  sound("crate_sd, sd").struct("<x(2,4,1)!3 [[~ x x ~] [x x ~ x] [~ x x ~ ] [x x]]>"),
  sound("popkick:10, popkick:4").struct("<x(3,8) x(5,8) x(3,8) x(5,16)>")
).room(.25).lpf(lowpass).postgain(songVolume)

bass: note("<[c2@6 d2@2] [f2@3 eb2@3 d2@2]>").sound("jvbass, z_sine").struct("x(3,8)").lpf(lowpass)._scope().postgain(songVolume)
arp: stack(
  n("[0, 2, 4]").arp("<[ 0 1 2 3 2 0 1@10] [0 1 2 3 2 0 2@4 1@4 0@2]>").sound("z_sawtooth").scale("<C2:minor F2:minor C2:minor G2:major>")
).postgain(songVolume)

synthStab: stack(
  n("[0, 2, 4]").scale("<C:minor F:minor C:minor G:major>").sound("z_sawtooth").struct("x(3,8)").clip("1@6 0@2").add(note("0, 0.1")).room(.25)
).postgain(songVolume)


synthLead: n("<[4 2 0] [2 0 -5]>").struct("x(3,8)").sustain(1).release(1).scale("<C4:minor F4:minor C4:minor G4:major>")
  .sound("z_sawtooth").add(note("0, 0.1")).room(.5).hpf(1000).lpf(4000).postgain(songVolume)
guitar: stack(
  note("<c3 f3 c3 g3>").sound("gm_distortion_guitar, gm_electric_guitar_muted").struct("x*16").clip(.5).add(note("0, -12, -7"))
).postgain(songVolume)
