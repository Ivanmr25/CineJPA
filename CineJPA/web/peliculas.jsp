<%-- 
    Document   : peliculas
    Created on : 10-feb-2023, 17:04:03
    Author     : Usuario
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Entities.Movie"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy", Locale.US);
    List<Movie> resumen = (List<Movie>) session.getAttribute("resumen");


%>

<html>
    <%if (resumen.size() == 0) {%>
    <h5 class="text-danger">No existen pelis destacadas</h5>
    <%}%> 
    <div class="row">
        <% for (Movie movie : resumen) {%>

        <div class="card flex-fill">
            <div class="row">
                <div class="col-4 ">
                    <img class="card-img-top" src="<%=movie.getPoster() == null ? "img/noimagemovie.png" : "https://image.tmdb.org/t/p/w500" + movie.getPoster()%>" alt=""/>
                </div>
                <div class="col-8 d-flex">
                    <div class="card-body">
                        <h4 class="card-title"><%=movie.getTitulo()%></h4>
                        <p class="card-text"><%=movie.getTrama()%></p>
                        <p class="card-text"><%=sdf.format(movie.getFecha())%></p>
                    </div>
                </div>
            </div>
        </div>

        <%}%>
    </div>

</html>
</html>
