# Docker Time Machine Server

To start this docker use:

```bash
docker run -p 548:548 -p 5353:5353 -p 5354:5354 -v <local_folder>:/TimeMachineBcks:rw -d <image_name>
```
