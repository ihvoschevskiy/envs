#!/bin/bash

rem=16

# widths
bp_w_0=450
bp_w_1=1920
bp_w_2=2560

# heights
bp_h_0=215
bp_h_1=1540


function calculate() {
  while :
  do
    read -p "Enter min and max preffered values px: " f_sizes 
    read -a F_SIZES <<< "$f_sizes"
    
    # (max_font_size - min_font_size) / (max_width - min_width)
    delta_w=$(bc <<< "scale=4; ($max - $min)/$rem")
    delta_f=$(bc <<< "scale=4; (${F_SIZES[1]} - ${F_SIZES[0]})/$rem")

    slope=$(bc <<< "scale=4; $delta_f / $delta_w")
    slope_vw=$(bc <<< "scale=4; $slope*100")

    # -minWidth * slope + minFontSize
    yAxisIntersection=$(bc <<< "scale=4; (-$min*$slope + ${F_SIZES[0]})/$rem")

    preffered="${yAxisIntersection}rem + ${slope_vw}vw"

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

PS3='Please enter your choice: '

options=("Get clamp values for width" "Get clamp values for height" "Quit")

select opts in "${options[@]}"
do
  case $opt in
    "Get clamp values")

done

options=("Get clamp values" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Get clamp values")
        echo
        echo -e "1rem = "$rem"px\n"

        break_points=("${bp_w_0}/${bp_w_1}" "${bp_w_1}/${bp_w_2}" "Set sizes" "Quit")
        min=0
        max=0
        select screens in "${break_points[@]}"
        do
          case $screens in
            "${bp_w_0}/${bp_w_1}")
              min=${bp_w_0}
              max=${bp_w_1}
              break
              ;;
            "${bp_w_1}/${bp_w_2}")
              min=${bp_w_1}
              max=${bp_w_2}
              break
              ;;
            "Set sizes")
              read -p "Enter min and max sizes px: " widts 
              read -a WIDTS <<< "$widts"
              min=${WIDTS[0]}
              max=${WIDTS[1]}
              break
              ;;
            "Quit")
              exit 1
              break
              ;;
            *) echo "invalid option $REPLY";;
          esac
        done
        calculate 
        break
        ;;
    "Quit")
        break
        ;;
    *) echo "invalid option $REPLY";;
  esac
done

