// @title Vengeance is Mine (Radical Highway) in the Style of Doom
// @by Tyler

samples('github:btylerh7/audio-samples');
setcpm(160 / 4);
$: sound("<~@7 shadow>");
const riff = note(`<
    [d@2 [d!2] c@3 d@2 [d!2] a2@2 a2@2 c@2]
    [d@2 [d!2] c@2 [c!2] d2@10]
    [d@2 [d!2] c@3 d@2 [d!2] a2@2 a2@2 c@2]
    [d@2 [d!2] c@3 d@2 ~ ~ eb@5]
 >`);

$: riff.add(note("-12, -5, 0")).sound("gm_distortion_guitar");
$: riff.add(note("-12")).sound("gm_fretless_bass, z_sine");
$: stack(
  sound("[bd ~ ~ bd] [sd ~ bd ~] [~ <bd@3 sd>] [sd <bd@3 sd>]").bank( "RolandTR909"),
  sound("[hh!4] [[hh*3][hh*2]] [hh!5] [hh!4]").bank("RolandTR808"),
);
