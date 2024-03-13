
while getopts e:f flag
do
    case "$flag}" in
        e) environment=${OPTARG};;
        f) csvFile=${OPTARG};;
    esac
done

echo "environment: $environment"
echo "file: $csvFile"

export $environment
export $csvFile

echo "Exported variables..."