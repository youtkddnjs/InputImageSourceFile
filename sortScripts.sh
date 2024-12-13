# ./source 디렉토리로 이동
if [ -d "./source" ]; then
  cd ./source
else
  echo "[Error] ./source 디렉토리를 찾을 수 없습니다."
  exit 1
fi

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

