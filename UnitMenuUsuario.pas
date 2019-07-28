unit UnitMenuUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, URLMON, ShellApi;

type
  TFormMenuUsuario = class(TForm)
    btGerarCurriculo: TButton;
    Panel1: TPanel;
    imageUserProfile: TImage;
    lblUsuarioNome: TLabel;
    GroupBox1: TGroupBox;
    lblCPF: TLabel;
    lblRG: TLabel;
    lblNascimento: TLabel;
    lblEditarUsuario: TLabel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    GroupBox3: TGroupBox;
    lblCadExperienciaProfissional: TLabel;
    lblCadFormacaoAcademica: TLabel;
    Label2: TLabel;
    memoAtividadesComplementares: TMemo;
    edObjetivos: TEdit;
    Label3: TLabel;
    edInformacoesAdicionais: TEdit;
    procedure FormShow(Sender: TObject);
    procedure lblCadFormacaoAcademicaClick(Sender: TObject);
    procedure btGerarCurriculoClick(Sender: TObject);

    procedure lblCadExperienciaProfissionalClick(Sender: TObject);
    procedure lblEditarUsuarioClick(Sender: TObject);
  private
    procedure PegarUsuarioInfo();
    procedure PegarIDCurriculo();
    procedure AtualizarDadosCurriculo();
    procedure PegarDadosInseridosCurriculo();
    procedure GerarHTML();
  public
    id_pessoa: Integer;
  end;

var
  id_curriculo: Integer;
  FormMenuUsuario: TFormMenuUsuario;

implementation

{$R *.dfm}

uses UnitCadFormacaoAcademica, UDataModule, UnitCadExperienciaProfissional,
  UnitCadPessoa, UnitBrowser;

procedure TFormMenuUsuario.FormShow(Sender: TObject);
begin
  PegarUsuarioInfo();
  PegarIDCurriculo();
  PegarDadosInseridosCurriculo();
end;

procedure TFormMenuUsuario.lblCadExperienciaProfissionalClick(Sender: TObject);
var
  curriculo: Integer;
begin
  curriculo := id_curriculo;
  With FormCadExperienciaProfissional do
  begin
    id_curriculo := curriculo;
    ShowModal;
  end;
end;

procedure TFormMenuUsuario.lblCadFormacaoAcademicaClick(Sender: TObject);
var
  curriculo: Integer;
begin
  curriculo := id_curriculo;
  With FormCadFormacaoAcademica do
  begin
    id_curriculo := curriculo;
    ShowModal;
  end;
end;

procedure TFormMenuUsuario.lblEditarUsuarioClick(Sender: TObject);
var
  curriculo: Integer;
begin
  curriculo := id_curriculo;
  with FormCadPessoa do
  begin
    editando := true;
    id_curriculo := curriculo;
    ShowModal;
  end;
end;

procedure TFormMenuUsuario.btGerarCurriculoClick(Sender: TObject);
begin
  AtualizarDadosCurriculo();
  GerarHTML();
end;

procedure TFormMenuUsuario.PegarUsuarioInfo();
var
  foto_perfil: String;
begin
  with DM.FDQueryTemp do
  begin
    Close();
    SQL.Clear();
    SQL.Add('SELECT * FROM pessoa where id_pessoa = :pIdPessoa');
    ParamByName('pIdPessoa').AsInteger := id_pessoa;
    Open();
    lblUsuarioNome.Caption := FieldByName('nome').AsString;
    lblCPF.Caption := 'CPF: ' + FieldByName('cpf').AsString;
    lblRG.Caption := 'RG: ' + FieldByName('rg').AsString;
    lblNascimento.Caption := 'Data de Nascimento: ' +
      DateToStr(FieldByName('nascimento').AsDateTime);
    foto_perfil := FieldByName('foto_perfil').AsString;
    if foto_perfil <> '' then
      imageUserProfile.Picture.LoadFromFile(foto_perfil);
    Close();
  end;
end;

procedure TFormMenuUsuario.PegarIDCurriculo();
begin
  with DM.FDQueryTemp do
  begin
    SQL.Clear;
    SQL.Add('select id_curriculo from curriculo where id_pessoa = :pId_pessoa');
    ParamByName('pId_pessoa').AsInteger := id_pessoa;
    Open;
    id_curriculo := FieldByName('id_curriculo').AsInteger;
    Close;
  end;
end;

procedure TFormMenuUsuario.AtualizarDadosCurriculo();
begin
  with DM.FDQueryTemp do
  begin
    SQL.Clear;
    SQL.Add('update curriculo set objetivo = :pObjetivo, atividades_complementares = :pAtividades_complementares, informacoes_adicionais = :pInformacoes_adicionais where id_curriculo = :pId_curriculo');
    ParamByName('pId_curriculo').AsInteger := id_curriculo;
    ParamByName('pObjetivo').AsString := edObjetivos.Text;
    ParamByName('pInformacoes_adicionais').AsString :=
      edInformacoesAdicionais.Text;
    ParamByName('pAtividades_complementares').AsString :=
      memoAtividadesComplementares.Text;
    ExecSQL();
    DM.FDConnection1.Commit();
    Close;
  end;
end;

procedure TFormMenuUsuario.PegarDadosInseridosCurriculo();
begin
  with DM.FDQueryTemp do
  begin
    SQL.Clear;
    SQL.Add('select * from curriculo where id_curriculo = :pId_curriculo');
    ParamByName('pId_curriculo').AsInteger := id_curriculo;
    Open();
    edObjetivos.Text := FieldByName('objetivo').AsString;
    edInformacoesAdicionais.Text :=
      FieldByName('informacoes_adicionais').AsString;
    memoAtividadesComplementares.Text :=
      FieldByName('atividades_complementares').AsString;
    Close;
  end;
end;

procedure TFormMenuUsuario.GerarHTML;
var
  newFile: TextFile;
  html: String;

  foto_perfil, nome, cpf, rg, nacionalidade, estado_civil, rua, numero, bairro,
    cidade, uf_estado, estado, email, telefone, celular, objetivo,
    informacoes_adicionais, atividades_complementares: String;
  sexo, id_informacoes_pessoais, id_endereco, id_cidade, num_formacoes, i,
    min_num_formacoes, num_experiencias, min_num_experiencias: Integer;
  data_nascimento: TDate;
begin

  with DM.FDQueryTemp do
  begin
    Close();
    SQL.Clear();
    SQL.Add('SELECT * FROM pessoa where id_pessoa = :pIdPessoa');
    ParamByName('pIdPessoa').AsInteger := id_pessoa;
    Open();
    foto_perfil := FieldByName('foto_perfil').AsString;
    nome := FieldByName('nome').AsString;
    cpf := FieldByName('cpf').AsString;
    rg := FieldByName('rg').AsString;
    sexo := FieldByName('sexo').AsInteger;
    data_nascimento := FieldByName('nascimento').AsDateTime;
    nacionalidade := FieldByName('nacionalidade').AsString;
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    SQL.Clear();
    SQL.Add('SELECT * FROM curriculo where id_curriculo = :pId_curriculo');
    ParamByName('pId_curriculo').AsInteger := id_curriculo;
    Open();
    id_informacoes_pessoais := FieldByName('id_informacoes_pessoais').AsInteger;
    atividades_complementares :=
      FieldByName('atividades_complementares').AsString;
    informacoes_adicionais := FieldByName('informacoes_adicionais').AsString;
    objetivo := FieldByName('objetivo').AsString;
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    SQL.Clear();
    SQL.Add('SELECT * FROM informacoes_pessoais where id_informacoes_pessoais = :pId_informacoes_pessoais');
    ParamByName('pId_informacoes_pessoais').AsInteger :=
      id_informacoes_pessoais;
    Open();
    estado_civil := FieldByName('estado_civil').AsString;
    id_endereco := FieldByName('id_endereco').AsInteger;
    email := FieldByName('email').AsString;
    telefone := FieldByName('telefone').AsString;
    celular := FieldByName('celular').AsString;
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    SQL.Clear();
    SQL.Add('SELECT * FROM endereco where id_endereco = :pId_endereco');
    ParamByName('pId_endereco').AsInteger := id_endereco;
    Open();
    rua := FieldByName('rua').AsString;
    numero := FieldByName('numero').AsString;
    bairro := FieldByName('bairro').AsString;
    id_cidade := FieldByName('id_cidade').AsInteger;
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    SQL.Clear();
    SQL.Add('SELECT * FROM cidade where id_cidade = :pId_cidade');
    ParamByName('pId_cidade').AsInteger := id_cidade;
    Open();
    cidade := FieldByName('nome').AsString;
    uf_estado := FieldByName('UF').AsString;
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    SQL.Clear();
    SQL.Add('SELECT * FROM estado where uf = :pUf_estado');
    ParamByName('pUf_estado').AsString := uf_estado;
    Open();
    estado := FieldByName('nome').AsString;
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    SQL.Clear();
    SQL.Add('SELECT count(ID_FORMACAO_ACADEMICA) FROM GERAR_FORMACAO_ACADEMICA where ID_CURRICULO = :pId_curriculo');
    ParamByName('pId_curriculo').AsInteger := id_curriculo;
    Open();
    num_formacoes := Fields[0].AsInteger;
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    SQL.Clear();
    SQL.Add('select min(id_formacao_academica) from gerar_formacao_academica where id_curriculo = :pId_curriculo');
    ParamByName('pId_curriculo').AsInteger := id_curriculo;
    Open();
    min_num_formacoes := Fields[0].AsInteger;
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    SQL.Clear();
    SQL.Add('SELECT count(id_experiencia_profissional) FROM GERAR_exp_profissional where ID_CURRICULO = :pId_curriculo');
    ParamByName('pId_curriculo').AsInteger := id_curriculo;
    Open();
    num_experiencias := Fields[0].AsInteger;
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    SQL.Clear();
    SQL.Add('select min(id_experiencia_profissional) from GERAR_exp_profissional where id_curriculo = :pId_curriculo');
    ParamByName('pId_curriculo').AsInteger := id_curriculo;
    Open();
    min_num_experiencias := Fields[0].AsInteger;
    Close();
  end;

  System.AssignFile(newFile, 'curriculo.html');
  System.Rewrite(newFile);

  html := '<html> <head> <style> body { font-family: Arial, Helvetica, sans-serif; } p { font-weight: bold; margin: 10px; } span { font-weight: normal; } .right_column { position: relative; float: right; width: 40%; } .left_column { position: relative; float: left;';
  html := html +
    ' width: 60%; } img { float: left; margin: 8px 15px 8px 10px; height: 100px; width: 100px; } .bloco { margin-bottom: 25px; overflow: hidden; } </style> </head> <body> <center> <h3>CURRÍCULO</h3> </center> <div class="bloco"> <p>INFORMAÇÕES PESSOAIS</p> ';
  html := html + '<hr> <div class="left_column"> ';

  WriteLn(newFile, html);
  if foto_perfil <> '' then
    WriteLn(newFile, '<img src="file:///' + foto_perfil + '" />');
  WriteLn(newFile, '<p>NOME: <span>' + nome);
  WriteLn(newFile, '</span> </p> <p>CPF: <span>' + cpf);
  WriteLn(newFile, '</span> </p> <p>RG: <span>' + rg + '</span> </p>');
  if sexo <> -1 then
  begin
    if sexo = 0 then
      WriteLn(newFile, '<p>SEXO: <span>Masculino</span> </p>')
    else if sexo = 1 then
      Write'Ln(newFile, '<p>SEXO: <span>Feminino</span> </p>');
  end;
  WriteLn(newFile, '<p>DATA DE NASCIMENTO: <span>' + DateToStr(data_nascimento)
    + '</span> </p>');
  if nacionalidade <> '' then
    WriteLn(newFile, '<p>NACIONALIDADE: <span>' + nacionalidade +
      '</span> </p> ');
  if estado_civil <> '' then
    WriteLn(newFile, '<p>ESTADO CIVIL: <span>' + estado_civil +
      '</span> </p> ');
  WriteLn(newFile, '</div> <div class="right_column"> ');
  if (rua <> '') and (numero <> '') then
    WriteLn(newFile, '<p>ENDEREÇO: <span>' + rua + ', Nº ' + numero +
      '</span> </p> ');
  if bairro <> '' then
    WriteLn(newFile, '<p>BAIRRO: <span>' + bairro + '</span> </p> ');
  if (cidade <> '') and (estado <> '') then
    WriteLn(newFile, '<p>CIDADE: <span>' + cidade +
      '</span> </p> <p>ESTADO: <span>' + estado + '</span> ');
  if email <> '' then
    WriteLn(newFile, '</p> <p>E-MAIL: <span>' + email + '</span> </p>');
  if telefone <> '' then
    WriteLn(newFile, '<p>TELEFONE: <span>' + telefone + '</span> </p> ');
  if celular <> '' then
    WriteLn(newFile, '<p>CELULAR: <span>' + celular + '</span> </p> ');
  WriteLn(newFile, '</div> </div>');

  //tenho erros aqui

  if num_formacoes > 0 then
  begin
    WriteLn(newFile, '<div class="bloco"> <p>FORMAÇÃO ACADÊMICA</p> <hr>');

    for i := 0 to num_formacoes - 1 do
    begin
      with DM.FDQueryTemp do
      begin
        Close();
        SQL.Clear();
        SQL.Add('SELECT * FROM FORMACAO_ACADEMICA where id_formacao_academica = :pId_formacao_academica');
        ParamByName('pId_formacao_academica').AsInteger :=
          min_num_formacoes + i;
        Open();
        WriteLn(newFile, '<div class="left_column">');
        WriteLn(newFile, '<p>INSTITUIÇÃO: <span>' + FieldByName('instituicao')
          .AsString + '</span> </p>');
        WriteLn(newFile, '<p>CURSO: <span>' + FieldByName('curso').AsString +
          '</span> </p>');
        WriteLn(newFile, ' </div>');
        WriteLn(newFile, '<div class="right_column">');
        WriteLn(newFile, '<p>ANO DE INÍCIO: <span> ' + FieldByName('ano_inicio')
          .AsString + ' </span> </p>');
        if FieldByName('ano_termino').AsString <> '' then
          WriteLn(newFile, '<p>ANO DE TÉRMINO: <span>' +
            FieldByName('ano_termino').AsString + '</span> </p>');
        WriteLn(newFile, '</div>');

        Close();
      end;
    end;

    WriteLn(newFile, '</div>');
  end;

  //tenho erros aqui

  if num_experiencias > 0 then
  begin
    WriteLn(newFile,
      '<div class="bloco"> <p>EXPERIÊNCIA PROFISSIONAL</p> <hr>');

    for i := 0 to num_experiencias - 1 do
    begin
      with DM.FDQueryTemp do
      begin
        Close();
        SQL.Clear();
        SQL.Add('SELECT * FROM experiencia_profissional where id_experiencia_profissional = :pId_experiencia_profissional');
        ParamByName('pId_experiencia_profissional').AsInteger :=
          min_num_experiencias + i;
        Open();
        WriteLn(newFile, '<div class="left_column">');
        WriteLn(newFile, '<p>EMPRESA: <span>' + FieldByName('empresa').AsString
          + '</span> </p>');
        WriteLn(newFile, '<p>CARGO: <span>' + FieldByName('cargo').AsString +
          '</span> </p>');
        WriteLn(newFile, ' </div>');
        WriteLn(newFile, '<div class="right_column">');
        WriteLn(newFile, '<p>ANO DE INÍCIO: <span> ' + FieldByName('ano_inicio')
          .AsString + ' </span> </p>');
        if FieldByName('ano_termino').AsString <> '' then
          WriteLn(newFile, '<p>ANO DE TÉRMINO: <span>' +
            FieldByName('ano_termino').AsString + '</span> </p>');
        WriteLn(newFile, '</div>');

        Close();
      end;
    end;
    WriteLn(newFile, '</div>');
  end;

  if atividades_complementares <> '' then
    WriteLn(newFile,
      '<div class="bloco"> <p>EXPERIÊNCIAS COMPLEMENTARES</p> <hr> <p><span>' +
      atividades_complementares + '</span></p> </div>');

  if objetivo <> '' then
    WriteLn(newFile, '<div class="bloco"> <p>OBJETIVOS</p> <hr> <p><span>' +
      objetivo + '</span></p> </div>');

  if informacoes_adicionais <> '' then
    WriteLn(newFile,
      '<div class="bloco"> <p>INFORMAÇÕES ADICIONAIS</p> <hr> <p><span>' +
      informacoes_adicionais + '</span></p> </div>');

  WriteLn(newFile,
    ' <div> <p style="float: right; font-size: 14px; font-weight: normal">CurriculumGenerator - 2019</p> </div> <script> window.onload = function () { window.print(); } </script> </body></html>');

  System.CloseFile(newFile);

  ShellExecute(0, nil, PChar('curriculo.html'), nil, nil, SW_SHOWNORMAL);
end;

end.
