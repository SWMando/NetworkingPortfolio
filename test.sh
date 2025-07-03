#!/bin/bash

#!/bin/bash
grep -rl "^### Addressing Table$" . | while IFS= read -r file; do
  sed -i 's/^### Addressing Table$/#### Addressing Table:/' "$file"
done

