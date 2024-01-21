# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'SimbirDiary' do
  use_frameworks!
  pod 'RealmSwift', '10.45.3'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'Realm'
      create_symlink_phase = target.shell_script_build_phases.find { |x| x.name == 'Create Symlinks to Header Folders' }
      create_symlink_phase.always_out_of_date = "1"
    end
  end
end