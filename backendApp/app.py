from flask import Flask, jsonify, request, render_template, Response
import base64
import torch
import torchvision
from io import BytesIO
from PIL import Image
import itertools
from torchvision.utils import make_grid
from openai import OpenAI
import requests
import io

app = Flask(__name__)

selectedVideoData = {"VideoData": "", "FrameSize": ""}
description = {"VideoDescription": ""}

music_description = "90's metal music with electro guitar solo"

def createImageGridFromVideo(data):
    # Replace this with your base64-encoded video data
    print("creating image grid")
    base64_encoded_video_data = data

    # Decode base64-encoded video data
    video_data = base64.b64decode(base64_encoded_video_data) #video binary data
    # Convert BytesIO to bytes
    video_bytes = BytesIO(video_data).getvalue()
    
    # Create VideoReader from the decoded video data
    reader = torchvision.io.VideoReader(video_bytes, "video")
    #reader_md = reader.get_metadata() not working for .MOV
    #duration = reader_md["video"].get("duration", None)
    reader.seek(2.0)
    frame = next(reader)

    frame_size = float(selectedVideoData["FrameSize"])
    max_number_of_frames = int(20 // frame_size) # approx number of max frames s.t. img_base64 <= 20mb
    frame_number = int(max_number_of_frames // 15)
    
    frames = []
    for frame in itertools.islice(reader.seek(0), frame_number):
        frames.append(frame['data'])

    frame_grid = frames
    row = int(len(frame_grid)**0.5)
    grid = make_grid(frame_grid, nrow=row, padding=25)
    img = torchvision.transforms.ToPILImage()(grid)
    
    buffer = BytesIO()
    img.save(buffer, format="JPEG")  # You can choose the format according to your needs
    img_base64 = base64.b64encode(buffer.getvalue()).decode("utf-8")
    
    return img_base64
    
    
def checkImageSize(base64_image):
    # Decode base64-encoded image data
    image_data = base64.b64decode(base64_image)
    
    # Get the file size in bytes
    file_size_bytes = len(image_data)
    
    # Convert bytes to megabytes
    file_size_mb = file_size_bytes / (1024 ** 2)
    
    # print("checking the size of the generated image grid")
    # print("file size is:", file_size_mb)
    if file_size_mb < 20.0:
        return True
    else:
        return False


def imageToText(base64_image):
    if checkImageSize(base64_image):
        client = OpenAI(api_key="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")
        
        #systemMessage = "you are provided with a set of images which are screenshots from the same video. Based on the video, describe a music. In this description, make sure to include a genre and style, tempo and rhythm, instrumentation, emotional resonance, narrative alignment, and volume and dynamics. In your description DO NOT describe the images you see, only give a description for a music that can go good with the video content. Try to be concise with giving short sentences to "

        systemMessage = "what's the image?"
        
        response = client.chat.completions.create(
        model="gpt-4-vision-preview",
        messages=[
            {
            "role": "user",
            "content": [
                {"type": "text", "text": systemMessage},
                {
                "type": "image_url",
                "image_url": {
                    "url": f"data:image/jpeg;base64,{base64_image}",
                    "detail": "low"
                },
                },
            ],
            }
        ],
        max_tokens=300,
        )
        output = response.choices[0].message.content
        #print(response.json())
        
        return output
    else:
        result = "image size is too large"
        return result

    
def text2music(text):
    API_URL = "https://api-inference.huggingface.co/models/facebook/musicgen-small"
    headers = {"Authorization": "Bearer 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"}
    
    def query(payload):
        response = requests.post(API_URL, headers=headers, json=payload)
        return response.content

    audio_bytes = query({
        "inputs": text,
    })

    return audio_bytes



@app.route('/tasks', methods=['GET'])
def get_tasks():
    if description["VideoDescription"] != "":
        return ({'video description': description["VideoDescription"]})
    else:
        return "no description available", 201



@app.route('/tasks', methods=['POST'])
def add_video():
    data = request.get_json()
    try:
        video_data = data.get('VideoData', '')
        frame_size = data.get('FrameSize', '')
        
        selectedVideoData['VideoData'] = video_data
        selectedVideoData['FrameSize'] = frame_size
        imageOfVideo = createImageGridFromVideo(selectedVideoData['VideoData'])
        #description["VideoDescription"] = imageToText(imageOfVideo)
        
        if description["VideoDescription"] != "image size is too large":
            generatedMusicData = text2music("90's pop music") #change this
            audio64 = base64.b64encode(generatedMusicData)
            audio64_encoded_str = audio64.decode('utf-8')
            
            return ({'message': audio64_encoded_str}), 201
        else:
            print("image size is too large")
            return ("error")
    except Exception as e:
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True)
