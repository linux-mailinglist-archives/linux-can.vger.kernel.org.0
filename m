Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0978367605C
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 23:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjATWqd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Jan 2023 17:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjATWqc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2023 17:46:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBF713DCB
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 14:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674254791; x=1705790791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HupPt3b6q/U74PjeCxThfXnsutJJcHPxsI7rdR4QW8M=;
  b=R0MGAhakCP6RJl+ehN9pTLVKgxyaWCLREQcPj1XK7TH3vJkMVOE9K2Iy
   7G7thRV3lf3ENuhnA2e8skYyjWQ5w2U2XY7HFL2uVZBo8aMlyPVlwfgWs
   ZEf5VL0PKuYV10pQq8vNmI6nwlrmoFE5tV1/P6S6QymZqcyeCYdJkZTp/
   rNVENdAHPiyx3ZyqEnI2fhYeCgHGeb7CvPY9anCqmnBm1iQH1xRHTkwQV
   DCEUOTH1GZO12j2UGqFg/oSQADSkKwlJpj/fLzudxZGDQvNYIkbZvxImu
   JYSf1MfwQpMW5cuz5ymQ8vlzCeZIA7I+s0ZkvcdzHA6hL0a9hut53cLMN
   A==;
X-IronPort-AV: E=Sophos;i="5.97,233,1669100400"; 
   d="scan'208";a="197692839"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 15:46:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 15:46:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 15:46:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Drd6pIl/HCS7OeQv1gEnQrFdyeCrNF1PKDpGS13OU0MQQDP4duB2YOhscKSqp1BkklM5Xv+sjZypjO5rHpwsI6JefCTBLE464saeBPBud+keGhekN5hYvH1iYTAFk4hBwgUhLmXpKInZN/1Gx56juPnWCrAS0zHke6ks+KSmAq21aDLaXjgsB6y2eFKPBVUgeoArMq2Rb9PF4sWkKB0/waHLHGOEXatH4Sw4s1y4DmZhrH0D+5yFU5zq6I9p+zZzTAAaisezblXGN0r6RHLf0FhgXOzbEA29wja9LAs0r1vuR3RzxBUhSKNq1He4n6wiZZFNV9BZsNRV+uDaxz8faw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HupPt3b6q/U74PjeCxThfXnsutJJcHPxsI7rdR4QW8M=;
 b=XZKD3L2SzsVmGFa+enFhYwxk6Yx7j7K+24i3dTCmHqP6oSQUM4a8Gcp7V4Oy9p7iym9+hDcLnOEGwm5dHp/XqTXDlOmWzH+f6WtLuLx66hlwE5rGjWyTGvYqSZ2e8a9hwc1sfh3uURjK1owVL5Lf2M0mRUiMESK1nA7Lcm6AsxzNcUAxuM2jJtyBNrqmmJz9OMq4HgLtPr7mji6H8nNTkSE51cf6eTDqCWexol9UTpkQzUej5rmgQ1pYYMswPE4mN0WkPu3zLVMV0Nst6kv7pKUwEx6526cX8nj62d4/6u1lGXs5lmId2PFa/zFXgr79EWkbDCaZhcz13nhhIeee7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HupPt3b6q/U74PjeCxThfXnsutJJcHPxsI7rdR4QW8M=;
 b=RaHfomldL5+dQiZC3rLUg0emOqPXhcn9MP5hlV8mEx3sngZA1VZ6hIDWPUlWCB4JuWgXESM0JC0oQO3UvA3vZBmO2JgxgfW9jeTlmM98BNjV/bB7DrO2GhT+hY8jXK4gqM6XdWHD1w1DmqUqFr8sWWvio2IuSzyfGEc28rScGlA=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 22:46:27 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096%3]) with mapi id 15.20.6002.026; Fri, 20 Jan 2023
 22:46:27 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <Stefan.Althoefer@janztec.com>
CC:     <linux-can@vger.kernel.org>
Subject: RE: AW: RE: mcp251xfd: rx frame truncation (1/2)
Thread-Topic: AW: RE: mcp251xfd: rx frame truncation (1/2)
Thread-Index: AQHZKz4szMq49nyLkUucW5HyhGITIq6kOILggAAd4YCAAPuhYIAARQeAgAAbIACAAACgIIAAC5oAgAIFcICAABmWgIAADieg
Date:   Fri, 20 Jan 2023 22:46:27 +0000
Message-ID: <BL3PR11MB64841AD10C3CFBC21A2A16FFFBC59@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966F32AD422DDD867F8C53A97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB6484911640CCC738ED799E6FFBC79@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19663A60B0F7CE7F684A7A6297C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64842584529FAEF279F7B137FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19669083201C1B9C2DFB9E5497C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB196633E4F8E1195086E2402B97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB648434F2B7DE7F75E291E159FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230119133214.ofapvfc2rzi3gvn4@pengutronix.de>
 <FR0P281MB1966B0AD5BD74FA1AE550F2797C59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20230120215547.ewa5npqsxf5jxjcr@pengutronix.de>
In-Reply-To: <20230120215547.ewa5npqsxf5jxjcr@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|DM4PR11MB5262:EE_
x-ms-office365-filtering-correlation-id: 482d2889-3a6e-42dd-0082-08dafb382a4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KEYJSuZIdRkGDqZIL50JvsE5ygr0SRl/eiSon3Dc1N8NZ2Cdn9zd0ip91/gYXNgNab855EhyDP5ao0BDDyRbAZ14b7uP87T3A0k44aw/hStKJcX6FTYUWoIrhXg58gS3WdTDOzrogmdTD007TVHduYBTz5gSZVw/8beyrl2HuX5Yu5FzHT31Z1laXB9933YD6yqpFSk+Nml+mHYsdp/Ynp251yTpLWyCeatAgplUvrPNLe1ZX7QAVod5d9hABfUI+HkPydw5/SsTL1QDbtdh3HHrR+wWYzQE6EKhkGeIEfcIl7A07McktTzGe4VWDXZSiMSiJLKy/tzrMlF1j0yyn+M8JxnwjK1bo4aNOkCavyT7HEu1ja1Oi1VI6b+uX8LWlzWm/7A3KiYvaRRqVj2oQljB4WeaCWbb7i8cAyZztZ1OacJltvCoBSYI/yaiTk+MI7uvHopBZcSxAaJNrOv/mFAJURhStV5Cjkuevk7HaoUbFdEgC4N8g3Ag8NhYeZKl2KPcPkGaq4RUinEdzYNHQgShBdlo5H6mS3XglfYZzn4W0juPLsfefmdKum7NIvozjdrAI1yFEq9DLALrnJ2HVKLMxuOOzQz1NfebitcsuO1/EOl0vIPq7gZg0g7oq9jAyBM87KLNSpK6ay4n1XeOWPUEBToJkltLjVZSE4GBvpelYu7DukjTbqND4SR7zMCWuTQC+qZJ3WtDvvQwT7pMmIDhfpLz9z2CrF2EFCD31rqMYV0U+BRZAx8VzFPkRnVn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(33656002)(110136005)(478600001)(71200400001)(7696005)(9686003)(55016003)(38070700005)(86362001)(122000001)(6506007)(4744005)(66476007)(41300700001)(2906002)(66446008)(52536014)(38100700002)(186003)(26005)(5660300002)(8676002)(66946007)(4326008)(316002)(76116006)(66556008)(8936002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3YyRW4wUE5RYWFhQnBuZVc1b3ljbG5lK28waHIzUHMramc0WHg4MkR6RzZx?=
 =?utf-8?B?cThlblRTTkNjOEh5TEZCOUY2dUJ1ejdHSkhwaVkvYkk3TnI5WGlGa1pZVVF2?=
 =?utf-8?B?VHBEUUpndUtSLzFFSzFKdzY3Z3h3UmhZc1dWQmNnTVhwKy9palFxRTZvSFFi?=
 =?utf-8?B?YjlkR2d0N2U0QzFwRnVaSGpGN0cvWVFncEFoNmtyVDh0eDNmZ0lFbHJ1T013?=
 =?utf-8?B?MUJrdXRkNjcybXpOVmd2UGxzREJmWWlTZ3RKdVdiNnVpODlLc21qWDVmd0kv?=
 =?utf-8?B?akwxYVdNNlZ2ZHJSMWNRbzZiVGVrbS9iVThhMkMveElxVU1FNHhqbHY2UTFC?=
 =?utf-8?B?Z2pYUHV1aEhVVS9EaTEyWWdUZkxBclAwMHRsRk5Ed2pVc1lqZk93Nk1yeS9X?=
 =?utf-8?B?dWpDS3dMa2hJZVNoYnh4ZlRsdHoxQkp0SStNclQvaC9Sa1pCMklnck1kUWl5?=
 =?utf-8?B?Z1pTa3FSVGw5N0FtM0s2RW9tNWFnNVNGNTdhMzlJS3JEbFIwWTdPMzdRb3Bk?=
 =?utf-8?B?YUIrbFdXZ2xzWlMwMW1SQjVzZWpud3BId0RpdjVhTkNjbytKdU9qSWVveFda?=
 =?utf-8?B?a1VpME5OYUk3enAweWhyYy90REJZeE5NU2tOUTMyZG9FQmo1YWdmQzF1aEFj?=
 =?utf-8?B?SXNhelFCMzBRNFdiWmVubWV1UEowcFRoUnIxTnpJMDZQcHFZcCt6b1AwSkVl?=
 =?utf-8?B?dTY0R1BrR3M0MDk1VVpEb29lMWJmY2w1dlR2aFo3bmpCYWhjZkRnT0Q3cVdI?=
 =?utf-8?B?ZlAzL09nbi9YR1lhQUdzZTlaa0Zhclh3WDJxNW1lRzNvd2VIbk1wWG1WaWZD?=
 =?utf-8?B?UFExM0xwc0VGZUdjaUxMWTlKMUQ0VnJ3M3Q0a3paUFZCd3dnUkhMRXdQdHc1?=
 =?utf-8?B?akRLTUt5OFpGSnhBTVNiNlVKWDZMNW9XNGNqY0NZSWNpQmF3RE9DZ0x0U0tL?=
 =?utf-8?B?U1NITWNYZGl6SGppZ21qSDMxNG5ISzR4S1U5V0dMOVFINlpSN0NEQ2xJdUwr?=
 =?utf-8?B?Yjg1aVlFaWpwNmUrT01HRFlPOERMTUc5enphTW0zcnp6MFpXOEN2U3JiU0M5?=
 =?utf-8?B?R3ViditKUE1YdEJqd2gxbCsxYVhJamNRejlpdy9xNmliTnBLcFo0QXJPSlF5?=
 =?utf-8?B?OFhidzZPZ3hJcTNSekppUW5PRk1hcWRIMkxsL2dmUXRhQ1RVMXdWY1M3QXJn?=
 =?utf-8?B?MGRTKzVIeVRDVVphVE93YnFHaU96UWk2ZlJPODkwZm9qSkRtM2g0NkhqOTc0?=
 =?utf-8?B?UWI4R0EvRVpFQjZobUpJMmk0b3NGU3BhSzlDVHNOekhaTHI4NlYyYUEwdExT?=
 =?utf-8?B?cE5DZVpsTGR4bFNzNjVXR09hRlNUMUJHajRUMTBtUEZETHgxNndpcVZabVh5?=
 =?utf-8?B?cVNLZmI1dTF2V0VkMlY0VnRuVEE5UjRIV0JISXVPcUgwZmN5bXJ0cXZiUWU1?=
 =?utf-8?B?MCtWZCtVVjVzS1ZLcldPNXNLMW4yaUFwRWhrSW5RckRtMnhTaU9kL2d4TjBa?=
 =?utf-8?B?bFE0NzV0VjU3cUtPQjZZZ0VObkUzS095bENBSE8rVENjR3pGK2hHR1Vzc1or?=
 =?utf-8?B?WjdmN0ZMQ2VScWxSNUw4NldieUJId1h6ckxwbFczb3AvaTVaelRuV3c4QUxp?=
 =?utf-8?B?M1cxUW9aM3VRMUlGYzJLYXJHV3dYeXNKRWk2Tjh3K2tmUTlENFI4bWlJRk83?=
 =?utf-8?B?eGtqWHRtSm1SNW8yRmE1Vk56cmRTbXFEclUwc1R4UzJmZHhyTDlwc1I2bXRv?=
 =?utf-8?B?YktMZnludEFmZTIrREJ3U0RjU2VHbjN1T29vZGxoN0JhR0hWd1FFTi9mWFRj?=
 =?utf-8?B?Wmh0ZzUvbEZYdWN1NU5valJJUUhLNVFOK2dubHQ2VGIxTXFsOHFyZ2tBYis2?=
 =?utf-8?B?WVlQbW1GeDYzZ3lxb1ROZ3hmbFZVQTI4S0FuRUV2OXFFdFY0eDdnY094c2Fo?=
 =?utf-8?B?V0hqZGUwbGZORVJZcXNOUkc1Rk1YK1FVdG9WR3J1WTRCVXJxUXorVjIzV2E5?=
 =?utf-8?B?ckIvK0h0bkVzODFIaG5JczgvV3huT0ZwMEdGVnZpOTUyQ3laT3dIMURyd2cw?=
 =?utf-8?B?MWpqc0l2WVFwSVl1NHdoNlpqamdzazBhSXcyZ3lBWnBldEI4NW5xeGNDV0hD?=
 =?utf-8?Q?pDPo4SDh+kJ+lHjy3oL5yD9Me?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482d2889-3a6e-42dd-0082-08dafb382a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 22:46:27.2751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSPYl90U+NFmbwm2+mQw2jomeIhwRHXSG09P4Iqi4jM6zJO6DRy31m4Ez9iFG0m+qovPOmIjerIrDssYBtSbqxVjXdZqP9sssZF225+9WD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiA+IERhbW4gc2hpdC4gVGhlIGVycm9yIHRyaWdnZXJlZCByaWdodCBzb29uIGFmdGVyIHlvdSBs
YXN0IGVtYWlsLiBJdCB0b29rDQo+ID4gdHdvIG1vcmUgZXJyb3JzIHVudGlsIEkgbGVhcm5lZCB0
aGF0IGlzIGEgZ29vZCBpZGVhIHRvIHNhdmUgaW4gbmF0aXZlIGZvcm1hdA0KPiA+IGZpcnN0LCBh
bmQgdGhlbiBhdHRlbXB0IHRvIGV4cG9ydCB0byB2Y2QgKHdoaWNoIHRlbmRzIHRvIGhhbmcpLg0K
PiANCj4gZG9oIQ0KPiANCj4gPiBUaGlzIHRpbWUgdGhlIGZyYW1lIGluIHF1ZXN0aW9uIHdhcyB0
cnVuY2F0ZWQgdG8gNCBieXRlcy4gVGhlIG90aGVyIGNhc2VzIGl0DQo+IHdhcw0KPiA+IGFsd2F5
cyB0cnVuY2F0ZWQgdG8gMjAgYnl0ZXMuDQo+ID4NCj4gPiBUaGUgcmVnZHVtcHMgd2VyZSB0YWtl
biBxdWl0ZSBhIHdoaWxlIGFmdGVyIHRoZSBlcnJvci4NCj4gDQo+IEkgbWFuYWdlZCB0byBsb2Fk
IHRoZSBWQ0QgaW50byBwdWxzZXZpZXcsIGRlY29kZSB0aGUgU1BJIGFuZCBldmVuIG15IG9sZA0K
PiBtY3AyNTF4ZmQgZGVjb2RlciBzaG93cyBzb21ldGhpbmcuDQoNClRoYW5rcyBmb3IgdGhlIGNh
cHR1cmVzIQ0KDQpUaGUgYmFkIGRhdGEgaXMgb24gdGhlIFNQSSBidXMgKGNvcnJ1cHRlZCBETEMs
IGV2ZXJ5dGhpbmcgZWxzZSBzZWVtcyB0byBiZSBvay4gU1BJIENSQyBpcyBhbHNvIGZpbmUgKG1h
dGNoZXMgdGhlIHdyb25nIGRhdGEpLiBUaGUgY2hpcCBzZW5kaW5nIHRoZSBmYXVsdHkgRExDIGlz
IGJ1c3kgYXQgdGhlIHRpbWUgd2l0aCB0aGUgQ0FOIENSQy4gV2lsbCB0cnkgdG8gcmUtY3JlYXRl
IHRoZSB0aW1pbmcgYW5kIGZpbmQgb3V0IHdoYXQncyBnb2luZyBvbi4NCg0KVGhvbWFzDQo=
