import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { Album } from '../shared/models/album.model';

@Injectable({
  providedIn: 'root'
})
export class StyleService {
  private averageColorSubject = new BehaviorSubject<string>('rgb(9,9,9)');
  averageColor = this.averageColorSubject.asObservable();

  calculateAverageColor(album: Album) {
    const imageUrl = album?.imageUrl;
    if (imageUrl) {
        const img = new Image();
        img.crossOrigin = "Anonymous";
        img.src = imageUrl; 
        img.onload = () => {
            const canvas = document.createElement('canvas');
            const ctx = canvas.getContext('2d')!;
            canvas.width = img.width;
            canvas.height = img.height;
            ctx.drawImage(img, 0, 0);
            
            const imageData = ctx.getImageData(0, 0, img.width, img.height).data;
            let r = 0, g = 0, b = 0;
      
            for (let i = 0; i < imageData.length; i += 4) {
                r += imageData[i];
                g += imageData[i + 1];
                b += imageData[i + 2];
            }
      
            const pixels = imageData.length / 4;
            const averageColor = `rgb(${Math.round(r / pixels)}, ${Math.round(g / pixels)}, ${Math.round(b / pixels)})`;

            const hslColor = this.rgbToHsl(averageColor);
            hslColor[1] = Math.min(1, hslColor[1] * 2.5);
            const saturatedColor = this.hslToRgb(hslColor[0], hslColor[1], hslColor[2]);

            this.updateAverageColor(saturatedColor);
        };
    }
  }

  updateAverageColor(color: string) {
    this.averageColorSubject.next(color);
  }

  rgbToHsl(rgb: string): [number, number, number] {
    const [r, g, b] = rgb.match(/\d+/g)!.map(Number);
    const rRatio = r / 255;
    const gRatio = g / 255;
    const bRatio = b / 255;
    const max = Math.max(rRatio, gRatio, bRatio);
    const min = Math.min(rRatio, gRatio, bRatio);
    let h = 0,
      s = 0,
      l = (max + min) / 2;

    if (max !== min) {
      const d = max - min;
      s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
      switch (max) {
        case rRatio:
          h = ((gRatio - bRatio) / d + (gRatio < bRatio ? 6 : 0)) / 6;
          break;
        case gRatio:
          h = ((bRatio - rRatio) / d + 2) / 6;
          break;
        case bRatio:
          h = ((rRatio - gRatio) / d + 4) / 6;
          break;
      }
    }

    return [h, s, l];
  }

  hslToRgb(h: number, s: number, l: number): string {
    let r, g, b;
    if (s === 0) {
      r = g = b = l;
    } else {
      const hueToRgb = (p: number, q: number, t: number) => {
        if (t < 0) t += 1;
        if (t > 1) t -= 1;
        if (t < 1 / 6) return p + (q - p) * 6 * t;
        if (t < 1 / 2) return q;
        if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
        return p;
      };
      const q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      const p = 2 * l - q;
      r = hueToRgb(p, q, h + 1 / 3);
      g = hueToRgb(p, q, h);
      b = hueToRgb(p, q, h - 1 / 3);
    }
    return `rgb(${Math.round(r * 255)}, ${Math.round(g * 255)}, ${Math.round(b * 255)})`;
  }
}
