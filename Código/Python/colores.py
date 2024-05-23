import cv2
import numpy as np

def capture_objects():
    cap = cv2.VideoCapture(0)

    # Rango de color para objetos oscuros
    dark_lower = np.array([0,0,0], np.uint8)
    dark_upper = np.array([180,255,30], np.uint8)

    # Rango de color para objetos verdes
    green_lower = np.array([36, 25, 25])
    green_upper = np.array([86, 255, 255])
    
    while True:
        ret, frame = cap.read()

        if ret==True:
            frame_hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

            # Detección de objetos oscuros
            mask_dark = cv2.inRange(frame_hsv, dark_lower, dark_upper)
            contours_dark, _ = cv2.findContours(mask_dark, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
            
            for c in contours_dark:
                area = cv2.contourArea(c)
                if area > 3000:
                    M = cv2.moments(c)
                    if (M["m00"]==0): M["m00"]=1
                    x = int(M["m10"]/M["m00"])
                    y = int(M['m01']/M['m00'])
                    cv2.circle(frame, (x,y), 7, (0,0,3), -1)  # Centros verdes
                    font = cv2.FONT_HERSHEY_SIMPLEX
                    cv2.putText(frame, '{},{}'.format(x,y),(x+10,y), font, 0.75,(0,255,0),1,cv2.LINE_AA)
                    new_contour = cv2.convexHull(c)
                    cv2.drawContours(frame, [new_contour], 0, (0,0,0), 3)  # Contornos negros
            
            # Detección de objetos verdes
            mask_green = cv2.inRange(frame_hsv, green_lower, green_upper)
            contours_green, _ = cv2.findContours(mask_green, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
            
            for c in contours_green:
                area = cv2.contourArea(c)
                if area > 3000:
                    M = cv2.moments(c)
                    if (M["m00"]==0): M["m00"]=1
                    x = int(M["m10"]/M["m00"])
                    y = int(M['m01']/M['m00'])
                    cv2.circle(frame, (x,y), 7, (0,255,0), -1)  # Centros rojos
                    font = cv2.FONT_HERSHEY_SIMPLEX
                    cv2.putText(frame, '{},{}'.format(x,y),(x+10,y), font, 0.75,(0,0,255),1,cv2.LINE_AA)
                    new_contour = cv2.convexHull(c)
                    cv2.drawContours(frame, [new_contour], 0, (0,255,0), 3)  # Contornos verdes
            
            cv2.imshow('frame',frame)
            if cv2.getWindowProperty('frame', cv2.WND_PROP_VISIBLE) < 1:
                break
            
            if cv2.waitKey(1) & 0xFF == ord('s'):
                break
    
    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    capture_objects()
