# sum=$1
# thresold=$2
upper_value=8905.55

function compare_values {
    sum=$1
    thresold=$2
    gt_thresold=$(echo "$sum > $thresold"| bc)
    lt_fixed_value=$(echo "$sum <= $upper_value" | bc)
    if [[ $gt_thresold -eq "1" &&  $lt_fixed_value  -eq "1" ]]; then
            echo "Test PASSED:- Resulted  ${sum} GFLOPS are in range of our expected thresold $thresold and Upper Value ${upper_value} GFLOPS"
    elif [ $gt_thresold -eq "0" ]; then
            echo "Test FAILED:- Resulted ${sum} GFLOPS are less than expected threshold ${thresold} GFLOPS"
    else
            echo "Test FAILED:- Resulted ${sum} GFLOPS are higher than peak value ${upper_value} GFLOPS. Some wrong test"
    fi
}

# sum i less than thresold
echo "sum i less than thresold"
compare_values  "8500.22" "8600"
echo "sum in between threshold and upper_value"
compare_values  "8600.22" "8500"
echo "sum is greater than upper_value."
compare_values  "9000.22" "8600"
echo "sum = float, threshold = float,"
compare_values  "8500.22" "8600.34"
echo " sum = int, thresold=float, "
compare_values  "8500" "8600.456"
echo " sum = float, thresold = int, "
compare_values  "8500.22" "8600"
echo " sum =int , thresold = int."
compare_values  "8500" "8600"
