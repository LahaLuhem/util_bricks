#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
#-keep class io.flutter.plugin.editing.** { *; }

##Firebase
#-keep class com.google.firebase.** { *; }
#-keep class com.firebase.** { *; }
#-keep class org.apache.** { *; }
#-keepnames class com.fasterxml.jackson.** { *; }
#-keepnames class javax.servlet.** { *; }
#-keepnames class org.ietf.jgss.** { *; }
#-dontwarn org.w3c.dom.**
#-dontwarn org.joda.time.**
#-dontwarn org.shaded.apache.**
#-dontwarn org.ietf.jgss.**
#-keepattributes Signature
#-keepattributes *Annotation*
#-keepattributes EnclosingMethod
#-keepattributes InnerClasses
#-keep class androidx.lifecycle.DefaultLifecycleObserver

#Crashlytics
-keepattributes *Annotation*
# in order to provide the most meaningful crash reports, add the following line:
-keepattributes SourceFile,LineNumberTable
# If you are using custom exceptions, add this line so that custom exception types are skipped during obfuscation:
#-keep public class * extends java.lang.Exception
-keep class com.crashlytics.** { *; }
-dontwarn com.crashlytics.**