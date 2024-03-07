import { Album } from "./album.model";
import { Genre } from "./genre.model";

export class Artist {
    constructor(
        public id?: number,
        public name?: string,
        public description?: string,
        public countryCode?: any,
        public albums?: Album[],
        public genres?: Genre[]
    ){}
}
