import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Recipe } from 'src/app/_models/Recipe';
import { AlertifyService } from 'src/app/_services/alertify.service';
import { RecipeService } from 'src/app/_services/recipe.service';
@Component({
  selector: 'app-detail-product',
  templateUrl: './detail-product.component.html',
  styleUrls: ['./detail-product.component.scss']
})
export class DetailProductComponent implements OnInit {
  public isAdd: boolean;
  public id: any;
  public detail: Recipe;
  public recipes: Recipe[];
  constructor(private toastrService: ToastrService, private recipeService: RecipeService,
              private router: Router, private alertifyService: AlertifyService, private route: ActivatedRoute ) { }

  ngOnInit() : void{
    this.route.paramMap.subscribe(params => this.id = params.get('id'));
    this.loadRecipe(this.id);
    console.log("Cong thuc mon an" + this.detail);
  }

  loadRecipe(id: any) {
    this.recipeService.getRecipeByID(id)
      .subscribe((res: Recipe[]) => {
        this.recipes = res;
        this.detail = res[0];
        if (res == null || res.length == 0){
          this.isAdd = true;
        }
    }, error => {
      this.toastrService.error(error);
    });
  }
  navigateToHome(){
    this.router.navigate(['admin/home']);
  }
  deleteRecipe(){
    this.alertifyService.confirm('Bạn có muốn xóa?', () => {
      this.recipeService.deleteRecipe(this.detail.id).subscribe(
        () => {
        this.toastrService.info('Xóa thành công');
        this.detail = null;
        },
        err => {
          this.toastrService.error('Xóa thất bại');
        }
      );
    });
  }

}
