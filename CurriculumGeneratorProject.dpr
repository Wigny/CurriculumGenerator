program CurriculumGeneratorProject;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitCadPessoa in 'UnitCadPessoa.pas' {FormCadPessoa},
  UnitCadFormacaoAcademica in 'UnitCadFormacaoAcademica.pas' {FormCadFormacaoAcademica},
  UDataModule in 'UDataModule.pas' {DM: TDataModule},
  UnitCadExperienciaProfissional in 'UnitCadExperienciaProfissional.pas' {FormCadExperienciaProfissional},
  UnitMenuUsuario in 'UnitMenuUsuario.pas' {FormMenuUsuario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormCadPessoa, FormCadPessoa);
  Application.CreateForm(TFormCadFormacaoAcademica, FormCadFormacaoAcademica);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormCadExperienciaProfissional, FormCadExperienciaProfissional);
  Application.CreateForm(TFormMenuUsuario, FormMenuUsuario);
  Application.Run;
end.
