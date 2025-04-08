allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Set the root build directory using the layout API.
rootProject.layout.buildDirectory.set(file("../build"))

subprojects {
    // Set each subproject's buildDir to a subfolder of the root build directory.
    layout.buildDirectory.set(rootProject.layout.buildDirectory.dir(name))
    evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") { delete(rootProject.layout.buildDirectory.get().asFile) }
