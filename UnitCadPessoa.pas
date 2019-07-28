unit UnitCadPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.ExtDlgs, FireDAC.Stan.Param;

type
  TFormCadPessoa = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edNome: TEdit;
    CPF: TLabel;
    edCPF: TMaskEdit;
    Label2: TLabel;
    edRG: TEdit;
    Sexo: TLabel;
    boxSexo: TComboBox;
    Label3: TLabel;
    edNascimento: TMaskEdit;
    Label4: TLabel;
    edNacionalidade: TEdit;
    imageUserProfile: TImage;
    btSelecionarImagem: TButton;
    Label5: TLabel;
    edEmail: TEdit;
    Telefone: TLabel;
    edTelefone: TEdit;
    edCelular: TEdit;
    Celular: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    boxEstadoCivil: TComboBox;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    boxEstado: TComboBox;
    boxCidade: TComboBox;
    Label9: TLabel;
    edBairro: TEdit;
    edRua: TEdit;
    Label10: TLabel;
    edNumero: TEdit;
    Label8: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    btOk: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure boxEstadoChange(Sender: TObject);
    procedure boxCidadeChange(Sender: TObject);
    procedure btSelecionarImagemClick(Sender: TObject);

  private
    procedure SalvarDados();
    procedure PreencherEstadoBox();
    procedure PreencherCidadeBox();
    procedure PegarCidadeID();
    procedure PegarEstadoUF();
    procedure AbrirMenuUsuario();
    procedure CriarCurriculo();
//    procedure AtualizarDadosPessoa();

  public
    id_curriculo: Integer;
    id_pessoa: Integer;
    editando: Boolean;
    procedure PegarDadosInseridosUsuario();
  end;

var
  estado_uf: String;
  id_cidade: Integer;
  id_endereco: Integer;
  id_informacoes_pessoais: Integer;

  FormCadPessoa: TFormCadPessoa;

implementation

{$R *.dfm}

uses UDataModule, UnitMenuUsuario, UnitMain;

procedure TFormCadPessoa.FormShow(Sender: TObject);
begin
  PreencherEstadoBox();

  if editando = true then
    PegarDadosInseridosUsuario;
end;

procedure TFormCadPessoa.btOkClick(Sender: TObject);
var
  camposNaoPreenchidos: Boolean;
begin
  camposNaoPreenchidos := (edNome.Text = '') or (edCPF.Text = '   .   .   -  ')
    or (edRG.Text = '') or (boxSexo.ItemIndex = -1) or
    (edNascimento.Text = '  /  /    ');
  if camposNaoPreenchidos then
    raise Exception.Create('Preencha todos os campos obrigatórios.');

  if editando <> true then
  begin
    SalvarDados();
    CriarCurriculo();
    AbrirMenuUsuario();
  end
  else
  begin
//    AtualizarDadosPessoa;
    Close;
  end;
end;

procedure TFormCadPessoa.btSelecionarImagemClick(Sender: TObject);
begin
  OpenPictureDialog1.Execute();
  imageUserProfile.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TFormCadPessoa.PreencherEstadoBox();
begin
  With DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('select * from estado;');
    Open();
    First();
    while not Eof do
    begin
      boxEstado.Items.Add(FieldByName('NOME').AsString);
      Next();
    end;
    Close();
  end;
end;

procedure TFormCadPessoa.boxEstadoChange(Sender: TObject);
begin
  PegarEstadoUF();

  boxCidade.Items.Clear;
  boxCidade.Clear;

  PreencherCidadeBox();
end;

procedure TFormCadPessoa.PegarEstadoUF();
begin
  with DM.FDQueryTemp do
  begin
    Sql.Clear();
    Sql.Add('select UF from ESTADO where NOME = :pEstadoNome');
    ParamByName('pEstadoNome').AsString := boxEstado.Items[boxEstado.ItemIndex];
    Open();
    estado_uf := FieldByName('UF').AsString;
    Close();
  end;
end;

procedure TFormCadPessoa.PreencherCidadeBox();
begin
  With DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('select * from cidade where UF = :pEstado;');
    ParamByName('pEstado').AsString := estado_uf;
    Open();
    First();
    while not Eof do
    begin
      boxCidade.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
    Close();
  end;
end;

procedure TFormCadPessoa.boxCidadeChange(Sender: TObject);
begin
  PegarCidadeID();
end;

procedure TFormCadPessoa.PegarCidadeID();
begin
  with DM.FDQueryTemp do
  begin
    Sql.Clear;
    Sql.Add('select ID_CIDADE from CIDADE inner join ESTADO using (UF) where CIDADE.NOME = :pCidadeNome and ESTADO.UF = :pEstadoUF');
    ParamByName('pCidadeNome').AsString := boxCidade.Items[boxCidade.ItemIndex];
    ParamByName('pEstadoUF').AsString := estado_uf;
    Open;
    id_cidade := FieldByName('ID_CIDADE').AsInteger;
    Close;
  end;
end;

// atualizar dados pessoa

procedure TFormCadPessoa.SalvarDados();
begin

  with DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('insert into endereco (bairro, rua, numero, id_cidade) values (:pBairro, :pRua, :pNumero, :pId_cidade);');
    ParamByName('pBairro').AsString := edBairro.Text;
    ParamByName('pRua').AsString := edRua.Text;
    ParamByName('pNumero').AsString := edNumero.Text;
    ParamByName('pId_cidade').AsInteger := id_cidade;
    ExecSQL();
    DM.FDConnection1.Commit();
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear();
    Sql.Add('SELECT max(id_endereco) FROM endereco');
    Open();
    id_endereco := Fields[0].AsInteger;
    Close();
  end;

  With DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('insert into informacoes_pessoais (estado_civil, email, telefone, celular, id_endereco) values (:pEstado_civil, :pEmail, :pTelefone, :pCelular, :pId_endereco)');
    ParamByName('pEstado_civil').AsString := boxEstadoCivil.Items
      [boxEstadoCivil.ItemIndex];
    ParamByName('pEmail').AsString := edEmail.Text;
    ParamByName('pTelefone').AsString := edTelefone.Text;
    ParamByName('pCelular').AsString := edCelular.Text;
    ParamByName('pId_endereco').AsInteger := id_endereco;
    ExecSQL();
    DM.FDConnection1.Commit();
    Close;
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear();
    Sql.Add('SELECT max(id_informacoes_pessoais) FROM informacoes_pessoais');
    Open();
    id_informacoes_pessoais := Fields[0].AsInteger;
    Close();
  end;

  With DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('insert into pessoa (nome, cpf, rg, sexo, nascimento, nacionalidade, foto_perfil) values (:pNome, :pCpf, :pRg, :pSexo, :pNascimento, :pNacionalidade, :pFotoPerfil);');
    ParamByName('pNome').AsString := edNome.Text;
    ParamByName('pCpf').AsString := edCPF.Text;
    ParamByName('pRg').AsString := edRG.Text;
    ParamByName('pSexo').AsInteger := boxSexo.ItemIndex;
    ParamByName('pNascimento').AsDateTime := StrToDate(edNascimento.Text);
    ParamByName('pNacionalidade').AsString := edNacionalidade.Text;
    ParamByName('pFotoPerfil').AsString := OpenPictureDialog1.FileName;
    ExecSQL();
    DM.FDConnection1.Commit();
    Close;
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear();
    Sql.Add('SELECT max(id_pessoa) FROM pessoa');
    Open();
    id_pessoa := Fields[0].AsInteger;
    Close();
  end;

end;

procedure TFormCadPessoa.CriarCurriculo();
begin
  with DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('insert into curriculo (id_pessoa, id_informacoes_pessoais) values (:pId_pessoa, :pId_informacoes_pessoais);');
    ParamByName('pId_pessoa').AsInteger := id_pessoa;
    ParamByName('pId_informacoes_pessoais').AsInteger :=
      id_informacoes_pessoais;
    ExecSQL();
    DM.FDConnection1.Commit();
    Close();
  end;
end;

procedure TFormCadPessoa.AbrirMenuUsuario();
var
  usuario: Integer;
begin
  usuario := id_pessoa;

  With FormMenuUsuario do
  begin
    id_pessoa := usuario;
    Show;
  end;
  FormMain.PreencherUsuariosBox();
  Self.Close;
end;
//
//procedure TFormCadPessoa.AtualizarDadosPessoa();
//var
//  id_informacoes_pessoais: Integer;
//begin
//
//  With DM.FDQueryTemp do
//  begin
//    Close();
//    Sql.Clear;
//    Sql.Add('update informacoes_pessoais set estado_civil = :pEstado_civil,');
//    Sql.Add('email = :pEmail, telefone = :pTelefone, celular = :pCelular');
//    Sql.Add('inner join curriculo using');
//    Sql.Add('(id_informacoes_pessoais) where curriculo.id_curriculo');
//    Sql.Add(' = :pid_curriculo');
//
//    ParamByName('pid_curriculo').AsInteger := id_curriculo;
//    ParamByName('pEstado_civil').AsString := boxEstadoCivil.Items
//      [boxEstadoCivil.ItemIndex];
//    ParamByName('pEmail').AsString := edEmail.Text;
//    ParamByName('pTelefone').AsString := edTelefone.Text;
//    ParamByName('pCelular').AsString := edCelular.Text;
//    ExecSQL();
//    DM.FDConnection1.Commit();
//    Close;
//  end;
//
//  with DM.FDQueryTemp do
//  begin
//    Close();
//    Sql.Clear();
//    Sql.Add('SELECT id_informacoes_pessoais FROM informacoes_pessoais inner join curriculo using (id_informacoes_pessoais) where curriculo.id_curriculo = :pid_curriculo');
//    ParamByName('pid_curriculo').AsInteger := id_curriculo;
//    Open();
//    id_informacoes_pessoais := Fields[0].AsInteger;
//    Close();
//  end;
//
//  with DM.FDQueryTemp do
//  begin
//    Close();
//    Sql.Clear;
//    Sql.Add('update endereco set bairro = :pBairro, rua = :pRua, numero = :pNumero, id_cidade = :pId_cidade inner join informacoes_pessoais using (id_endereco) where id_informacoes_pessoais = :pid_informacoes_pessoais');
//    ParamByName('id_informacoes_pessoais').AsInteger := id_informacoes_pessoais;
//    ParamByName('pBairro').AsString := edBairro.Text;
//    ParamByName('pRua').AsString := edRua.Text;
//    ParamByName('pNumero').AsString := edNumero.Text;
//    ParamByName('pId_cidade').AsInteger := id_cidade;
//    ExecSQL();
//    DM.FDConnection1.Commit();
//    Close();
//  end;
//
//  desisto, delphi é a pior linguagem do mundo, que porcaria de estrutura é essa
//
//  With DM.FDQueryTemp do
//  begin
//    Close();
//    Sql.Clear;
//    Sql.Add('update pessoa set nacionalidade = :pNacionalidade, foto_perfil = :pFotoPerfil ');
//    Sql.Add('inner join curriculo using (id_pessoa) where curriculo.id_curriculo = :pId_curriculo');
//    ParamByName('pId_curriculo').AsInteger := id_curriculo;
//    ParamByName('pNacionalidade').AsString := edNacionalidade.Text;
//    ParamByName('pFotoPerfil').AsString := OpenPictureDialog1.FileName;
//    ExecSQL();
//    DM.FDConnection1.Commit();
//    Close;
//  end;
//
//end;

procedure TFormCadPessoa.PegarDadosInseridosUsuario();
var
  id_pessoa, id_informacoes_pessoais, id_cidade: Integer;
  uf_estado, cidade_nome, estado_nome: String;
begin
  edNome.Enabled := false;
  edCPF.Enabled := false;
  edRG.Enabled := false;
  boxSexo.Enabled := false;
  edNascimento.Enabled := false;

  with DM.FDQueryTemp do
  begin
    Close;
    Sql.Clear;
    Sql.Add('select * from pessoa inner join curriculo using (id_pessoa) where curriculo.id_curriculo = :pId_curriculo');
    ParamByName('pId_curriculo').AsInteger := id_curriculo;
    Open();
    edNome.Text := FieldByName('nome').AsString;
    edCPF.Text := FieldByName('cpf').AsString;
    edRG.Text := FieldByName('rg').AsString;
    boxSexo.ItemIndex := FieldByName('sexo').AsInteger;
    edNascimento.Text := FieldByName('nascimento').AsString;
    edNacionalidade.Text := FieldByName('nacionalidade').AsString;
    Close;
  end;

  With DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('select * from informacoes_pessoais inner join curriculo using (id_informacoes_pessoais) where id_curriculo = :pId_curriculo');
    ParamByName('pId_curriculo').AsInteger := id_curriculo;
    Open();
    id_informacoes_pessoais := FieldByName('id_informacoes_pessoais').AsInteger;
    boxEstadoCivil.ItemIndex := boxEstadoCivil.Items.IndexOf
      (FieldByName('estado_civil').AsString);
    edEmail.Text := FieldByName('email').AsString;
    edTelefone.Text := FieldByName('telefone').AsString;
    edCelular.Text := FieldByName('celular').AsString;
    Close;
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('select * from endereco inner join informacoes_pessoais using (id_endereco) where informacoes_pessoais.id_informacoes_pessoais = :pId_informacoes_pessoais');
    ParamByName('pId_informacoes_pessoais').AsInteger :=
      id_informacoes_pessoais;
    Open();
    edBairro.Text := FieldByName('bairro').AsString;
    edRua.Text := FieldByName('rua').AsString;
    edNumero.Text := FieldByName('numero').AsString;
    id_cidade := FieldByName('id_cidade').AsInteger;
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('select * from cidade inner join endereco using (id_cidade) where endereco.id_cidade = :pId_cidade');
    ParamByName('pId_cidade').AsInteger := id_cidade;
    Open();
    cidade_nome := FieldByName('nome').AsString;
    uf_estado := FieldByName('uf').AsString;
    Close();
  end;

  with DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('select * from estado where uf = :pEstado_uf');
    ParamByName('pEstado_uf').AsString := uf_estado;
    Open();
    estado_nome := FieldByName('nome').AsString;
    Close();
  end;

  With DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('select * from cidade where UF = :pEstado;');
    ParamByName('pEstado').AsString := uf_estado;
    Open();
    First();
    while not Eof do
    begin
      boxCidade.Items.Add(FieldByName('NOME').AsString);
      Next;
    end;
    boxCidade.ItemIndex := boxCidade.Items.IndexOf(cidade_nome);
    Close();
  end;

  With DM.FDQueryTemp do
  begin
    Close();
    Sql.Clear;
    Sql.Add('select * from estado;');
    Open();
    First();
    while not Eof do
    begin
      boxEstado.Items.Add(FieldByName('NOME').AsString);
      Next();
    end;
    boxEstado.ItemIndex := boxEstado.Items.IndexOf(estado_nome);
    Close();
  end;

end;

end.
