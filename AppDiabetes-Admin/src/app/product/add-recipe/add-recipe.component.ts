import { Component, HostListener, OnInit, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Recipe } from 'src/app/_models/Recipe';
import { RecipeDTO } from 'src/app/_models/RecipeDTO';
import { RecipeService } from 'src/app/_services/recipe.service';

@Component({
  selector: 'app-add-recipe',
  templateUrl: './add-recipe.component.html',
  styleUrls: ['./add-recipe.component.scss']
})
export class AddRecipeComponent implements OnInit {

  constructor(public recipeService: RecipeService, private route: ActivatedRoute, private router: Router,
    private toastrService: ToastrService) { }
  @ViewChild('form') form: NgForm;
  newRecipe: RecipeDTO;
  groupID: any;
  @HostListener('window:beforeunload', ['$event'])
  unloadNotify($event: any){
  if  (this.form.dirty){
    $event.returnValue = true;
  }
}
  ngOnInit() {
    this.route.paramMap.subscribe(params => this.groupID = params.get('id'));
    this.resetForm();
  }
  resetForm(form?: NgForm){
    if  (form != null) {
      form.resetForm();
    }

    this.newRecipe = {
      id: null,
      name: '',
      ingredient: '',
      recipe: '',
      benefit: '',
      groupID: this.groupID
    };
  }
  navigateToPage(){
    this.router.navigate(['admin/home']);
  }

  addRecipe(){
    this.recipeService.addRecipe(this.newRecipe).subscribe( next => {
      this.toastrService.success('Thêm mới công thức thành công');
      this.navigateToPage();
    }, err => {
      console.log(err);
    this.toastrService.error(err);
    }
   );
  }

}
