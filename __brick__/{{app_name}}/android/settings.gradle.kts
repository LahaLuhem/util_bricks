pluginManagement {
    // Load flutter.sdk from local.properties.
    val properties =
        java.util.Properties().apply { file("local.properties").inputStream().use { load(it) } }
    val flutterSdkPath =
        properties.getProperty("flutter.sdk") ?: error("flutter.sdk not set in local.properties")
    settings.extra["flutterSdkPath"] = flutterSdkPath

    // Include the Flutter tools build.
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.9.0" apply false
    id("org.jetbrains.kotlin.android") version "2.1.10" apply false
    id("com.google.gms.google-services") version "4.4.2" apply false
}

include(":app")
