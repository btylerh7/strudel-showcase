// @title Golden (Originally by HUNTR/X)
// @by Tyler
setcpm(115/4);
const verseProgression = "<C:Major G:Major D:Major E:Minor>"
const chorusProgression = "<C:Major D:Major [G:Major F#:locrian] E:minor>"
const slowBass = n("0").struct("<x x [x x] x>").sound("gm_fretless_bass")

const drivingBass = n("0").struct("[x x x]*4")
.layer(
    (x) => x.sound("gm_acoustic_bass").velocity("[0.75 1 1]*4"),
    (x) => x.sound("sine").add(note("-12, -11.90")).struct("<x x [x x] x>"),
  )
const piano = n("[0,2,4]").struct("<x x [x x] x>").sound("piano").lpf(1500)
const drums = stack(
  sound("bd sd bd sd").room(.1),
  sound("[hh hh hh]*4").gain(.1)
).bank("RolandTR707")

versePart1: cat(
  n("[~ [2 3 3] 3 [2 3 3]]"),
  n("[3 [ ~ ~ 5] [~ ~ ~] [ ~ 1 1 ]]"),
  n("[2 [ ~ ~ 5] [~ ~ ~] [ ~ 0 0 ]]"),
  n("1 -1@12"),
  n("[~ [2 3 3] 3 [2 3 3]]"),
  n("[3 [ ~ ~ 5] [~ ~ ~] [ ~ 1 1 ]]"),
  n("[2 [~ ~ 7] [7] [~ 6 7]]"),
  n("6 _ 6  7 [~ 6] ~ [~ 6] ~ 6   ~ ~ ~")
  
).sound("piano").scale("G:Major").scaleTranspose("<-1>")

backingTracks: arrange(
  [16, stack(
    drivingBass.scale(verseProgression).transpose("-12"),
    piano.scale(verseProgression),
    drums
    
  )],
  [8, stack(
    slowBass.scale(chorusProgression).transpose("-12"),
    piano.scale(chorusProgression)
  )],
  [ 16, stack(
    drivingBass.scale(chorusProgression).transpose("-12"),
    piano.scale(chorusProgression),
    drums
    
  )]
)
// @title Golden (Originally by HUNTR/X)
// @by Tyler
setcpm(115/4)
const verseProgression = "<C:Major G:Major D:Major E:Minor>"
const chorusProgression = "<C:Major D:Major [G:Major F#:locrian] E:minor>"
const slowBass = n("0").struct("<x x [x x] x>").sound("gm_fretless_bass")

const drivingBass = n("0").struct("[x x x]*4")
.layer(
    (x) => x.sound("gm_acoustic_bass").velocity("[0.75 1 1]*4"),
    (x) => x.sound("sine").add(note("-12, -11.90")).struct("<x x [x x] x>"),
  )
const piano = n("[0,2,4]").struct("<x x [x x] x>").sound("piano").lpf(1500)
const drums = stack(
  sound("bd sd bd sd").room(.1),
  sound("[hh hh hh]*4").gain(.1)
).bank("RolandTR707")

const versePart1 = cat(
  n("[~ [2 3 3] 3 [2 3 3]]"),
  n("[3 [ ~ ~ 5] [~ ~ ~] [ ~ 1 1 ]]"),
  n("[2 [ ~ ~ 5] [~ ~ ~] [ ~ 0 0 ]]"),
  n("1 -1@12"),
  n("[~ [2 3 3] 3 [2 3 3]]"),
  n("[3 [ ~ ~ 5] [~ ~ ~] [ ~ 1 1 ]]"),
  n("[2 [~ ~ 7] [7] [~ 6 7]]"),
  n("6 _ 6  7 [~ 6] ~ [~ 6] ~ 6   1 ~ 5")
);

const versePart2 = cat(
  n("[~ ~ 5] [~ ~ 5 ] [ ~ ~ 1 ] [1 ~ 5]"),
  n("[~ ~ 5] [~ ~ 5 ] [ ~ ~ 1 ] [~ ~ ~ ]"),
  n("[5 5 5] [5 5 5]"),
  n("[5 _ 6] [~] [~ ~ 1] [1 ~ 5]"),
  n("[~ ~ 5] [~ ~ 5 ] [ ~ ~ 1 ] [1 ~ 5]"),
  n("[~ ~ 5] [~ ~ 5 ] [ 6 ~ 1 ] [~ ~ ~ ]"),
  n("[5 5 5] [5 4 3]"),
  n("[3 _ 2] [~] [~ ~ ~] [ ~ ]")
)

const prechorus = cat(
  n("[-1 1 4 3] [-2 0 6 5] [3 5 [~ ~ 6] [ 5 4 4]] [ 3 _ _ 0]").slow(4)
  
)
  
vocals: arrange(
  // [8, versePart1],
  // [8, versePart2],
  [8, prechorus]
).sound("piano").scale("G:Major").scaleTranspose("<-1>")

backingTracks: arrange(
  // [16, stack(
  //   drivingBass.scale(verseProgression).transpose("-12"),
  //   piano.scale(verseProgression),
  //   drums
    
//  )],
  [8, stack(
    slowBass.scale(chorusProgression).transpose("-12"),
    piano.scale(chorusProgression)
  )],
  [ 16, stack(
    drivingBass.scale(chorusProgression).transpose("-12"),
    piano.scale(chorusProgression),
    drums
    
  )]
)

