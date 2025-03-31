#!/bin/bash
# run_all.sh

echo "Starting Bear export..."
./export.sh

# Check if export.sh executed successfully
if [ $? -eq 0 ]; then
  echo "Export completed successfully. Now organizing files..."
  ./organize.sh
else
  echo "Export failed. Aborting organization step."
  exit 1
fi

echo "All steps completed."