abstract class BaseMapper<E, D> {
  D mapFromEntity(E type) => Object as D;

  E mapToEntity(D type) => Object as E;
}
