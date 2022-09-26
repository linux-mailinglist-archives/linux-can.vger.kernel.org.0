Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC325E9958
	for <lists+linux-can@lfdr.de>; Mon, 26 Sep 2022 08:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiIZGPn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Sep 2022 02:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiIZGPm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Sep 2022 02:15:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0284E19033
        for <linux-can@vger.kernel.org>; Sun, 25 Sep 2022 23:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664172938; x=1695708938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fLFiJBl30+pRAI6Y4uQe6GQbvjjMrzCEac8eFqguwl8=;
  b=kMzsnxa1TNNnGKQFcScm4UATk2KEkO5AP47GnryMZLHj8hVqds8g6NW1
   3cTG8uiWi+55H2jlAbByaFckDOGbxZFQcltecyPXYGr3n6EX2mkgzLJSe
   FlBd6qF0rsAeLO0QKbACRQ0gHBaFpKaa4mQSHbuZ3153ymXc4j3gaJ3cS
   PXcgdRYN0AUwfZEqthl1gGZH+6hyHAIADsPgiU9kH3zNh0VbU3lQP9lF4
   GH6MjhWt/tpBJmF0GPCl5HXes7H/GYg+m3PFqNAiiW9zmS5JyWprslpuy
   1BJQO64Nm8rnGAU+Z67JTbDfKqXslCi+D8IvmvTE1E2ScAjSlglqKlkUV
   A==;
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="115359604"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Sep 2022 23:15:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 25 Sep 2022 23:15:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sun, 25 Sep 2022 23:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmXT6J6OyDoKqx6hfoGmmN3W4JO5QDNwleYMEJrA0RKbxxxLHJ8YmzeaW/kqPyu+DPEh7NFz44GjsmI3/i9AnWM9XSLhIPXgLU4RW1kpvaqNVweFa/2yGs4UPn9q0sgRPkS1aVjQ38mj53Yc7Aa0MNy2bRPEkfY5zepVQ3ohHBYVJHHuYIUinOeCeT9k8yD7hdxfaJ1eiWq2sP6GcNgInBglq2tAZQoZxiW1LGPZ7n+Y0vx0aeM2Q2D8M+AxSeBDp+f8/aYdE/Ym49HxHV19KOY2ZCzgUVWaTnVqpqY+jMKaRDS9liqMP8JWn9yrN3BeP9He/xNMSxryOkxGGXdOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLFiJBl30+pRAI6Y4uQe6GQbvjjMrzCEac8eFqguwl8=;
 b=f3WtAcHk3WOH9w6RBAjep03usS02ukXeHX8VvAGlRyK7gZEatYxbqFyoC0dTYBZjH1gVp8Rm4Yck9GDFadFnMjN5oEhi6jhQQuHpE9rkzCyiLIGWs/UAeagWB4fczEvM7/OY6Cl0BH23mYNhesXX9P+D0jsOqN6suOt8L6QsdjshjaF7nEMGyBlqyVekEPzjiawrJySv64mj+a+HIjRBzg8nUdMDeabtSaEBRXGlNVLb/9XZqZF0mypDKA4uByeGnQj6IMDpcBJo7RxoLLx21HOrFIv1VmZQcMEZYGh71lXZbF2Qn86g2Hol/R9J4UKmcazcovgQGiVLSKWvvUF1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLFiJBl30+pRAI6Y4uQe6GQbvjjMrzCEac8eFqguwl8=;
 b=nFd1wNFbBrncFGIq/BOUknuBOuX0YRX3/h4xcKy9B1Qn11E93L4kjDpfV/mp6JzQLs5+uxK4JppO4lVBT82ltr7QNmt8EjJvfUPEKodKttLrP6xt+TDJ7aDjqG1bcGcKestT1fdLFJhKP5d6fSXkdHBjyGzPOqf3RSIfjTeyc6Q=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by MW4PR11MB6839.namprd11.prod.outlook.com (2603:10b6:303:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 06:15:31 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::f173:80f3:e137:636f]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::f173:80f3:e137:636f%7]) with mapi id 15.20.5654.022; Mon, 26 Sep 2022
 06:15:30 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <mark@baggywrinkle.co.uk>
Subject: RE: [PATCH 5/5] can: bittiming: can_calc_bittiming(): use Phase Seg2
 / 2 as default for SJW
Thread-Topic: [PATCH 5/5] can: bittiming: can_calc_bittiming(): use Phase Seg2
 / 2 as default for SJW
Thread-Index: AQHYwqZka3m5utakhUurCga9Z9T8Y63UUyGwgAGh9QCAARVPgIAWLdPs
Date:   Mon, 26 Sep 2022 06:15:29 +0000
Message-ID: <BL3PR11MB6484C05BF35456E869AABFD9FB529@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
 <20220907103845.3929288-6-mkl@pengutronix.de>
 <BL3PR11MB64844BD45DE7FDE94BDE47BCFB419@BL3PR11MB6484.namprd11.prod.outlook.com>
 <871qsmt3mq.fsf@hardanger.blackshift.org>
 <20220909122947.sqbbpabrnft7jacs@pengutronix.de>
In-Reply-To: <20220909122947.sqbbpabrnft7jacs@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|MW4PR11MB6839:EE_
x-ms-office365-filtering-correlation-id: 9a1bd6b8-802e-46e7-9f03-08da9f86831a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: POaBWBKmA6qSHuouGSCYKp4HMIR5tBBmJoc0r71FZi9FUM0hakrKmgAuMlrtkS2xMfoTQJzX//JuN2v8pG1JhGAEYeNKKij12EWSkalEM4wuu2baYr15nGgky6O7tWBgfztywqIti2v/Ryk4z26tStPVlMo2p1PUxP8KA/D/Kvo4lpSy4G7GVtBnzG5U0FTgm5VYqK48vn7rhmFXDBzd5uPWXyAE3CNCC5I/IpsTJ9bVbdlrJAK9vN0PVnqd2nB1WqG+7txMZGIHHeUO58kcxgCiO5olGx+jXzq4now/K/hPoMw/O5NSH4ubnHdJSwxCKgCXtlzF3lvF69wE/vIvWIekQWKSZNaXlfcvDP9fk58dqQN3ebRL+JCAAkFAJfHfnDjSlxh0L0QoGViqLJ7lK6czua/RRTzIjGpHvZRWKPBq0AfCn1aSIgiGu7Kj0JlRNFtV2Bx3AoM6VM781+FMMDPf1enpFC4pxcenmyowHwpe2laZiYUiweCdy0wqD/9MnTRFeE5+rd4kMGcuAwLtMkiai2qG8x9uLqKednF38wOuFXoGFqzRLWpckJHHKbcyGg+IB82s0h0dfxb/QvAN7cHPWmhZNOcmeR/IWwGIbdD7+aFsVw/KUf06/Fg+aO7B74r+z2h8APpPDVcJeUkGXcPUbWLOOqzIbBaYQhaZYXKNlrqaIWIIAqCeLZZ4vBDDRjlTSr+27625RfRtfb/s7Obkb+evFu9NjpYj2EBBk3MlcXVtZoDq081rBxmKV76jFO1/eqx90Htumm2PT4W+WQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199015)(8936002)(52536014)(38070700005)(86362001)(4744005)(2906002)(5660300002)(71200400001)(41300700001)(7696005)(186003)(9686003)(26005)(6506007)(478600001)(53546011)(6916009)(66946007)(4326008)(76116006)(122000001)(66556008)(66476007)(64756008)(8676002)(316002)(66446008)(38100700002)(54906003)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkhweFRPNGpmK2V5VU1lR3Bod3RMZXpNek53OCtvUDJmK1BXbE41M1FHRUtQ?=
 =?utf-8?B?cTAxdVBlVXRBSFI2cVIvN1ZueFM0Y0hRMnFaTnBNTWJQQlgxR0tGTzAzanUv?=
 =?utf-8?B?OVdWYWZId01QQlpXRUprRGx4TWI2RlAwRGIwTXZzL1NPeitXc3ZHbnpWNTVr?=
 =?utf-8?B?WU9JYlE1N3NvVVJyTk1oU1RkVERjc2FhU29hS1h4dkVUcGpSQWtHZkR6VVNP?=
 =?utf-8?B?WmNWcG9wMm84cjQ3Njl1Zm9wd3BwOElZN1RFRklvZFhTanRNV2NWeXE3RlBZ?=
 =?utf-8?B?N3VKVENxWHZadmhSUmJpQXljV0dxdmVlUTIvY041bWpnSGFpU012NzRiUlJh?=
 =?utf-8?B?b0JGTEpPY28xNUl0cXVibjFmd1krWWIrZ3RuZUdYelFtdkExTWJFOUY5U1lo?=
 =?utf-8?B?TWIyNGxxWUZyQXMrYUZ0dkxFTDZpQUcvUWUrdmp4UEZMZnZQbnFyQkEwR0hI?=
 =?utf-8?B?ekN4NTMrVElkVGt4T3VNRzdja1BQVnJCZ202VktET1RPMEdWcGJFaG02Umxq?=
 =?utf-8?B?L25VT3JsUHlYNWppczliR2dpbG1TY1RqVkp1MkVma243elhJVHJuYlkwbUxZ?=
 =?utf-8?B?WnF3NDdaWlhTUTJ5MXA0Q0RUMXh3bzVnNDN5MURRWmswaXc3TS9QYXdza2JI?=
 =?utf-8?B?N0lQNkVkdzBIMjF5bjdoYWhUUjhZQ2plTER3UDVybW9Oc1FoMTY3NGszSHNt?=
 =?utf-8?B?OHVueTA1STBJNDZnR1lZYUJ3dm5IeDgrN0xKWk5Ic1JnVElUbm14WERteGtF?=
 =?utf-8?B?bmdvSHRlV1hiTDdocTZVM3hjRHFpeTlHOHFkOWpYZ21BQWRncTZyNVlpNVlw?=
 =?utf-8?B?ZTVLM0UvWTZPbzlML0l4UGJZeHhhSjQ0ZFNIb1BzY0RiRFdjanZ3WkJ3d3Qr?=
 =?utf-8?B?SWJEVnhMUzh3UFpBSUJ5ZXU1LzlzS2pHeDNZUXl5TGVSaVY1MUM3RERSK1A4?=
 =?utf-8?B?Tm5Ma01JUGt6TEtLb1krNHU5V05XTmFEVWx3RHRScXRxVFprOFIrNXZWYVhK?=
 =?utf-8?B?NHRMVDB2UnhkQXlKc1Bia3h2c3MyTy9tVkJCODY2aXJJKzhYUFZ6Zk9KNlR0?=
 =?utf-8?B?Y01vVUR2THExT21EeThKRkJmZ0ZGQTZ4Q3RSWlVXVTZmdWdTN3pHZWQ5bjBv?=
 =?utf-8?B?OWNaM1hYRXIxbGcwUDdjQWc1SU1HR3NuTElTanBqVkNJSWIrWWQ2UWFvOG1i?=
 =?utf-8?B?djAzd3QrZHhTbTA3b1VCTkcxWGxoMUp0QUVURHY3YlpWTUtlV2YxT1hDN3Zl?=
 =?utf-8?B?S2orNC9DeVBHaE9XRmtsTnJzRVZrRGEwM3JWREhUalFGVTdxYURZSG1VMWlh?=
 =?utf-8?B?WGlTYTNsMnZuZG1yNit2UnhyTSs0STErcWFZV0ZDeGNKc2QvcFFqYlNwZ05B?=
 =?utf-8?B?VE1LcDJGZUlqTUFnTnE2QndYQVFieU5YcEZRazFabWxoLzFGN0NHYldtQnZY?=
 =?utf-8?B?cFdNYVpvL0d5QjR5NktCSFgwNW9NUXU2N0NoTzFwZGtWcEU0U0FMb3N4Q1Fh?=
 =?utf-8?B?aStzQUl5d3RKUzZUSlBrck9JcUJxMUx2RElVdTVlb2x4c1BYVmxMQ2VDUGJR?=
 =?utf-8?B?Z1c0Z3k5VzVGcDcrWHBsYjdUUjlSbXpaVk1DemcyREFuSjhBRmg3bkhVbUZp?=
 =?utf-8?B?WmxHbllyOXY4TTJOaDEyMzBKcEQ5UWt2TTJYQjFzc0E0Wms3aXoyZVI5NU5P?=
 =?utf-8?B?NUQ3eFRVK0g1cFRlN0ZoUU01eFhoK1BtdnRTTGF4NzRYcUFGS2hRN1R5ODYr?=
 =?utf-8?B?WEtBemVwOHhMSmZZODVzSkZ0cnJEbVcrSWY4WndmNGthQWdzS1pPM1FwNEdR?=
 =?utf-8?B?eG9Hc1R3WkZ4L0RMMXdCaWFnTUdlS0xBaENVMVVzejRGT0ZNZ2JyZUhwS1Fy?=
 =?utf-8?B?WTR4ZFc0NFA5L1lJRnBqbmkycFB5UzlWMlpUcEJEYzBTRjRlMUUyNk1sQVd0?=
 =?utf-8?B?U21uMnpBOW43UThhQTNiWDVxU09sS2R5V3BKaUdkZTRBT2FBN2tCTzh1dFps?=
 =?utf-8?B?eEFmTnVnVmlmZ0lHM0hKdEZ0eElvUlNMa0tFMUxhYWg3ZVJXek8rLzlJTkww?=
 =?utf-8?B?V0hYdVRZZ29pd1NMUDRnNFJNTFVzS2hUaWtCM2lQZHkzUm9BSVBMMXZMR2Z0?=
 =?utf-8?Q?nrohEP4+6mYRlzYAX7365hwtt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1bd6b8-802e-46e7-9f03-08da9f86831a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 06:15:30.0028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+4hyjnGa6tATY5Qi5pELh/dChjWG7/3xL3UqtMwLL0+JyKwFpL8G9oUU75RAHMkxZdrbkDtOk/Mi4RLBOecPo1SxQyFnAV0waETAss3oHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6839
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBPbiAwOC4wOS4yMDIyIDIxOjU3OjE2LCBNYXJjIEtsZWluZS1CdWRkZSB3cm90ZToNCj4gPiA+
IFRoYW5rcyBmb3IgeW91ciB3b3JrIG9uIHRoaXMhIE1heSBJIGFzayB3aHkgUGhhc2UgU2VnMiAv
IDIgaXMgY2hvc2VuPw0KPiANCj4gWy4uLl0NCj4gDQo+ID4gQW5kIEkgdGVzdGVkIHdpdGggU0pX
PW1heCBmcm9tIG1jcDI1MXggKG5vdCB0aGUgbWNwMjUxeGZkKSB3aXRoDQo+IFNKVz1tYXgNCj4g
PiB0byBhIHBlYWsgVVNCIGFkYXB0ZXIgd2l0aCBTSlc9MSAtIHRoZSBwZWFrIGFkYXB0ZXIgZmFp
bHMgdG8gcmVjZWl2ZSBDQU4NCj4gPiBmcmFtZXM6DQo+IA0KPiA+IFdpdGggU0pXID0gUGhhc2Ug
U2VnMiAvIDIsIGl0IHdvcmtzLg0KPiANCj4gQ29ycmVjdGlvbjoNCj4gDQo+IE15IHRlc3Q6DQo+
IA0KPiAgICAgVFggKG1jcDI1MTUsIDIwIE1IeiBPU0MpIC0+IFJYIChQRUFLIFVTQikNCj4gDQo+
IElzIGJyb2tlbiBbMV0gaWYgdGhlIFBFQUsgVVNCIHVzZXMgU0pXPT0xLCBpbmRlcGVuZGVudCBv
ZiB0aGUgU0pXIG9mIHRoZQ0KPiBtY3AyNTE1ICh0aGUgc2VuZGVyKS4NCj4gDQo+IFRoZSB0ZXN0
IHdvcmtzIGlmIHRoZSBQRUFLIFVTQiB1c2VzIFNKVz1QaGFzZVNlZzIvMi4NCg0KU28gZXZlcnl0
aGluZyB3b3JrcyBhcyBleHBlY3RlZCAob3IgZG9lc24ndCB3b3JrLCBhbHNvIGFzIGV4cGVjdGVk
LCkgdGhhdCdzIGdvb2QuIFNvLCBob3cgZG8gd2UgbW92ZSBmb3J3YXJkIGhlcmU/IEknZCBzdGls
bCBzYXkgbWF4aW1pemluZyBTSlcgaXMgdGhlIGJldHRlciB0aGluZyB0byBkbyBidXQgd2Ugc2hv
dWxkIGdldCBkZWZpbml0ZWx5IGdldCBpdCBpbmNyZWFzZWQgYW5kIGlmIFBTLzIgaXMgdGhlIGNv
bXByb21pc2UgSSBjYW4gbGl2ZSB3aXRoIHRoYXQodGhvdWdoLCB0aGVyZSBhcmUgbm8gZHJhd2Jh
Y2tzIHRvIFBTLzIgYmVzaWRlcyAiY29tcGF0aWJpbGl0eSIpLg0KDQpCZXN0IFJlZ2FyZHMsDQpU
aG9tYXMgDQo=
