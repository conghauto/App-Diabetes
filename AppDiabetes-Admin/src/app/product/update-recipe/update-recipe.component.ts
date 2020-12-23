import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Recipe } from 'src/app/_models/Recipe';
import { AlertifyService } from 'src/app/_services/alertify.service';
import { RecipeService } from 'src/app/_services/recipe.service';

@Component({
  selector: 'app-update-recipe',
  templateUrl: './update-recipe.component.html',
  styleUrls: ['./update-recipe.component.scss']
})
export class UpdateRecipeComponent implements OnInit {

  public id: any;
  public idRecipe: any;
  public detail: Recipe;
  public recipes: Recipe[];
  constructor(private toastrService: ToastrService, private recipeService: RecipeService,
              private router: Router, private alertifyService: AlertifyService, private route: ActivatedRoute ) { }

  ngOnInit() : void{
    this.route.paramMap.subscribe(params => this.id = params.get('id'));
    this.route.paramMap.subscribe(params => this.idRecipe = params.get('idRecipe'));
    this.loadRecipe(this.id);
  }

  loadRecipe(id: any) {
    this.recipeService.getRecipeByID(id)
      .subscribe((res: Recipe[]) => {
        this.recipes = res;
        this.detail = res[0];
    }, error => {
      this.toastrService.error(error);
    });
  }
  navigateToPage(){
    this.router.navigate(['admin/home']);
  }
  updateRecipe(){
    this.recipeService.updateRecipe(this.detail).subscribe( next => {
      this.toastrService.success('Cập nhật thành công');
      this.navigateToPage();
    }, err => {
      console.log(err);
    this.toastrService.error(err);
  });
  }
}
