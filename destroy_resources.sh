directories=$(ls -dr */)

for i in ${directories}; do
  echo $i
  cd $i
  terraform destroy -auto-approve
  cd ..
done
