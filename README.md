# Dokumentasi LunaPOS SDK

---

Dokumen ini akan menjelaskan kebutuhan apa saja yang perlu dilakukan untuk menggunakan SDK Lunapos ke dalam project Flutter.

Jika anda ingin men-download project demo yang kami buat, silakan buka link repository berikut: [https://github.com/bagassfn/lunapos-demo-sdk](https://github.com/bagassfn/lunapos-demo-sdk)

Dokumentasi ini dibuat berdasarkan demo project di atas.

# Lokasi Menyimpan SDK

---

Simpan file AAR yang yang di-berikan sebelumnya ke dalam path di bawah ini:

```jsx
[your_flutter_project_path]/android/libs/lunapos_sdk_dev.aar
```

Jika folder `libs` tidak ada, maka buatlah terlebih dahulu.

# Setting Gradle File

---

## Ubah File `settings.gradle`

Buka file `[flutter_project]/android/settings.gradle` , file akan terlihat seperti ini:

```groovy
pluginManagement {
    ...

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
        
        // Tambahkan line berikut
        maven { url 'https://jitpack.io' } // << 1
    }
}

plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "7.3.0" apply false

    // tambahkan dengan ini
    id "org.jetbrains.kotlin.android" version "1.9.0" apply false // << 2
}

include ":app"
```

1. Tambahkan repository `maven { url 'https://jitpack.io' }`
2. Tambahkan plugin `id "org.jetbrains.kotlin.android" version "1.9.0" apply false` , Jika plugin sudah ada sebelumnya, harap ubah versi-nya ke `“1.9.0”` .

## Ubah File `build.gradle`

Terdapat 2 file build.gradle dalam project Android, yang dibedakan dengan path:

1. `[flutter_project]/android/build.gradle`
2. `[flutter_project]/android/app/build.gradle`

### Ubah File `[flutter_project]/android/build.gradle`

Buka file `[flutter_project]/android/build.gradle` , lalu tambahkan bagian yang di tandai pada code di bawah ini:

```groovy
allprojects {
    repositories {
        google()
        mavenCentral()
        
        // Tambahkan repository
        gradlePluginPortal()                // << 1
        maven { url 'https://jitpack.io' }  // << 2
    }
}

...

// Tambahkan semua code di bawah ini
buildscript {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
        maven { url 'https://jitpack.io' }
    }
    dependencies {
        def nav_version = "2.5.3"
        classpath "androidx.navigation:navigation-safe-args-gradle-plugin:$nav_version"
    }
} // << 3
```

Tambahkan repository seperti lines yang ditandai dengan nomor 1 dan 2.

Untuk code yang di tandai dengan nomor 3, anda harus menambahkan semua lines yang ada di dalam `buildscript {}`  scope.

### Ubah File `[flutter_project]/android/app/build.gradle`

Buka file `[flutter_project]/android/app/build.gradle`, lalu tambahkan bagian yang di tandai pada code di bawah ini:

```groovy
plugins {
    id "com.android.application"
    id "kotlin-android"
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id "dev.flutter.flutter-gradle-plugin"

    // Aktifkan plugin ke dalam project android
    id 'kotlin-kapt'                            // << 1
    id 'androidx.navigation.safeargs.kotlin'    // << 2
    id 'kotlin-parcelize'                       // << 3
}

...

android {
    ...

    defaultConfig {
       ...
    }
    
		...

    // Aktifkan feature viewBinding
    buildFeatures {
        viewBinding true // << 4
    }
}

// Tambahkan semua dependecies di bawah ini
dependencies { // << 5
		...
		
    implementation 'androidx.core:core-ktx:1.10.1'
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
    implementation "androidx.fragment:fragment-ktx:1.5.7"
    implementation 'androidx.startup:startup-runtime:1.1.1'

    def nav_version = "2.5.3"
    implementation "androidx.navigation:navigation-fragment-ktx:$nav_version"
    implementation "androidx.navigation:navigation-ui-ktx:$nav_version"

    def room_version = "2.5.1"
    implementation "androidx.room:room-ktx:$room_version"
    implementation "androidx.room:room-runtime:$room_version"
    kapt "androidx.room:room-compiler:$room_version"

    def lifecycle_version = "2.6.1"
    implementation "androidx.lifecycle:lifecycle-viewmodel-ktx:$lifecycle_version"
    implementation "androidx.lifecycle:lifecycle-livedata-ktx:$lifecycle_version"
    implementation "androidx.lifecycle:lifecycle-common-java8:$lifecycle_version"

    implementation "androidx.swiperefreshlayout:swiperefreshlayout:1.1.0"

    def work_version = "2.8.1"
    implementation "androidx.work:work-runtime-ktx:$work_version"

    /** External library **/
    implementation "androidx.exifinterface:exifinterface:1.3.6"

    /* Glide Image Processing */
    implementation 'com.github.bumptech.glide:glide:4.14.2'
    kapt 'com.github.bumptech.glide:compiler:4.14.2'

    /* Networking library */
    implementation 'com.squareup.retrofit2:retrofit:2.9.0'
    implementation 'com.squareup.retrofit2:converter-gson:2.4.0'
    implementation 'com.squareup.okhttp3:okhttp:3.14.9'
    implementation 'com.squareup.okhttp3:logging-interceptor:3.10.0'

    /* Chart Library */
    implementation 'com.github.PhilJay:MPAndroidChart:v3.1.0'
}

```

1. Tambahkan plugin `android-kapt`
2. Tambahkan plugin `androidx.navigation.safeargs.kotlin`
3. Tambahkan plugin `kotlin-parcelize`
4. Aktifkan feature viewBinding `buildFeatures **{** viewBinding true **}**`
5. tambahkan section `dependencies { }`  jika belum ada. Lalu tambahkan semua dependencies seperti contoh di atas.

## Implementasikan SDK LunaPOS ke dalam project

Untuk meng-implementasikan SDK LunaPOS ke dalam project, anda harus menambahkan dependency di dalam file `[flutter_project]/android/app/build.gradle`  pada section `dependencies { }` .

`[flutter_project]/android/app/build.gradle`

```groovy
plugins {
    ...
}

...

android {
    ...
}

dependencies { 
		...
		
    // implementasikan Luna Aar
    implementation rootProject.files("libs/lunapos_sdk_dev.aar") // << 1
}

```

Jika sudah melakukan seperti contoh di atas, maka SDK sudah dapat digunakan.

# Cara Menggunakan SDK

Karena SDK LunaPOS menggunakan native code. Anda harus memanggilnya dari project Android-nya.

1. Buka file MainActivity, pada path `[flutter_project]/android/app/src/main/kotlin/[package_name]/MainActivity` . Jika tidak ditemukan, coba ke folder `java` daripada `kotlin` berdasarkan path tersebut.
2. import 2 class berikut ke dalam file MainActivity.

    ```kotlin
    import com.lunapos.poslite.LunaConstant
    import com.lunapos.poslite.LunaMainActivity
    ```

3. Panggil activity `LunaMainActivity`  dengan menggunakan `Intent` . Seperti code dibawah ini:

    ```kotlin
    private fun startLunaPos(firstName: String?, lastName: String?, email: String?, phone: String?) {
            val intent = Intent(applicationContext, LunaMainActivity::class.java)
            intent.apply {
                putExtra(LunaConstant.EXTRA_FIRST_NAME, firstName)
                putExtra(LunaConstant.EXTRA_LAST_NAME, lastName)
                putExtra(LunaConstant.EXTRA_EMAIL, email)
    
                // Nomor handphone dikirim tanpa awalan "0" (nol)
                putExtra(LunaConstant.EXTRA_PHONE_NUMBER, phone)
            }
            startActivity(intent)
        }
    ```

   Anda harus memberikan 4 data sebagai Intent extra seperti contoh di atas, atau luna tidak dapat melanjutkan ke proses login.

   Data yang harus terpenuhi adalah: `EXTRA_FIRST_NAME`, `EXTRA_LAST_NAME`, `EXTRA_EMAIL`, `EXTRA_PHONE_NUMBER`.

   untuk data `EXTRA_PHONE_NUMBER`, nomor handphone tidak perlu ada angka 0 sebagai awalan nomor handphone.

4. Lalu anda perlu menggunakan `MethodChannel` agar fungsi native dapat di panggul dari flutter project. seperti contoh dibawah ini.

    ```kotlin
    class MainActivity : FlutterActivity() {
        private val channel = "example.com/native-code-example"
    
        override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
            super.configureFlutterEngine(flutterEngine)
            MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                channel
            ).setMethodCallHandler { call, result ->
                if (call.method == "startPos") {
                    val firstName = call.argument<String>("firstName")
                    val lastName = call.argument<String>("lastName")
                    val email = call.argument<String>("email")
                    val phone = call.argument<String>("phone")
    
    								// panggil fungsi yang dibuat sebelumnya
                    startLunaPos(firstName, lastName, email, phone)
                    
                    result.success(true)
                } else {
                    result.notImplemented()
                }
            }
        }
    }
    ```