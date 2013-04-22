import c4d
import os
from c4d import *  
from c4d.documents import *	 
from c4d.utils import * 

skip = 0


def main():
		# userdata
		
		skip = op[c4d.ID_USERDATA, 1]
		fileName = op[c4d.ID_USERDATA, 2] 
		numFiles = op[c4d.ID_USERDATA, 3] 
		frameRatio = op[c4d.ID_USERDATA, 4] 
		objName = op[c4d.ID_USERDATA, 5] 
		
		
		# initialization
		
		time = doc.GetTime()  
		currentFrame = time.GetFrame(doc.GetFps())	

		mod = int(currentFrame*frameRatio) % numFiles
		
		
		
		f = open ( fileName % mod )

			
		points = []
		index = 0
		relevant_indices = []
		
		bs = BaseSelect()
		
		while f:
				line = f.readline()
				try: 
						idx,x,y,z = [100*float(v) for v in line.split(",")]

						idx = int(idx)
						v = c4d.Vector(x,y,z)
						if (x*y*z != 0) :
							bs.Select(index)
						
						points.append(v)
				except ValueError:
						break

				for i in range(skip):
						f.readline()
						
				index += 1

		f.close()

		obj =  doc.SearchObject(objName)
		obj.ResizeObject(len(points))
		obj.SetAllPoints(points)
		

		all_tags = obj.GetTags()
		
		relevant_tag = None
		
		for tag in all_tags:
			if tag.GetName() == 'relevantPoints':
				relevant_tag = tag
		
		
  
		sel = relevant_tag.GetBaseSelect()
		sel.DeselectAll()
		sel.Merge(bs)
	
		
		#sel.SetAll(relevant_indices)
		#print sel.GetCount()

		
		
		obj.Message(MSG_UPDATE)
		EventAdd()

		return
