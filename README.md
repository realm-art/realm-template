# realm-template

Template Godot project for Realm creation.

Modify to create custom Realm microverses for use in the Realm metaverse.

### Getting started

#### Settting up Godot
Download the latest stable Godot version for your platform from the [official Godot website](https://godotengine.org/download/). Godot does not need to be installed, but can be run immediately after unzipping the downloaded file.

#### Cloning/forking the repository

You can clone this repository by either using a git client or downloading the repo as a `.zip`. Press the green `Code` button at the top of the page to do so.
Alternatively, fork the repository first to create your own copy of it that you can modify and publish to github as you please. In order to do that, press the `Fork` button at the top of the page. 

**Forks are the easiest way to share your creations with both Realm and the community.**

For more information on how forking on GitHub works, take a look at the [official docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/about-forks).

Once you have downloaded this repo or your fork, open the Godot launcher and press `Import`, then navigate to the `project.godot` file of the repository. `Import&Edit` will then open the template within Godot.

#### Editing the template

After opening the project, wait for Godot to finish importing all resources. 
Some Godot versions may display an error message regarding a plugin failing to load. In that case, simply re-enabling the affected plugins via `Project -> Project Settings... -> Plugins` will fix the issue.

In the bottom right corner of the editor, a short tutorial will be displayed explaining the structure of the template. There will also be a `Smart Objects` tab displayed next to the Tutorial allowing for easy placement of interactive objects such as portals and platforms.

Additional documentation regarding our specific asset specs can be found [here](https://realm-3.gitbook.io/blender-godot-pipeline/hKcCIWP1RIZjlu4K0joj/).

Documentation regarding general usage of the Godot engine can be found in the official Godot docs [here](https://docs.godotengine.org/en/stable/index.html).

#### Exporting

In order to export your built Realm, use the `Project -> Export..` menu. Select the `Realm Export` template, then press `Export PCK/Zip`.

Select a valid target file location, make sure you are saving your Realm as a `.zip` file, and press `Save`. 
