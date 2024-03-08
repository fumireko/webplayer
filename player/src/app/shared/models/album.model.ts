import { Artist } from "./artist.model";
import { Song } from "./song.model";

export class Album {
    constructor(
        public id?: number,
        public title?: string,
        public imageUrl?: string,
        public releaseDate?: Date,
        public artists?: Artist[],
        public songs?: Song[],
        public releaseDateString?: string
    ){}
}
