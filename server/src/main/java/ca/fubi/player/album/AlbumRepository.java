package ca.fubi.player.album;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ca.fubi.player.artist.Artist;

import java.util.List;

@Repository
public interface AlbumRepository extends JpaRepository<Album, Long>{
	Optional<Album> findById(Long id);
	Optional<Album> findByTitle(String title);
	List<Album> findByArtists(Artist a);
}
