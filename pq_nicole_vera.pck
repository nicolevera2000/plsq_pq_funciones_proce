create or replace package pq_nicole_vera is

  -- Author  : DESARROLLO
  -- Created : 11/2/2023 13:03:04
  -- Purpose : 

  -- Function and procedure implementations
  PROCEDURE FUNCION_AL_REVES(PV_CADENA_INGRESO IN VARCHAR2);
 
                                       
  FUNCTION FUNCION_DIFERENCIA_DE_FECHA (PD_FECHA_INICIO IN DATE, 
    PD_FECHA_FIN IN DATE,PV_ERROR OUT VARCHAR2, PN_ERROR OUT NUMBER) 
    RETURN NUMBER;
   
   procedure numeroPrimo(pn_numero_ingreso  in  number,
                                        pv_mensajeerro     out varchar2,
                                        pn_codigoerro      out number,
                                        pv_resultado out varchar2);

end pq_nicole_vera;
/
create or replace package body pq_nicole_vera is

  PROCEDURE FUNCION_AL_REVES(PV_CADENA_INGRESO IN VARCHAR2) is
  
    LV_NUEVA_VARIABLE VARCHAR2(100);
    LV_NUMERO_CA      NUMBER;
    LV_VARIABLE_RESUL VARCHAR2(100);
  begin
  
    LV_NUEVA_VARIABLE := PV_CADENA_INGRESO;
    LV_NUMERO_CA      := LENGTH(LV_NUEVA_VARIABLE);
    FOR I IN REVERSE LV_NUMERO_CA .. 1 LOOP
      lV_VARIABLE_RESUL := SUBSTR(LV_NUEVA_VARIABLE, I);
      DBMS_OUTPUT.put_line(lV_VARIABLE_RESUL);
    END LOOP;
  
  end;

  FUNCTION FUNCION_DIFERENCIA_DE_FECHA(PD_FECHA_INICIO IN DATE,
                                       PD_FECHA_FIN    IN DATE,
                                       PV_ERROR        OUT VARCHAR2,
                                       PN_ERROR        OUT NUMBER)
    RETURN NUMBER IS
  
    LD_CALCULO_FECHA    DATE;
    LN_FECHA_INICIO     NUMBER;
    LN_FECHA_FINAL      NUMBER;
    LN_DIFERENCIA_FECHA NUMBER;
    LV_NOMBRE_PAQUETE VARCHAR2(100):='pq_nicole_vera.FUNCION_DIFERENCIA_DE_FECHA';
  
  BEGIN
  
  IF PD_FECHA_INICIO IS NULL THEN 
    
    PV_ERROR := 'INGRESE UNA FECHA DE INICIO EN LA FUNCION: '|| LV_NOMBRE_PAQUETE ;
     PN_ERROR := 2;
     
     RETURN NULL;
  END IF;
  
  IF PD_FECHA_FIN IS NULL THEN 
    
    PV_ERROR := 'INGRESE UNA FECHA DE FIN EN LA FUNCION:  '||  LV_NOMBRE_PAQUETE;
     PN_ERROR := 2;
     
     RETURN NULL;
  END IF;
  
  
    LN_FECHA_INICIO     := TO_NUMBER(TO_CHAR(PD_FECHA_INICIO, 'YYYY'));
    LN_FECHA_FINAL      := TO_NUMBER(TO_CHAR(PD_FECHA_FIN, 'YYYY'));
    LN_DIFERENCIA_FECHA := LN_FECHA_FINAL - LN_FECHA_INICIO;
    RETURN LN_DIFERENCIA_FECHA;
  
  EXCEPTION
  
    WHEN OTHERS THEN
      PV_ERROR := 'ERROR EN LA FUNCION: ' ||  LV_NOMBRE_PAQUETE|| ' - ' || SQLERRM;
      PN_ERROR := -1;
    
      RETURN NULL;
  END FUNCION_DIFERENCIA_DE_FECHA;
  
  procedure numeroPrimo(pn_numero_ingreso  in  number,
                                        pv_mensajeerro     out varchar2,
                                        pn_codigoerro      out number,
                                        pv_resultado out varchar2) is


ln_contador number;



begin
      ln_contador:=0;      
      if pn_numero_ingreso is null then 
        
      pv_mensajeerro:='Ingrese un numero';
      pn_codigoerro:=2;
      
      end if;
      
      if pn_numero_ingreso<=0 then
      pv_mensajeerro:='Digite un numero entero positivo';
      pn_codigoerro:=2;        
      end if;
      
      if pn_numero_ingreso >=1 then 
      
      for i in 1..pn_numero_ingreso loop
      
      if mod(pn_numero_ingreso,i)=0 then
         ln_contador:=ln_contador+1;
         dbms_output.put_line(ln_contador);
      end if; 
      
      end loop;
      
      if ln_contador=2 then 
        pv_resultado:='Es primo';
     else
        pv_resultado:='No es primo';
      end if;
      end if;
  
exception when others then
   pn_codigoerro      := -1;
   pv_mensajeerro     := 'Errorrr:'||sqlcode||'-'||sqlerrm;--aqui se muestran los errores de oracle, se puede controlar para 
 --r
end numeroPrimo;

end pq_nicole_vera;
/
