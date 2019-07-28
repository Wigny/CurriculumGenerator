unit UnitCadExperienciaProfissional;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormCadExperienciaProfissional = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edEmpresa: TEdit;
    edCargo: TEdit;
    edInicio: TEdit;
    edTermino: TEdit;
    Panel2: TPanel;
    btOk: TButton;
    btNovo: TButton;
    procedure btOkClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
  private
    procedure SalvarDados();
  public
    id_curriculo: Integer;
  end;

var
  id_experiencia_profissional: Integer;

  FormCadExperienciaProfissional: TFormCadExperienciaProfissional;

implementation

{$R *.dfm}

uses UDataModule;

procedure TFormCadExperienciaProfissional.btNovoClick(Sender: TObject);
begin
  SalvarDados();
  edEmpresa.Text := '';
  edCargo.Text := '';
  edInicio.Text := '';
  edTermino.Text := '';
  edEmpresa.SetFocus;
end;

procedure TFormCadExperienciaProfissional.btOkClick(Sender: TObject);
begin
  SalvarDados();
  Close();
end;

procedure TFormCadExperienciaProfissional.SalvarDados();
var
  empresa, cargo, ano_inicio, ano_termino: String;
  camposPreenchidos: Boolean;

begin
  empresa := edEmpresa.Text;
  cargo := edCargo.Text;
  ano_inicio := edInicio.Text;
  ano_termino := edTermino.Text;

  camposPreenchidos := (empresa <> '') and (cargo <> '') and (ano_inicio <> '');

  if (camposPreenchidos) then
  begin
    with DM.FDQueryTemp do
    begin
      Close();
      SQL.Clear;
      SQL.Add('insert into experiencia_profissional (empresa, cargo, ano_inicio, ano_termino) values (:pEmpresa, :pCargo, :pAno_inicio, :pAno_termino);');
      ParamByName('pEmpresa').AsString := empresa;
      ParamByName('pCargo').AsString := cargo;
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
      SQL.Add('SELECT max(id_experiencia_profissional) FROM experiencia_profissional');
      Open();
      id_experiencia_profissional := Fields[0].AsInteger;
      Close();
    end;

    with DM.FDQueryTemp do
    begin
      Close();
      SQL.Clear();
      SQL.Add('insert into GERAR_EXP_PROFISSIONAL (id_curriculo, id_experiencia_profissional) values (:pId_curriculo, :PId_experiencia_profissional)');
      ParamByName('pId_curriculo').AsInteger := id_curriculo;
      ParamByName('PId_experiencia_profissional').AsInteger :=
        id_experiencia_profissional;
      ExecSQL();
      DM.FDConnection1.Commit();
      Close();
    end;
  end
  else
    raise Exception.Create('Preencha todos os campos obrigatórios.');
end;

end.
