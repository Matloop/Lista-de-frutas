import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet,FormsModule],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'app-formularios';
  usuario = {nome: '',email:'',fone:''}
  labelTextEmail = ''
  labelTextNome = ''
  labelTextFone = ''

  dados(dados:any){
    if(this.usuario.email === ''){
      this.labelTextEmail = 'Infome email'
    } else{
      this.labelTextEmail = ''
    }
    if(this.usuario.nome === ''){
      this.labelTextNome = 'Infome nome'
    } else{
      this.labelTextNome = ''
    }
    if(this.usuario.fone === ''){
      this.labelTextFone = 'Infome fone'
    } else{
      this.labelTextFone = ''
    }
    console.log(dados.value)
  }
}
