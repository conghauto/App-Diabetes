import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Recipe } from '../_models/Recipe';
import { map } from 'rxjs/operators';
import { ToastrService } from 'ngx-toastr';
import { RecipeDTO } from '../_models/RecipeDTO';
@Injectable({
  providedIn: 'root'
})
export class RecipeService {
  id: number;
  baseUrl = environment.apiUrl;
  recipe: Recipe[];

  constructor(private http: HttpClient, private toastrService: ToastrService) {
   }

  getRecipeByID(idFood) : Observable<Recipe[]>{
    return this.http.get<Recipe[]>(`${this.baseUrl}admin/getRecipeByGroupId.php?id=` + idFood).pipe(
      map((response) => {
        this.recipe = response['data'];
        console.log(this.recipe);
        return this.recipe;
      }, err => {
        this.toastrService.error(err);
      })
    );
  }

  updateRecipe(updatedRecipe: Recipe){
    return this.http.post(`${this.baseUrl}admin/updateRecipe.php`, { data: updatedRecipe });
  }

  addRecipe(addRecipe: RecipeDTO){
    return this.http.post(`${this.baseUrl}admin/addRecipe.php`, { data: addRecipe });
  }

  deleteRecipe(id: number){
    const params = new HttpParams()
    .set('id', id.toString());
    return this.http.delete(this.baseUrl + 'admin/deleteRecipe.php', { params: params });
  }

}
