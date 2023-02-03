import cv2
import time




def FindArea(img):
	"""
	This will extract the coordinates above the eyes, returns a list under the form [[x,y],[x,y]]

	Made by : Lucas MARAIS
	Date: 02/02/2023
	updated by: Lucas MARAIS
	UpDate: 02/02/2023
	"""

	gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
	face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades +'haarcascade_frontalface_default.xml')
	eye_cascade = cv2.CascadeClassifier(cv2.data.haarcascades +'haarcascade_eye.xml')
	face = face_cascade.detectMultiScale(gray, 1.3, 5)
	for (x,y,w,h) in face:
		cv2.rectangle(img, (x, y), (x+w, y+h), (0, 0, 255), 2)
		eyes = eye_cascade.detectMultiScale(gray, 1.3, 5)
		for (x,y,w,h) in eyes:
			cv2.rectangle(img, (x, y), (x+w, y+h), (255, 0, 0), 2)





	return cv2.imshow("face",img)


img = cv2.imread('C:/Users/lucas/Documents/EENG3/Robotic/FDA/img/1272.png')

FindArea(img)
cv2.waitKey(0)