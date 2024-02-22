package ca.fubi.player.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ca.fubi.player.models.Genre;

@Repository
public interface GenreRepository extends JpaRepository<Genre, Long>{
	Optional<Genre> findById(Long id);
	Optional<Genre> findByDescription(String description);
}
