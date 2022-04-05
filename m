Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3104F4587
	for <lists+linux-can@lfdr.de>; Wed,  6 Apr 2022 00:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbiDEOqc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Apr 2022 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386798AbiDEM6J (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Apr 2022 08:58:09 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30110.outbound.protection.outlook.com [40.107.3.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E60ED9C2
        for <linux-can@vger.kernel.org>; Tue,  5 Apr 2022 05:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5CeDXCKONMjDtpgK3st8olVyx2mGNvGccq09Dl92j1D/Q5uVJEwVuoJHe8JdNBPoOSitPU4k1s6TMztcDhGeT6QyW1MaYRHGFaEilpTdpkLjLvDxVaehpBhLhCKRPLQdWjjFmDs6DtD8ZJD2vnPmK4Y7XxUlUbbsmWDG/jDoO3jMfO1SAEMouWy9aftYsVldVgeVfVzeMEzHdJ91dumbXDE/9UAnw31LsUe5gnS2wg/m7g5xlHFv6pw7c+6xJqyHiX+BQtlne20NOEQicGChEXzw/b8iTejFREEiubURac4nL0oSYNFBwn74wbdYScvjJFoZPaVNjtz+eW299klmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWHV+wp2BYdNrBU8NgK0QH+d1SfsZ5yaeCGkEaOvb1Q=;
 b=YxeC7VNWuvyTMBrJVDzMAhPSjk3bDH8ZK8imtAYdE8v93grcbTABOMKVR2MLPnMxIs2mr/cI/nkrTlMYXK9qHfAKDRokFL/xGUJjnnyuCvPxUfSYqe+fZ2qNXCSyppukWfVSR3vAeSjZVNVWTqkvb38ALVYG7iBpAOPudjI94RXIukQA2s6PEBPsU0bEwf1Z6O+0K0ftb8SZKU1azSau0uVN/UJXNgmz5qPaWyERU9t/mgVxvW5C9tDZOENVMAqgjyuBRZHCu2lX0Kc5VU9v9jSZqe7KJUSSGptD3urgVKX4Lh6rPVAoIwF4kKqH9wFJGY4jxNGkQVSZgsoF0EHvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWHV+wp2BYdNrBU8NgK0QH+d1SfsZ5yaeCGkEaOvb1Q=;
 b=MquR29eqU2N/JBYlWKodJR9dMJmsFn8JetSBpoNPQBqGoiekp6rVtkNl4n0TVoy0parNCfN03uIbQg9TAaYTKwK5P6g+fenWmsOnodVMJL+zaO4r1R1RIntDMDLKE0ewC/2wam3JGSn0bo86QE8i9LgTiB8w1S3VviIS4/AVXWA=
Received: from AM0PR02MB5923.eurprd02.prod.outlook.com (2603:10a6:208:187::17)
 by DB9PR02MB6955.eurprd02.prod.outlook.com (2603:10a6:10:1ff::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 12:02:09 +0000
Received: from AM0PR02MB5923.eurprd02.prod.outlook.com
 ([fe80::ec30:e2aa:61fb:7f3e]) by AM0PR02MB5923.eurprd02.prod.outlook.com
 ([fe80::ec30:e2aa:61fb:7f3e%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 12:02:09 +0000
From:   Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
To:     Marc Kleine-Budde <mkl@blackshift.org>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: PROBLEM: tcan4x5x nINT stays asserted under high RX/TX interrupt
 load
Thread-Topic: PROBLEM: tcan4x5x nINT stays asserted under high RX/TX interrupt
 load
Thread-Index: AdhFyuJj1zOoVQ3MQF6tNgMHZCJ37QBfrqgAAGa3FZA=
Date:   Tue, 5 Apr 2022 12:02:09 +0000
Message-ID: <AM0PR02MB59236CF6507DD614F60D078FEAE49@AM0PR02MB5923.eurprd02.prod.outlook.com>
References: <AM0PR02MB592368F53A7BEA4154D24A87EAE09@AM0PR02MB5923.eurprd02.prod.outlook.com>
 <20220403105730.fnurim5vnnuxb7s5@pengutronix.de>
In-Reply-To: <20220403105730.fnurim5vnnuxb7s5@pengutronix.de>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prodrive-technologies.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5db8487-1989-40ff-12b4-08da16fc1ccf
x-ms-traffictypediagnostic: DB9PR02MB6955:EE_
x-microsoft-antispam-prvs: <DB9PR02MB695578F90692868647CA44C7EAE49@DB9PR02MB6955.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aFjowuacF9wDF/r31IQaovSaTqmbkYcegUEgW5wSvpeX5hjL7yCyslxpVCcdlveDImNPxRdO4bsSadwhBp4khJ+4RXusIpY2RqAxe9PVJUpyfYzHKm4VGrcvsWRdr6uAkOrhlHxo5gpCpA5Onxr4BH/wvJr3kAyQMuYwz4nbzbGc2n3gA0ePRSkGZ5E6a4BbHnkBw2li0w0wNBuQ7dZmxQd9Cfrll9Wrst9VlVOqiRAJ5sTE+B7kVcQzgHhZ/H1XUAIMr2ep5IT/q1VDDPKnLbyOuqbfJQXoYFS8P0SY/poBhmDEvIO83pO8/bGjigfbCCA2kaSbu4Hnzs/PpLgHWM7mfbVmGkhaqPrJdZVIk0t1CVhLejpQ6vOoI32PWHKjxbu7Hs9/BgA7KY3NOqTK1k+7a8zK6c0yNSOYSeNaiPRQZvSeneWMzcFuTd9KYeLNsH58HzFtWdUo4QmUf0bUa8MToviciTyKE7ZNoPJ+FIY1t9sr867/jT6WKLLjIA0CWjUC9Wx+5qmZPbqcl2yaOcWg0lIxqndlQHbhcgH8S5l0P4eZt3+4qC5llMUdycJ9h23kYeujVOzRVVDiSaE9qtYiDZkbpJqUunvC+JKOqaW4NfugZ8VX731QEriTPgXohvXnTxlbXTP8rtXoC/RGtIQwAV1GRniwNY/8A9L3wbHkKTN1s9kYTl9WXOqoHKGNuTczzcr+roU4Q2ZhbxEekTjwclkhLIJsT2yf0wdFOPtPa4e9F7Io/da8z0+SVSBIAvAZBfb0RjtLL6wMGUIdgBYlkaHB53E1JgyeM4/+JJY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5923.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(66476007)(6916009)(4326008)(64756008)(55016003)(71200400001)(966005)(186003)(66446008)(66946007)(76116006)(26005)(33656002)(83380400001)(8676002)(66556008)(508600001)(53546011)(7696005)(6506007)(38100700002)(2906002)(8936002)(5660300002)(52536014)(38070700005)(122000001)(86362001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW1sanl4L0VSS0ltUm41ODRrNHYrSDRzNjMwV2RYemM0T1B3YUgzYXVXYzln?=
 =?utf-8?B?QkVjSVNWcnJUK1NUdHAvOVhKZFlkSnBZZGkvUUtKL1g3NEd2enVjN0RzYlU1?=
 =?utf-8?B?dTZWRWpDTFgyQUh6NWRoc0ZHSTRPUUUrMXBmMVRWRWdxS0Z5clo1Z1BjbzFJ?=
 =?utf-8?B?NXVDZ3F1U2VKMTJ4VE9GV0k5NzZuZFdkMGtpUjQrL0FRZUNKZUN3cUtwZUY1?=
 =?utf-8?B?aTJ2NklmMHVPRmRZRnJ1OEY1UVZXeFc0emdONGFmQ0oyUXlPclZhVXpnNnZT?=
 =?utf-8?B?MVliUzJiWG9CTzZtWTU3ZjcrRStpMW5TSUNIdnVQcU5TekVrVmROUGpqT01K?=
 =?utf-8?B?UEVkemVGSCt6Y0xDOTVtYW5EZFMyNTFPODFCUkxUSGxyYTRlQ1Z3V3NrOThw?=
 =?utf-8?B?N0xHb3pHWGZDVnlqcTZILzNCdmZYUHpiMUg4UDdNMXBkL3BLVkFjWHFKNDcy?=
 =?utf-8?B?ckVaSDVNWmZOclJoUnNlU0tKd09jeU9uNHRZOUJ0d1Z2OTk1Nk14SStiYmpK?=
 =?utf-8?B?bzJZNzk3U1gxMW9pN1M3cEMvQkgrUzBzQmJhSFhxeXFDZC9Fc1FDcjhWTEt3?=
 =?utf-8?B?V2RXbXdUQi8rREN4amJ6ZWZ5Q3JVL1ZsMXBDMlREM2Q4bVdnRTArbXdVMjly?=
 =?utf-8?B?eUsvWjdBd29acjgrR2V5N1UvTERJM3dZcVZVdk5MdENJNkhmRXhMcE1VZmN5?=
 =?utf-8?B?N0NBWmNwblZZd2tXRytrOXUvNS9xYjBEZ25leStJOHRmRTVVSmdac2dtSXVI?=
 =?utf-8?B?S0RBejBGc3ZNNUxOMkxsMlI2TUNHZUZGdDI0Skt4aDNkQkh0ZFRSeG5JQTNa?=
 =?utf-8?B?dzM4d2Zqb0FCVU95RjBkUGFCdzhLbTVhalpPWERXVVZkd1Yyb2Y0S0poanJy?=
 =?utf-8?B?LzYyRGFobkcxMkRqdG5UZFptYjRURFZmTHlIMEJhMTBDTTh3MkpPeDZDR1Ru?=
 =?utf-8?B?NXVFOThjKzRGR2dmT2hNb2llWFBzeEh5ZGl2M2RURFROa1V6TWdVVE5LeEpm?=
 =?utf-8?B?OFh3a0RhT1NFYlZZblQ4K3JNQnNBOVByd3VwSm90dWRTWUMvTUREQ1J2NEFG?=
 =?utf-8?B?SStLK1pXZS9vcFFQbmZ2QnJvanJYNGp3NkQzTlpDdlc3OFFNQkEwZDRtNEtn?=
 =?utf-8?B?RkorR0J2UlVOZW1vODFxM0k1TDl1aTJwKzh1UGtKa2lRc21HdGViMkl6b2RE?=
 =?utf-8?B?Snl1TmwxdWxwMXJiQlVZWlhqNVg4VUxJZ28rVGdabTJGQ1ZqUUVhRlZvQjBi?=
 =?utf-8?B?a2pJalFidUlLU2gyZGdmc0lNUXlDNVZkRkMyNUpnd0J1N09NMzh4OVgrdSsv?=
 =?utf-8?B?bjMwNjdMU0NOL3k2UXYvdVVjUTlkMlBNRzh4bithVWR6UUw3YjY0eDhSQ0Yv?=
 =?utf-8?B?RFBOQ3F3ZFN5bTN3My83UzhXRzFVU2lMamRiZ3ZKL0FMcHJyRkU0RjdJNG5B?=
 =?utf-8?B?L3M1bXgrQWhGeHN2aVdYc21PeWRoL2d4dXJxaEdvMjJuTGUyTlJkZHVYbjRC?=
 =?utf-8?B?OGx0dE0vU2dpZFZWdEdQbVNJZXczM3VUQUw5V3RSaFZrQnY1VVFrTkNUdGNH?=
 =?utf-8?B?MGlHWCtMaTRlUnF6djMweXNEdDJpTVgzalhZVGdMMUlqa0V6NGZ5VEhNWDc0?=
 =?utf-8?B?ell3ZHJkM2JKWDhmQVN2TVkydDU5TUZva0EzUHVMRERHbTFhdVlZRy9NVE05?=
 =?utf-8?B?bzZxMDdnNDhJV0NxVmVXWG4vOWZDV1VIUDRJazhhc004ajJxQXg3MU9HY0FY?=
 =?utf-8?B?b3B1USs4QU0rK2FYdURCWElWa21Ca04wVHFnS3RQL0RFVzRIcVRRTk1wSjI2?=
 =?utf-8?B?NmtOeDdrNWhlMHBiWm0xNnRiSjlsaXhZYk53VFAySCs3bU5BT0pQNTFuU29M?=
 =?utf-8?B?TjlkcjNnK1BIZHoyRWd4UlY3Mmdldk5UNVd3Tm4wd1NUK3BrR3VJNFhmZlhS?=
 =?utf-8?B?YVNMN0E5bllwN1FLeVYxUjNJeHBFNVY2L2ZKdm1ONjJEaTgwQnVENHJVTlZs?=
 =?utf-8?B?TVpCQzlkVXJadXhab0VEM1FMTVl4djFNMHQyTnJDZUFMNjBIV3p6dWpibHZx?=
 =?utf-8?B?TER6T0ZWQ1dtZTZLVGxVWDVYTVFibHplb0pTNGM5RTh3MFBjMk4yM0xsZkVV?=
 =?utf-8?B?K2tDaG5xakFYc2NVZDFpQ1cydXg2S1BEUlBELzNRYWNqbTc1d09MQmJMY2ta?=
 =?utf-8?B?SWsyV2tpZ3VtV2ozeVRWbGRmUTY5dFV2SHJXeEc2M01ReUpialBjdHl6VXp1?=
 =?utf-8?B?RnEwalhPc2JOajdjdkdZZVV1TnpwcTFOSEZPWjhsZU9kNlVyQURlLzBTcU1r?=
 =?utf-8?B?VlZBdXd0VnYwQ0NSZ0VBbXIwZVlQa3FJVERtNjVtaHhvMnB4dGV2dGl4N1o1?=
 =?utf-8?Q?K2kAvaBq2IL5hkT/NB3PUtEn9HOWp0HUc8OuNZYahyDHa?=
x-ms-exchange-antispam-messagedata-1: tehhKuYS1J7bjQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5923.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5db8487-1989-40ff-12b4-08da16fc1ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 12:02:09.6936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haw07v6NinnexDtQPGdp4V9riPw/gCNA7vE+Mz01OPgqT0B3c2UyamJmmAzxB2UmfSGyO+LGt9BLkszlZhglEQZqfPT4W1GL1SzK0Jbz4iocMEKLqDdieT5enAdLt+Y329sDPXle3Lq4lrdA+iTvXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6955
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gTWFyYywNCg0KSSB0ZXN0ZWQgdGhpcyBvbiBhICh2ZW5kb3Igc3BlY2lmaWMpIDUuNC4y
NCBrZXJuZWwsIHdoZXJlIEkga25vdyB0aGUgcGF0Y2ggaXMgdmFsaWQuDQpJIHdvbid0IGJlIGFi
bGUgdG8gdGVzdCBpdCBvbiB0aGUgbGF0ZXN0IG1haW4tbGluZSBrZXJuZWwgb24gc2hvcnQgdGVy
bSwgZHVlIHRvIGJvYXJkIGJyaW5ndXAgaXNzdWVzIHdpdGggdGhpcyBrZXJuZWwgYmFzZS9yZXZp
c2lvbiBjaGFuZ2UuDQpIb3dldmVyLCB0aGUgcGF0Y2ggaXRzZWxmIGlzIHF1aXRlIHRyaXZpYWwu
IFdoYXQgZG8geW91IGFkdmlzZT8gRG8geW91IHByZWZlciBhIHRlc3RlZCBwYXRjaCBmb3IgNS40
LjI0LCBhbiB1bnRlc3RlZCBwYXRjaCBmb3IgNS4xOCwgb3Igb3RoZXJ3aXNlPw0KDQpNZXQgdnJp
ZW5kZWxpamtlIGdyb2V0IC8gS2luZCByZWdhcmRzLA0KDQpXb3V0ZXIgdmFuIEhlcnBlbiANCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xA
YmxhY2tzaGlmdC5vcmc+IA0KU2VudDogem9uZGFnIDMgYXByaWwgMjAyMiAxMjo1OA0KVG86IFdv
dXRlciB2YW4gSGVycGVuIDx3b3V0ZXIudmFuLmhlcnBlbkBwcm9kcml2ZS10ZWNobm9sb2dpZXMu
Y29tPg0KQ2M6IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBQUk9CTEVN
OiB0Y2FuNHg1eCBuSU5UIHN0YXlzIGFzc2VydGVkIHVuZGVyIGhpZ2ggUlgvVFggaW50ZXJydXB0
IGxvYWQNCg0KSGVsbG8gV291dGVyLA0KDQpPbiAwMS4wNC4yMDIyIDEzOjIzOjQzLCBXb3V0ZXIg
dmFuIEhlcnBlbiB3cm90ZToNCj4gV2hlbiB1c2luZyB0aGUgdGNhbjR4NXggdW5kZXIgaGlnaCBs
b2FkIG9mIGJvdGggUlgvVFggaW50ZXJydXB0cywgYXQgDQo+IHNvbWUgcG9pbnQgdGhlIG5JTlQg
c2lnbmFsIHN0YXlzIGFzc2VydGVkLCBjYXVzaW5nIHRoZSBzb2NrZXQgdG8gYmxvY2sgDQo+IGlu
IHVzZXIgc3BhY2UuDQo+IA0KPiBUaGlzIHJlcHJvZHVjZXMgdmVyeSByZWxpYWJseSAoaW4gbXkg
c3lzdGVtKSB3aGVuIGJvdGggcmVhZGluZy93cml0aW5nIA0KPiBhdCAxbXMgaW50ZXJ2YWxzIGF0
IENBTiBidXMgc3BlZWQgMU1icHMuIFdoZW4gaXQgb2NjdXJzLCBNX0NBTl9JUiBpcyANCj4gc2V0
IHRvIDB4NTgwZCBhbmQgbmV2ZXIgcmVjb3ZlcnMgKGNhdXNpbmcgbklOVCB0byBzdGF5IGFzc2Vy
dGVkKS4gVGhlIA0KPiBwcm9ibGVtIGRvZXMgbm90IG9jY3VyIHdoZW4gb25seSByZWFkaW5nIG9y
IG9ubHkgd3JpdGluZy4NCj4gDQo+IEFmdGVyIGNoZWNraW5nIHRoZSBtX2Nhbl9pc3IoKSBmdW5j
dGlvbiBmcm9tIA0KPiBkcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYywgSSBub3RpY2VkIHRo
YXQgTUNBTiBpbnRlcnJ1cHRzIGFyZSANCj4gZGlzYWJsZWQgd2hpbGUgcHJvY2Vzc2luZyB0aGUg
SVJfUkYwTiBmbGFnLCBidXQgbm90IHdoaWxlIHByb2Nlc3NpbmcgDQo+IElSX1RFRk4uIEknbSBu
b3Qgc3VyZSB3aHksIGFyZW4ndCBib3RoIGhhbmRsZXJzIHJ1bm5pbmcgZnJvbSB0aGUgc2FtZSAN
Cj4gaW50ZXJydXB0IGNvbnRleHQgYW5kIGNvbW11bmljYXRpbmcgdG8gTVJBTSB2aWEgU1BJPw0K
DQpUaGFua3MgZm9yIHlvdXIgYW5hbHlzaXMuIFdpdGhvdXQgbG9va2luZyBkZWVwZXIgaW50byBp
dCwgdGhhdCBzb3VuZHMgcmVhc29uYWJsZS4NCg0KPiBJJ20gcnVubmluZyBrZXJuZWwgdmVyc2lv
biA1LjQuMjQgYnV0IEkgY2FuIHNlZSB0aGF0IGluIGUuZy4gNS4xNy4wIA0KPiB0aGlzIHN0aWxs
IGFwcGxpZXMuIFdoZW4gSSBkaXNhYmxlIGludGVycnVwdHMgZHVyaW5nIElSX1RFRk4gaGFuZGxp
bmcsIA0KPiB0aGUgYmxvY2tpbmcgc29ja2V0IC8gbklOVCBpc3N1ZSBpcyBnb25lLg0KDQpDYW4g
eW91IHNlbmQgYSBwYXRjaCBmaXhpbmcgdGhlIHByb2JsZW0/IFBsZWFzZSBpbmNsdWRlIGEgcGF0
Y2ggZGVzY3JpcHRpb24gYW5kIHlvdXIgU2lnbmVkLW9mZi1ieToNCg0KaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjUuMTIvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJt
aXR0aW5nLXBhdGNoZXMucnN0I0wzNTYNCg0KcmVnYXJkcywNCk1hcmMNCg==
