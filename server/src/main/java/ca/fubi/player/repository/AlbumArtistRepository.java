package ca.fubi.player.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ca.fubi.player.models.Album;
import ca.fubi.player.models.Artist;
import ca.fubi.player.models.relations.AlbumArtist;

@Repository
public interface AlbumArtistRepository extends JpaRepository<AlbumArtist, Long> {
	Optional<AlbumArtist> findByAlbum(Album album);
	Optional<AlbumArtist> findByArtist(Artist artist);
}
