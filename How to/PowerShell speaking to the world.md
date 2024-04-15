```PowerShell
# Create Voice object
$Voice = New-Object -ComObject Sapi.spvoice

# Get voices installed in the system
$Voice.GetVoices()

# Select one voice
$Voice.Voice = $Voice.GetVoices().Item(0)

# Set the volumne
$Voice.Volume = 10

# Set the speed
$Voice.Rate =  10 # Too quick
$Voice.Rate = -10 # Drunk?
$Voice.Rate =   0 # Normal

# Say something
$Voice.Speak("I don't know what to say. ok, I'll just say: Hello world!")

# Much more...
$Voice | Get-Member
```
