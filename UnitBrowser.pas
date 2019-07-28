unit UnitBrowser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw;

type
  TFormBrowser = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure FormShow(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  FormBrowser: TFormBrowser;

implementation

{$R *.dfm}

procedure TFormBrowser.FormShow(Sender: TObject);
begin
  WebBrowser1.Navigate('file:///D:\Temp\index.html');
  
end;

end.
