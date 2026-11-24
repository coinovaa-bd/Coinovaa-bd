# Coinovaa BD — Android APK build package

This package contains the current Flutter prototype and a GitHub Actions workflow so you can build an APK using only an Android phone and Chrome.

## Build from an Android phone (no computer)

1. Open **https://github.com** in Chrome and sign in or create an account.
2. Create a new repository named `coinovaa-bd`. Set it to **Private** if you prefer.
3. In the repository, choose **Add file → Upload files**.
4. Extract this ZIP on your phone first, then upload the *contents* of the extracted folder (including the hidden `.github` folder if your file manager shows hidden files). If uploading hidden folders is difficult, create `.github/workflows/android-apk.yml` on GitHub using the exact workflow file included in this package.
5. Commit the files to the `main` branch.
6. Open the repository's **Actions** tab. Select **Build Coinovaa BD APK** and tap **Run workflow** (or wait for the automatic build after the commit).
7. When the run finishes with a green check, open that run, scroll to **Artifacts**, and download `coinovaa-bd-apk`.
8. Extract the downloaded artifact ZIP. Inside is `app-release.apk`. Tap it to install. Android may ask you to allow Chrome or Files to install unknown apps; only allow this for the APK you built from your own repository.

## Important limitations

- This is a prototype UI, not a live earning service.
- The admin IDs shown in the demo are not protected by real server authentication. Do not use it to manage real users or money.
- Real video rewards, sponsor tasks, referral validation, secure coin ledger, database, admin permissions, and bKash/Nagad/Rocket disbursement are not connected.
- Never store admin passwords, payment PINs, OTPs, or API secrets in the app or public repository.
- Before real-money launch, add a secure backend, real authentication, server-side reward verification, audit logs, abuse prevention, and approved payment disbursement arrangements.

## Included admin demo IDs

- `OwnerAdmin`
- `Admin2`

The demo login is not secure authentication and must be replaced before deployment.
