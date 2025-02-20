import { Routes } from '@angular/router';
import { CadastroComponent } from './cadastro/cadastro.component';
import { HomeComponent } from './home/home.component';
import { PageErrorComponent } from './page-error/page-error.component';
import { EdicaoComponent } from './edicao/edicao.component';
import { ConsultaComponent } from './consulta/consulta.component';

export const routes: Routes = [
    { path:'',component:HomeComponent},
    { path:'cadastro',component:CadastroComponent},
    { path:'consulta', component:ConsultaComponent},
    { path:'consulta/:id', component: EdicaoComponent},
    {path:'**',component: PageErrorComponent}
];
