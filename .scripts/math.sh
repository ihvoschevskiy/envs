#!/bin/bash
declare -a break_points

rem=16

widths=(450 1920 2560)
heights=(750 1536)

function prepareBPoints() {
  input=("$@")
  length="${#input[@]}"

  for (( i=1; i < "${length}"; i++ )); do 
    break_points+=("${input[i-1]}"/"${input[i]}")
  done

  break_points+=("Set sizes")
  break_points+=("Quit")
}

function calculate() {
  units=$1
  while :
  do
    echo
    read -p "Enter min and max preffered values px: " f_sizes 
    read -a F_SIZES <<< "$f_sizes"
    
    # (max_font_size - min_font_size) / (max_width - min_width)
    delta_w=$(bc <<< "scale=4; ($max - $min)/$rem")
    delta_f=$(bc <<< "scale=4; (${F_SIZES[1]} - ${F_SIZES[0]})/$rem")

    slope=$(bc <<< "scale=4; $delta_f / $delta_w")
    slope_vw=$(bc <<< "scale=4; $slope*100")

    # -minWidth * slope + minFontSize
    yAxisIntersection=$(bc <<< "scale=4; (-$min*$slope + ${F_SIZES[0]})/$rem")

    preffered="${yAxisIntersection}rem + ${slope_vw}${units}"

    minVal=$(bc <<< "scale=2; ${F_SIZES[0]}/$rem")
    maxVal=$(bc <<< "scale=2; ${F_SIZES[1]}/$rem")

    clamp="clamp(${minVal}rem, ${preffered}, ${maxVal}rem)"

    echo "$clamp"
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
      echo "$clamp" | xclip -selection c -rmlastnl
    elif [[ "$OSTYPE" == "msys" ]]; then
      echo "$clamp" > /dev/clipboard
    fi
  done
}

function getClamp() {
  echo
  direction="$1"
  arr=("$@")

  min=0
  max=0

  select screen in "${arr[@]: 1}"
  do
     case $screen in
       ([0-9]*)
        IFS="/" read -r left right <<< "$screen"
        min="$left"
        max="$right"
        break
        ;;
      "Set sizes")
        read -p "Enter min and max sizes px: " szs 
        read -a SZS <<< "$szs"
        min=${SZS[0]}
        max=${SZS[1]}
        break
        ;;
      "Quit")
        exit 1
        break
        ;;
      *) echo "invalid option $REPLY";;
    esac
  done
  calculate "$direction"
}

PS3='Please enter your choice: '

echo
echo -e "1rem = "$rem"px\n"

options=("Get clamp values for width" "Get clamp values for height" "Quit")
select opt in "${options[@]}"
do
  case $opt in
      "Get clamp values for width")
        prepareBPoints "${widths[@]}" 
        getClamp "vw" "${break_points[@]}" 
        break
        ;;
      "Get clamp values for height")
        prepareBPoints "${heights[@]}"
        getClamp "vh" "${break_points[@]}"
        break
        ;;
      "Quit")
        break
        ;;
      *) echo "invalid option $REPLY";;
  esac
done
