Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 968C319887
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2019 08:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfEJGlH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 May 2019 02:41:07 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:47779
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726940AbfEJGlH (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 May 2019 02:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oxe6Sb0w6kfgHPpOBrOB4ueYPkNQsKGWkfotGGQgig=;
 b=QsUq0VFla+80SXMSdp3UU+De4RG+CEOrUCiRA1uin3TMXwC5xrKdUmK24yXnOa+whnnYc3HyOHU3dQ+zzpe0bF+CncBG/PgzNpCjsV2gMGDo1rQhu/v4Rsv6wcGlkSmLy83cPg7d599HMboMpI79RUHPs49omJVNV7504Aj/hCA=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4778.eurprd04.prod.outlook.com (20.176.233.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Fri, 10 May 2019 06:40:57 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::dcff:11e1:ab70:bb81]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::dcff:11e1:ab70:bb81%5]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 06:40:57 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH 0/4] net: can: flexcan: can FD Format (FDF) changes
Thread-Topic: [PATCH 0/4] net: can: flexcan: can FD Format (FDF) changes
Thread-Index: AQHVBvEs1Trfh85bgECGnx5+b6LwIqZj1Q6AgAALoQA=
Date:   Fri, 10 May 2019 06:40:57 +0000
Message-ID: <DB7PR04MB4618F64EF55054F0CB2A788BE60C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190510105137.27523-1-pankaj.bansal@nxp.com>
 <VI1PR0401MB2496B9C6F88EA090EA58A58EF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB2496B9C6F88EA090EA58A58EF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51059da3-acd1-4c08-63aa-08d6d5127558
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4778;
x-ms-traffictypediagnostic: DB7PR04MB4778:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB477885A230B26E11E2472BF6E60C0@DB7PR04MB4778.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(13464003)(199004)(189003)(305945005)(81156014)(52536014)(53936002)(7696005)(99286004)(7736002)(66066001)(6246003)(8936002)(68736007)(8676002)(76176011)(6306002)(76116006)(3846002)(6116002)(81166006)(2906002)(55016002)(9686003)(66556008)(476003)(66476007)(11346002)(446003)(14444005)(66946007)(73956011)(45080400002)(5660300002)(53546011)(6506007)(26005)(64756008)(186003)(102836004)(66446008)(486006)(14454004)(71190400001)(71200400001)(6436002)(478600001)(54906003)(86362001)(229853002)(966005)(33656002)(74316002)(110136005)(4326008)(256004)(316002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4778;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RPFWVuJMS531X06owAEzP2VPKX+yhGCImD3J7A5FoPC/5Tb4X7UGwfBXyrdoEET34svQ4BZ3pz6aVJzfMpMmfUJdo9znNAo7MtK7sy8NQgV74F6OW9GD/IMab0AxBWztkMbQpB37TTGDgKy8KPMXf4782AXK+DgmLpoPF2P/VGMfTvlvVTBLe9w9PDl+pOr0b8DSo3bVEYiNxub2zjebS0FYO5p8G/6YewGWy36QwfVX5435tC5t3SQJUA+tufmNR7fX2RryOtIz34oj2+OaK9kFl7hcVIhWHNgwz2oJPGCFgKIe0xocQK2tfx5nnAiNUXpGHLr6H8bZUKC5rD55vXu+2FKUgHdyBHUO2Wr0jwKKtvOyHvuyGb2toL6qzXAbYAskP6AuDwN+eBynbkfUZgp3DX5Op3CfLjd9AdGgs6w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51059da3-acd1-4c08-63aa-08d6d5127558
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 06:40:57.3277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4778
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQpIaSBQYW5rYWogQmFuc2FsLA0KDQpJIG5vdGljZWQgdGhlIGlzc3VlIHdoaWNoIHlvdSBtZW50
aW9uZWQgaW4gIltQQVRDSCAzLzRdIGNhbjogZmxleGNhbjogbW9kaWZ5IHRoZSBpbnRlcnJ1cHQg
cmVnaXN0ZXIgaGFuZGxpbmciLCBJIGFsc28gcmVwb3J0ZWQgYW5kIE1hcmMgaGFzDQpmaXhlZCBp
dCBpbiBsaW51eC1jYW4tbmV4dC4NCg0KQW5kIEkgbm90aWNlZCB0aGUgcmFuZ2Ugb2YgYSBiaXQg
dGltZSBtYXkgbm90IGNvcnJlY3Q6DQorc3RhdGljIGNvbnN0IHN0cnVjdCBjYW5fYml0dGltaW5n
X2NvbnN0IGV4dGVuZGVkX2ZsZXhjYW5fYml0dGltaW5nX2NvbnN0ID0gew0KKwkubmFtZSA9IERS
Vl9OQU1FLA0KKwkudHNlZzFfbWluID0gMiwNCisJLnRzZWcxX21heCA9ICo5NiosDQorCS50c2Vn
Ml9taW4gPSAyLA0KKwkudHNlZzJfbWF4ID0gMzIsDQorCS5zandfbWF4ID0gMTYsDQorCS5icnBf
bWluID0gMSwNCisJLmJycF9tYXggPSAxMDI0LA0KKwkuYnJwX2luYyA9IDEsDQorfTsNCisNCitz
dGF0aWMgY29uc3Qgc3RydWN0IGNhbl9iaXR0aW1pbmdfY29uc3QgZmxleGNhbl9kYXRhX2JpdHRp
bWluZ19jb25zdCA9IHsNCisJLm5hbWUgPSBEUlZfTkFNRSwNCisJLnRzZWcxX21pbiA9IDIsDQor
CS50c2VnMV9tYXggPSAqMzkqLA0KKwkudHNlZzJfbWluID0gMiwNCisJLnRzZWcyX21heCA9IDgs
DQorCS5zandfbWF4ID0gNCwNCisJLmJycF9taW4gPSAxLA0KKwkuYnJwX21heCA9IDEwMjQsDQor
CS5icnBfaW5jID0gMSwNCit9Ow0KDQpJIGRvIG5vdCBrbm93IGhvdyBtYW55IGJpdHMgb2YgUFJP
UFNFRyBhbmQgUFNFRzEgYXJlIExYMjE2MEEgcmVhbGl6ZWQuIA0KQnV0IGluIGkuTVg4UU0vUVhQ
Og0KQ0JUIHJlZ2lzdGVyOiBFUFJPUFNFRyg2IGJpdCksIEVQU0VHKDUgYml0KSBidXQgaXMgY2Fu
J3QgcmVhY2ggOTYNCkZEQ0JUIHJlZ2lzdGVyOiBGUFJPUFNFRyg1IGJpdCksIEVQU0VHKDMgYml0
KSBidXQgaXMgY2FuJ3QgcmVhY2ggMzkNCg0KWW91IGNhbiBjaGVjayB0aGUgY29kZSBpbiAvZHJp
dmVycy9uZXQvY2FuL2Rldi5jIGZvciB0aGUgcmVhc29uOg0KQ2FuX2NhbF9iaXR0aW1pbmc6DQp8
ICAgICAyMTEgICAgICAgICBidC0+cHJvcF9zZWcgPSB0c2VnMSAvIDI7DQp8ICAgICAyMTIgICAg
ICAgICBidC0+cGhhc2Vfc2VnMSA9IHRzZWcxIC0gYnQtPnByb3Bfc2VnOw0KfCAgICAgMjEzICAg
ICAgICAgYnQtPnBoYXNlX3NlZzIgPSB0c2VnMjsNCg0KTm93IEkgYW0gYWxzbyB1cHN0cmVhbWlu
ZyB0aGUgQ0FOIEZEIGZlYXR1cmUgZm9yIGkuTVg4LCBJIHdpbGwgc2VuZCBvdXQgdGhlIFYzLg0K
VGhlIHdheSBpcyBub3QgdGhlIHNhbWUsIHNoYWxsIHdlIGRpc2N1c3Mgd2hpY2ggaXMgYmV0dGVy
PyBUaGlzIG1heSBzcGVlZCB1cCB0aGUgcHJvY2Vzcy4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2lt
IFpoYW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtY2Fu
LW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtY2FuLW93bmVyQHZnZXIua2VybmVsLm9yZz4N
Cj4gT24gQmVoYWxmIE9mIFBhbmthaiBCYW5zYWwNCj4gU2VudDogMjAxOeW5tDXmnIgxMOaXpSAx
MzozNA0KPiBUbzogV29sZmdhbmcgR3JhbmRlZ2dlciA8d2dAZ3JhbmRlZ2dlci5jb20+OyBNYXJj
IEtsZWluZS1CdWRkZQ0KPiA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogbGludXgtY2FuQHZn
ZXIua2VybmVsLm9yZzsgVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhwLmNvbT4NCj4gU3ViamVjdDog
UkU6IFtQQVRDSCAwLzRdIG5ldDogY2FuOiBmbGV4Y2FuOiBjYW4gRkQgRm9ybWF0IChGREYpIGNo
YW5nZXMNCj4gDQo+IEhpIE1hcmMgZXQuIEFsLA0KPiANCj4gVGhlc2UgY2hhbmdlcyBhcmUgcGVu
ZGluZyBmcm9tIGEgbG9uZyB0aW1lIGFuZCB0aGUgcmVndWxhciBjaGFuZ2VzIHRvIGZsZXhjYW4N
Cj4gY29kZSBtYWtlIGl0IHZlcnkgaGFyZCB0byBtYWludGFpbiB0aGVzZSBjaGFuZ2VzLiBJIHJl
cXVlc3QgeW91IHRvIHBsZWFzZQ0KPiByZXZpZXcgdGhlc2UgY2hhbmdlcyBhbmQgbWVyZ2UuIEkg
d2lsbCBwcm9tcGx5IHJlcGx5IHRvIGFueSBxdWVyaWVzIHlvdSBoYXZlLg0KPiANCj4gUmVnYXJk
cywNCj4gUGFua2FqIEJhbnNhbA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IFBhbmthaiBCYW5zYWwNCj4gPiBTZW50OiBGcmlkYXksIDEwIE1heSwgMjAxOSAx
MDo1OCBBTQ0KPiA+IFRvOiBXb2xmZ2FuZyBHcmFuZGVnZ2VyIDx3Z0BncmFuZGVnZ2VyLmNvbT47
IE1hcmMgS2xlaW5lLUJ1ZGRlDQo+ID4gPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gPiBDYzogbGlu
dXgtY2FuQHZnZXIua2VybmVsLm9yZzsgUGFua2FqIEJhbnNhbCA8cGFua2FqLmJhbnNhbEBueHAu
Y29tPjsNCj4gPiBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0KPiA+IFN1YmplY3Q6IFtQ
QVRDSCAwLzRdIG5ldDogY2FuOiBmbGV4Y2FuOiBjYW4gRkQgRm9ybWF0IChGREYpIGNoYW5nZXMN
Cj4gPg0KPiA+IFRoaXMgaXMgbXkgc2Vjb25kIGF0dGVtcHQgdG8gYWRkIEZEIHN1cHBvcnQgaW4g
ZmxleGNhbi4gbXkgZWFybGllcg0KPiA+IHBhdGNoZXMgY2FuIGJlIHJlZmVycmVkIGhlcmU6DQo+
ID4NCj4gPiBbMV0NCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZ3d3cuDQo+ID4NCj4gc3Bpbmljcy5uZXQlMkZsaXN0
cyUyRmxpbnV4LWNhbiUyRm1zZzAwMzQ4Lmh0bWwmYW1wO2RhdGE9MDIlN0MwMSU3Qw0KPiBxaWEN
Cj4gPg0KPiBuZ3FpbmcuemhhbmclNDBueHAuY29tJTdDMDQxZWI1ODc5NjQxNDg5MjFiYmMwOGQ2
ZDUwOTI0NWYlN0M2OA0KPiA2ZWExZDNiYw0KPiA+DQo+IDJiNGM2ZmE5MmNkOTljNWMzMDE2MzUl
N0MwJTdDMCU3QzYzNjkzMDYzMjU3MDc1NTg3MCZhbXA7c2RhdGE9DQo+IDBEWTNoaVdiDQo+ID4g
VmdYTWZad1clMkIwZ2JBZmtTWHZJRnZ0T3lha2EzM0UxdUVicyUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
PiA+DQo+ID4gU29tZSBvZiB0aGUgcGF0Y2hlcyBmcm9tIGFib3ZlIHNlcmllcyBoYXZlIGFscmVh
ZHkgYmVlbiBtZXJnZWQuDQo+ID4NCj4gPiBUaGVyZSBoYXMgYmVlbiBhIHNpZ25pZmljYW50IGNo
YW5nZSBpbiBmbGV4Y2FuIGNvZGUgc2luY2UgaSBzZW50IGFib3ZlDQo+ID4gcGF0Y2hlcw0KPiA+
IG5hbWVseToNCj4gPg0KPiA+IGNvbW1pdCBjYmZmYWY3YWEwOWUgKCJjYW46IGZsZXhjYW46IEFs
d2F5cyB1c2UgbGFzdCBtYWlsYm94IGZvciBUWCIpDQo+ID4NCj4gPiB3aXRoIHRoaXMgcGF0Y2gs
IHRoZSBmbGV4Y2FuIEZEIHN1cHBvcnRzIGJyZWFrcyAoaWYgb25lIHdlcmUgdG8gYXBwbHkNCj4g
PiB0aGUgYWJvdmUNCj4gPiBwYXRjaGVzWzFdKQ0KPiA+DQo+ID4gVG8gZml4IEZEIHN1cHBydCB3
aXRoIGFib3ZlIHBhdGNoLCBpIGhhdmUgYWRkZWQgY2hhbmdlcyBpbiB0aGlzIHNlcmllczoNCj4g
Pg0KPiA+IDMvNDogY2FuOiBmbGV4Y2FuOiBtb2RpZnkgdGhlIGludGVycnVwdCByZWdpc3RlciBo
YW5kbGluZw0KPiA+DQo+ID4gVGhlIHJlc3Qgb2YgdGhlIHBhdGNoZXMgYXJlIGZyb20gb2xkIHBh
dGNoIHNlcmllcy4NCj4gPg0KPiA+IENjOiBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0K
PiA+DQo+ID4gUGFua2FqIEJhbnNhbCAoNCk6DQo+ID4gICBuZXQ6IGNhbjogZmxleGNhbjogdXNl
IENBTiBGRCBmcmFtZXMgZm9yIFR4L1J4DQo+ID4gICBjYW46IGZsZXhjYW46IG1vdmUgY2FuIHNl
dCBiaXRpdGluZ3MgYWZ0ZXIgbW9kdWxlIGNvbnRyb2wNCj4gPiAgIGNhbjogZmxleGNhbjogbW9k
aWZ5IHRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXIgaGFuZGxpbmcNCj4gPiAgIG5ldDogY2FuOiBmbGV4
Y2FuOiBjYW4gRkQgRm9ybWF0IChGREYpIGNoYW5nZXMNCj4gPg0KPiA+ICBkcml2ZXJzL25ldC9j
YW4vZmxleGNhbi5jICAgICAgfCAzMTYgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
DQo+ID4gIGRyaXZlcnMvbmV0L2Nhbi9yeC1vZmZsb2FkLmMgICB8ICAzMiArKystDQo+ID4gIGlu
Y2x1ZGUvbGludXgvY2FuL3J4LW9mZmxvYWQuaCB8ICAgNiArLQ0KPiA+ICAzIGZpbGVzIGNoYW5n
ZWQsIDI3NiBpbnNlcnRpb25zKCspLCA3OCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IC0tDQo+ID4g
Mi4xNy4xDQoNCg==
