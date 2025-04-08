#!/usr/bin/env zsh

echo "Generating sensitive Firebase keys 🔑 ..."

if command -v firebase >/dev/null 2>&1; then
  echo "firebase command exists ✅"
else
  echo "firebase command does not exist. Installing CLI ⇊..."
  curl -sL https://firebase.tools | bash
fi

echo "Ensure firebase login"
firebase login

firebase apps:sdkconfig --project combipac-scan-app android 1:78447964828:android:9236f196b8e33b53c4b359 > ../scanner/android/app/google-services.json
echo "google-services.json created ✅"

firebase apps:sdkconfig --project combipac-scan-app ios 1:78447964828:ios:ea6003f539c40014c4b359 > ../scanner/ios/GoogleService-Info.plist
echo "GoogleService-Info.plist created ✅"

echo "Uninstall firebase CLI..."
curl -sL firebase.tools | uninstall=true bash
echo "Uninstalled firebase CLI 🧹"

echo "Creating default key.properties template 📝..."
cat <<'EOF' > ../scanner/android/app/key.properties
storePassword=keystorepassword
keyPassword=keystorepassword
keyAlias=upload
storeFile=/Users/username/upload-keystore.jks
EOF
echo "key.properties created. Point the \`storeFile\` to your keystore file location"

echo "Key generation done 🚀"