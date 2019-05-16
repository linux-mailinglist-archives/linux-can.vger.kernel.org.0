Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B755C1FF72
	for <lists+linux-can@lfdr.de>; Thu, 16 May 2019 08:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEPGRe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 May 2019 02:17:34 -0400
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:39799
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfEPGRd (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 16 May 2019 02:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GldOmHvE2EGO44kckYf2qpl8iRZFRQh07Q2hDHq53I=;
 b=lnT1QMEFvSw6vqyxrufPvagni0nngx8AxBxO/q+ADHxC+DhbrFhKNxr87HtxdjcRt/kBGaX4YdJKffMsumYAxalL/Dsv32vPm/8JH8ahVU3PFsTRtX5IOZgF6Ap1OvF7kUglQom660VF3GZKzUarqFmCpRNu0QmBGk2zA9khnY8=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2494.eurprd04.prod.outlook.com (10.168.65.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 06:17:29 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::3d45:6b81:13ba:88cf%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 06:17:29 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/2] Documentation: can: flexcan: Add flexcan clocks'
 information
Thread-Topic: [PATCH v2 1/2] Documentation: can: flexcan: Add flexcan clocks'
 information
Thread-Index: AQHVC68KFmdiWxcDJkWrh2soEevNSw==
Date:   Thu, 16 May 2019 06:17:29 +0000
Message-ID: <20190516114057.5878-2-pankaj.bansal@nxp.com>
References: <20190516114057.5878-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190516114057.5878-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4e8bdf0-6988-43be-2384-08d6d9c62c64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2494;
x-ms-traffictypediagnostic: VI1PR0401MB2494:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0401MB2494D0031F83D31D5D8FFD58F10A0@VI1PR0401MB2494.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(52116002)(53936002)(99286004)(386003)(102836004)(6506007)(7736002)(50226002)(4326008)(6512007)(26005)(966005)(478600001)(14454004)(316002)(11346002)(44832011)(2616005)(476003)(486006)(446003)(186003)(110136005)(36756003)(54906003)(8936002)(76176011)(81156014)(68736007)(86362001)(81166006)(2906002)(6436002)(305945005)(8676002)(66946007)(6486002)(6306002)(66066001)(66446008)(66556008)(6116002)(64756008)(66476007)(73956011)(14444005)(256004)(25786009)(71190400001)(71200400001)(3846002)(1076003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2494;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C1HZAEujuV/kAJTBMd1O6TF/HAqTcM8K9MNin1qKuWLZYIYfj9f3uYo0IFDXeYJXHRXRqdyG403RKVwRWOAB2bEbZ/0nLklvlCoPJzlU7D5Eeo0SMZw6xUwifYymMmFsbl0qhjBwaoVa4Xw3rKKsciKWRx55khbT3bHo3wvwLop4nGkNUsjkTmZxxjHO1ELMkdVdhdd63BMPx7qrAsfI3iQcN9gyZjY6QYiRtKN+yjOenwZxXuM8VJxVXJR5KJjpKgfOrbXQ6nAQVUdBb9lcQDyAHVL3Bn/I00Nqzow6Vzl454XG8Y3L0i+DuJ7W+ScZBHjriw8NPpAyjMNxnXcMiZAvZc1xSTqSsF617UP4HDCEbyfd+JgmP4BL621H9yQeB89O+qAk2tsOXqueWuCwwL0IukNGoRBGLVwecbCR/9s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e8bdf0-6988-43be-2384-08d6d9c62c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 06:17:29.3698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2494
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

VGhlIGNsb2NraW5nIGluZm9ybWF0aW9uIGlzIG1pc3NpbmcgZnJvbSBmbGV4Y2FuIGRldmljZSB0
cmVlIGJpbmRpbmdzLg0KVGhpcyBpbmZvcm1hdGlvbiBpcyBuZWVkZWQgdG8gYmUgYWJsZSB0byB1
c2UgZmxleGNhbi4gRG9jdW1lbnQgdGhlIHNhbWUuDQoNClNpZ25lZC1vZmYtYnk6IFBhbmthaiBC
YW5zYWwgPHBhbmthai5iYW5zYWxAbnhwLmNvbT4NCi0tLQ0KDQpOb3RlczoNCiAgICBEZXBlbmRl
bmNpZXM6DQogICAgLSBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvY292ZXIvMTAy
NDUzNi8NCiAgICANCiAgICBWMjoNCiAgICAtIFJlbW92ZWQgY2xvY2stZnJlcXVlbmN5IGZyb20g
b3B0aW9uYWwgcHJvcGVydGllcw0KICAgIC0gQWRkZWQgRGVwZW5kZW5jaWVzIGluIE5vdGVzDQoN
CiAuLi4vYmluZGluZ3MvbmV0L2Nhbi9mc2wtZmxleGNhbi50eHQgICAgICAgICB8IDQ2ICsrKysr
KysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9jYW4vZnNsLWZsZXhjYW4udHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9jYW4vZnNsLWZsZXhjYW4udHh0DQppbmRleCBhMDQxNjg2MDU5OTguLjczYzYxNmNh
MGY5YSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
Y2FuL2ZzbC1mbGV4Y2FuLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9jYW4vZnNsLWZsZXhjYW4udHh0DQpAQCAtMTIsOSArMTIsNDIgQEAgUmVxdWlyZWQg
cHJvcGVydGllczoNCiAtIHJlZyA6IE9mZnNldCBhbmQgbGVuZ3RoIG9mIHRoZSByZWdpc3RlciBz
ZXQgZm9yIHRoaXMgZGV2aWNlDQogLSBpbnRlcnJ1cHRzIDogSW50ZXJydXB0IHR1cGxlIGZvciB0
aGlzIGRldmljZQ0KIA0KLU9wdGlvbmFsIHByb3BlcnRpZXM6DQorQ2xvY2tpbmcgaW5mb3JtYXRp
b24gaXMgbXVzdCBmb3IgZmxleGNhbi4gcGxlYXNlIHJlZmVyIGJlbG93IGluZm8gZm9yDQordW5k
ZXJzdGFuZGluZyBjbG9ja2luZyBpbiBmbGV4Y2FuOg0KKw0KK+KAoiBUaGUgRkxFWENBTiBtb2R1
bGUgaXMgZGl2aWRlZCBpbnRvIHR3byBibG9ja3MuIENvbnRyb2xsZXIgaG9zdCBpbnRlcmZhY2UN
CisgICgiQ0hJIikgYW5kIFByb3RvY29sIEVuZ2luZSAoIlBFIikNCivigKIgQm90aCB0aGVzZSBi
bG9ja3MgcmVxdWlyZSBjbG9jay4NCivigKIgQ0hJIGlzIHJlc3BvbnNpYmxlIGZvciByZWdpc3Rl
cnMgcmVhZCB3cml0ZSBpbmNsdWRpbmcgTUIgcmVhZC93cml0ZS4NCisgIFdoaWxlIFBFIGlzIHJl
c3BvbnNpYmxlIGZvciBUcmFuc2Zlci9yZWNlaXZlIGRhdGEgb24gQ0FOIGJ1cy4NCivigKIgVGhl
IGNsb2NrcyBmZWVkaW5nIHRvIHRoZXNlIHR3byBibG9ja3MgY2FuIGJlIHN5bmNocm9ub3VzIChp
LmUuIHNhbWUgY2xvY2spDQorICBvciBhc3luY2hyb25vdXMgKGkuZS4gc2VwYXJhdGUgY2xvY2tz
KS4NCivigKIgU2VsZWN0aW9uIGlzIG1hZGUgaW4gdGhlIENMS19TUkMgYml0IChiaXQgMTMpIG9m
IENvbnRyb2wgMSBSZWdpc3Rlci4NCisgIC0gQ0xLX1NSQyA9IDAsIGFzeW5jaHJvbm91cyBpLmUu
IHNlcGFyYXRlIGNsb2NrcyBmb3IgQ0hJIGFuZCBQRQ0KKyAgLSBDTEtfU1JDID0gMSwgc3luY2hy
b25vdXMgaS5lLiBDSEkgY2xvY2sgaXMgdXNlZCBmb3IgUEUgYW5kIFBFDQorICAgICAgICAgICAg
ICAgICBjbG9jayBpcyBub3QgdXNlZC4NCivigKIgSWYgdGhpcyBiaXQgaXMgbm90IGltcGxlbWVu
dGVkIGluIFNPQywgdGhlbiBTT0Mgb25seSBzdXBwb3J0cyBhc3luY2hyb25vdXMNCisgIGNsb2Nr
cy4NCivigKIgRWl0aGVyIG9mIHRoZSBjbG9jayBjYW4gYmUgZ2VuZXJhdGVkIGJ5IGFueSBvZiB0
aGUgY2xvY2sgc291cmNlLg0KK+KAoiBXaGVuIHRoZSB0d28gY2xvY2tzIGFyZSBhc3luY2hyb25v
dXMsIHRoZW4gZm9sbG93aW5nIHJlc3RyaWN0aW9ucyBhcHBseSB0bw0KKyAgUEUgY2xvY2suDQor
ICAtIFBFIGNsb2NrIG11c3QgYmUgbGVzcyB0aGFuIENISSBjbG9jay4NCivigKIgSWYgbG93IGpp
dHRlciBpcyByZXF1aXJlZCBvbiBDQU4gYnVzLCBkZWRpY2F0ZWQgb3NjaWxsYXRvciBjYW4gYmUg
dXNlZCB0bw0KKyAgcHJvdmlkZSBQRSBjbG9jaywgYnV0IGl0IG11c3QgYmUgbGVzcyB0aGFuIENI
SSBjbG9jay4NCisNCitCYXNlIG9uIGFib3ZlIGluZm9ybWF0aW9uIGNsb2NraW5nIGluZm8gaW4g
ZmxleGNhbiBjYW4gYmUgZGVmaW5lZCBpbiB0d28gd2F5czoNCisNCitNZXRob2QgMShQcmVmZXJy
ZWQpOg0KKyAgLSBjbG9ja3M6IHBoYW5kbGUgdG8gdGhlIGNsb2NrcyBmZWVkaW5nIHRoZSBmbGV4
Y2FuLiBUd28gY2FuIGJlIGdpdmVuOg0KKyAgICAtICJpcGciOiBQcm90b2NvbCBFbmdpbmUgY2xv
Y2sNCisgICAgLSAicGVyIjogQ29udHJvbGxlciBob3N0IGludGVyZmFjZSBjbG9jaw0KKyAgLSBj
bG9jay1uYW1lczogTXVzdCBjb250YWluIHRoZSBjbG9jayBuYW1lcyBkZXNjcmliZWQganVzdCBh
Ym92ZS4NCiANCi0tIGNsb2NrLWZyZXF1ZW5jeSA6IFRoZSBvc2NpbGxhdG9yIGZyZXF1ZW5jeSBk
cml2aW5nIHRoZSBmbGV4Y2FuIGRldmljZQ0KK01ldGhvZCAyKE5vdCBQcmVmZXJyZWQpOg0KKyAg
LSBjbG9jay1mcmVxdWVuY3kgOiBUaGUgc3luY2hyb25vdXMgY2xvY2sgZnJlcXVlbmN5IHN1cHBs
aWVkIHRvIGJvdGgNCisgIENvbnRyb2xsZXIgaG9zdCBpbnRlcmZhY2UgYW5kIFByb3RvY29sIEVu
Z2luZQ0KKw0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQogDQogLSB4Y2VpdmVyLXN1cHBseTogUmVn
dWxhdG9yIHRoYXQgcG93ZXJzIHRoZSBDQU4gdHJhbnNjZWl2ZXINCiANCkBAIC00Nyw1ICs4MCwx
NCBAQCBFeGFtcGxlOg0KIAkJaW50ZXJydXB0cyA9IDw0OCAweDI+Ow0KIAkJaW50ZXJydXB0LXBh
cmVudCA9IDwmbXBpYz47DQogCQljbG9jay1mcmVxdWVuY3kgPSA8MjAwMDAwMDAwPjsgLy8gZmls
bGVkIGluIGJ5IGJvb3Rsb2FkZXINCisJfTsNCisNCisJY2FuQDIxODAwMDAgew0KKwkJY29tcGF0
aWJsZSA9ICJmc2wsbHgyMTYwYXIxLWZsZXhjYW4iOw0KKwkJcmVnID0gPDB4MCAweDIxODAwMDAg
MHgwIDB4MTAwMDA+Ow0KKwkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIxIElSUV9UWVBFX0xFVkVM
X0hJR0g+Ow0KKwkJY2xvY2tzID0gPCZzeXNjbGs+LCA8JmNsb2NrZ2VuIDQgNz47DQorCQljbG9j
ay1uYW1lcyA9ICJpcGciLCAicGVyIjsNCiAJCWZzbCxjbGstc291cmNlID0gPDA+OyAvLyBzZWxl
Y3QgY2xvY2sgc291cmNlIDAgZm9yIFBFDQorCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIAl9Ow0K
LS0gDQoyLjE3LjENCg0K
