docker image build -t kernel:1.0 .
docker run -it --rm -v $(pwd)/output:/kernel/output kernel:1.0 /bin/bash
