import { Album } from "./album.model";
import { File } from "./file.model";

export class Song {
    constructor(
        public id?: number,
        public title?: string,
        public length?: number,
        public album?: Album,
        public file?: File
    ){}
}
