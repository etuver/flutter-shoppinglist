# shoppinglist

IDATT2506 Prosjektøving

## Hvordan bruke appen:
- Opprette ny handleliste: 
  - Dersom man ikke har noen lister fra tidligere, trykk på "Legg til ny liste"
  - Dersom man har lister fra tidligere, åpne oversikten over lister, og velg "opprett ny liste" i 
    menyen som dukker opp.
- Åpne oversikt over handlelister / velge liste:
  - Dersom ingen lister er valgt: trykk på "Velg liste" 
  - Dersom en liste er valg: trykk på tittelen til valgte liste
- Legge til innslag på en liste: 
  - Skriv navn på innslag i tekstfeltet og trykk på pluss-knappen
-Markere innslag som ferdig/ ikke ferdig: 
  - Trykk på aktuelle innslag i listen
- Fjerne alle innslag som er markert ferdig:
  - Åpne menyen via knappen øverst til høyre, og velg "Fjern markerte varer"
- Slette en liste:
  - Ha aktuelle liste som valg liste, åpne menyen øverst til høyre, og velg "Slett denne listen"


<p float="left">
  <img src="/IMG_0191.PNG" width="100" />
  <img src="/IMG_0192.PNG" width="100" /> 
  <img src="/IMG_0193.PNG" width="100" />
  <img src="/IMG_0194.PNG" width="100" />
</p>



## Utvikling og testing
- Debugging under utvikling er gjennomført med OnePLus Nord N10 5G via Wifi.
- Applikasjonen er også testet på Iphone 12.
- For emulator i AVD er det brukt en Pixel 6 
- NB! Sørg for å ha nok minne på emulatoren



## Kjøre applikasjonen


### Android:
- Innstallere Flutter: https://docs.flutter.dev/get-started/install
- Innstallere Android studio: https://developer.android.com/studioflu

1. Åpne prosjektet i Android studio
2. Sett opp en Android emulator (AVD): https://developer.android.com/studio/run/emulator
3. Sørg for at emulatoren kjører med følgende kommando i terminalen: 
    ```
   flutter devices
   ```
4. Kjør prosjektet på emulatoren enten ved    
     ```
   - flutter run
   - Velg deretter riktig emulator i CLI'en om den ikke starter automatisk.
   ``` 
   Eller å velge riktig emulator og kjøre main.dart i android studio.



### IOS:
- Innstallere Flutter: https://docs.flutter.dev/get-started/install
- Innstallere Android studio: https://developer.android.com/studioflu
- Innstallere XCODE: https://apps.apple.com/us/app/xcode/id497799835?mt=12 (kun apple enheter)

1. Åpne prosjektet i Android studio
2. Kjør følgende kommandoer i terminalen:    
   ```
   - cd ios
   - rm Podfile
   - rm Podfile.lock
   - flutter clean
   - flutter pub get
   - pod install
   ```
3. Åpne XCODE og åpne filen /ios/Runner.xceworkspace
4. Sørg for at apple-enheten er koblet til via usb og følg denne guiden:
5. https://medium.com/front-end-weekly/how-to-test-your-flutter-ios-app-on-your-ios-device-75924bfd75a8



