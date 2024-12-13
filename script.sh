#!/bin/bash

read -p "이미지가 있는 폴더명(default:source) : " SRC_DIR
echo 
read -p "이미지 파일 이름을 변경 할건가요?(default:mdpi 파일명) : " FILE_NAME
echo
read -p "파일을 넣을 모듈명(default:app): " MODULE_NAME 
echo

#ORI_DIR=$(pwd | grep -o '[^/]*$')
ORI_DIR="source"

if [[ $SRC_DIR == "" ]]
then 
  SRC_DIR=$ORI_DIR 
fi

if [ -d "$SRC_DIR" ]
then 
  cd "$SRC_DIR"
  echo
  # 현재 디렉토리의 모든 파일과 디렉토리를 탐색
  for file in *; do
    # 파일 이름에 공백이 포함되어 있는지 확인
    if [[ "$file" == *" "* ]]; then
      # 공백을 제거한 새로운 이름 생성
      new_name=$(echo "$file" | tr -d ' ')
      # 이름 변경 실행
      mv "$file" "$new_name"
      echo "Renamed: '$file' -> '$new_name'"
    fi
  done
else
  echo
  echo "[Error] $SRC_DIR 을 찾을 수 없습니다."
  echo
  exit 1
fi


files=(*.png)

# 파일 개수 확인
if [[ ${#files[@]} -ne 5 ]]; then
  echo
  echo "[Error] .png 파일의 개수가 5개가 아닙니다."
  echo
  exit 1
fi

# 첫번째 인자는 모듈 이름으로 처리
if [[ $MODULE_NAME == "" ]]
then
  MODULE_NAME="app"
fi

if [ -d ../$MODULE_NAME ] 
then 
  echo
  echo "[Info] 모듈 이름은 $MODULE_NAME 입니다" 
  echo
else 
  echo
  echo "[Error] 모듈을 찾을 수 없습니다." 
  echo
  exit 1
fi

MODULE_PATH="../$MODULE_NAME"

#사이즈별 폴더 만들기
PATH_MDPI=$MODULE_PATH
PATH_MDPI+='/src/main/res/drawable'
PATH_HDPI=$MODULE_PATH
PATH_HDPI+='/src/main/res/drawable-hdpi'
PATH_XHDPI=$MODULE_PATH
PATH_XHDPI+='/src/main/res/drawable-xhdpi'
PATH_XXHDPI=$MODULE_PATH
PATH_XXHDPI+='/src/main/res/drawable-xxhdpi'
PATH_XXXHDPI=$MODULE_PATH
PATH_XXXHDPI+='/src/main/res/drawable-xxxhdpi'

#declare -a MDPI_LIST
#declare -a HDPI_LIST
#declare -a XHDPI_LIST
#declare -a XXHDPI_LIST
#declare -a XXXHDPI_LIST

# Create directories if not exists
[ ! -d $PATH_MDPI ] && mkdir -p $PATH_MDPI >/dev/null 2>&1
[ ! -d $PATH_HDPI ] && mkdir -p $PATH_HDPI >/dev/null 2>&1
[ ! -d $PATH_XHDPI ] && mkdir -p $PATH_XHDPI >/dev/null 2>&1
[ ! -d $PATH_XXHDPI ] && mkdir -p $PATH_XXHDPI >/dev/null 2>&1
[ ! -d $PATH_XXXHDPI ] && mkdir -p $PATH_XXXHDPI >/dev/null 2>&1

# 파일 크기 기준으로 정렬
sorted_files=($(ls -1Sr *.png | tr '\n' '\0' | xargs -0 -n1 echo))

# 파일을 각 배열에 순서대로 추가
MDPI_FILE_NAME="${sorted_files[0]}"
HDPI_FILE_NAME="${sorted_files[1]}"
XHDPI_FILE_NAME="${sorted_files[2]}"
XXHDPI_FILE_NAME="${sorted_files[3]}"
XXXHDPI_FILE_NAME="${sorted_files[4]}"

# 배열 확인
#echo "MDPI_LIST: ${MDPI_LIST[@]}"
#echo "HDPI_LIST: ${HDPI_LIST[@]}"
#echo "XHDPI_LIST: ${XHDPI_LIST[@]}"
#echo "XXHDPI_LIST: ${XXHDPI_LIST[@]}"
#echo "XXXHDPI_LIST: ${XXXHDPI_LIST[@]}"


# 파일 이름 확인
echo "파일 이름 확인"
echo "MDPI_FILE_NAME: ${MDPI_FILE_NAME}"
echo "HDPI_FILE_NAME: ${HDPI_FILE_NAME}"
echo "XHDPI_FILE_NAME: ${XHDPI_FILE_NAME}"
echo "XXHDPI_FILE_NAME: ${XXHDPI_FILE_NAME}"
echo "XXXHDPI_FILE_NAME: ${XXXHDPI_FILE_NAME}"
echo

if [[ $FILE_NAME == "" ]]
then 
  FILE_NAME=${MDPI_FILE_NAME}
fi

# 파일 이동 
mv "$MDPI_FILE_NAME" "$PATH_MDPI/$FILE_NAME"
mv "$HDPI_FILE_NAME" "$PATH_HDPI/$FILE_NAME"
mv "$XHDPI_FILE_NAME" "$PATH_XHDPI/$FILE_NAME"
mv "$XXHDPI_FILE_NAME" "$PATH_XXHDPI/$FILE_NAME"
mv "$XXXHDPI_FILE_NAME" "$PATH_XXXHDPI/$FILE_NAME"

echo
echo "다음과 같이 이동 되었습니다."
echo $PATH_MDPI/$FILE_NAME
echo "끝"
