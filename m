Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EA12160D
	for <lists+linux-can@lfdr.de>; Fri, 17 May 2019 11:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfEQJMN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 May 2019 05:12:13 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:29971
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727620AbfEQJMN (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 17 May 2019 05:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5quRbpb2AiO8IdWtodTyDMhtx7D/qLrnydAGOppMLoo=;
 b=Yu1Fk/dwPgznXhrGuALgxGNtzfxxk+NXqXtgtcRXB9fg2ZzM53hRNa9ESUtvVSv6Iua/EfFwx6U4xKCTCKzT93mVkIDlbxG9Tnn3VvRig+cZe/VsYE/wB/wajmaTHajBGFbP/JaZc9KVFaSEdd6yiO43PYw3Pbiw+4Ki246FhXc=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2205.eurprd04.prod.outlook.com (10.166.43.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.14; Fri, 17 May 2019 09:12:07 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf%7]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 09:12:07 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Documentation: can: flexcan: Add flexcan clocks'
 information
Thread-Topic: [PATCH v2 1/2] Documentation: can: flexcan: Add flexcan clocks'
 information
Thread-Index: AQHVC78Yo2UbMSbYHkCzxz1nr7Sue6Zug0gAgACFGWA=
Date:   Fri, 17 May 2019 09:12:07 +0000
Message-ID: <VI1PR0401MB2496DF6A7D91789C723D8014F10B0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190516133556.15872-1-pankaj.bansal@nxp.com>
 <20190516133556.15872-2-pankaj.bansal@nxp.com>
 <DB7PR04MB4618432A6FFDE8FDCC5DBAC3E60B0@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4618432A6FFDE8FDCC5DBAC3E60B0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.120.0.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23065c55-cb88-4c42-ae96-08d6daa7bc7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2205;
x-ms-traffictypediagnostic: VI1PR0401MB2205:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <VI1PR0401MB2205729AE9F26C5DF2C7F227F10B0@VI1PR0401MB2205.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(13464003)(199004)(189003)(4326008)(81156014)(8936002)(110136005)(7736002)(966005)(74316002)(478600001)(81166006)(8676002)(6246003)(6436002)(53936002)(305945005)(2906002)(45080400002)(54906003)(9686003)(68736007)(86362001)(71190400001)(3846002)(71200400001)(66446008)(6306002)(229853002)(14454004)(6116002)(53546011)(66066001)(25786009)(11346002)(6506007)(102836004)(486006)(33656002)(44832011)(316002)(55016002)(256004)(476003)(66946007)(14444005)(66556008)(186003)(446003)(76176011)(99286004)(73956011)(7696005)(76116006)(66476007)(26005)(5660300002)(64756008)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2205;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: znss+J7pK/SExSKxSOE7lonO1Y07LdxqLRyhoS64sLcOJ6uXuTu+EWVNJfADq+qo/eL6gtQh+8/4apZbPkC/6kgUQaMEZuiOWENGk8Fy2urkD7CjwmJYap30ogg71Kl1XtUOGbWdKmzD2y2EYTjKVZspfMVYDXWdR7hNYZvRled6UVjIJxpFBHzdrJjiHFp71Z3/tNhsHkOWu+xCtJgbwACfkPxOi6q1BBSX9f//Z4A8OSwq62yNfCN6CfafZOhZVZHQ2G8Q3g6gGt2tzyeHpy9NhqnkpeS47cHTVS9vGWh+SCc/LK4yruC40mMY7lsfT696UpLQr1VLX5rcN40k1RwTfHi8gInfeN9AMIwTI9A4Z5saBtNRqOvJz5vuhBLlvciOuUGloNs1DdOs763/gf8rfcn60iLwK8v34B+ohc8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23065c55-cb88-4c42-ae96-08d6daa7bc7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 09:12:07.5010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2205
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9ha2ltIFpoYW5nDQo+
IFNlbnQ6IEZyaWRheSwgMTcgTWF5LCAyMDE5IDA2OjQxIEFNDQo+IFRvOiBQYW5rYWogQmFuc2Fs
IDxwYW5rYWouYmFuc2FsQG54cC5jb20+OyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47DQo+
IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0
bGFuZEBhcm0uY29tPjsNCj4gV29sZmdhbmcgR3JhbmRlZ2dlciA8d2dAZ3JhbmRlZ2dlci5jb20+
OyBNYXJjIEtsZWluZS1CdWRkZQ0KPiA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogbGludXgt
Y2FuQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUkU6IFtQQVRDSCB2MiAxLzJdIERvY3VtZW50YXRpb246IGNhbjogZmxleGNhbjogQWRkIGZs
ZXhjYW4gY2xvY2tzJw0KPiBpbmZvcm1hdGlvbg0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBsaW51eC1jYW4tb3duZXJAdmdlci5rZXJuZWwub3JnDQo+
ID4gPGxpbnV4LWNhbi1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBQYW5rYWog
QmFuc2FsDQo+ID4gU2VudDogMjAxOeW5tDXmnIgxNuaXpSAxNjoxMg0KPiA+IFRvOiBMZW8gTGkg
PGxlb3lhbmcubGlAbnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Ow0K
PiA+IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBXb2xmZ2FuZyBHcmFuZGVn
Z2VyDQo+ID4gPHdnQGdyYW5kZWdnZXIuY29tPjsgTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5n
dXRyb25peC5kZT4NCj4gPiBDYzogbGludXgtY2FuQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMS8yXSBEb2N1bWVudGF0
aW9uOiBjYW46IGZsZXhjYW46IEFkZCBmbGV4Y2FuIGNsb2NrcycNCj4gPiBpbmZvcm1hdGlvbg0K
PiA+DQo+ID4gVGhlIGNsb2NraW5nIGluZm9ybWF0aW9uIGlzIG1pc3NpbmcgZnJvbSBmbGV4Y2Fu
IGRldmljZSB0cmVlIGJpbmRpbmdzLg0KPiA+IFRoaXMgaW5mb3JtYXRpb24gaXMgbmVlZGVkIHRv
IGJlIGFibGUgdG8gdXNlIGZsZXhjYW4uIERvY3VtZW50IHRoZSBzYW1lLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUGFua2FqIEJhbnNhbCA8cGFua2FqLmJhbnNhbEBueHAuY29tPg0KPiA+IC0t
LQ0KPiA+DQo+ID4gTm90ZXM6DQo+ID4gICAgIERlcGVuZGVuY2llczoNCj4gPiAgICAgLQ0KPiA+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxvcmUNCj4gPiAua2VyDQo+IG5lbC5vcmclMkZwYXRjaHdvcmslMkZjb3ZlciUy
RjEwMjQ1MzYlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q3FpYQ0KPiA+IG5ncWluZy56aGFuZyU0MG54
cC5jb20lN0M0MjYxNzU4M2QyYzI0MjUyMWE4ZTA4ZDZkOWQ2M2VlNyU3QzY4DQo+ID4gNmVhMWQz
YmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5MzU5MTE1MzQ0MDUxODEmYQ0K
PiA+IG1wO3NkYXRhPVVPQzdtSUhQc25aYksyNzQybVRqWWtMMyUyQm1DN0VxVVA0RTEyN1VNNWJX
WSUzRCYNCj4gPiBhbXA7cmVzZXJ2ZWQ9MA0KPiA+DQo+ID4gICAgIFYyOg0KPiA+ICAgICAtIFJl
bW92ZWQgY2xvY2stZnJlcXVlbmN5IGZyb20gb3B0aW9uYWwgcHJvcGVydGllcw0KPiA+ICAgICAt
IEFkZGVkIERlcGVuZGVuY2llcyBpbiBOb3Rlcw0KPiA+DQo+ID4gIC4uLi9iaW5kaW5ncy9uZXQv
Y2FuL2ZzbC1mbGV4Y2FuLnR4dCAgICAgICAgIHwgNDYgKysrKysrKysrKysrKysrKystDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2Fu
L2ZzbC1mbGV4Y2FuLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9jYW4vZnNsLWZsZXhjYW4udHh0DQo+ID4gaW5kZXggYTA0MTY4NjA1OTk4Li43M2M2MTZj
YTBmOWEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9jYW4vZnNsLWZsZXhjYW4udHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC9jYW4vZnNsLWZsZXhjYW4udHh0DQo+ID4gQEAgLTEyLDkgKzEyLDQy
IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gIC0gcmVnIDogT2Zmc2V0IGFuZCBsZW5ndGgg
b2YgdGhlIHJlZ2lzdGVyIHNldCBmb3IgdGhpcyBkZXZpY2UNCj4gPiAgLSBpbnRlcnJ1cHRzIDog
SW50ZXJydXB0IHR1cGxlIGZvciB0aGlzIGRldmljZQ0KPiA+DQo+ID4gLU9wdGlvbmFsIHByb3Bl
cnRpZXM6DQo+ID4gK0Nsb2NraW5nIGluZm9ybWF0aW9uIGlzIG11c3QgZm9yIGZsZXhjYW4uIHBs
ZWFzZSByZWZlciBiZWxvdyBpbmZvIGZvcg0KPiA+ICt1bmRlcnN0YW5kaW5nIGNsb2NraW5nIGlu
IGZsZXhjYW46DQo+ID4gKw0KPiA+ICvigKIgVGhlIEZMRVhDQU4gbW9kdWxlIGlzIGRpdmlkZWQg
aW50byB0d28gYmxvY2tzLiBDb250cm9sbGVyIGhvc3QNCj4gPiAraW50ZXJmYWNlDQo+ID4gKyAg
KCJDSEkiKSBhbmQgUHJvdG9jb2wgRW5naW5lICgiUEUiKQ0KPiA+ICvigKIgQm90aCB0aGVzZSBi
bG9ja3MgcmVxdWlyZSBjbG9jay4NCj4gPiAr4oCiIENISSBpcyByZXNwb25zaWJsZSBmb3IgcmVn
aXN0ZXJzIHJlYWQgd3JpdGUgaW5jbHVkaW5nIE1CIHJlYWQvd3JpdGUuDQo+ID4gKyAgV2hpbGUg
UEUgaXMgcmVzcG9uc2libGUgZm9yIFRyYW5zZmVyL3JlY2VpdmUgZGF0YSBvbiBDQU4gYnVzLg0K
PiA+ICvigKIgVGhlIGNsb2NrcyBmZWVkaW5nIHRvIHRoZXNlIHR3byBibG9ja3MgY2FuIGJlIHN5
bmNocm9ub3VzIChpLmUuDQo+ID4gK3NhbWUNCj4gPiArY2xvY2spDQo+ID4gKyAgb3IgYXN5bmNo
cm9ub3VzIChpLmUuIHNlcGFyYXRlIGNsb2NrcykuDQo+ID4gK+KAoiBTZWxlY3Rpb24gaXMgbWFk
ZSBpbiB0aGUgQ0xLX1NSQyBiaXQgKGJpdCAxMykgb2YgQ29udHJvbCAxIFJlZ2lzdGVyLg0KPiA+
ICsgIC0gQ0xLX1NSQyA9IDAsIGFzeW5jaHJvbm91cyBpLmUuIHNlcGFyYXRlIGNsb2NrcyBmb3Ig
Q0hJIGFuZCBQRQ0KPiA+ICsgIC0gQ0xLX1NSQyA9IDEsIHN5bmNocm9ub3VzIGkuZS4gQ0hJIGNs
b2NrIGlzIHVzZWQgZm9yIFBFIGFuZCBQRQ0KPiA+ICsgICAgICAgICAgICAgICAgIGNsb2NrIGlz
IG5vdCB1c2VkLg0KPiA+ICvigKIgSWYgdGhpcyBiaXQgaXMgbm90IGltcGxlbWVudGVkIGluIFNP
QywgdGhlbiBTT0Mgb25seSBzdXBwb3J0cw0KPiA+ICthc3luY2hyb25vdXMNCj4gPiArICBjbG9j
a3MuDQo+ID4gK+KAoiBFaXRoZXIgb2YgdGhlIGNsb2NrIGNhbiBiZSBnZW5lcmF0ZWQgYnkgYW55
IG9mIHRoZSBjbG9jayBzb3VyY2UuDQo+ID4gK+KAoiBXaGVuIHRoZSB0d28gY2xvY2tzIGFyZSBh
c3luY2hyb25vdXMsIHRoZW4gZm9sbG93aW5nIHJlc3RyaWN0aW9ucw0KPiA+ICthcHBseSB0bw0K
PiA+ICsgIFBFIGNsb2NrLg0KPiA+ICsgIC0gUEUgY2xvY2sgbXVzdCBiZSBsZXNzIHRoYW4gQ0hJ
IGNsb2NrLg0KPiA+ICvigKIgSWYgbG93IGppdHRlciBpcyByZXF1aXJlZCBvbiBDQU4gYnVzLCBk
ZWRpY2F0ZWQgb3NjaWxsYXRvciBjYW4gYmUNCj4gPiArdXNlZCB0bw0KPiA+ICsgIHByb3ZpZGUg
UEUgY2xvY2ssIGJ1dCBpdCBtdXN0IGJlIGxlc3MgdGhhbiBDSEkgY2xvY2suDQo+ID4gKw0KPiA+
ICtCYXNlIG9uIGFib3ZlIGluZm9ybWF0aW9uIGNsb2NraW5nIGluZm8gaW4gZmxleGNhbiBjYW4g
YmUgZGVmaW5lZCBpbg0KPiA+ICt0d28NCj4gPiB3YXlzOg0KPiA+ICsNCj4gPiArTWV0aG9kIDEo
UHJlZmVycmVkKToNCj4gPiArICAtIGNsb2NrczogcGhhbmRsZSB0byB0aGUgY2xvY2tzIGZlZWRp
bmcgdGhlIGZsZXhjYW4uIFR3byBjYW4gYmUgZ2l2ZW46DQo+ID4gKyAgICAtICJpcGciOiBQcm90
b2NvbCBFbmdpbmUgY2xvY2sNCj4gPiArICAgIC0gInBlciI6IENvbnRyb2xsZXIgaG9zdCBpbnRl
cmZhY2UgY2xvY2sNCj4gDQo+IFtKb2FraW0gWmhhbmddIEluIGZsZXhjYW4gZHJpdmVyIG5vdywg
ImlwZyIgaXMgZm9yIENISSBjbG9jaywgInBlciIgaXMgZm9yIFBFIGNsb2NrLg0KPiBJIHRoaW5r
IGl0J3MgdW5uZWNlc3NhcnkgdG8gZXhjaGFuZ2UgaGVyZS4NCg0KSW4gZmxleGNhbiBkcml2ZXIg
bm93LCBzYW1lIGlzIGNsb2NrIHN1cHBsaWVkIHRvIGJvdGggQ0hJIGFuZCBQRSBibG9ja3MgdXNp
bmcgQ1RSTFtDTEtfU1JDXSA9IDENCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1
LjEuMy9zb3VyY2UvZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYyNMMTM2NQ0KDQpBbmQgY2xvY2tf
ZnJlcSBpcyBiZWluZyBjYWxjdWxhdGVkIHVzaW5nICJwZXIiLg0KaHR0cHM6Ly9lbGl4aXIuYm9v
dGxpbi5jb20vbGludXgvdjUuMS4zL3NvdXJjZS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jI0wx
NTE1DQoNClRoZXJlZm9yZSwgInBlciIgaXMgdGhlIENISSBjbG9jayBhbmQgImlwZyIgaXMgUEUg
Y2xvY2suDQo+IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IEpvYWtpbSBaaGFuZw0KPiA+ICsgIC0gY2xv
Y2stbmFtZXM6IE11c3QgY29udGFpbiB0aGUgY2xvY2sgbmFtZXMgZGVzY3JpYmVkIGp1c3QgYWJv
dmUuDQo+ID4NCj4gPiAtLSBjbG9jay1mcmVxdWVuY3kgOiBUaGUgb3NjaWxsYXRvciBmcmVxdWVu
Y3kgZHJpdmluZyB0aGUgZmxleGNhbg0KPiA+IGRldmljZQ0KPiA+ICtNZXRob2QgMihOb3QgUHJl
ZmVycmVkKToNCj4gPiArICAtIGNsb2NrLWZyZXF1ZW5jeSA6IFRoZSBzeW5jaHJvbm91cyBjbG9j
ayBmcmVxdWVuY3kgc3VwcGxpZWQgdG8NCj4gPiArYm90aA0KPiA+ICsgIENvbnRyb2xsZXIgaG9z
dCBpbnRlcmZhY2UgYW5kIFByb3RvY29sIEVuZ2luZQ0KPiA+ICsNCj4gPiArT3B0aW9uYWwgcHJv
cGVydGllczoNCj4gPg0KPiA+ICAtIHhjZWl2ZXItc3VwcGx5OiBSZWd1bGF0b3IgdGhhdCBwb3dl
cnMgdGhlIENBTiB0cmFuc2NlaXZlcg0KPiA+DQo+ID4gQEAgLTQ3LDUgKzgwLDE0IEBAIEV4YW1w
bGU6DQo+ID4gIAkJaW50ZXJydXB0cyA9IDw0OCAweDI+Ow0KPiA+ICAJCWludGVycnVwdC1wYXJl
bnQgPSA8Jm1waWM+Ow0KPiA+ICAJCWNsb2NrLWZyZXF1ZW5jeSA9IDwyMDAwMDAwMDA+OyAvLyBm
aWxsZWQgaW4gYnkgYm9vdGxvYWRlcg0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwljYW5AMjE4MDAw
MCB7DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYXIxLWZsZXhjYW4iOw0KPiA+ICsJ
CXJlZyA9IDwweDAgMHgyMTgwMDAwIDB4MCAweDEwMDAwPjsNCj4gPiArCQlpbnRlcnJ1cHRzID0g
PEdJQ19TUEkgMjEgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKwkJY2xvY2tzID0gPCZzeXNj
bGs+LCA8JmNsb2NrZ2VuIDQgNz47DQo+ID4gKwkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7
DQo+ID4gIAkJZnNsLGNsay1zb3VyY2UgPSA8MD47IC8vIHNlbGVjdCBjbG9jayBzb3VyY2UgMCBm
b3IgUEUNCj4gPiArCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICAJfTsNCj4gPiAtLQ0KPiA+
IDIuMTcuMQ0KDQo=
