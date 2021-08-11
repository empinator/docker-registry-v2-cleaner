# docker-registry-v2-cleaner

- Create/edit a file ```image-list.txt``` with images you want to delete

  Format: ```imageName:Version1,Version2,...```

- Run the ```create-delete-instructions.sh```
  Instructions to delete the manifests from your registry will be written to ```DELETE-manifest-instructions.sh```

- run the ```DELETE-manifest-instructions.sh```

- run the Registry Garbage Collector

see also 
https://azizunsal.github.io/blog/post/delete-images-from-private-docker-registry/#override-the-registry-configuration
