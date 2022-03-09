//
//  ViewController.swift
//  WrapperApp
//
//  Created by LIPL-227 on 09/03/22.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var resultLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        do {
            
            let val =   try self.safeShell("ls -la")
            print(val)
            resultLabel.stringValue = "\(val)"
            
            /*
            Use Git - For use git command at there

            try shellOut(to: .gitInit())
            try shellOut(to: .gitClone(url: repositoryURL))
            try shellOut(to: .gitCommit(message: "A scripted commit!"))
            try shellOut(to: .gitPush())
            try shellOut(to: .gitPull(remote: "origin", branch: "release"))
            try shellOut(to: .gitSubmoduleUpdate())
            try shellOut(to: .gitCheckout(branch: "my-feature"))
            */
            
            
            /*
             Handle files, folders and symlinks

             try shellOut(to: .createFolder(named: "folder"))
             try shellOut(to: .createFile(named: "file", contents: "Hello world"))
             try shellOut(to: .moveFile(from: "path/a", to: "path/b"))
             try shellOut(to: .copyFile(from: "path/a", to: "path/b"))
             try shellOut(to: .openFile(at: "Project.xcodeproj"))
             try shellOut(to: .readFile(at: "Podfile"))
             try shellOut(to: .removeFile(from: "path/a"))
             try shellOut(to: .createSymlink(to: "target", at: "link"))
             try shellOut(to: .expandSymlink(at: "link"))
             */
            
            /*
             Use The Swift Package Manager

             try shellOut(to: .createSwiftPackage(withType: .executable))
             try shellOut(to: .updateSwiftPackages())
             try shellOut(to: .generateSwiftPackageXcodeProject())
             try shellOut(to: .buildSwiftPackage())
             try shellOut(to: .testSwiftPackage())
             */
            
            
            
        }  catch  {
                print("\(error)") //handle or silence the error here
            resultLabel.stringValue = "\(error)"
            }
         

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func safeShell(_ command: String) throws -> String {
          let task = Process()
          let pipe = Pipe()
          
          task.standardOutput = pipe
          task.standardError = pipe
          task.arguments = ["-c", command]
          task.executableURL = URL(fileURLWithPath: "/bin/zsh") //<--updated

          try task.run() //<--updated
          
          let data = pipe.fileHandleForReading.readDataToEndOfFile()
          let output = String(data: data, encoding: .utf8)!
          
          return output
      }
    
}

