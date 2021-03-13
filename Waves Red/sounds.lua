function split(str, pat)
  local t = {}
  local fpat = "(.-)" .. pat
  local last_end = 1
  local s, e, cap = str:find(fpat, 1)
  while s do
     if s ~= 1 or cap ~= "" then
        table.insert(t,cap)
     end
     last_end = e+1
     s, e, cap = str:find(fpat, last_end)
  end
  if last_end <= #str then
     cap = str:sub(last_end)
     table.insert(t, cap)
  end
  return t
end

function parseSound(link)
 local parts = split(link, '%%22')
 local sound = {}

 for i = 2, #parts,2 do
   local value = parts[i + 1]:sub(4, -4)
   if parts[i] == 'waveform' then
     value = parts[i + 2]
   end
   if parts[i] == 'amplification' then
     value = value / 100.0
   end
   if value == "true" then
     value = true
   end
   if value == "false" then
     value = false
   end
   sound[parts[i]] = value
 end
 return sound
end

doom = parseSound('https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Powerup%2019%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0.1584521174716702%2C%22sustain%22%3A0.6400710350223584%2C%22sustainPunch%22%3A0%2C%22decay%22%3A0.7071982438700677%2C%22tremoloDepth%22%3A0%2C%22tremoloFrequency%22%3A10%2C%22frequency%22%3A54.96753067463228%2C%22frequencySweep%22%3A1900%2C%22frequencyDeltaSweep%22%3A6.861983184217331%2C%22repeatFrequency%22%3A4.40659063020797%2C%22frequencyJump1Onset%22%3A33%2C%22frequencyJump1Amount%22%3A0%2C%22frequencyJump2Onset%22%3A66%2C%22frequencyJump2Amount%22%3A0%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22sawtooth%22%2C%22interpolateNoise%22%3Atrue%2C%22vibratoDepth%22%3A0%2C%22vibratoFrequency%22%3A10%2C%22squareDuty%22%3A5%2C%22squareDutySweep%22%3A95%2C%22flangerOffset%22%3A0%2C%22flangerOffsetSweep%22%3A0%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A4424.307507238867%2C%22lowPassCutoffSweep%22%3A0%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A0%2C%22compression%22%3A0.5%2C%22normalization%22%3Atrue%2C%22amplification%22%3A10%7D')
inertiac = parseSound('https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Explosion%2011%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0.09811972385034262%2C%22sustain%22%3A0.2220992659790273%2C%22sustainPunch%22%3A0%2C%22decay%22%3A0.1898501932739176%2C%22tremoloDepth%22%3A0%2C%22tremoloFrequency%22%3A10%2C%22frequency%22%3A1964.621828834126%2C%22frequencySweep%22%3A-2203.549625802091%2C%22frequencyDeltaSweep%22%3A1458.5314492973198%2C%22repeatFrequency%22%3A0%2C%22frequencyJump1Onset%22%3A33%2C%22frequencyJump1Amount%22%3A0%2C%22frequencyJump2Onset%22%3A66%2C%22frequencyJump2Amount%22%3A0%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22whistle%22%2C%22interpolateNoise%22%3Afalse%2C%22vibratoDepth%22%3A0%2C%22vibratoFrequency%22%3A10%2C%22squareDuty%22%3A50%2C%22squareDutySweep%22%3A0%2C%22flangerOffset%22%3A0%2C%22flangerOffsetSweep%22%3A0%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A22050%2C%22lowPassCutoffSweep%22%3A0%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A0%2C%22compression%22%3A1.3%2C%22normalization%22%3Atrue%2C%22amplification%22%3A10%7D')
triplespawn = parseSound('https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Triple%20Spawn%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0.11290166221035958%2C%22sustain%22%3A0.17404619835517798%2C%22sustainPunch%22%3A10%2C%22decay%22%3A0.09811972385034262%2C%22tremoloDepth%22%3A0%2C%22tremoloFrequency%22%3A10%2C%22frequency%22%3A609.4805812116352%2C%22frequencySweep%22%3A-140.01881645497284%2C%22frequencyDeltaSweep%22%3A638.7357387013108%2C%22repeatFrequency%22%3A1.208133417977789%2C%22frequencyJump1Onset%22%3A33%2C%22frequencyJump1Amount%22%3A0%2C%22frequencyJump2Onset%22%3A66%2C%22frequencyJump2Amount%22%3A0%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22square%22%2C%22interpolateNoise%22%3Atrue%2C%22vibratoDepth%22%3A0%2C%22vibratoFrequency%22%3A10%2C%22squareDuty%22%3A30%2C%22squareDutySweep%22%3A30%2C%22flangerOffset%22%3A0%2C%22flangerOffsetSweep%22%3A0%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A22050%2C%22lowPassCutoffSweep%22%3A0%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A0%2C%22compression%22%3A1%2C%22normalization%22%3Atrue%2C%22amplification%22%3A5%7D')
triplepick = parseSound('https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Triple%20Pickup%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0%2C%22sustain%22%3A0.306597965661231%2C%22sustainPunch%22%3A0%2C%22decay%22%3A0.21%2C%22tremoloDepth%22%3A0%2C%22tremoloFrequency%22%3A10%2C%22frequency%22%3A609.4805812116352%2C%22frequencySweep%22%3A900%2C%22frequencyDeltaSweep%22%3A1000%2C%22repeatFrequency%22%3A13.678934446685206%2C%22frequencyJump1Onset%22%3A33%2C%22frequencyJump1Amount%22%3A0%2C%22frequencyJump2Onset%22%3A66%2C%22frequencyJump2Amount%22%3A0%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22sawtooth%22%2C%22interpolateNoise%22%3Atrue%2C%22vibratoDepth%22%3A0%2C%22vibratoFrequency%22%3A10%2C%22squareDuty%22%3A0%2C%22squareDutySweep%22%3A30%2C%22flangerOffset%22%3A0%2C%22flangerOffsetSweep%22%3A0%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A22050%2C%22lowPassCutoffSweep%22%3A0%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A0%2C%22compression%22%3A1%2C%22normalization%22%3Atrue%2C%22amplification%22%3A20%7D')
doubleswipepick = parseSound('https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Powerup%2022%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0%2C%22sustain%22%3A0.2220992659790273%2C%22sustainPunch%22%3A70%2C%22decay%22%3A0.4541150478250584%2C%22tremoloDepth%22%3A0%2C%22tremoloFrequency%22%3A10%2C%22frequency%22%3A963.6887243859687%2C%22frequencySweep%22%3A1400%2C%22frequencyDeltaSweep%22%3A1100%2C%22repeatFrequency%22%3A18.335504518836174%2C%22frequencyJump1Onset%22%3A33%2C%22frequencyJump1Amount%22%3A0%2C%22frequencyJump2Onset%22%3A66%2C%22frequencyJump2Amount%22%3A0%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22tangent%22%2C%22interpolateNoise%22%3Atrue%2C%22vibratoDepth%22%3A0%2C%22vibratoFrequency%22%3A10%2C%22squareDuty%22%3A80%2C%22squareDutySweep%22%3A35%2C%22flangerOffset%22%3A0%2C%22flangerOffsetSweep%22%3A0%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A22050%2C%22lowPassCutoffSweep%22%3A0%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A0%2C%22compression%22%3A1%2C%22normalization%22%3Atrue%2C%22amplification%22%3A30%7D')
shieldpick = parseSound('https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Powerup%2044%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0.013461135465436147%2C%22sustain%22%3A0.1898501932739176%2C%22sustainPunch%22%3A0%2C%22decay%22%3A0.17404619835517798%2C%22tremoloDepth%22%3A0%2C%22tremoloFrequency%22%3A10%2C%22frequency%22%3A1200%2C%22frequencySweep%22%3A100%2C%22frequencyDeltaSweep%22%3A1100%2C%22repeatFrequency%22%3A10.200000000000001%2C%22frequencyJump1Onset%22%3A33%2C%22frequencyJump1Amount%22%3A0%2C%22frequencyJump2Onset%22%3A66%2C%22frequencyJump2Amount%22%3A0%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22sawtooth%22%2C%22interpolateNoise%22%3Atrue%2C%22vibratoDepth%22%3A30%2C%22vibratoFrequency%22%3A438%2C%22squareDuty%22%3A60%2C%22squareDutySweep%22%3A95%2C%22flangerOffset%22%3A0%2C%22flangerOffsetSweep%22%3A0%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A22050%2C%22lowPassCutoffSweep%22%3A0%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A0%2C%22compression%22%3A1%2C%22normalization%22%3Atrue%2C%22amplification%22%3A30%7D')
BAFhit = parseSound("https://pewpew.live/jfxr/index.html#%7B%22_version%22%3A1%2C%22_name%22%3A%22Hit%2Fhurt%2068%22%2C%22_locked%22%3A%5B%5D%2C%22sampleRate%22%3A44100%2C%22attack%22%3A0.027103473098891273%2C%22sustain%22%3A0.09811972385034262%2C%22sustainPunch%22%3A0%2C%22decay%22%3A0.09%2C%22tremoloDepth%22%3A0%2C%22tremoloFrequency%22%3A10%2C%22frequency%22%3A674.8196581472791%2C%22frequencySweep%22%3A212.00190495828934%2C%22frequencyDeltaSweep%22%3A-2203.549625802091%2C%22repeatFrequency%22%3A8.063330567057024%2C%22frequencyJump1Onset%22%3A55%2C%22frequencyJump1Amount%22%3A-75%2C%22frequencyJump2Onset%22%3A45%2C%22frequencyJump2Amount%22%3A65%2C%22harmonics%22%3A0%2C%22harmonicsFalloff%22%3A0.5%2C%22waveform%22%3A%22sine%22%2C%22interpolateNoise%22%3Atrue%2C%22vibratoDepth%22%3A7.280246437890472%2C%22vibratoFrequency%22%3A0.22903767602206426%2C%22squareDuty%22%3A50%2C%22squareDutySweep%22%3A0%2C%22flangerOffset%22%3A9%2C%22flangerOffsetSweep%22%3A6%2C%22bitCrush%22%3A16%2C%22bitCrushSweep%22%3A0%2C%22lowPassCutoff%22%3A22050%2C%22lowPassCutoffSweep%22%3A-14600%2C%22highPassCutoff%22%3A0%2C%22highPassCutoffSweep%22%3A0%2C%22compression%22%3A1%2C%22normalization%22%3Atrue%2C%22amplification%22%3A100%7D")

sounds = {
    doom,
    inertiac,
    triplespawn,
    triplepick,
    doubleswipepick,
    shieldpick,
    BAFhit,
}