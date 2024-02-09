// Meal data as: B, L, S, D

//1800 cal during first trimester (1-3 months)
//2200 cal during second trimester
//2400 cal during third trimester

List<List<Map<String, List<String>>>> mealDatas = [
  // Breakfast Only
  [
    {
      "Milk": [
        "https://www.heritagefoods.in/blog/wp-content/uploads/2020/12/shutterstock_539045662.jpg",
        "Milk",
        "Protien: 3.4gm,  Fats: 1gm, Carbs: 5gm",
        "42"
      ]
    },
    {
      "Moong Dal Cheela": [
        "https://fatloss.askyourdiet.in/wp-content/uploads/2019/03/Mung-Dal.jpg",
        "Moong Dal Cheela",
        "Protien: 3.6gm,  Fats: 3.1gm, Carbs: 8gm",
        "74"
      ]
    },
    {
      "Paratha with Curd and Ghee": [
        "https://www.myweekendkitchen.in/wp-content/uploads/2016/01/plain_paratha_Indian_bread-500x500.jpg",
        "Paratha with Curd and Ghee",
        "Protien: 5.16gm,  Fats: 8.99gm, Carbs: 25gm",
        "250"
      ]
    },
    {
      "Oats upma": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO-r-kFpbX8zTreZEXdDo8xS744bFCaN0zeg&usqp=CAU",
        "Oats upma",
        "Protien: 5gm,  Fats: 6gm, Carbs: 25gm",
        "150"
      ]
    },
    {
      "Multigrain Thalipeeth": [
        "https://cdn.tarladalal.com/members/9306/big/big_nutritious_thalipeeth-15581.jpg",
        "Multigrain Thalipeeth",
        "Protien: 3gm,  Fats: 3gm, Carbs: 15gm",
        "100"
      ]
    },
    {
      "Laapshi ": [
        "https://s3.amazonaws.com/appforest_uf/f1597942743539x341276110357740400/Lapsi.jpg",
        "Laapshi",
        "Protien: 5gm,  Fats: 2gm, Carbs: 30gm",
        "150"
      ]
    },
    {
      "Poha with peanuts": [
        "https://pipingpotcurry.com/wp-content/uploads/2020/12/Poha-Recipe-Piping-Pot-Curry.jpg",
        "Poha with peanuts",
        "Protien: 4gm,  Fats: 7gm, Carbs: 20gm",
        "150"
      ]
    },
  ],

  //Lunch Only
  [
    {
      "Multigrain Thalipeeth": [
        "https://ministryofcurry.com/wp-content/uploads/2020/02/Thalipeeth-6-850x1275.jpg",
        "Multigrain Thalipeeth",
        "Protien: 4gm,  Fats: 3gm, Carbs: 20gm",
        "120"
      ]
    },
    {
      "Lentils with Lemon Rice": [
        "https://holycowvegan.net/wp-content/uploads/2020/09/lemon-rice-south-indian-5-1.jpg",
        "Lentils with Lemon Rice",
        "Protien: 12gm,  Fats: 1gm, Carbs: 50gm",
        "250"
      ]
    },
    {
      "Leafy vegetables": [
        "https://betterme.world/articles/wp-content/uploads/2021/06/shutterstock_390988792.jpg",
        "Leafy vegetables",
        "Protien: 3gm,  Fats: 1gm, Carbs: 5gm", //These are approx values since every vegetable has different nutritional value.
        "40"
      ]
    },
    {
      "Mixed Dal with Roti": [
        "https://www.yummyoyummy.com/wp-content/uploads/2015/03/Mixed-dal-tadka.jpg",
        "Mixed Dals with Roti",
        "Protien: 7gm,  Fats: 1gm, Carbs: 20gm",
        "110"
      ]
    },
    {
      "Vegetable khichdi": [
        "https://curefoods-images.eatfit.in/tr:w-600,ar-0.8,c_fit//image/singles/eat/meals/COM1427/primary/1_1.jpg",
        "Vegetable khichdi",
        "Protien: 10gm,  Fats: 5gm, Carbs: 45gm",
        "250"
      ]
    },
    {
      "Rajma Chawal": [
        "https://chaturvedisweetsandnamkeen.com/wp-content/uploads/2022/10/Rajma-Chawal-scaled.jpeg",
        "Rajma Chawal",
        "Protien: 10gm,  Fats: 5gm, Carbs: 50gm",
        "300"
      ]
    },
    {
      "Kofta curry": [
        "https://cdn1.foodviva.com/static-content/food-images/lunch-recipes/lauki-kofta-curry/lauki-kofta-curry.jpg",
        "Kofta curry",
        "Protien: 10gm,  Fats: 20gm, Carbs: 15gm",
        "300"
      ]
    },
  ],

  //Snacks Only
  [
    {
      "Chikkis": [
        "https://m.media-amazon.com/images/I/51tlvKKsHML._AC_UF1000,1000_QL80_.jpg",
        "Chikkis",
        "Protien: 2gm,  Fats: 7gm, Carbs: 15gm",
        "120"
      ]
    },
    {
      "Dry Fruit Laddoos": [
        "https://d1mxd7n691o8sz.cloudfront.net/static/recipe/recipe/2023-03/Dry-Fruit-Ladoo-7eaf2445dc844112821b2cc11733958b.jpg",
        "Dry Fruit Laddoos",
        "Protien: 2gm,  Fats: 5gm, Carbs: 15gm",
        "100"
      ]
    },
    {
      "Sprout bhel": [
        "https://images.indianexpress.com/2021/07/GettyImages-sprouts-recipe-1200.jpg",
        "Sprout bhel",
        "Protien: 5gm,  Fats: 1gm, Carbs: 30gm",
        "150"
      ]
    },
    {
      "Makhana": [
        "https://media.post.rvohealth.io/wp-content/uploads/2021/05/makhana-1200x628-facebook.jpg",
        "Laddoo",
        "Protien: 9gm,  Fats: 1gm, Carbs: 65gm",
        "300"
      ]
    },
    {
      "Murmura bhel": [
        "https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Divya_Shivaraman_/Puffed_Rice_Upma__Murmura_Upma.jpg",
        "Murmura bhel",
        "Protien: 3gm,  Fats: 5gm, Carbs: 25gm",
        "150"
      ]
    },
    {
      "Fruit chaat": [
        "https://pipingpotcurry.com/wp-content/uploads/2022/04/Fruit-Chaat-recipe-indian-pakistani-style-Piping-Pot-Curry.jpg",
        "Fruit chaat",
        "Protien: 1gm,  Fats: 1gm, Carbs: 20gm",
        "80"
      ]
    },
    {
      "Corn salad": [
        "https://cdn.tarladalal.com/members/9306/big/big_american_sweet_corn_salad-15828.jpg",
        "Corn salad",
        "Protien: 3gm,  Fats: 5gm, Carbs: 15gm",
        "100"
      ]
    },
  ],

  // Dinner Only
  [
    {
      "Rice": [
        "https://hips.hearstapps.com/vidthumb/images/delish-u-rice-2-1529079587.jpg",
        "Rice",
        "Protien: 5gm,  Fats: 1gm, Carbs: 90gm",
        "100"
      ]
    },
    {
      "Curry": [
        "https://www.indianhealthyrecipes.com/wp-content/uploads/2023/09/curry-sauce-recipe.jpg",
        "Curry",
        "Protien: 12gm,  Fats: 5gm, Carbs: 100gm",
        "100"
      ]
    },
    {
      "Dal": [
        "https://www.indianveggiedelight.com/wp-content/uploads/2022/12/dal-fry-stovetop-featured.jpg",
        "Dal",
        "Protien: 15gm,  Fats: 8gm, Carbs: 120gm",
        "100"
      ]
    },
    {
      "Chapati": [
        "https://www.vegrecipesofindia.com/wp-content/uploads/2010/06/plain-paratha-recipe-1-500x375.jpg",
        "Chapati",
        "Protien: 6gm,  Fats: 1gm, Carbs: 80gm",
        "100"
      ]
    },
    {
      "Khichdi": [
        "https://greenbowl2soul.com/wp-content/uploads/2020/01/moong-dal-khichdi-500x500.jpg",
        "Khichdi",
        "Protien: 8gm,  Fats: 5gm, Carbs: 35gm",
        "200"
      ]
    },
    {
      "Multigrain roti-Mushroom curry": [
        "https://www.sailusfood.com/wp-content/uploads/2016/02/mushroom-masala-recipe.jpg",
        "Multigrain roti-Mushroom curry",
        "Protien: 8gm,  Fats: 11gm, Carbs: 25gm",
        "250"
      ]
    },
    {
      "Stuffed paratha": [
        "https://biancazapatka.com/wp-content/uploads/2019/07/aloo-paratha-recipe-crispy-flatbread-720x1080.jpg",
        "Stuffed paratha",
        "Protien: 5gm,  Fats: 8gm, Carbs: 30gm",
        "200"
      ]
    },
  ],
];
