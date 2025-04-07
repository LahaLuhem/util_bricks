import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// Load local.properties
val localProperties =
    Properties().apply {
        val localPropertiesFile = rootProject.file("local.properties")
        if (localPropertiesFile.exists()) {
            localPropertiesFile.reader(Charsets.UTF_8).use { load(it) }
        }
    }

// Load key.properties
val keystoreProperties =
    Properties().apply {
        val keystorePropertiesFile = rootProject.file("key.properties")
        if (keystorePropertiesFile.exists()) {
            keystorePropertiesFile.inputStream().use { load(it) }
        }
    }

val flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

android {
    // ----- BEGIN flavorDimensions (autogenerated by flutter_flavorizr) -----
    flavorDimensions += "flavor-type"
    productFlavors {
        create("develop") {
            dimension = "flavor-type"
            applicationId = "{{android_app_id}}"
			applicationIdSuffix = ".dev"
            resValue ("string", "app_name", "{{dispay_name}} dev")
			versionNameSuffix = "-dev"
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "{{android_app_id}}"
            resValue ("string", "app_name", "{{dispay_name}}")
        }
    }
    // ----- END flavorDimensions (autogenerated by flutter_flavorizr) -----

    namespace = "{{android_app_id}}"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_21
        targetCompatibility = JavaVersion.VERSION_21
    }

    kotlinOptions { jvmTarget = JavaVersion.VERSION_21.toString() }

    // Add Kotlin sources
    sourceSets { getByName("main") { java.srcDir("src/main/kotlin") } }

    defaultConfig {
        applicationId = "{{android_app_id}}"
        // Use values from the Flutter extension if available;
        // otherwise, you may need to hardcode these or retrieve them differently.
        compileSdk = flutter.compileSdkVersion
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        // Initially set ndkVersion from flutter, but later override if needed.
        ndkVersion = "27.0.12077973"
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = (keystoreProperties["storeFile"] as? String)?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        getByName("debug") {
            // The debug signing config is provided by default.
            signingConfig = signingConfigs.getByName("debug")
            isDebuggable = true
        }
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            ndk { abiFilters += (listOf("arm64-v8a", "x86_64")) }
        }
    }
}

flutter { source = "../.." }
