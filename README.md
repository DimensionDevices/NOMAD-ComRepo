# NOMAD Official .com & .ext Repository

This repository holds Officially supported NOMAD Extensions (.ext) files and example hosted sites, games and apps (.com) files.

Some files are fully functional apps/games while others are more geared towards examples/tech demos.

Details for how these files are created and managed are in the links below.

## NOMAD Tools

- **tools/theme-generator.html**

This file is used to generate .ext files that overwrite the default theme of your NOMAD device. Edit your theme and download the .ext file, upload to your NOMAD and restart the device to apply. To remove, simply delete the .ext file and restart the device.

- **tools/minify-com-file.html**

This file is used to minify created .com files, this essentially removed extra whitespace and minifies everything as much as possible without external libraries or compression. This tool does *not* compress the content, it only reduces whitespace and layout. This is worthwhile due to the packet limitation of LoRa, all filesize savings are important.

- **tools/volume-splitter.html**

This file converts .html and .md files to multi-volume NOMAD safe files that may be uploaded directly to your device. These split volumes are pre-calculated for compression to accurately measure the volumes' content that may fit into 20kb compressed per volume (the NOMAD limit).

e.g.
A 110kb .md file may be split into five volumes between 15-20kb volumes and some that may be 50-10kb. The compression level is denoted by the content itself. If the content is very repetitive, it will compress better. 

## NOMAD File Types Documentation

Click below to read details on how to create your own .com files outside of NOMAD (or to just brush up on the techniques used):

- **[.com File Documentation](/COM_README.md)**

Click below to read details on how Extension files (.ext) are generated and used within NOMAD. Details within are geared towards development and maintainance:

- **[.ext File Documentation](/EXT_README.md)**

© 2026 "NOMAD: Network for Open Messaging and Data" is Copyright of DimensionDevices