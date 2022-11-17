# shoppinglist

IDATT2506 Prosjektøving

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



