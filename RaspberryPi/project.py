import face_recognition, cv2, os, glob, time, subprocess, signal
import numpy as np
from numpy import save
from numpy import load

try:
    pro = subprocess.Popen("python3 profiler.py recogresource.csv", stdout=subprocess.PIPE, shell=True, preexec_fn=os.setsid) #starts profiling hardware use
    faces_encodings = []  # list with facial encodings
    faces_names = []  # list with face names

    path = '/10/numpyfiles/' # directory with facial encodings stored
    list_of_files = [f for f in glob.glob(path + '*.npy')]
    number_files = len(list_of_files)
    names = list_of_files.copy()

    for name in list_of_files: # adds encodings to list from file
        faces_encodings.append(load(name))
        facename = name.replace(path, '')  #Create array of known names
        faces_names.append(facename)

    face_locations = []
    face_encodings = []
    face_names = []
    process_this_frame = True

    frameNum = 0 #counts number of frames processed by script

    # establishes video capture
    video_capture = cv2.VideoCapture(0)
    video_capture.set(cv2.CAP_PROP_FRAME_WIDTH, 800)
    video_capture.set(cv2.CAP_PROP_FRAME_HEIGHT, 600)
    video_capture.set(cv2.CAP_PROP_FPS, 20)

    start_time = int(time.time()) #measures execution time of script

    while True:
        ret, frame = video_capture.read()  # reads frame
        small_frame = cv2.resize(frame, (0, 0), fx=0.25, fy=0.25)
        rgb_small_frame = small_frame[:, :, ::-1]
        if process_this_frame:

            face_locations = face_recognition.face_locations(rgb_small_frame)  #gets face location
            face_encodings = face_recognition.face_encodings(rgb_small_frame, face_locations) #generates face encoding of face in frame
            face_names = []

            for face_encoding in face_encodings:  # iterates over number of faces in frame
                matches = face_recognition.compare_faces(faces_encodings, face_encoding)  # checks if faces match
                name = "Unknown"
                face_distances = face_recognition.face_distance(faces_encodings,
                                                                face_encoding)#calculates distance between faces
                best_match_index = np.argmin(face_distances) #finds shortest distance face
                if matches[best_match_index]:
                    name = faces_names[best_match_index]  #gets face name
                face_names.append(name)

        process_this_frame = not process_this_frame

        frameNum = frameNum + 1


except:
    print("test")
