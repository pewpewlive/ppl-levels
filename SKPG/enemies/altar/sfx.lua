require("/dynamic/helpers/sound_parser.lua")

sound = parseSound('https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Explosion%2042%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0%2C%22sustain%22%3A0.4835746950193103%2C%22sustainPunch%22%3A0%2C%22decay%22%3A0.41000000000000003%2C%22tremoloDepth%22%3A0%2C%22tremoloFrequency%22%3A10%2C%22frequency%22%3A827.2257959341856%2C%22frequencySweep%22%3A-1673.6173949883291%2C%22frequencyDeltaSweep%22%3A-69.91961378922332%2C%22repeatFrequency%22%3A0%2C%22frequencyJump1Onset%22%3A33%2C%22frequencyJump1Amount%22%3A0%2C%22frequencyJump2Onset%22%3A66%2C%22frequencyJump2Amount%22%3A0%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22triangle%22%2C%22interpolateNoise%22%3Atrue%2C%22vibratoDepth%22%3A0%2C%22vibratoFrequency%22%3A10%2C%22squareDuty%22%3A50%2C%22squareDutySweep%22%3A0%2C%22flangerOffset%22%3A1%2C%22flangerOffsetSweep%22%3A0%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A22050%2C%22lowPassCutoffSweep%22%3A0%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A0%2C%22compression%22%3A1%2C%22normalization%22%3Atrue%2C%22amplification%22%3A50%7D')

boom = parseSound('https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Random%201%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0%2C%22sustain%22%3A0.6732980579718404%2C%22sustainPunch%22%3A70%2C%22decay%22%3A0.13544849602495557%2C%22tremoloDepth%22%3A2%2C%22tremoloFrequency%22%3A941%2C%22frequency%22%3A7900%2C%22frequencySweep%22%3A-9200%2C%22frequencyDeltaSweep%22%3A9900%2C%22repeatFrequency%22%3A42.6%2C%22frequencyJump1Onset%22%3A33%2C%22frequencyJump1Amount%22%3A0%2C%22frequencyJump2Onset%22%3A66%2C%22frequencyJump2Amount%22%3A0%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22pinknoise%22%2C%22interpolateNoise%22%3Afalse%2C%22vibratoDepth%22%3A200%2C%22vibratoFrequency%22%3A442%2C%22squareDuty%22%3A50%2C%22squareDutySweep%22%3A0%2C%22flangerOffset%22%3A0%2C%22flangerOffsetSweep%22%3A0%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A200%2C%22lowPassCutoffSweep%22%3A0%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A6000%2C%22compression%22%3A1.1%2C%22normalization%22%3Atrue%2C%22amplification%22%3A75%7D')

charge = parseSound('https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Explosion%2042%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0.5035452949620587%2C%22sustain%22%3A1.7443276778387706%2C%22sustainPunch%22%3A0%2C%22decay%22%3A0.18192178084060018%2C%22tremoloDepth%22%3A0%2C%22tremoloFrequency%22%3A10%2C%22frequency%22%3A183.8434219961033%2C%22frequencySweep%22%3A-0.410117660429262%2C%22frequencyDeltaSweep%22%3A227.15739933624536%2C%22repeatFrequency%22%3A0%2C%22frequencyJump1Onset%22%3A33%2C%22frequencyJump1Amount%22%3A0%2C%22frequencyJump2Onset%22%3A66%2C%22frequencyJump2Amount%22%3A0%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22breaker%22%2C%22interpolateNoise%22%3Atrue%2C%22vibratoDepth%22%3A0%2C%22vibratoFrequency%22%3A10%2C%22squareDuty%22%3A50%2C%22squareDutySweep%22%3A0%2C%22flangerOffset%22%3A1%2C%22flangerOffsetSweep%22%3A0%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A22050%2C%22lowPassCutoffSweep%22%3A0%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A0%2C%22compression%22%3A1%2C%22normalization%22%3Atrue%2C%22amplification%22%3A50%7D')

yellow_spawn = parseSound('https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Explosion%2042%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0%2C%22sustain%22%3A0.13%2C%22sustainPunch%22%3A0%2C%22decay%22%3A0.4%2C%22tremoloDepth%22%3A0%2C%22tremoloFrequency%22%3A10%2C%22frequency%22%3A747.1519058834239%2C%22frequencySweep%22%3A8.020575613999288%2C%22frequencyDeltaSweep%22%3A2.4460316853289603%2C%22repeatFrequency%22%3A0%2C%22frequencyJump1Onset%22%3A33%2C%22frequencyJump1Amount%22%3A0%2C%22frequencyJump2Onset%22%3A66%2C%22frequencyJump2Amount%22%3A0%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22triangle%22%2C%22interpolateNoise%22%3Atrue%2C%22vibratoDepth%22%3A113.81523416226814%2C%22vibratoFrequency%22%3A10%2C%22squareDuty%22%3A80%2C%22squareDutySweep%22%3A25%2C%22flangerOffset%22%3A0%2C%22flangerOffsetSweep%22%3A0%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A22050%2C%22lowPassCutoffSweep%22%3A0%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A0%2C%22compression%22%3A1%2C%22normalization%22%3Atrue%2C%22amplification%22%3A100%7D')

spawn = parseSound('https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Explosion%2042%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0%2C%22sustain%22%3A0.5546558419733234%2C%22sustainPunch%22%3A0%2C%22decay%22%3A0.4%2C%22tremoloDepth%22%3A0%2C%22tremoloFrequency%22%3A10%2C%22frequency%22%3A579.219567335846%2C%22frequencySweep%22%3A-484.9553097314256%2C%22frequencyDeltaSweep%22%3A-60.81077958891608%2C%22repeatFrequency%22%3A0%2C%22frequencyJump1Onset%22%3A33%2C%22frequencyJump1Amount%22%3A0%2C%22frequencyJump2Onset%22%3A66%2C%22frequencyJump2Amount%22%3A0%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22triangle%22%2C%22interpolateNoise%22%3Atrue%2C%22vibratoDepth%22%3A260.97527278976236%2C%22vibratoFrequency%22%3A10%2C%22squareDuty%22%3A80%2C%22squareDutySweep%22%3A25%2C%22flangerOffset%22%3A0%2C%22flangerOffsetSweep%22%3A0%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A22050%2C%22lowPassCutoffSweep%22%3A0%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A0%2C%22compression%22%3A1%2C%22normalization%22%3Atrue%2C%22amplification%22%3A100%7D')

sounds = {
    sound, charge, yellow_spawn, boom, spawn
}