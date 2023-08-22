// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
     var allProducts = <Product>[
      Product(
        category: Category.accessories,
        id: 0,
        isFeatured: true,
        starnum: 1,
        name: 'A Hotel',
        location: '경상북도 포항시 북구 흥해읍 한동로 558 A',
        phone_number: '010-1111-1111',
        description: 'A Hotel은 바쁜 일상에서 여유로운 휴식을 즐길 수 있는 도심 속 힐링 공간으로, 비즈니스, 쇼핑, 문화의 중심부에 위치하여 버스, 지하철 등 대중교통 이용에 용이합니다.\n모던하고 세련된 인테리어의 총 208개 객실, 올데이 다이닝 레스토랑, 24시간 이용 가능한 편의시설, 로비 라운지, 연회장 등을 비롯하여 낮에는 반짝이는 햇살을 밤에는 반짝이는 도심 야경을 감상할 수 있는 루프탑 야외 수영장은 마치 휴양지에 온듯한 분위기를 연상시키는 A Hotel의 시그니처 공간입니다.',
      ),
      Product(
        category: Category.accessories,
        id: 1,
        isFeatured: true,
        starnum: 2,
        name: 'B Hotel',
        location:'경상북도 포항시 북구 흥해읍 한동로 558 B',
        phone_number: '010-2222-2222',
        description: '모던한 분위기의 호텔로 편안한 휴식과 함께 소래습지생태공원, 차이나타운, 벽화마을, 신포국제시장 등 주변의 관광지도 쉽게 둘러볼 수 있어요!\n비즈니스 센터에서 간단한 복사,팩스 등의 업무도 가능합니다.'
      ),
      Product(
        category: Category.accessories,
        id: 2,
        isFeatured: false,
        starnum: 3,
        name: 'C Hotel',
        location: '경상북도 포항시 북구 흥해읍 한동로 558 C',
        phone_number: '010-3333-3333',
        description: 'C Hotel은 은 비즈니스에 최적화된 다양한 시설과 품격 있는 서비스를 더하여 고객님을 맞이합니다.\n이 곳에 머무는 동안 고객님은 호텔 앞에 펼쳐진 청계산 자락의 맑은 공기를 느끼며 도심 속 휴식을 느낄 수 있습니다.\n도심 한 가운데에 있는 그림과 같은 청계산을 오르거나 근처 양재 시민의 숲길을 따라 산책하며 아름다운 경치를 즐길 수 있습니다.'
      ),
      Product(
        category: Category.accessories,
        id: 3,
        isFeatured: true,
        starnum: 4,
        name: 'D Hotel',
        location: '경상북도 포항시 북구 흥해읍 한동로 558 D',
        phone_number: '010-4444-4444',
        description: '네 개의 세계적인 인테리어 회사들이 참가하여 설계한 독창적인 객실은 최신 트렌드를 반영하고 있으며 품격과 정교함을 경험할 수 있습니다.\n최상의 평온함을 위한 해온(he:on) 베딩 시스템, 전 객실에서 서울 도심의 환상적인 전망을 감상하실 수 있습니다.'
      ),
      Product(
        category: Category.accessories,
        id: 4,
        isFeatured: false,
        starnum: 5,
        name: 'E Hotel',
        location: '경상북도 포항시 북구 흥해읍 한동로 558 E',
        phone_number: '010-5555-5555',
        description: '포항 지역 최고의 역사와 전통을 자랑하는 특급 호텔입니다.\n지하 350m에서 끌어올린 약알칼리 래디움 온천수가 특징적인 온천호텔!\n국립공원, 사찰, 엑스포 과학공원 등의 관광지 인근에 위치해있어요.'
      ),
      Product(
        category: Category.accessories,
        id: 5,
        isFeatured: false,
        starnum: 6,
        name: 'F Hotel',
        location: '경상북도 포항시 북구 흥해읍 한동로 558 F',
        phone_number: '010-1234-5678',
        description: '어린이를 위한 키즈룸은 방마다 다른 컨셉으로 아이들이 좋아하는 겨울왕국, 프린세스 등으로 꾸며져 있습니다 :D\n디럭스 타입에서는 바다전망이나 성산 일출봉 전망을 즐기실 수 있고 넓은 로비를 편안하게 이용하실 수 있어요!'
      ),
    ];
    if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}
