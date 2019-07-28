unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormMain = class(TForm)
    btnCadUsuario: TButton;
    boxSelecionarUsuario: TComboBox;
    btnSelecionarUsuario: TButton;
    Label1: TLabel;
    procedure btnCadUsuarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSelecionarUsuarioClick(Sender: TObject);
    procedure boxSelecionarUsuarioChange(Sender: TObject);
  private
    procedure PegarIDUsuario();
  public
    procedure PreencherUsuariosBox();
  end;

var
  id_pessoa: Integer;
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses UnitCadPessoa, UDataModule, UnitCadFormacaoAcademica, UnitMenuUsuario;

procedure TFormMain.boxSelecionarUsuarioChange(Sender: TObject);
begin
  PegarIDUsuario();
end;

procedure TFormMain.btnCadUsuarioClick(Sender: TObject);
begin
  FormCadPessoa.ShowModal;
end;

procedure TFormMain.btnSelecionarUsuarioClick(Sender: TObject);
var
  usuario: Integer;
begin
  usuario := id_pessoa;
  if (boxSelecionarUsuario.ItemIndex = -1) then
    raise Exception.Create('Usuário não selecionado.');

  With FormMenuUsuario do begin
    id_pessoa := usuario;
    ShowModal;
  end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  PreencherUsuariosBox();
end;

procedure TFormMain.PreencherUsuariosBox();
var
  nome: String;
begin
  with DM.FDQueryTemp do begin
    Close();
    SQL.Clear();
    SQL.Add('SELECT * FROM pessoa');
    Open();
    First();
      while not Eof do
        begin
          nome := FieldByName('NOME').AsString;
          boxSelecionarUsuario.Items.Add(nome);
          Next();
        end;
    Close();
  end;
end;

procedure TFormMain.PegarIDUsuario();
begin
  with DM.FDQueryTemp do begin
    SQL.Clear();
    SQL.Add('select * from pessoa where nome = :pNomePessoa');
    ParamByName('pNomePessoa').AsString := boxSelecionarUsuario.Items[boxSelecionarUsuario.ItemIndex];
    Open();
    id_pessoa := FieldByName('id_pessoa').AsInteger;
    Close();
  end;
end;

end.
