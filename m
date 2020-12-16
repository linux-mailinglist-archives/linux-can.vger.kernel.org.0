Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C332DC8D2
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 23:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgLPWMG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Dec 2020 17:12:06 -0500
Received: from mail-eopbgr130134.outbound.protection.outlook.com ([40.107.13.134]:34341
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728756AbgLPWMG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 16 Dec 2020 17:12:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXGNx6R9YYS1qZogcBmgqMlFuGEp/gz1aGjVWiMdcpMhzEpaNtR2jHSlN0KbXq8yj44BrW7mraUANdBCyrl+MZ2t8ft0dphATWtmmGg+kBCRhjv4BvYVPd8aAe+HPTg33OEEJ0fySCNTWSrAvkGRbxoPbHbHD+juhV/hIgrDQVcCS/6QuEnRu2AXx6ucAbRFSSaslvPb7UqbDBhA28u+x8tJvHFmScJz4sq7ERtHkyrFYoeg5aImWcLJzTZ7p5pA22CeZijRkOe49/+NaLmd6dOvvvd3P3bOHE1PyHeb1ma0dLQXZuxsfc6VlfZMeC0mcMljqxK72+tVHQTrOD5fdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSXlZLREQOnjUNEMosx0FIDUygqnMkXpcrkbZA404tg=;
 b=LA4FZJNP8g8ihMXqmwK4GDhlu8YXBE8UHpk2hMwFBiKjEyXeFCtFW/zhp5Dqhn+daaLnEZO2DYCsjjXvOZh9EcX99iSGwYmGvUE9F8kH/Syr6ZJSYshbDPW+DXofaW5xaxBXR9bBBYvRdfMYBbkWLtxoZND30UYiZET28EqzbnFyeBIq3brhfhfrBnvA3+5rYtoL39YnnoZqdYS8st4F969Y65z5FuqFwqISNxgFRZzKrpQSsUqgj8S3DuB7A8SH7/htOly7/xCX57jbJTBY3o6OsUgbXm3E6wAxrs5+PlvdC2fGgRx632ho8fxDZdTC2QvDJ6WJqQHFxkSf3f9jTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSXlZLREQOnjUNEMosx0FIDUygqnMkXpcrkbZA404tg=;
 b=Rdzehk4BhzYpyqREpuFvG4kyTxbG/77yOtcQeWO1p1afi/4+abQ+ET59cE+qjQxvi1d2emqpVaDNm+JrpublCU+zztddpWx5m9wH+Xydbx0T54qYvTniG/Ma9lnNuvA1uMvD5qzRAF7v+93U9M2s8EK8ziqGjoZyHQV36HZUwas=
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:12d::21)
 by DBAP190MB0998.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Wed, 16 Dec
 2020 22:11:16 +0000
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::fc76:b821:1966:db40]) by DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::fc76:b821:1966:db40%6]) with mapi id 15.20.3676.025; Wed, 16 Dec 2020
 22:11:16 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: AW: assignment of spi to can channels
Thread-Topic: AW: assignment of spi to can channels
Thread-Index: AdbTmBm1lZbEHNKQRxyl9xCamZQMEQAFv+GAAAj51EAABbc5gAADgGnQ
Date:   Wed, 16 Dec 2020 22:11:16 +0000
Message-ID: <DB8P190MB063448143C2C8F7FE8457CFAD9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
References: <DB8P190MB06343276BF64CB3530DEB5D6D9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <32e1f29b-b16e-bc8e-e57a-92c67d45a335@pengutronix.de>
 <DB8P190MB0634B8626AEF0F14A653DC67D9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <f9538bbb-89a8-86b0-8e34-31150caee140@pengutronix.de>
In-Reply-To: <f9538bbb-89a8-86b0-8e34-31150caee140@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=schleissheimer.de;
x-originating-ip: [62.153.209.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c30b71f9-fd3a-4957-dd7c-08d8a20f823e
x-ms-traffictypediagnostic: DBAP190MB0998:
x-microsoft-antispam-prvs: <DBAP190MB09982C1FE159F4BC26A035A8D9C50@DBAP190MB0998.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vdkUwnlBE/pxboLKwNJE2+S9z74No7ZXesp7UZInejWiUNiJMmITv9fXoIQDitZT8a//l53u3T+T8AGLK62d2t42q6e+CZBURPiRoYSh1YM/yKKvMo1iixxCyG7+ee67Lj/uP45zAvHJOJe4OM0kFBYLsmiUrES6ztfsKjq15g3RdxDrbWk/gR5UnoWDfzLAqqclh2am+/55Rb1kbnE+WKZ/7WW15of8GSmW7Xxeri68xqGxmeqWk3ZvBhvV6yyUKeb6H3508Z6dEBjrfOAPgZbQ/Yk4s8Bq1OqpICWHzNdzwbAv0/VKopGY45YOgXacnouehwIaPZ6z8Ct1p7f2iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P190MB0634.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(346002)(39830400003)(316002)(8676002)(83380400001)(71200400001)(26005)(76116006)(66476007)(9686003)(186003)(7696005)(66556008)(66446008)(52536014)(55016002)(6506007)(66946007)(64756008)(5660300002)(33656002)(8936002)(110136005)(2906002)(478600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cUNnRlZMMDRWb1VYdGRoUGdpVGZvbmM5MnlXNHhISDJoaDFOcWh3VE53N3Fz?=
 =?utf-8?B?a2RhMS9RZ2ZRUnRaWHZVam81bGZnNTNSUHRiUkw3YzJ0cmE1UkwyRS9xQTlR?=
 =?utf-8?B?aURFajZUclF0dzlpdkIxYjJwTDZFZysxakNvSWl2NTdYMGFUeEp3MDl6Q1hm?=
 =?utf-8?B?ekhWenJnRlVkZ1FEZkE2OFZJbmM0VWlPMmRUK2dnMC9JVzlwdWdRWExtTU5J?=
 =?utf-8?B?VnlhMDJuZ1h3cDN3YmlKcVFhSDdlY3dtVy9nSVRGOGgyUHpqV0twSkFRcFF5?=
 =?utf-8?B?dXBkNzZGTWw1NzB0QUtDVlg1WVhndXBZbmNzVUpBamZQS0lidTBjWkNxZHdw?=
 =?utf-8?B?aUJNTnQvWGNaVHJRS09TSzhmV0tTTjBuU0xKNWFVQlNBNkxudkFQTmVRUWxS?=
 =?utf-8?B?WHpoNER3UVhZVjk0WDJRU3l0U0hhZ1MzVjRaZmJJL2k1UHdSQXFPYkp0U0xH?=
 =?utf-8?B?MG1RUEltODJyZ1Vlb2hLZHI0bFNMSkFFWWdJWGVXWUMxUmc2WWtVdkEraEFL?=
 =?utf-8?B?bThtaCtrSExWRWQvWTBVdU8yMTQ4TXJUSmNlaFJid2IrZ0w1bmdxK3hsT1FE?=
 =?utf-8?B?cHFzcUxtakhRNThldjhZU1NXdmhvQWNKMjE3T3habVhWK3orekZiQ0YxSTNM?=
 =?utf-8?B?aGdBTHlENkRIelpQT294UnAwck1hNmZ4VWx0TjF3N1pIVmdoeC9jMWZZRTB2?=
 =?utf-8?B?YkV2ejJoWS82R1JwVXVvdjk2ZXpXR3FrZkZXWFJIamhBdUd2QWxtWEhPN3hF?=
 =?utf-8?B?emRzWDE3TmlCbzZ5UlJNbzlHV1hlQXhtSGQrRU9FT2plYnBYQ3F5Z2pZRVd2?=
 =?utf-8?B?WkdSN1IwZTZGY29YVXcyZS9VakZGWHl3Wm9hcjNGQlJzSzg1UDRpWTc0SUcx?=
 =?utf-8?B?NHh6TjNwaWN6S2pZQmp3ME9QQ2ZSOHAwSUNoQ082YU9IMEpiUXJLclZmd1pq?=
 =?utf-8?B?OFA2Ujh4QnRVeVNKeWw4aVZWZHMvRjJsVk5tS2JkZi8zWEJmOFEvNEhPL0hX?=
 =?utf-8?B?a3krQnNjTHVvaU1xQUVBb20rZFdra3N3Tmx5RXdqMyszZU5mS1RpR0MwUm50?=
 =?utf-8?B?VVdoRURoZkIycFkvTVJPUG9Jb0dYSVducGRsZVdLWEdRTXFoV0g5UGVoYmtF?=
 =?utf-8?B?bFJzZVcyODdBdjRnamgyZ2Y2cTF5V1VXdWkzWGJqeExPc25CalRzQ2hSZkZm?=
 =?utf-8?B?ZWNmbEdtbSs3ZUc3NitHanlXTFBmenZ3bVBlOHlnRXdUdkJVRzB3Y1JibFRW?=
 =?utf-8?B?SzM0SjBuUTNvR2RsN0NPclJySncxSVk1UDNYeFp5NW1qc0dyRUJXcnRBa1dI?=
 =?utf-8?Q?qEzLe/HBdCOwk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c30b71f9-fd3a-4957-dd7c-08d8a20f823e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 22:11:16.5097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNly5atgAD5eKUzW2MBg+O2/OPeSCoTjhQw7xyGoeDIwmfhzuYdQgl48/DotRLIIzrmsioGad9b7BEXvcwkSr0RkJPjS2xsGmxoKj17BFu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0998
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjogTWFyYyBLbGVpbmUt
QnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gR2VzZW5kZXQ6IE1pdHR3b2NoLCAxNi4gRGV6
ZW1iZXIgMjAyMCAyMToyNw0KPiA+IGNyZWF0ZWQgL2V0Yy91ZGV2L3J1bGVzLmQvNzAtY2FuLnJ1
bGVzIHdpdGgNCj4gPiBTVUJTWVNURU09PSJuZXQiLCBBQ1RJT049PSJhZGQiLCBERVZQQVRIPT0i
L2RldmljZXMvcGxhdGZvcm0vc29jLyovKi8qL3NwaTAuMC9uZXQvY2FuPyIsIE5BTUU9ImNhbjAi
DQo+ID4gU1VCU1lTVEVNPT0ibmV0IiwgQUNUSU9OPT0iYWRkIiwgREVWUEFUSD09Ii9kZXZpY2Vz
L3BsYXRmb3JtL3NvYy8qLyovKi9zcGkxLjAvbmV0L2Nhbj8iLCBOQU1FPSJjYW4xIg0KPiANCj4g
Tm90ZTogSUZBSUsgdGhpcyB3aWxsIG5vdCB3b3JrIHdpdGggbmV3ZXIgdmVyc2lvbnMgb2YgdWRl
di4uLi4NCj4gDQo+ID4gYW5kIHRhZGFhYWFhOg0KPiA+IFsgICAgNi45MTc1NzhdIHNwaV9tYXN0
ZXIgc3BpMTogd2lsbCBydW4gbWVzc2FnZSBwdW1wIHdpdGggcmVhbHRpbWUgcHJpb3JpdHkNCj4g
PiBbICAgIDYuOTM2OTU3XSBtY3AyNTF4ZmQgc3BpMS4wIGNhbjA6IE1DUDI1MThGRCByZXYwLjAg
KC1SWF8uLi4NCj4gPiBbICAgIDYuOTU2NTIzXSBzcGlfbWFzdGVyIHNwaTA6IHdpbGwgcnVuIG1l
c3NhZ2UgcHVtcCB3aXRoIHJlYWx0aW1lIHByaW9yaXR5DQo+ID4gWyAgICA2Ljk3MTk0Ml0gbWNw
MjUxeGZkIHNwaTAuMCBjYW4xOiBNQ1AyNTE4RkQgcmV2MC4wICgtUlhfLi4uDQo+ID4gWyAgICA3
LjAwNjUxNV0gbWNwMjUxeGZkIHNwaTEuMCByZW5hbWUzOiByZW5hbWVkIGZyb20gY2FuMA0KPiA+
IFsgICAgNy4wNDE2ODFdIG1jcDI1MXhmZCBzcGkwLjAgY2FuMDogcmVuYW1lZCBmcm9tIGNhbjEN
Cj4gPiBbICAgIDcuMDkxNTYzXSBtY3AyNTF4ZmQgc3BpMS4wIGNhbjE6IHJlbmFtZWQgZnJvbSBy
ZW5hbWUzDQo+IA0KPiAuLi50aGUgInJlbmFtZSIgdHJpY2sgZG9lc24ndCB3b3JrIGFueW1vcmUu
IEJldHRlciB1c2UgYSBkaWZmZXJuZXQgbmFtZSwgZS5nLjoNCj4gbWNwMCBhbmQgbWNwMS4NCg0K
b2theSwgdW5kZXJzdG9vZCBhbmQgcmVuYW1lZDoNClsgICAgNi42NzM3MzJdIG1jcDI1MXhmZCBz
cGkwLjAgbWNwMDogcmVuYW1lZCBmcm9tIGNhbjANClsgICAgNi43MTYwNTFdIG1jcDI1MXhmZCBz
cGkxLjAgbWNwMTogcmVuYW1lZCBmcm9tIGNhbjENCg0KVGhhbmtzIQ0KDQogICBTdmVuDQo=
