unit UnitCadFormacaoAcademica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormCadFormacaoAcademica = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btOk: TButton;
    btNovo: TButton;
    Label1: TLabel;
    edInstituicao: TEdit;
    Label2: TLabel;
    edCurso: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edInicio: TEdit;
    edTermino: TEdit;
    procedure btOkClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
  private
    procedure SalvarDados();
  public
    id_curriculo: Integer;
  end;

var
  id_formacao_academica: Integer;
  FormCadFormacaoAcademica: TFormCadFormacaoAcademica;

implementation

{$R *.dfm}

uses UDataModule;

procedure TFormCadFormacaoAcademica.btNovoClick(Sender: TObject);
begin
  SalvarDados();
  edInstituicao.Text := '';
  edCurso.Text := '';
  edInicio.Text := '';
  edTermino.Text := '';
  edInstituicao.SetFocus;
end;

procedure TFormCadFormacaoAcademica.btOkClick(Sender: TObject);
begin
  SalvarDados();
  Close();
end;

procedure TFormCadFormacaoAcademica.SalvarDados();
var
  instituicao, curso, ano_inicio, ano_termino: String;
  camposPreenchidos: Boolean;
begin
  instituicao := edInstituicao.Text;
  curso := edCurso.Text;
  ano_inicio := edInicio.Text;
  ano_termino := edTermino.Text;

  camposPreenchidos := (instituicao <> '') and (curso <> '') and
    (ano_inicio <> '');

  if (camposPreenchidos) then
  begin

    with DM.FDQueryTemp do
    begin
      Close();
      SQL.Clear;
      SQL.Add('insert into formacao_academica (instituicao, curso, ano_inicio, ano_termino) values (:pInstituicao, :pCurso, :pAno_inicio, :pAno_termino);');
      ParamByName('pInstituicao').AsString := instituicao;
      ParamByName('pCurso').AsString := curso;
      ParamByName('pAno_inicio').AsString := ano_inicio;
      ParamByName('pAno_termino').AsString := ano_termino;
      ExecSQL();
      DM.FDConnection1.Commit();
      Close();
    end;

    with DM.FDQueryTemp do
    begin
      Close();
      SQL.Clear();
      SQL.Add('SELECT max(id_formacao_academica) FROM formacao_academica');
      Open();
      id_formacao_academica := Fields[0].AsInteger;
      Close();
    end;

    with DM.FDQueryTemp do
    begin
      Close();
      SQL.Clear();
      SQL.Add('insert into gerar_formacao_academica (id_curriculo, id_formacao_academica) values (:pId_curriculo, :pId_formacao_academica)');
      ParamByName('pId_curriculo').AsInteger := id_curriculo;
      ParamByName('pId_formacao_academica').AsInteger := id_formacao_academica;
      ExecSQL();
      DM.FDConnection1.Commit();
      Close();
    end;
  end
  else
    raise Exception.Create('Preencha todos os campos obrigatórios.');
end;

end.
