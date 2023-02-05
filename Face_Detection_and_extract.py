"""

	Made by : Lucas MARAIS
	Date: 02/02/2023
	updated by: Lucas MARAIS
	UpDate: 02/02/2023

"""




import cv2
import numpy as np
from sklearn.decomposition import FastICA




def FindArea(img):
	"""
	This will extract the coordinates of the box above the eyes, returns a list under the form [[x,y],[x,y]], imput = img
	"""

	gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
	face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades +'haarcascade_frontalface_default.xml')
	eye_cascade = cv2.CascadeClassifier(cv2.data.haarcascades +'haarcascade_eye.xml')
	face = face_cascade.detectMultiScale(gray, 1.1, 10)
	for (x,y,w,h) in face:
		cv2.rectangle(img, (x, y), (x+w, y+h), (0, 0, 255), 2)
	cropped_image = img[face[0][1]:(face[0][1]+face[0][3]), face[0][0]:(face[0][0]+face[0][2])]
	gray = cv2.cvtColor(cropped_image, cv2.COLOR_BGR2GRAY)
	eyes = eye_cascade.detectMultiScale(gray, 1.1, 4)
	for (x,y,w,h) in eyes:
		cv2.rectangle(cropped_image, (x, y), (x+w, y+h), (255, 0, 0), 2)
	print(len(eyes), len(face))
	face = face[0]
	x,y,x2,y2 = int(min([eyes[0][0],eyes[1][0]])),int((1/8)*(max([eyes[0][1],eyes[1][1]]))),int(max([eyes[0][0],eyes[1][0]])+min([eyes[0][2],eyes[1][2]])), int(max([eyes[0][1],eyes[1][1]])-(1/8)*(max([eyes[0][1],eyes[1][1]])))
	cv2.rectangle(cropped_image, (x,y), (x2,y2), (0, 255, 0), 2)

	return [[x+face[0],y+face[1]],[x2+face[0],y2+face[1]]]

def average(coord, img):
	cropped_image = img[coord[0][1]:coord[1][1], coord[0][0]:coord[1][0]]
	#cv2.imshow("part selected",cropped_image)
	ACPR = np.average(cropped_image, axis=0)
	AvrgColor = np.average(ACPR, axis=0)
	return AvrgColor

def fICA(colors):
	pass
stacked = np.empty((0,3))


def processRGBdata(x):
	for i in range(0,3):
		y=0
		z=0
		for j in range(len(x)):
			y+=x[j][i]
			z+=1
		w=y/z
		m=0
		for j in range(len(x)):
			m+=abs(x[j][i]-w)
		mean = m/z
		SD = np.sqrt((m)/z)
		for j in range(len(x)):
			x[j][i]=(x[j][i]-mean)/SD
	return x









for i in [str(x).zfill(4) for x in range(1, 2001)]:
	try:
		print(i)
		img = cv2.imread(f'C:/Users/lucas/Documents/EENG3/Robotic/FDA/img/{i}.png')

		stacked = np.vstack((stacked,average(FindArea(img),img)))
	except :
		print("end of pictures")
	# cv2.imshow('title',img)
	# cv2.waitKey(0)
	# print(stacked)


normald = processRGBdata(stacked)

ICA = FastICA(n_components=3)
source = ICA.fit_transform(normald)

with open("results.txt", "w") as f:
	for x in range(len(source)):
		f.write(f'{source[x][0]},{source[x][1]},{source[x][2]}\n')