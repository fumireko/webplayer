import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'minutes'
})
export class MinutesPipe implements PipeTransform {
  transform(value: number | undefined): string | undefined {
    if(value){
      const minutes: number = Math.floor(value / 60);
      const seconds: number = Math.round(value % 60);  
      return `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
    }
    else return undefined;
  }
}
