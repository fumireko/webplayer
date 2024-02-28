package ca.fubi.player.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ca.fubi.player.models.Album;
import java.util.List;
import ca.fubi.player.models.Artist;

@Repository
public interface AlbumRepository extends JpaRepository<Album, Long>{
	Optional<Album> findById(Long id);
	Optional<Album> findByTitle(String title);
}
