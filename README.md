[<h1>Garbh: Empowering Parenthood</h1>](https://github.com/adarshnagrikar14/gsc24-garbh/)
> <h3>The Description</h3>
<br>
<h1>Download direct Apk from here</h1>
<a href="#">Download from here.</a>

<br>
<h1>Steps to Run the App</h1>
<br>

1. As we assume that flutter is properly installed on the machine, please do follow the below steps to test the App.
```
Note: The App is currently built for Android only.
```
2. Git clone the project into the directory of your choice.
```
git clone https://github.com/adarshnagrikar14/Aashray.git
```
3. Change directory to Aashray
```
cd ./Aashray
```
4. We need to add the required ***Directions API key and Maps API key*** at the specified locations.
```
Read here:
i. https://developers.google.com/maps/documentation/directions/get-api-key
ii. https://developers.google.com/maps/documentation/geocoding/get-api-key
```

5. Add the Google Map API key in the ***AndriodManifest.xml*** file in android/app/src/main/AndroidManifest.xml directory on line 42
```
<meta-data android:name="com.google.android.geo.API_KEY"
            android:value="Google API key"/>
```
6. Add the Directions API key in the ***locate_aashray.dart*** file in lib/Classes/locate_aashray/locate_aashray.dart on line 32
```
final String googleAPiKey = "Directions API key";
```
7. Run the following commands to download all required dependancies.
```
flutter clean
flutter pub get
```
7. Now after doing all the necessary steps, we are ready to run the App. 
```
flutter run
```

<br>
<h1>Feature tour:</h1>
<h5>Basic 4 Functionalities are available in case of any non emergency or an emergency situation.</h5>

Default Screen | Aashray Screen 
-------------- | --------------
In this default page, you can volunteer for Aashray <br> or Food | Here you can see and edit your entered aashray <br> details
<img src="https://firebasestorage.googleapis.com/v0/b/app-aashray.appspot.com/o/AppScreenshots%2FScreen1.jpg?alt=media&token=7b085e23-0a36-44a8-8215-e41beefd22e3" alt = "One" width="243" height="500"> | <img src="https://firebasestorage.googleapis.com/v0/b/app-aashray.appspot.com/o/AppScreenshots%2FScreen%20Home.jpg?alt=media&token=0cdd3e65-c02a-40a5-90c4-8ae1110f5dd1" alt = "Two" width="243" height="500">

Food Provider Screen | Emergency Screen
-------------------- | ----------------
Here you can see and edit your entered details for <br> providing a meal | This screen will let you know the emergency and <br> provide aashray or food provider's details
<img style= "margin-left: auto; margin-right: auto;" src="https://firebasestorage.googleapis.com/v0/b/app-aashray.appspot.com/o/AppScreenshots%2FScreen%20Food.jpg?alt=media&token=c53e5626-2cff-4094-b69c-71518eb38807" alt = "Three" width="243" height="500"> | <img src="https://firebasestorage.googleapis.com/v0/b/app-aashray.appspot.com/o/AppScreenshots%2Femergency%20screen.gif?alt=media&token=f65920cf-8d02-46f1-91ed-51c4dbde951d" alt = "Four" width="243" height="500">

<br>
<h1>Features to be implemented:</h1>
<h5>Two features are in development and are to be rolled in the next update. Here are some glimpses</h5>
<br>

Latest News | ChatBot Help
-------------------- | ----------------
Here you can see the latest global News. It will <br> make you aware of the current situation <br> about any mishap. | This unique feature will provide an extra <br> help in any situation.
<img style= "margin-left: auto; margin-right: auto;" src="https://firebasestorage.googleapis.com/v0/b/app-aashray.appspot.com/o/AppScreenshots%2FNews.jpg?alt=media&token=c5559de7-3bb4-4988-adc8-b4999468e574" alt = "One" width="243" height="500"> | <img src="https://firebasestorage.googleapis.com/v0/b/app-aashray.appspot.com/o/AppScreenshots%2Fchatbot.jpg?alt=media&token=413923e2-91d9-448f-ad22-f53f0579aa6f" alt = "Two" width="243" height="500">

<br>
<h1>Steps to Test the App</h1>
<h5>You need to create a testing location in Firebase Firestore database for emergency screen</h5>
<br>

1. We assume that firebase project is already created for the app and ***google-services.json*** is added to android/app. Follow the below steps to test.
```
i. Setup Firebase Auth.
ii. Add SHA Keys in the project.
iii. Create Firebase Firestore Database. 
```
2. Create a ***Collection*** named ***Disaster Locations***

<img style= "margin-left: auto; margin-right: auto;" src="https://firebasestorage.googleapis.com/v0/b/app-aashray.appspot.com/o/AppScreenshots%2FScreenshot%202023-03-22%20180622.png?alt=media&token=ced9dd24-3b01-4420-a04b-62836646f18c" alt = "Firebase">

3. Create a ***Document*** named ***Your area Pincode*** e.g 440001 (In)

4. Add field ***Type*** and value with any type of disaster as shown.
<img style= "margin-left: auto; margin-right: auto;" src="https://firebasestorage.googleapis.com/v0/b/app-aashray.appspot.com/o/AppScreenshots%2FScreenshot%202023-03-22%20181358.png?alt=media&token=f64595e4-17f7-4bc5-8eaa-3a3ec8f0f571" alt = "Firebase">

5. Good to go!
```
Your location is added in emergency locations. You can test the Emergency Screen now.
```
<br>

<h1>Attributions</h1>
<h4>1. Thankyou Flaticon for the required vector images. Visit here to know more www.flaticon.com <br>2. Thankyou Freepik for the required images and graphics. Visit here to know more www.freepik.com <br>3. Thankyou Lottiefiles for the required animation files. Visit here to know more www.lottiefiles.com <br>4. Thankyou Flutter team for making app development easier and faster. Visit here to know more www.flutter.dev</h4>
<br>

<h1>A Team work by</h1>
<h3>
1. Adarsh Nagrikar
<br> <br>
<a href="https://www.linkedin.com/in/adarsh-nagrikar/">
  <img src="https://img.shields.io/badge/linkedin%20-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=black" alt="Linkedin" height="32px">
</a> <br> <br>
<a href="https://github.com/adarshnagrikar14">
  <img src="https://img.shields.io/github/followers/adarshnagrikar14?style=social" alt="Linkedin" height="32px">
</a>
</h3>
<br>
<h3>
2. Harshita Soni
<br> <br>
<a href="https://www.linkedin.com/in/harshita-soni-85ba6922a/">
  <img src="https://img.shields.io/badge/linkedin%20-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=black" alt="Linkedin" height="32px">
</a> <br> <br>
<a href="https://github.com/h-o-n-e-y">
  <img src="https://img.shields.io/github/followers/h-o-n-e-y?style=social" alt="Linkedin" height="32px">
</a>
</h3>
<br>
<h3>
3. Advika Metre
<br> <br>
<a href="https://www.linkedin.com/in/advika-metre-9a2aaa234/">
  <img src="https://img.shields.io/badge/linkedin%20-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=black" alt="Linkedin" height="32px">
</a> <br> <br>
<a href="https://github.com/advikasm">
  <img src="https://img.shields.io/github/followers/advikasm?style=social" alt="Linkedin" height="32px">
</a>
</h3>
<br>
