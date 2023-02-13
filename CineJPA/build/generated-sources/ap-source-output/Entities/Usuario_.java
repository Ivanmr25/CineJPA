package Entities;

import Entities.Rating;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-02-10T12:14:07")
@StaticMetamodel(Usuario.class)
public class Usuario_ { 

    public static volatile ListAttribute<Usuario, Rating> ratingList;
    public static volatile SingularAttribute<Usuario, String> nombre;
    public static volatile SingularAttribute<Usuario, String> dni;

}