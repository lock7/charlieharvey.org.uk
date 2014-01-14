package invaders;
import java.awt.*;
import javax.swing.ImageIcon;
import java.util.Hashtable;
// singleton that loads images, and acts as a cache/store
// for images

/*Copyright (C) 2006 Charlie Harvey

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.*/

public abstract class ImageStore {
  Hashtable images;

  ImageStore() {
    images=new Hashtable(); 
  }
  
  public Image getImage(String filename) {
    return (Image)images.get(filename);
  }

  public void addImage(String filename) {
    images.put(filename,
        new ImageIcon(getClass().getClassLoader().getResource("invaders/graphics/"+filename)).getImage()
    );
  }
}