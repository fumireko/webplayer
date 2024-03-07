import { Song } from "./song.model";
import { User } from "./user.model";

export class Playlist {
    constructor(
        public id?: number,
        public name?: string,
        public user?: User,
        public songs?: Song[]
    ){}
}
