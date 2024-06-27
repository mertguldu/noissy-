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
import cv2
import numpy as np
import os
import tempfile
from pydub import AudioSegment
from io import BytesIO

def check_flac_header(audio_bytes):
    # Load FLAC audio data into an AudioSegment
    audio_segment = AudioSegment.from_file(BytesIO(audio_bytes), format="flac")

    # Print information about the audio file
    print("Channels:", audio_segment.channels)
    print("Sample width (bits per sample):", audio_segment.sample_width * 8)  # Convert sample width from bytes to bits
    print("Sample rate (Hz):", audio_segment.frame_rate)
    print("Duration (seconds):", len(audio_segment) / 1000)  # Length of audio in milliseconds, convert to seconds
    print("Sample Frames:", audio_segment.frame_count())
    
    return audio_segment.channels, audio_segment.frame_rate, len(audio_segment) / 1000, audio_segment.frame_count()

app = Flask(__name__)

selectedVideoData = {"VideoData": "", "UserID": ""}
description = {"VideoDescription": ""}

music_description = "90's metal music with electro guitar solo"

def estimate_frame_size(width, height, bits_per_pixel=24, compression_ratio=15):
    # Convert bits per pixel to bytes per pixel
    bytes_per_pixel = bits_per_pixel / 8
    # Calculate uncompressed frame size in bytes
    uncompressed_size = width * height * bytes_per_pixel
    # Apply compression ratio
    compressed_size = uncompressed_size / compression_ratio
    # Convert to MB
    size_mb = compressed_size / (1024 * 1024)
    return size_mb
    
def video_path_from_data(base64_data):
    # Decode base64 data
    video_data = base64.b64decode(base64_data)

    # Create a temporary file
    temp_file = tempfile.NamedTemporaryFile(suffix='.mov', delete=False)
    
    # Write the decoded data to the temporary file
    temp_file.write(video_data)

    # Close the file to flush the data to disk
    temp_file.close()
    #print(temp_file.name)
    
    return temp_file.name
    
    
def extract_frames(video_path, num_frames):

    cap = cv2.VideoCapture(video_path)
    # Get video properties
    fps = cap.get(cv2.CAP_PROP_FPS)
    total_frames = cap.get(cv2.CAP_PROP_FRAME_COUNT)
    duration = total_frames / fps

    # Calculate frame extraction interval
    interval = duration / num_frames

    # Extract frames from the video data
    frames = []
    frame_index = 0
    while True:
        ret, frame_data = cap.read()
        if not ret:
            break
        if frame_index % int(fps * interval) == 0:
            frames.append(cv2.cvtColor(frame_data, cv2.COLOR_BGR2RGB))
        frame_index += 1
    
    # Release the video capture object
    cap.release()

    return frames
    
# Function to arrange frames into a grid
def create_image_grid(frames, grid_size):
    grid_height, grid_width = grid_size
    frame_height, frame_width, _ = frames[0].shape
    grid_image = np.zeros((grid_height * frame_height, grid_width * frame_width, 3), dtype=np.uint8)

    for i in range(grid_height):
        for j in range(grid_width):
            index = i * grid_width + j
            if index < len(frames):
                frame = frames[index]
                grid_image[i * frame_height: (i + 1) * frame_height, j * frame_width: (j + 1) * frame_width] = frame

    
    # Convert NumPy array to PIL Image
    pil_image = Image.fromarray(grid_image)
    #pil_image.save('image_grid.jpg', 'JPEG')

    # Convert PIL image to Base64
    buffered = BytesIO()
    pil_image.save(buffered, format="JPEG")
    base64_image = base64.b64encode(buffered.getvalue()).decode("utf-8")
    return base64_image
    
    
def checkImageSize(base64_image):
    print("checking image size")
    # Decode base64-encoded image data
    image_data = base64.b64decode(base64_image)

    
    # Get the file size in bytes
    file_size_bytes = len(image_data)
    
    # Convert bytes to megabytes
    file_size_mb = file_size_bytes / (1024 ** 2)
    
    # print("checking the size of the generated image grid")
    print("file size is:", file_size_mb)
    if file_size_mb < 20.0:
        return True
    else:
        return False



def imageToText(base64_image):
    if checkImageSize(base64_image):
        client = OpenAI(api_key="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")
        
        systemMessage = "you are provided with a set of images which are screenshots from the same video. Based on the video, describe a music. In this description, make sure to include a genre and style, tempo and rhythm, instrumentation, emotional resonance, narrative alignment, and volume and dynamics. In your description DO NOT describe the images you see, only give a description for a music that can go good with the video content. Try to be concise. For example, an answer might be, emotion: peacefulness. genre: EDM. Instruments: syncopated drums, guitar. BPM: 120"

        #systemMessage = "The provided image is an image grid of a video. The frames are from the same video. Please describe the video content (image grid) by answering the following questions: 1. What emotion does the video evoke? 2. What genre or style of music is represented by the image? Which instruments can be associate with the emotion and genre of the video? What tempo or speed would you imagine the music based on the image? DO NOT describe the image, only answer the question. DO NOT use unnecessary word. The answer to the question should be no longer than 3 words. For example, an answer might be, emotion: peacefulness. genre: EDM. Instruments: syncopated drums, guitar. BPM: 120"

        
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
        max_tokens=100,
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
    
    return description["VideoDescription"]
    



@app.route('/music', methods=['POST'])
def add_video():
    data = request.get_json()
    try:
        video_data = data.get('VideoData', '')
        user_id = data.get('UserID', '')
        
        selectedVideoData['VideoData'] = video_data
        
        
        num_frames = 36  # Number of frames to extract
        grid_size = (6, 6)  # Grid size for the output image
        
        video_path = video_path_from_data(video_data)
        frames = extract_frames(video_path, num_frames)
        image_grid = create_image_grid(frames, grid_size)
        
        description["VideoDescription"] = "Classical Music with guitar solo" #imageToText(image_grid)
        
        if description["VideoDescription"] != "image size is too large":
            music_description = description["VideoDescription"]
            generatedMusicData = text2music(music_description)
            audio64 = base64.b64encode(generatedMusicData)
            audio64_encoded_str = audio64.decode('utf-8')
            
            audio_meta_data = check_flac_header(generatedMusicData)
            return ({'encodedData': audio64_encoded_str, 'channels': audio_meta_data[0], 'sampleRateHz': audio_meta_data[1], 'duration': audio_meta_data[2], 'sampleFrames': audio_meta_data[3]})
        else:
            print("image size is too large")
            return ("error")
    except Exception as e:
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True)
