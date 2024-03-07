import { Album } from "./album.model";

export class Song {
    constructor(
        public id?: number,
        public title?: string,
        public length?: number,
        public album?: Album
    ){}
}
