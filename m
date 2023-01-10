Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CDC664E2B
	for <lists+linux-can@lfdr.de>; Tue, 10 Jan 2023 22:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjAJVk1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Jan 2023 16:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjAJVkZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2023 16:40:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DDABF48
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2023 13:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673386821; x=1704922821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BT621XUZOxwjsUntoE8rS8Mh1uteRS+hhr+0f0a66eM=;
  b=EBDTLyJDpriRZZWfot796LePG8/pesNMEogFFl1XB0jIVH27XmHXdQ+v
   QBvQYRp/V8ThFsfcRYShq9cVABQED1V5cLojO1Bf+dxX6lNzkO4++CXCB
   GNNVtAcGstwhPNenTFa2XOaGFobe0v4Cj+7H21ujAujAbYj9BCYWX2fNU
   mPjnX81NfagIlY1ekVqWglVbIp0ounmkLI65vDnWg2O36B/ZrLh9UANYK
   Kk/b+pC0XoqoGI/2ET/rMN+HtC6Y7jur910B4poUdTpn6a7AmVaT50rd6
   hUPXUrYRV0WbrdA6EKSjd0rUGTKhxx8MaMmkoyOnEyB0C2hRPLwCNoN4H
   g==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="195169243"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jan 2023 14:40:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 14:40:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 10 Jan 2023 14:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjptr3uldw1+xYThJd/QhABDu52OK/1WdsR1EPHOD8Hbnbm6mYJg6Rt1rVqM08GCgPGwV0V2VO2p2A58U3zAPp8WF0M57Ykj4HqzWlD52Tk+97f+hsIcVqqOMkUOTmJ27xLR7d1at1+YeKZgmoIahKV2mrSxW9bM/et9PbQvTIMl/PzXAr3/aZqTgUtIhq6Pxi+w0EJeDud3/xJuxbVuUMGW0ujNik7pqR3Dsp+wfr2ycyOGWmzlfs41LYjcTKvIne7wLawe5BihCsYH+3OuPVxAcWH8P4VA6ZQtOHGVVpF0cp1LAfjQ+ezRiDmmeu20ny2LKq8/eDDISmdwK1ysAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT621XUZOxwjsUntoE8rS8Mh1uteRS+hhr+0f0a66eM=;
 b=Hp6Gm1zzSWgeXpIzbtwErMP1iUz97uavWZr4U1OfcombwvwJwK/ymFqs/KKw6+5TLPCxrOkFREcb+QFhCWMNQl8oBMhVb2S9x/V7WvmPao6Ln33fs6fauUqcyhbPAHg1jVb1mEcXGmEEselHvu+wfLB0PqrSkKjQk3P6HN6g66Ss30IrFdJp4i+5sk8C2kiAyiBCu1tDS9b8Q3OfivZUkbWOBNJwvXW/LW04qFnRF1So86MwSkTO/YH7X//2Z4AXWO+UizQS9hRsU9BqeC7lWRmC+mDLXlMhUsDHDi+BRxfebHoy6T2rXp9bEQ7cGh8vHqtTuc+eVEyMnKxR5b3Lqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT621XUZOxwjsUntoE8rS8Mh1uteRS+hhr+0f0a66eM=;
 b=hHY2Vz1nk+a7zHCh8cCxY8uyrEkZ8JcTwhJL2wnTbzOvtmKH2rXFn2uUyZOhULPKk2U7dXCbP4+/sU1kozDT8CqAUPKaaDsQHl9wwMtJHr30CJgr5awn6MvyMZGVtkjhkMfG//fAh/B9pD/UGx6USUnjsz4ebkKPhUecaWzWJS0=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 21:40:17 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096%3]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 21:40:16 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>
CC:     <Stefan.Althoefer@janztec.com>, <linux-can@vger.kernel.org>
Subject: RE: RE: AW: AW: mcp251xfd: Bad message receiption (1/2)
Thread-Topic: RE: AW: AW: mcp251xfd: Bad message receiption (1/2)
Thread-Index: AQHZI/l4ok8+oI6xUkm6kTnSDPwpj66Xi/gggAAypgCAACXigIAAGWcAgAAyZjA=
Date:   Tue, 10 Jan 2023 21:40:16 +0000
Message-ID: <BL3PR11MB6484FC468720BAB0660766A8FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20221222130219.xrfnm54g6lfjozvs@pengutronix.de>
 <FR0P281MB19666A63278AAA9D20B6989297E99@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20221224155705.l6qx3xu34nmo3ehn@pengutronix.de>
 <FR0P281MB196615471DB16E566528E7F097F09@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966783A50BDAD455BBC7F1A97F69@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966543302DB6485C49F8A2E97F59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966801F8A7BCC540D40A4DE97FE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64849F53D129B61D79952538FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230110145322.4bqwlw3owesc5myj@pengutronix.de>
 <20230110170857.5ejgppyjnoc2adji@pengutronix.de>
 <20230110183952.pvtuw5gudefnnyv5@pengutronix.de>
In-Reply-To: <20230110183952.pvtuw5gudefnnyv5@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: ccdb6173-fd2d-4f07-c8fc-08daf353438e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JvrGQ2dZeomna9mrfsIGl+h+uVx0HfywBXwSjJaK89D081etCL6QmqkNMVzmOFsuVpDNsg40oc10qrTuPDnvjQlF5l6ZZkFRqz1xDzyULCP2kZXXKK19rZ/QIrm95MTG1vW27zWhfprcPLhrU5So0s6IRUPcqDAeurnIrYiZEEo2KRp/T4YP5xuiuLe56YA9gHcF4hejGUAiZxrp3UjXDFliPfK4p1mDMlIKHzM058x5VFMpaVQrSvkdRlXMmPW8JM0Y52BJHyHfPNd6C1RlHQ9whJ+2x8u3Fzmc0iSB6+TNC4KVGBDVuRJ7b88VAQLr+TCYXk0WXVoeDQuX0QOW+1g0SqGKRis4CZ2bFAsrsIKBwukZakr2ShVWmFPoBPf52hWCJLZem8wR7bhYfqhE8Fd/PHLolbCAg4DQpJwAfDeNSodlAhA0NitWVG/kLG5gMebMPxoGi4dVBPL5m2m04gHSk46zHUcfU934YpGp/DiHO8oFAV8LQ689pcOwe5QUmkhqcUqbOEvmAcu8J/VpAq83nevO21ukb7Y/Y79QQNcWwktnCgvo7cVZLaQuebwoxKqlGpFe3dUS0iv5q8TQNm3j4Xrn4akWHroQy6SohEJuoi48fL2LiWFUWIAKc5UMvf1BAjc+ng0N2m9s0GeX0vNHAlR3NTPxmZBR1ARbwb1b7kOHVZfqyh/OdCso+Pon9yy0HzTw7t7fsi//R3prhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(33656002)(6506007)(478600001)(4326008)(55016003)(26005)(186003)(9686003)(64756008)(66556008)(316002)(8676002)(66476007)(6916009)(66446008)(76116006)(71200400001)(54906003)(7696005)(86362001)(38070700005)(122000001)(38100700002)(83380400001)(41300700001)(52536014)(66946007)(5660300002)(15650500001)(4744005)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0t5MHByVXdaTjZoRDdma0RVbnNmUG9McFBnV216dng4eWZISWNwRnBPcEpD?=
 =?utf-8?B?YkNsQXlQMnROdksyUTRyU0c4eVZpZ3YwWHlUdzg1Y21rc2ZKN056a01HY1Mx?=
 =?utf-8?B?K3ViRWE5K2hrRTFCRXdYMDZYNFlmd0J0WVJubUt2MTdCc3VmV2ZOTDR6Tjl6?=
 =?utf-8?B?VVRXdXUySGFRQjhDcWRJYWFTTHZ1MFgvNTNzOFErTVNRQU1WUE94L3hVZ0Vp?=
 =?utf-8?B?bVBuUHBzT2VhcHFWV25NWjFPeENMWXRSOWNQbUM4ZFl6Yk9RZDZCeGp5YXJn?=
 =?utf-8?B?bFZBUXRvZmZNczI0MjMzdFdDNTRUUHNmaE5kV0QwUzBHU2JDcUJUaTM3d2dF?=
 =?utf-8?B?NkdiVDNVcFJicWQ1cW4zWFlDWmFtYk5rVk5IVGtFMlJyelBkSHk2TVNxSlpv?=
 =?utf-8?B?Ky90U1VpdjRRaG42VlNPUnFrRkhwOVA0VS9RMm4wQVZXbEJWYUZTdHVVa21M?=
 =?utf-8?B?N2tYK0wydWM2MlhYa0Y1alUzOFh0UEUzaHNXaG1yaVJpcm9QZnhva0RsbVd3?=
 =?utf-8?B?SlZ3UnJyek42YVMrcWpKRElYcTZhbDBuY2pQc09zRUFXZmFMOFp4M29KQ3dG?=
 =?utf-8?B?QmJ3SlhsM1RDelB4N0JacThHT3hWclNYbk1JY1k1TGtSN0dZbEFrWGEzd1Ur?=
 =?utf-8?B?UFVQSkExc1pzOU83dHJZbXJSREE4Z25GcXF5czFhTzB1V2dVVDgvUnVzNVFr?=
 =?utf-8?B?Y3hYaHNIdmhPb21JVndlck41WHVWbWtxaXpiald5dHJQUGtlYi9lTGR4REUz?=
 =?utf-8?B?YzlqRXpDZnFYL05GRDFLcHlOOTZRbklVME1JRWpMMXV1ZDNIaUxKUGdOZVVk?=
 =?utf-8?B?Z3hab0R1WFVGUXUxM3ptUTlVSmg2ODFxdzNVVzV3MEthY1ZyZ0lrYzJpaTQw?=
 =?utf-8?B?SEZsL1c5Z3FtY3BOQnB4bUFyeTVjQmlhU0RRNlJKL1hYMVlIYVhpSFhUTWpu?=
 =?utf-8?B?WVVnaEU2cnpiYjd1TElUU2FaYWdLRmFZcjlhOEprZys4b3Q3bkN6MWVVZ1Nl?=
 =?utf-8?B?NjdZMjAzSHFzMFJUWFRWdVR5YTUrNTNFbGNuTDNnOEpKK3d4czErVG1Xd2h3?=
 =?utf-8?B?TFlIbTBCZnB3WGNSM2l2bmNOSERtVmp2ZERuNmpKMkttRzlOWm9Qb3JyTGlQ?=
 =?utf-8?B?R0p4SmhST1czTUxFT0h4eXViMEF1NUNyVWtJd0ZQWWUxMlVlNlZRQU9odElL?=
 =?utf-8?B?dGdrcFFOdC9lOHFQZjBwWnBwRTNXdGo5Y2poRFpVVUprZjhONWJyb05IbEFS?=
 =?utf-8?B?c0VMN0gwbkpUbnBONGdCOWM3azNCZ3ZzOEYxdk4xKzRZWWY0aTc0VFZhTFFU?=
 =?utf-8?B?WDQ4ZUp1a1ZaeE1wRWhmRk9wcWlBRTdmOHZpZHhXWHZWOFB0UWRNTWpvazla?=
 =?utf-8?B?VnRCOWJ0K2E5TmNONTdaeTNQejJ2bk5sLzBDbG5HS1RYU1Z0ZG0wMGZvTG1p?=
 =?utf-8?B?Zi9mWWVjaGZnRVh0bjBLME1uRE10ZUpuWUtDUUlwUTlGYW5GSHVnd1lkVEN6?=
 =?utf-8?B?a21RZXJyakxuVWJ5OTRER2g4ZkNMYVZRQXVvMXNqQ1VobWRVd3dtby85Zk1K?=
 =?utf-8?B?dGorSk1lZFBPM2pUNlQvNnB3bW9UbVo0bG1tSGU5c1ZiSTBiQ0ltcEZYVUVs?=
 =?utf-8?B?WXNxbjA4TG1lbmROUkJTOFhURjlicGREYWNqRHk4aXI3S2F0ZlM2azE4dFF2?=
 =?utf-8?B?NW5CaFkyV0wzU2N4Z3RXZi9PRTFROWRZMUlEYUdHUHV1YjZvOE55NUtEcHdM?=
 =?utf-8?B?YkJ2bE9RQXBlQ0hvYmxFSm12QnhQMXhkUVlwemR5djUxaWNGS24wUVpqV1gx?=
 =?utf-8?B?Q3Z6OFFiN2Jtb1M3cEN0Z0FXY3VUL05Ic2M1TXMyd1RDdngvQ1lrc3NEOStI?=
 =?utf-8?B?ZVM2ZFdlUEFLRHIzQ0ZLNFJhc3haSFVNSUNpZ3R1KzNvVTIxKzZRK2d2NUU2?=
 =?utf-8?B?Vnl0M0NSVGNyR2lzMnhGanpvSE9CWDV2REdIU21ZVk5PbjVma2FENldxclJj?=
 =?utf-8?B?aStFbUtKcXBIYUQxU2Nwd0hLODMwS1kzNjRyS1NNWXRscWE1UFYwTVR6UHNm?=
 =?utf-8?B?dlVmbzZmUDg2cGRVcVcrbGZpYWtqeitSZ1ZDU3hERlVEdlRURnRXOFlzazFC?=
 =?utf-8?Q?dZPGiDIQ9RBqjgaLbkGTyfPHB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdb6173-fd2d-4f07-c8fc-08daf353438e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 21:40:16.6987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWN2meCuGMME/fd77afjkOQnthCiREaDnLCX/JK1EquPl7SAfnJsJIooBTpYUrTDWjVVN29FckrdBrLIMr1kCS3M5bhZf7zZ7GGG8j+XZkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

QWJvdXQgSGVhZCBub3QgdGFpbDogV2hvb3BzLCB5ZXMgY29ycmVjdC4NCg0KPiBUaGUgY29ycmVj
dCBtZXNzYWdlIGNvdW50ZXIgaXMgMHgxMDAsIHRoZSB3cm9uZyBvbmUgMHgxMjAuIFRoYXQncyAy
eA0KPiBGSUZPIHNpemUuIEknZCBsaWtlIHRvIGtub3cgd2hlbiB0aGUgRklGTyBoZWFkIGlzIHdy
b25nIGZvciB0aGUgZmlyc3QNCj4gdGltZSwgb25lIHRoYXQgcmVzdWx0cyBpbiBhIGRhdGEgdHJh
bnNmZXIgd2hlcmUgIm9sZCIgRklGTyBjb250ZW50cyBpcw0KPiByZWFkLiBJIGhhdmVuJ3QgZHVt
cGVkIGFueSBkYXRhIHlldC4NCg0KTm90IHN1cmUgd2hhdCB5b3UgbWVhbi4gRG8geW91IHdhbnQg
dGhlIG1lc3NhZ2UgY291bnRlciBhdCB0aGF0IHBvaW50IGluIHRpbWU/IA0KDQpUaG9tYXMgDQo=
