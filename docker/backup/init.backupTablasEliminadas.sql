-- ==================================================================
-- SCRIPT DE MIGRACIÓN DE SQL SERVER A POSTGRESQL
-- Conversión completa de estructura de base de datos
-- ==================================================================

-- Tabla: VadPrincActivo
CREATE TABLE VadPrincActivo (
    CodFarmaco VARCHAR(10) NOT NULL,
    CodPActivo VARCHAR(15) NOT NULL,
    Descripcion VARCHAR(150) NOT NULL,
    Caracteristica TEXT NOT NULL,
    CONSTRAINT PK_VadPrincActivo PRIMARY KEY (CodFarmaco, CodPActivo)
);

-- Tabla: VadNComercial
CREATE TABLE VadNComercial (
    CodFarmaco VARCHAR(10) NOT NULL,
    CodPActivo VARCHAR(15) NOT NULL,
    CodNComercial VARCHAR(15) NOT NULL,
    Descripcion VARCHAR(150) NOT NULL,
    Indicacion TEXT NOT NULL,
    Posologia VARCHAR(2024),
    Contraindicaciones VARCHAR(250),
    CONSTRAINT PK_VadNComercial PRIMARY KEY (CodFarmaco, CodPActivo, CodNComercial)
);

-- Tabla: VadFarmacos
CREATE TABLE VadFarmacos (
    CodFarmaco VARCHAR(10) NOT NULL,
    Descripcion VARCHAR(150),
    CONSTRAINT PK_VadFarmacos PRIMARY KEY (CodFarmaco)
);

-- Tabla: VADEMECUM
CREATE TABLE VADEMECUM (
    CODIGOTF DOUBLE PRECISION,
    TIPOSDEFARMACOS VARCHAR(255),
    CODIGOPA VARCHAR(255),
    PRINCIPIOSACTIVOS VARCHAR(255),
    CARACTERISTICA TEXT,
    CODIGONC VARCHAR(255),
    NOMBRESCOMERCIALES VARCHAR(255),
    indicacion TEXT,
    POSOLOGIA TEXT
);

-- Tabla: temtratamientos
CREATE TABLE temtratamientos (
    codespecialidad VARCHAR(50),
    desespecialidad VARCHAR(100),
    idCodTratamiento INTEGER,
    codtratamiento NUMERIC(18, 3),
    destratamiento VARCHAR(50),
    valordestra TEXT,
    coddetra VARCHAR(50),
    desdetra VARCHAR(100),
    valortrades NUMERIC(18, 2)
);

-- Tabla: TEMDETALLE
CREATE TABLE TEMDETALLE (
    iLinea SERIAL NOT NULL,
    iIdproducto INTEGER,
    dCantidad NUMERIC(18, 4)
);

-- Tabla: temActivos
CREATE TABLE temActivos (
    codigo VARCHAR(10),
    activo VARCHAR(200),
    marca VARCHAR(200),
    modelo VARCHAR(200),
    serie VARCHAR(200)
);

-- Tabla: tblFacturadores
CREATE TABLE tblFacturadores (
    vCIRuc VARCHAR(13),
    vNombre VARCHAR(250),
    vApellido VARCHAR(250),
    vDireccion VARCHAR(250),
    vTelefono VARCHAR(100),
    vEmail VARCHAR(100)
);

-- Tabla: ODONGarantias
CREATE TABLE ODONGarantias (
    iidGarantia INTEGER,
    iidDetalle INTEGER
);

-- Tabla: MARtblMarcaciones
CREATE TABLE MARtblMarcaciones (
    vUsuario VARCHAR(30) NOT NULL,
    sFechaMarcacion TIMESTAMP NOT NULL,
    sHoraEntradaJornadaUno VARCHAR(5) NOT NULL,
    sHoraSalidaJornadaUno VARCHAR(5),
    sHoraEntradaJornadaDos VARCHAR(5),
    sHoraSalidaJornadaDos VARCHAR(5),
    vUsuarioIngreso VARCHAR(30),
    sFechaIngreso TIMESTAMP,
    vEstacionIngresa VARCHAR(50),
    vUsuarioActualiza VARCHAR(30),
    sFechaActualiza TIMESTAMP,
    vEstacionActualiza VARCHAR(50)
);

-- Tabla: SEGUsuarioAplicaciones
CREATE TABLE SEGUsuarioAplicaciones (
    vUsuario VARCHAR(30),
    bAdministracion BOOLEAN,
    bodontologia BOOLEAN,
    bFacturacion BOOLEAN,
    binventario BOOLEAN,
    bContabilidad BOOLEAN,
    bMarcaciones BOOLEAN
);

-- Tabla: SEGtblUsuario
CREATE TABLE SEGtblUsuario (
    vUsuario VARCHAR(30) NOT NULL,
    vNombres VARCHAR(80) NOT NULL,
    vApellidos VARCHAR(80) NOT NULL,
    vClave VARCHAR(100) NOT NULL,
    vDireccionFoto VARCHAR(200),
    bActivo BOOLEAN NOT NULL,
    IdDoctor INTEGER,
    CONSTRAINT PK_SEGtblUsuario PRIMARY KEY (vUsuario)
);

-- Tabla: ortodoncia
CREATE TABLE ortodoncia (
    idespe INTEGER,
    idestr INTEGER,
    codouno VARCHAR(20),
    desuno VARCHAR(500),
    cododos VARCHAR(20),
    desdos VARCHAR(500),
    valor NUMERIC(9, 3)
);

-- Tabla: ODOnTratamientoPacienteLog
CREATE TABLE ODOnTratamientoPacienteLog (
    iIdDetalle INTEGER,
    idpaciente INTEGER,
    iIdEspecialidad INTEGER,
    siTratamiento SMALLINT,
    iIdTratamientoDetalle INTEGER,
    dValor NUMERIC(9, 2),
    cEstado CHAR(1),
    iIdDoctor INTEGER,
    idConsultorio INTEGER,
    vObservacion VARCHAR(150),
    dFecha TIMESTAMP,
    vUsuario VARCHAR(20),
    cEstadoTratamiento CHAR(1),
    vPieza VARCHAR(20),
    vDatoPieza VARCHAR(250),
    iIdDetalleDescuento INTEGER,
    vObservacion1 VARCHAR(150),
    FechaEliminacion TIMESTAMP,
    vUsuarioElimina VARCHAR(20)
);

-- Tabla: ODOntblTratamientos
CREATE TABLE ODOntblTratamientos (
    iIdEspecialidad INTEGER NOT NULL,
    siTratamiento SMALLINT NOT NULL,
    vcodigo VARCHAR(6),
    vDescTratamiento VARCHAR(500) NOT NULL,
    bActivo BOOLEAN,
    CONSTRAINT PK_ODOntblTratamientos PRIMARY KEY (iIdEspecialidad, siTratamiento)
);

-- Tabla: ODOntblTratamientoOrtodonciaPaciente
CREATE TABLE ODOntblTratamientoOrtodonciaPaciente (
    idDetalle SERIAL NOT NULL,
    idpaciente INTEGER,
    dFechaPago TIMESTAMP,
    dValor NUMERIC(9, 2),
    cEstado CHAR(1)
);


-- Tabla: ODONtblTratamientoDetalle
CREATE TABLE ODONtblTratamientoDetalle (
    iIdEspecialidad INTEGER NOT NULL,
    siTratamiento SMALLINT NOT NULL,
    iIdTratamientoDetalle SERIAL NOT NULL,
    vcodigo VARCHAR(15),
    vDescripcion VARCHAR(80),
    dValorTratamiento NUMERIC(8, 2),
    bEstado BOOLEAN,
    CONSTRAINT PK_tblTratamientoDetalle PRIMARY KEY (iIdEspecialidad, siTratamiento, iIdTratamientoDetalle)
);

-- Tabla: ODOntblRecetaPaciente
CREATE TABLE ODOntblRecetaPaciente (
    iIdReceta SERIAL NOT NULL,
    idpaciente INTEGER,
    iIdDetalle INTEGER,
    vUsuario VARCHAR(20),
    CONSTRAINT PK_ODOntblRecetaPaciente PRIMARY KEY (iIdReceta)
);

-- Tabla: OdontblParametrosGeneralesDet
CREATE TABLE OdontblParametrosGeneralesDet (
    siGrupoParametro SMALLINT NOT NULL,
    siCodigoParametro SMALLINT NOT NULL,
    vDescCodigoParametro VARCHAR(100) NOT NULL,
    bActivo BOOLEAN NOT NULL,
    vUsuarioIngreso VARCHAR(30) NOT NULL,
    sFechaIngreso TIMESTAMP NOT NULL,
    sFechaActualiza TIMESTAMP,
    vUsuarioActualiza VARCHAR(30),
    vEstacionIngresa VARCHAR(50) NOT NULL,
    vEstacionActualiza VARCHAR(50),
    CONSTRAINT PK_tblParametrosGenerales PRIMARY KEY (siGrupoParametro, siCodigoParametro)
);

-- Tabla: OdontblParametrosGeneralesCab
CREATE TABLE OdontblParametrosGeneralesCab (
    siGrupoParametro SERIAL NOT NULL,
    vDescGrupoParametro VARCHAR(100),
    bVisualizaUsuario BOOLEAN NOT NULL,
    bActivo BOOLEAN NOT NULL,
    vUsuarioIngreso VARCHAR(30) NOT NULL,
    sFechaIngreso TIMESTAMP NOT NULL,
    sFechaActualiza TIMESTAMP,
    vUsuarioActualiza VARCHAR(30),
    vEstacionIngresa VARCHAR(50) NOT NULL,
    vEstacionActualiza VARCHAR(50),
    CONSTRAINT PK_tblParametrosGeneralesCab PRIMARY KEY (siGrupoParametro)
);

-- Tabla: ODONtblPaciente
CREATE TABLE ODONtblPaciente (
    iIdPaciente BIGSERIAL NOT NULL,
    vApellido VARCHAR(100) NOT NULL,
    vapellidoSecundario VARCHAR(100),
    vApellidoOtros VARCHAR(100),
    vNombre VARCHAR(100),
    vDireccion VARCHAR(300),
    vTelefonoCasa VARCHAR(100),
    vTelefonoTrabajo VARCHAR(100),
    vCelular VARCHAR(50),
    vFax VARCHAR(50),
    dFechaNacimiento TIMESTAMP,
    dFechaIngreso TIMESTAMP,
    vDireccionFoto VARCHAR(200),
    vRecomendado VARCHAR(200),
    dFechaActuializacion TIMESTAMP,
    vEstadiCivil VARCHAR(50),
    vOcupacion VARCHAR(200),
    vEmail VARCHAR(100),
    cEstado CHAR(1),
    sEdad SMALLINT,
    Csexo CHAR(1),
    SPais SMALLINT,
    sCiudad SMALLINT,
    vTrabajo VARCHAR(150),
    vDireccionTrabajo VARCHAR(200),
    sCiudadTrabajo SMALLINT,
    sNacionalidad SMALLINT,
    vCI VARCHAR(10),
    CONSTRAINT PK_ODONtblPaciente PRIMARY KEY (iIdPaciente)
);

-- Tabla: ODONtblGuia
CREATE TABLE ODONtblGuia (
    idGuia SERIAL NOT NULL,
    vUsuario VARCHAR(20),
    vApellido VARCHAR(100),
    vNombre VARCHAR(100),
    vDireccion VARCHAR(100),
    vTelefono VARCHAR(100),
    vCiudad VARCHAR(100),
    vEmpresa VARCHAR(100),
    vDirEmpresa VARCHAR(100),
    vTelEmpresa VARCHAR(100),
    vEmail VARCHAR(100),
    dFechaIngreso TIMESTAMP
);

-- Tabla: ODOntblFacturaFormaPago
CREATE TABLE ODOntblFacturaFormaPago (
    iIdFormapago SERIAL NOT NULL,
    iIdFactura INTEGER,
    sIdFormaPago SMALLINT,
    sidBanco SMALLINT,
    vReferencia VARCHAR(100),
    dValor NUMERIC(9, 2),
    dFechaPago TIMESTAMP,
    dDescuento NUMERIC(9, 2),
    CONSTRAINT PK_ODOntblFacturaFormaPago PRIMARY KEY (iIdFormapago)
);

CREATE INDEX IX_ODOntblFacturaFormaPago ON ODOntblFacturaFormaPago(iIdFactura);

-- Tabla: ODOntblFacturaDetalle
CREATE TABLE ODOntblFacturaDetalle (
    iIdDetalleFactura SERIAL NOT NULL,
    iIdFactura INTEGER,
    iIdDetalle INTEGER,
    iIdEspecialidad INTEGER,
    siTratamiento SMALLINT,
    iIdTratamientoDetalle INTEGER,
    dValor NUMERIC(9, 2)
);

CREATE INDEX IX_ODOntblFacturaDetalle ON ODOntblFacturaDetalle(
    iIdFactura, iIdDetalle, iIdEspecialidad, siTratamiento, iIdTratamientoDetalle
);

-- Tabla: ODOntblfactura
CREATE TABLE ODOntblfactura (
    iIdFactura SERIAL NOT NULL,
    iIdPaciente INTEGER,
    dFechaFactura TIMESTAMP,
    vUsuario VARCHAR(20),
    Impresa BOOLEAN,
    CONSTRAINT PK_ODOntblfactura PRIMARY KEY (iIdFactura)
);

CREATE INDEX IX_ODOntblfactura ON ODOntblfactura(iIdFactura, iIdPaciente);

-- Tabla: ODONtblDoctor
CREATE TABLE ODONtblDoctor (
    iIdDoctor SERIAL NOT NULL,
    vNombre VARCHAR(50) NOT NULL,
    vApellido VARCHAR(50) NOT NULL,
    iIdCargo INTEGER NOT NULL,
    bTemporal BOOLEAN NOT NULL,
    cEstado CHAR(1) NOT NULL,
    CONSTRAINT PK_ODONtblDoctor PRIMARY KEY (iIdDoctor)
);

-- Tabla: ODOntblDetalleTratamientoPaciente
CREATE TABLE ODOntblDetalleTratamientoPaciente (
    iIdDetalle SERIAL NOT NULL,
    idpaciente INTEGER,
    iIdEspecialidad INTEGER,
    siTratamiento SMALLINT,
    iIdTratamientoDetalle INTEGER,
    dValor NUMERIC(9, 2),
    cEstado CHAR(1),
    iIdDoctor INTEGER,
    idConsultorio INTEGER,
    vObservacion VARCHAR(150),
    dFecha TIMESTAMP,
    vUsuario VARCHAR(20),
    cEstadoTratamiento CHAR(1),
    vPieza VARCHAR(20),
    vDatoPieza VARCHAR(250),
    iIdDetalleDescuento INTEGER,
    vObservacion1 VARCHAR(150) NOT NULL,
    CONSTRAINT PK_ODOntblDetalleTratamientoPaciente PRIMARY KEY (iIdDetalle)
);

CREATE INDEX IX_ODOntblDetalleTratamientoPaciente ON ODOntblDetalleTratamientoPaciente(
    iIdDetalle, idpaciente, iIdEspecialidad, siTratamiento, iIdTratamientoDetalle, cEstado
);

-- Tabla: ODOntblDetalleRecetaPaciente
CREATE TABLE ODOntblDetalleRecetaPaciente (
    iIdReceta INTEGER NOT NULL,
    CodFarmaco VARCHAR(10) NOT NULL,
    CodPActivo VARCHAR(15) NOT NULL,
    CodNComercial VARCHAR(15) NOT NULL,
    Cantidad SMALLINT NOT NULL,
    Descripcion VARCHAR(150) NOT NULL,
    Posologia VARCHAR(2024),
    vUsuario VARCHAR(20),
    CONSTRAINT PK_ODOntblDetalleRecetaPaciente PRIMARY KEY (iIdReceta, CodFarmaco, CodPActivo, CodNComercial)
);

-- Tabla: ODOntblCiudadesPais
CREATE TABLE ODOntblCiudadesPais (
    iIdPais INTEGER NOT NULL,
    sCiudad SMALLINT NOT NULL,
    vDescCiudad VARCHAR(100) NOT NULL,
    bActivo BOOLEAN NOT NULL,
    CONSTRAINT PK_ODOntblCiudadesPais PRIMARY KEY (iIdPais, sCiudad)
);


-- Tabla: ODONTblBodegaResponsable
CREATE TABLE ODONTblBodegaResponsable (
    idBodega SMALLINT,
    vUsuario VARCHAR(30)
);

-- Tabla: fe_doc_send
CREATE TABLE fe_doc_send (
    iiddocument SERIAL NOT NULL,
    taxidemisor VARCHAR(13) NOT NULL,
    tipo_doc VARCHAR(2) NOT NULL,
    Talonario INTEGER,
    NumFactura INTEGER,
    documentno VARCHAR(30) NOT NULL,
    tosend CHAR(1) NOT NULL,
    fecha_emision TIMESTAMP,
    taxidreceptor VARCHAR(20),
    CONSTRAINT PK_fe_doc_send PRIMARY KEY (iiddocument)
);

-- Tabla: fe_doc_data
CREATE TABLE fe_doc_data (
    iiddocument INTEGER NOT NULL,
    trama_doc TEXT NOT NULL,
    num_doc TEXT,
    tipo_doc VARCHAR(2),
    cod_estab VARCHAR(3),
    pto_emi VARCHAR(3),
    tipo_envio VARCHAR(1),
    taxidreceptor VARCHAR(20),
    fecha_emision TIMESTAMP,
    taxidemisor VARCHAR(13)
);

-- Tabla: FacturasRuc
CREATE TABLE FacturasRuc (
    idRuc VARCHAR(13),
    RazonSocial VARCHAR(150),
    Establecimiento VARCHAR(3),
    PuntoEmision VARCHAR(3),
    Secuencial INTEGER
);

-- Tabla: FacTurasNumeracion
CREATE TABLE FacTurasNumeracion (
    Talonario INTEGER NOT NULL,
    idRuc VARCHAR(13),
    NumInicial INTEGER,
    NumFinal INTEGER,
    NumActual INTEGER,
    Estado BOOLEAN
);

-- Tabla: FacTurasImpresasDetalle
CREATE TABLE FacTurasImpresasDetalle (
    Talonario INTEGER,
    NumFactura INTEGER,
    NumFacturaRef INTEGER,
    DatoAdicional VARCHAR(150)
);

-- Tabla: FacTurasImpresas
CREATE TABLE FacTurasImpresas (
    Talonario INTEGER,
    NumFactura INTEGER,
    Identificacion VARCHAR(13),
    Estado BOOLEAN,
    Fecha TIMESTAMP
);

-- Tabla: FacTblTarjetas
CREATE TABLE FacTblTarjetas (
    iIdTransaccion SERIAL NOT NULL,
    iIdPaciente INTEGER,
    sidBanco SMALLINT,
    vReferencia VARCHAR(100),
    dValor NUMERIC(18, 2),
    dDescuento NUMERIC(18, 2),
    dDisponible NUMERIC(18, 2),
    dFechaIngreso TIMESTAMP,
    dFechaActualiza TIMESTAMP,
    vUsuario VARCHAR(20),
    Estado BOOLEAN,
    Tipo CHAR(1),
    DFECHACH TIMESTAMP,
    EstadoR CHAR(1) NOT NULL
);

-- Tabla: FacTblCuenta
CREATE TABLE FacTblCuenta (
    iIdTransaccion SERIAL NOT NULL,
    iIdPaciente INTEGER,
    dfecha TIMESTAMP,
    dCantidad NUMERIC(8, 2),
    dSaldo NUMERIC(8, 2),
    cMovimiento CHAR(1),
    vUsuario VARCHAR(20)
);

CREATE INDEX IX_FacTblCuenta ON FacTblCuenta(iIdPaciente);

-- Tabla: FacTblChequesPosfechados
CREATE TABLE FacTblChequesPosfechados (
    iIdCheque SERIAL NOT NULL,
    iIdPaciente INTEGER,
    sBanco SMALLINT,
    sNumCheque INTEGER,
    dfecha TIMESTAMP,
    dCantidad NUMERIC(8, 2),
    cEstado CHAR(1),
    vUsuario VARCHAR(20)
);

-- Tabla: ActivosArchivo
CREATE TABLE ActivosArchivo (
    num_activo DOUBLE PRECISION,
    DESCRIPCION VARCHAR(255),
    DESCRIPCION_EXTENDIDA VARCHAR(255),
    MARCA VARCHAR(255),
    MODELO VARCHAR(255),
    num_serie VARCHAR(255),
    FAMILIA VARCHAR(255),
    COD_CDA VARCHAR(255),
    FACTURA VARCHAR(255),
    PROVEEDOR VARCHAR(255),
    fecha_adq VARCHAR(255),
    valor_adq VARCHAR(255),
    fecha_gt VARCHAR(255),
    UB VARCHAR(255),
    RESPONSABLE VARCHAR(255),
    EST VARCHAR(255)
);

-- Tabla: ACTblActivoFijoMovimientos
CREATE TABLE ACTblActivoFijoMovimientos (
    iIdActivo BIGINT,
    sUbicacion SMALLINT,
    vResponsable VARCHAR(20),
    dFechaMovimiento TIMESTAMP,
    sNuevaUbicacion SMALLINT,
    vNuevoResponsable VARCHAR(20),
    vusuario VARCHAR(20),
    vusuarioAut VARCHAR(30)
);

-- Tabla: ACTblActivoFijo
CREATE TABLE ACTblActivoFijo (
    iIdActivo BIGSERIAL NOT NULL,
    sDescripcion SMALLINT,
    vDescripcionExtendida VARCHAR(150),
    sMarca VARCHAR(50),
    sModelo SMALLINT,
    vNumerodeSerie VARCHAR(50),
    sFamilia SMALLINT,
    vFactura VARCHAR(50),
    sProveedor SMALLINT,
    dFechaAdquisicion TIMESTAMP,
    dValorAdquisicion NUMERIC(9, 2),
    sClase SMALLINT,
    sUso SMALLINT,
    sEstadoFisico SMALLINT,
    sUbicacion SMALLINT,
    vResponsable VARCHAR(20),
    bTieneGarantia BOOLEAN,
    dFechaDesdeG TIMESTAMP,
    dFechaHastaG TIMESTAMP,
    bEgresado BOOLEAN,
    vUsuarioAut VARCHAR(30),
    vMotivoEgreso CHAR(1),
    sCondicion SMALLINT,
    dFechaEgreso TIMESTAMP
);

-- Tabla: InvConsumoProductosConteo
CREATE TABLE InvConsumoProductosConteo (
    iIdConsultorio INTEGER,
    CodReferencia INTEGER,
    iidproducto INTEGER,
    Cantidad INTEGER,
    CantidadUsada INTEGER
);

-- Tabla: invConsultorioBodega
CREATE TABLE invConsultorioBodega (
    idConsultorio INTEGER,
    idBodega INTEGER
);

-- Tabla: invproduct
CREATE TABLE invproduct (
    CodigoNOM VARCHAR(255),
    u_de_ent VARCHAR(255),
    CANT DOUBLE PRECISION,
    idcodigo INTEGER
);

-- Tabla: INVKitProducto
CREATE TABLE INVKitProducto (
    iIdproductoKit INTEGER,
    iIdproducto INTEGER
);

-- Tabla: InvtblUnidadesConversion
CREATE TABLE InvtblUnidadesConversion (
    siUnidadCompra SMALLINT NOT NULL,
    siUnidadConsumo SMALLINT NOT NULL,
    dCantidad NUMERIC(8, 2) NOT NULL,
    CONSTRAINT PK_InvtblUnidadesConversion PRIMARY KEY (siUnidadCompra, siUnidadConsumo)
);


-- Tabla: InvtblSubClacificacion
CREATE TABLE InvtblSubClacificacion (
    siClasificacion SMALLINT NOT NULL,
    siSubClasificacion SMALLINT NOT NULL,
    vCodigo VARCHAR(6),
    vDescSubClasificacion VARCHAR(100) NOT NULL,
    bActivo BOOLEAN NOT NULL,
    CONSTRAINT PK_InvtblSubClacificacion PRIMARY KEY (siClasificacion, siSubClasificacion)
);

-- Tabla: INVTBLStockBodega
CREATE TABLE INVTBLStockBodega (
    iIdEmpresa INTEGER NOT NULL,
    iIdBodega INTEGER NOT NULL,
    iIdproducto INTEGER NOT NULL,
    dCantidad NUMERIC(18, 4) NOT NULL,
    CONSTRAINT PK_TBLStockBodega PRIMARY KEY (iIdEmpresa, iIdBodega, iIdproducto)
);

-- Tabla: INVTBLRequisicionD
CREATE TABLE INVTBLRequisicionD (
    iIdBodega INTEGER,
    iIdTipoMov SMALLINT,
    iIdMovimiento BIGINT,
    iIdproducto INTEGER,
    dCantidad NUMERIC(18, 4),
    iIdBodegaSolicita INTEGER,
    dCantidadAprobada NUMERIC(18, 4),
    StockActual NUMERIC(18, 2)
);

-- Tabla: INVTBLRequisicionC
CREATE TABLE INVTBLRequisicionC (
    iIdBodega INTEGER,
    iIdTipoMov SMALLINT,
    iIdMovimiento BIGINT,
    dFechaIngreso TIMESTAMP,
    vUsuario VARCHAR(50),
    cEstado CHAR(1),
    iIdBodegaSolicita INTEGER,
    dFechaAprobada TIMESTAMP,
    sUsuarioAprueba VARCHAR(20),
    dFechaEntrega TIMESTAMP,
    sUsuarioEntrega VARCHAR(20)
);

-- Tabla: INVtblProveedor
CREATE TABLE INVtblProveedor (
    iIdProveedor SERIAL NOT NULL,
    vNombre VARCHAR(80) NOT NULL,
    vRuc VARCHAR(20),
    vDireccion VARCHAR(150),
    vtelefono VARCHAR(50),
    vFax VARCHAR(50),
    sTipo INTEGER,
    CONSTRAINT PK_tblProveedor PRIMARY KEY (iIdProveedor)
);

-- Tabla: InvtblProducto
CREATE TABLE InvtblProducto (
    siClasificacion SMALLINT NOT NULL,
    siSubClasificacion SMALLINT NOT NULL,
    iIdProducto SERIAL NOT NULL,
    vCodigo VARCHAR(12),
    iNombre INTEGER NOT NULL,
    iCaracteristica INTEGER,
    iMarca INTEGER,
    vModelo VARCHAR(100),
    siUnidadCompra SMALLINT NOT NULL,
    siUnidadConsumo SMALLINT NOT NULL,
    dStock NUMERIC(5, 2),
    dCantidadMinima NUMERIC(5, 2) NOT NULL,
    dFechacreacion TIMESTAMP,
    dFechaUltimoMovimiento TIMESTAMP,
    bEstado BOOLEAN NOT NULL,
    bEsdeConteo BOOLEAN,
    CONSTRAINT PK_InvtblProducto PRIMARY KEY (siClasificacion, siSubClasificacion, iIdProducto)
);

-- Tabla: INVTBLordenD
CREATE TABLE INVTBLordenD (
    iIdBodegaSolicita INTEGER,
    iIdMovimiento BIGINT,
    iIdproducto INTEGER,
    dCantidad NUMERIC(18, 4),
    dCantidadAprobada NUMERIC(18, 4),
    iIdProveedor INTEGER,
    dValorUnitario NUMERIC(18, 4),
    cEstado CHAR(1),
    bEstado BOOLEAN,
    StockActual NUMERIC(18, 2),
    NumFactura VARCHAR(20)
);

-- Tabla: INVTBLOrdenC
CREATE TABLE INVTBLOrdenC (
    iIdBodegaSolicita INTEGER,
    iIdMovimiento BIGINT,
    dFechaIngreso TIMESTAMP,
    vUsuario VARCHAR(50),
    cEstado CHAR(1),
    dFechaCotiza TIMESTAMP,
    sUsuarioCotiza VARCHAR(20),
    dFechaAprobada TIMESTAMP,
    sUsuarioAprueba VARCHAR(20),
    dFechaEntrega TIMESTAMP,
    sUsuarioEntrega VARCHAR(20)
);

-- Tabla: INVTBLMovimientosM
CREATE TABLE INVTBLMovimientosM (
    iIdMovimiento BIGINT NOT NULL,
    iIdEmpresa INTEGER NOT NULL,
    iIdBodega INTEGER NOT NULL,
    iIdTipoMov INTEGER NOT NULL,
    iEjercicio SMALLINT NOT NULL,
    iPeriodo SMALLINT NOT NULL,
    dFechaMov TIMESTAMP NOT NULL,
    iIdProveedor INTEGER,
    iIdEspecialidad SMALLINT,
    iIdTratamiento SMALLINT,
    iIdDetalleTratamiento SMALLINT,
    vDocumentoReferencia VARCHAR(50),
    iIdBodegaDestino INTEGER,
    vUsuario VARCHAR(20) NOT NULL,
    Observaciones VARCHAR(150)
);

-- Tabla: INVTBLMovimientosD
CREATE TABLE INVTBLMovimientosD (
    iIdBodega INTEGER NOT NULL,
    iIdTipoMov INTEGER NOT NULL,
    iIdMovimiento BIGINT NOT NULL,
    iLinea INTEGER NOT NULL,
    iIdproducto INTEGER NOT NULL,
    dCantidad NUMERIC(18, 4) NOT NULL,
    dCosto NUMERIC(18, 4),
    FCaducidad TIMESTAMP,
    sCosteado SMALLINT,
    sContabilizado SMALLINT
);

-- Tabla: INVTBLEgresoConsumo
CREATE TABLE INVTBLEgresoConsumo (
    iiddetalle BIGINT,
    iidConsultorio INTEGER,
    iIdproducto INTEGER NOT NULL,
    dCantidad NUMERIC(18, 2) NOT NULL
);

-- Tabla: InvtblClacificacion
CREATE TABLE InvtblClacificacion (
    siClasificacion SERIAL NOT NULL,
    vCodigo VARCHAR(2),
    vDescClasificacion VARCHAR(100),
    bActivo BOOLEAN NOT NULL,
    CONSTRAINT PK_InvtblClacificacion PRIMARY KEY (siClasificacion)
);
