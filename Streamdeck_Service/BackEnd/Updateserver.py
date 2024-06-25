from flask import Flask, request, jsonify, send_file, make_response
import requests as rq

app = Flask(__name__)

# 업데이트 파일 목록 및 정보
update_info = {
    "version": "1.0.1",
    "filename": "update.zip",
    "url": "C:/Users/HHH/Documents/VScode/IT-Concept/Streamdeck_Service/BackEnd/test.txt",
    "description": "버그 수정 및 기능 추가",
}

go_downloadinfo = {
    "version": "1.0.1",
    "filename": "update.zip",
    "url": "C:/Users/HHH/Documents/VScode/IT-Concept/Streamdeck_Service/BackEnd/test.txt",
    "description": "버그 수정 및 기능 추가",
}

# 업데이트 정보 요청 처리
@app.route("/update/info")
def get_update_info():
    return jsonify(update_info)

# 업데이트 파일 다운로드 요청 처리
@app.route("/update/download")
def download_update():

    file_path = r"test.txt"

    # 파일 다운로드
    with open(file_path, "wb") as f:
        response = rq.get(update_info["url"], stream=True)
        response.raw.decode_content = True
        for chunk in response.iter_content(chunk_size=1024):
            f.write(chunk)

    # 다운로드 완료 응답
    return jsonify({"message": "다운로드 완료"})
@app.route("/go/download")
def return_files_tut():
	try:
		return send_file("C:/Users/HHH/Documents/VScode/IT-Concept/Streamdeck_Service/BackEnd/test.exe",  mimetype="text/plain", as_attachment=True)
	except Exception as e:
		return str(e)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)


