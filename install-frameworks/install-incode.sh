run_command()
{
  if ! $1 
  then
    echo "\nThere is an error running \033[33m$1\033[0m command\n"
    exit 1
  fi
}

# remove dir
# rm -rf './IncdOnboarding-distribution'

# Clone repo
run_command 'git clone --depth 1 --branch 5.16.0-d https://github.com/Incode-Technologies-Example-Repos/IncdOnboarding-distribution.git'

# Remove current frameworks
rm -rf './../Sources/Frameworks/IncdOnboarding.xcframework'
rm -rf './../Sources/Frameworks/opencv2.xcframework'

# Move frameworks to Resources folder
mv './IncdOnboarding-distribution/IncdOnboarding.xcframework' './../Sources/Frameworks'
mv './IncdOnboarding-distribution/opencv2.xcframework' './../Sources/Frameworks'

# Remove folder
rm -rf './IncdOnboarding-distribution'