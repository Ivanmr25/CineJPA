<%-- 
    Document   : home.jsp
    Created on : 10-feb-2023, 11:54:35
    Author     : diurno
--%>

<%@page import="java.math.BigDecimal"%>
<%@page import="Entities.Usuario"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigInteger"%>
<%@page import="Entities.Person"%>
<%@page import="Entities.Movie"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%
List<Movie> movies = (List<Movie>) session.getAttribute("movies");
List<Person> persons = (List<Person>) session.getAttribute("personas");
    SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy",Locale.US);
        String msg = (String) session.getAttribute("msg");
        Usuario usuario = (Usuario) session.getAttribute("user");
    session.removeAttribute("msg");
%>
<head>
  <title>The Movies DB</title>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
   <link rel="stylesheet" href="style.css">
</head>

<body>
    <% if (msg != null ){%>
        <div class="container">
            <div class="toast">
                <div class="toast-header">
                  
                </div>
                <div class="toast-body">
                   <%=msg%>
                </div>
        </div>
            <%}%>
  <div class="container shadow p-0">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="d-flex align-items-center">
        <a class="navbar-brand" href="#">
          <img src="img/logotmdb.png" alt="logo" width="60" />
        </a>
        <div class="navbar-nav mx-auto mt-2 mt-lg-0">
          <a class="nav-link" href="Controller?op=vaperson"><h4 class="text-white">Person</h4></a>
          <a class="nav-link" href="Controller?op=vamovie"><h4 class="text-white">Movies</h4 ></a>
        </div>
      </div>
      <div class="ml-auto">
       <form action="Controller?op=login" method="post">
  <div class="d-flex">
    <input type="text" name="dni" id="" placeholder="DNI" class="w-50">
    <input type="text" name="nombre" id="" placeholder="Nombre" class="w-50 form-control">
    <% if (usuario == null) {%>
    <button class="btn btn-outline-success mr-2 ml-2"  type="submit">Login/Register</button>
 <%}%>
  </div>
</form>

<% if (usuario != null) {%>
  
      <div class="d-flex float-right">
          <a href="Controller?op=logout"> <button class="btn btn-outline-danger my-2 my-sm-0 text-white " >Logout</button></a>
      </div>
  </form>
<%}%>
          
      </div> 
           
    </nav>
      <%if(movies == null){%>
    <div class="row pt-2 justify-content-center">
           <% for(Person person:persons){%>
      <div class="col-md-6 col-lg-4 mb-4 d-flex">
       
        <div class="card flex-fill">
          
                
                
          
             <img class="card-img-top" src="<%=person.getFoto()==null?"img/noimagemovie.png":"https://image.tmdb.org/t/p/w500"+person.getFoto() %>" alt=""/>
        
          <div class="card-body text-center">
              <h4 class="card-title"><%for(double i=0.; i < 5; i++){ %>
                  <%Double trouble =  Double.parseDouble(  person.getPopularidad().toString() );
                    Double result = (trouble / 10); %>
                  <% String color = i <  result ? "text-warning" : "text-muted"; %>
<span class="<%=color%>"><i class="fa fa-star text-center" aria-hidden="true"></i></span>
<%} %></h4>
            <h2 class="card-text"><%=person.getNombre() %></h2>
            <% if (usuario != null) {
                    
                
            %>
            <span class="rating">
                <%for(int i = 1; i < 6; i++){%>
                                	<a href="Controller?op=puntuar&pt=<%=i%>&persona=<%=person.getId()%>&user=<%=usuario.getDni()%>">&#9733;</a>
                                        <%}%>
                                	
                            	</span>
           
          </div>
          <div class="card-footer text-center">
            <button class="btn btn-success mr-2 ml-2"  data-toggle="modal" data-target="#modalresumen" data-person="<%=person.getId() %>">Filmografia</button>
            <%}%>
          </div>
        </div>
      </div>
          <%}%>
    </div>
    <%}%>
    <%if(persons == null){%>
    <div class="row pl-2 pt-2 ">
        <% for (Movie movie:movies){%>
      <div class="col-md-6 mb-4 d-flex ">
        <div class="card flex-fill">
          <div class="row">
            <div class="col-4 ">
               
              <img class="card-img-top" src="<%=movie.getPoster()==null?"img/noimagemovie.png":"https://image.tmdb.org/t/p/w500"+movie.getPoster() %>" alt=""/>
             
            </div>
            <div class="col-8 d-flex">
              <div class="card-body">
                <h4 class="card-title"><%=movie.getTitulo() %></h4>
                <p class="card-text"><%=movie.getTrama() %></p>
                <p class="card-text"><%=sdf.format(movie.getFecha())%></p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <%}%>
    </div>
    <%}%>

    <h2 class="text-center text-success bg-dark p-3">The Movie DB 2020</h2>
  </div>
    <div class="modal fade" id="modalresumen" tabindex="-1" role="dialog" aria-labelledby="modelTitleId"
       aria-hidden="true">
       <div class="modal-dialog" role="document">
           <div class="modal-content">
               <div class="modal-header">
               </div>
               <h4 class="modal-title bg-primary text-white text-center mb-2">Pelis mas destacadas</h4>
               
               <div class="container text-center" id="resumen"></div>

           </div>
       </div>
   </div>
  <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
    <script src="myjs.js"></script>
    <%if(msg != null){%>
        <script>
            $(document).ready(function(){
             $('.toast').toast('show');
            });
            </script>
            <%}%>
</body>

</html>
