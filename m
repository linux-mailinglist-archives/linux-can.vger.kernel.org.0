Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B9922364F
	for <lists+linux-can@lfdr.de>; Fri, 17 Jul 2020 09:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgGQHzX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Jul 2020 03:55:23 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:64612
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbgGQHzW (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 17 Jul 2020 03:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEJjJJHWojMxloh+BLkdzCRchP4KfcdV7DANDxhDkdFvnKVslEYGto7kKA7cxVWsOfFqFsaRAz+EuKsxGDwXVEJtHHtP1kAyz/0lL0RZ/Y9Gcv9FctUeCeWqGAwN3KWyZnuAf0Xi8q/+0sTCQ+L9NhYVHOYFqDcSvtVy1bngoILUxoRsTQizeobOGS7uI+jj4dZd43uaXChRX6u2Ngasqul8h8L67Zgd6id0dmKJUDoQXXMWdA65uLLxgoWEvzPBG0Xq9DqSJXSTK5IYhBBEUrlp4B7UImqNoMQuR5JyTfFDmrvSFvFBQPaulIY/SxbhLskglcVZt5V8AEibs4+pQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS+5KrBS+y6dT2Lntp6xkD4guPOhpggfAq7P0XyXkYs=;
 b=Uz400S1KlOsWwAgg4PXU9LDxqyONT5t6xHqU3gWYF0FaeMvIvLxtVuFGMAGIEOGvEJhDvuJ/k+97WUA5Xq7gCSFyGY55wBRFDnWM0qm5qvQ5r+rWDqdq1xanAy1lnYz91LT+B8onRk9wnd96lxFKRpZq1prDtv5SmVgqTrGTE/xJTuSljr8/FSE9Idi6QDfN0CjAfsfiJ0XXtAfw+d1kURu2g3/hDy5Q9pEd0zHPM788EZyEOh5zP2NkG+WSv5QzFmZHCtYOMX/F+baz8i6q3fZBVHtxGoTfOKU6Bwe6O4yhuAq3lcN/wYWyq8MsU2867TE3mP5RxtsExuqzv7F3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS+5KrBS+y6dT2Lntp6xkD4guPOhpggfAq7P0XyXkYs=;
 b=bVHfRJ79Q/SXE963iNk8dn/nwxA1SOqSk0XzTVwqt294pzqW+U6FnTcY3dJLUhwEjmBgB6pxyc9VrbECBhQ8b+rlNcGH5oOOA6ehqosqbEIJZi4bMPkoMgBqSGAWbBxNS21wXHbkJOvtJIukeZ1fZNk2TaaG+upRa8mK+jy0Qqs=
Received: from DB7PR03MB5051.eurprd03.prod.outlook.com (2603:10a6:10:74::21)
 by DB7PR03MB4634.eurprd03.prod.outlook.com (2603:10a6:10:1e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 07:55:16 +0000
Received: from DB7PR03MB5051.eurprd03.prod.outlook.com
 ([fe80::2548:dd58:bbb5:40bb]) by DB7PR03MB5051.eurprd03.prod.outlook.com
 ([fe80::2548:dd58:bbb5:40bb%3]) with mapi id 15.20.3174.027; Fri, 17 Jul 2020
 07:55:16 +0000
From:   =?utf-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Philipp Lehmann <leph1016@hs-karlsruhe.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "christian.sauer.w@sew-eurodrive.de" 
        <christian.sauer.w@sew-eurodrive.de>
Subject: RE: [Bug] Kernel Panic on Deletion of the network-namespace
 containing the SocketCAN interface
Thread-Topic: [Bug] Kernel Panic on Deletion of the network-namespace
 containing the SocketCAN interface
Thread-Index: AQHWW493uXW0NDKXQkWfuvBe3q5jjakKiT0AgADc6hA=
Date:   Fri, 17 Jul 2020 07:55:16 +0000
Message-ID: <DB7PR03MB505186792325DBBF2471EF1ED67C0@DB7PR03MB5051.eurprd03.prod.outlook.com>
References: <20ea6d4c00dc4d5f99cd004677280369@hs-karlsruhe.de>
 <88fb5401-746a-5589-650d-a88fde43b122@hartkopp.net>
In-Reply-To: <88fb5401-746a-5589-650d-a88fde43b122@hartkopp.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hartkopp.net; dkim=none (message not signed)
 header.d=none;hartkopp.net; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [185.109.201.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ded92a4-73c7-4f9a-af2a-08d82a26be46
x-ms-traffictypediagnostic: DB7PR03MB4634:
x-microsoft-antispam-prvs: <DB7PR03MB46349A5EA01F2A44ACACC606D67C0@DB7PR03MB4634.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GL8T1FGJj3Z6WvWGVvS7kP8iAnWezuniIPhDtjgCrR5xsOw7PljWyRQhZN9VGiKRap6QYnzz4EUeHkIdRc0zcecuEPseiMPa5xxzuzUKA3/dg68JUcUXyWfGbdrFjSbavlxCxMr+gZA/syxRzvRc3KAhl02vHYfLxhWPeWwKrC77pLy80lNtJqRASD5ZF6ToqWUKgBKeyxAzjUqCAchcukzPeaXcO9dNNS6v07MGq6rhcRu9jCbkmFc+lOn7jmsMAPY0tTgTEhc8HfCIg91fLsUzyJ3t2om+gN2+ZCm6NU/WQpGGBujreeqyZaXlxo2xYnz84QBWSdYS0YFx3nl8Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB5051.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(376002)(366004)(136003)(396003)(346002)(54906003)(316002)(66556008)(52536014)(71200400001)(15974865002)(66476007)(66946007)(76116006)(66446008)(4326008)(64756008)(5660300002)(66574015)(83380400001)(55016002)(26005)(186003)(85182001)(110136005)(8676002)(8936002)(2906002)(7696005)(85202003)(508600001)(45080400002)(9686003)(6506007)(33656002)(86362001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jmbtbOvFpIbvPJfvPcmfl+o96CsuP+sFRAa2p9oqky7DDWOgCLVCJC4YJuaxL3XCw2yy0H8iDRwyrUkhGbSCPAzlcorYaoiQOU+02Z81esfYqDS3yXMA8wZwJ0IRD6Qet59QXkW4zC1QyzvUpahXpf5vuqN7craVn3u4ZTmYmt0LPLid3fjG24+k0C/Fu8v8uqBqtdqH6M4/Tw9RZG5SzjaLEgZkqhewEC+g/vSQ6i1+3Jn5TiYRHcTMojbLIC1K3LHDkIE+oNFg+ckb0Z8CBaX27P3pCCvde8/VqAn6cMOPR+MfuITskBs7HZ6DITVu/QQ9ouDdJXBMYqJU+vrCHDVVw/SA2SIJtvXR61nthk2NrLno0VsoMAMo6XxCYnIKeM4NqYjeJTG2WMU+qXpWZFLCSR/No0VGRVcnXJrzoVyKdWApbo0QQ+4AMpRQdTCT/2cZCPWKesrCEb31OSSIkiBpM/1J9lmG2ZrPbfg9bH2aRNV1REtrfuwi/u2DuZej
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB5051.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ded92a4-73c7-4f9a-af2a-08d82a26be46
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 07:55:16.1233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oI+O09AnfTQFJlTWagwWysCosms9GOwr4/zRW7Rkva8shFORdUsGqkQVoVSrfi3qeV5a/96kcwdF2upJdS77assa5ULwPUtgjgBlWpD7Kpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4634
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gZXZlcnlvbmUsDQoNCihhZGRlbmR1bSkNCg0KVGhlcmUncyBhIGZpcnN0IFdBUk5JTkcg
a2VybmVsIG1lc3NhZ2UganVzdCB3aGVuIHRoZSBuYW1lc3BhY2UgaXMgZGVsZXRlZC4gVGhlIFdB
Uk5JTkcgdHVybnMgaW50byBhIEJVRyAoa2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSkg
d2hlbiByZW1vdmluZyB0aGUgaW50ZXJmYWNlIGl0c2VsZiAoZm9yIGV4YW1wbGUsIHdoZW4gdGhl
IGRyaXZlciBtb2R1bGUgaXMgcmVtb3ZlZCBmcm9tIG1lbW9yeSkuIE5vdGUgdGhhdCB0aGUgaXNz
dWUgb2NjdXJzIHdpdGggYWxsIG91ciBpbnRlcm5hbCBhcyB3ZWxsIGFzIFVTQiBDQU4gaW50ZXJm
YWNlcy4NCg0KT2J2aW91c2x5LCB0aGUgcHJvYmxlbSBkb2Vzbid0IGFwcGVhciB3aGVuIHlvdSBw
dXQgdGhlIGludGVyZmFjZSBiYWNrIGluIHRoZSByb290IG5hbWVzcGFjZSBiZWZvcmUgdGhlIGRl
c3RydWN0aW9uLCBvciB3aGVuIHRoZSBpbnRlcmZhY2UgaXMgYSB0cnVlIEV0aGVybmV0IG5ldHdv
cmsgaW50ZXJmYWNlLg0KDQpSZWdhcmRzLA0KDQotLSBTdMOpcGhhbmUNCg0KQ29udGV4dDoNCg0K
JCB1bmFtZSAtYQ0KTGludXggbGludXgtZGV2IDUuNC4wLTM5LWdlbmVyaWMgIzQzLVVidW50dSBT
TVAgRnJpIEp1biAxOSAxMDoyODozMSBVVEMgMjAyMCB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUv
TGludXgNCg0KJCBkbWVzZyB8IGdyZXAgcGVha19wY2kNClsgICAxOS4wMjgwNDhdIHBlYWtfcGNp
IDAwMDA6MGE6MDAuMDogZW5hYmxpbmcgZGV2aWNlICgwMTAwIC0+IDAxMDIpDQpbICAgMTkuMDM0
MjgzXSBwZWFrX3BjaSAwMDAwOjBhOjAwLjA6IGNhbjYgYXQgcmVnX2Jhc2U9MHgwMDAwMDAwMDEz
NmI4YjBiIGNmZ19iYXNlPTB4MDAwMDAwMDBiODI2NTk3YyBpcnE9MjcNClsgICAxOS4wMzQzNzhd
IHBlYWtfcGNpIDAwMDA6MGE6MDAuMDogY2FuNyBhdCByZWdfYmFzZT0weDAwMDAwMDAwNmIzZGU5
YTAgY2ZnX2Jhc2U9MHgwMDAwMDAwMGI4MjY1OTdjIGlycT0yNw0KDQojIGlwIG5ldG5zIGFkZCB0
ZXN0DQojIGlwIGxpbmsgc2V0IGRldiBjYW42IG5ldG5zIHRlc3QNCiMgaXAgbmV0bnMgZGVsZXRl
IHRlc3QNCg0KWyAxNzU1LjgwNTI0MV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0t
LS0tDQpbIDE3NTUuODA1MjUxXSBXQVJOSU5HOiBDUFU6IDggUElEOiAyNjM1IGF0IG5ldC9jb3Jl
L2Rldi5jOjEwMDM5IG5ldGRldl9leGl0KzB4NDQvMHg1MA0KWyAxNzU1LjgwNTI1Ml0gTW9kdWxl
cyBsaW5rZWQgaW46IHZib3huZXRhZHAoT0UpIHZib3huZXRmbHQoT0UpIHZib3hkcnYoT0UpIG1k
NCBubHNfdXRmOCBjaWZzIGxpYmFyYzQgZnNjYWNoZSBsaWJkZXMgY2ZnODAyMTEgbmxzX2lzbzg4
NTlfMSBpbnRlbF9yYXBsX21zciBpbnRlbF9yYXBsX2NvbW1vbiB4ODZfcGtnX3RlbXBfdGhlcm1h
bCBpbnRlbF9wb3dlcmNsYW1wIGNvcmV0ZW1wIGt2bV9pbnRlbCBwZWFrX3VzYiA4ODEyYXUoT0Up
IGpveWRldiBwbGluKE9FKSBrdm0gaW5wdXRfbGVkcyBwY2FuKE9FKSBlZWVwY193bWkgc25kX2hk
YV9jb2RlY19oZG1pIHNuZF9oZGFfY29kZWNfcmVhbHRlayBub3V2ZWF1IHBjbWNpYSBzbmRfaGRh
X2NvZGVjX2dlbmVyaWMgYXN1c193bWkgcGNtY2lhX2NvcmUgY3JjdDEwZGlmX3BjbG11bCBnaGFz
aF9jbG11bG5pX2ludGVsIHBlYWtfcGNpIHNqYTEwMDAgcGVha19wY2llZmQgbGVkdHJpZ19hdWRp
byB0dG0gYWVzbmlfaW50ZWwgZHJtX2ttc19oZWxwZXIgc25kX2hkYV9pbnRlbCBzbmRfaW50ZWxf
ZHNwY2ZnIGZiX3N5c19mb3BzIHN5c2NvcHlhcmVhIHN5c2ZpbGxyZWN0IHN5c2ltZ2JsdCBjYW5f
ZGV2IHNuZF9oZGFfY29kZWMgc25kX2hkYV9jb3JlIGNyeXB0b19zaW1kIHNuZF9od2RlcCBjcnlw
dGQgc25kX3BjbSBnbHVlX2hlbHBlciBzbmRfc2VxX21pZGkgc25kX3NlcV9taWRpX2V2ZW50IHNu
ZF9yYXdtaWRpIHNuZF9zZXEgc25kX3NlcV9kZXZpY2Ugc25kX3RpbWVyIHNwYXJzZV9rZXltYXAg
aW50ZWxfY3N0YXRlIGludGVsX3JhcGxfcGVyZiBzbmQgdmlkZW8gbWVpX21lIG1laSBzb3VuZGNv
cmUgd21pX2Jtb2YgaW50ZWxfd21pX3RodW5kZXJib2x0IG14bV93bWkgbWFjX2hpZCBzY2hfZnFf
Y29kZWwgcGFycG9ydF9wYyBwcGRldiBscCBwYXJwb3J0IGRybSBpcF90YWJsZXMgeF90YWJsZXMg
YXV0b2ZzNCBoaWRfZ2VuZXJpYyB1c2JoaWQgdWFzIHVzYl9zdG9yYWdlIGhpZCBjcmMzMl9wY2xt
dWwgaWdiIGUxMDAwZQ0KWyAxNzU1LjgwNTMwNl0gIGFoY2kgaTJjX2k4MDEgaTJjX2FsZ29fYml0
IGxwY19pY2ggbGliYWhjaSBkY2Egd21pDQpbIDE3NTUuODA1MzE1XSBDUFU6IDggUElEOiAyNjM1
IENvbW06IGt3b3JrZXIvdTI0OjAgVGFpbnRlZDogRyAgICAgICAgICAgT0UgICAgIDUuNC4wLTM5
LWdlbmVyaWMgIzQzLVVidW50dQ0KWyAxNzU1LjgwNTMxNl0gSGFyZHdhcmUgbmFtZTogQVNVUyBB
bGwgU2VyaWVzL1g5OS1FIFdTLCBCSU9TIDQwMDEgMDUvMjcvMjAxOQ0KWyAxNzU1LjgwNTMxOV0g
V29ya3F1ZXVlOiBuZXRucyBjbGVhbnVwX25ldA0KWyAxNzU1LjgwNTMyNF0gUklQOiAwMDEwOm5l
dGRldl9leGl0KzB4NDQvMHg1MA0KWyAxNzU1LjgwNTMyN10gQ29kZTogOGIgYmIgMzAgMDEgMDAg
MDAgZTggOGIgOWQgOTcgZmYgNDggODEgZmIgMDAgMjEgYmUgYjUgNzQgMTMgNDggOGIgODMgOTAg
MDAgMDAgMDAgNDggODEgYzMgOTAgMDAgMDAgMDAgNDggMzkgYzMgNzUgMDMgNWIgNWQgYzMgPDBm
PiAwYiBlYiBmOSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCAwZiAxZiA0NCAwMCAwMCA1NSA0OCA4
OSBlNSA0MQ0KWyAxNzU1LjgwNTMyOV0gUlNQOiAwMDE4OmZmZmZiMTJkMDE2OWZkYzggRUZMQUdT
OiAwMDAxMDI4Nw0KWyAxNzU1LjgwNTMzMV0gUkFYOiBmZmZmOTYyNGM4YTcwMDUwIFJCWDogZmZm
Zjk2MjQ3NjQyYTcxMCBSQ1g6IDAwMDAwMDAwODAxMDAwMGINClsgMTc1NS44MDUzMzNdIFJEWDog
MDAwMDAwMDA4MDEwMDAwYyBSU0k6IDAwMDAwMDAwMDAwMDAwMDEgUkRJOiBmZmZmOTYyNGNkYzA2
YTAwDQpbIDE3NTUuODA1MzM0XSBSQlA6IGZmZmZiMTJkMDE2OWZkZDAgUjA4OiAwMDAwMDAwMDAw
MDAwMDAwIFIwOTogZmZmZmZmZmZiNGQyZTMwMA0KWyAxNzU1LjgwNTMzNV0gUjEwOiBmZmZmOTYy
NGEwZDg0MDAwIFIxMTogMDAwMDAwMDAwMDAwMDAwMSBSMTI6IGZmZmZiMTJkMDE2OWZlMjANClsg
MTc1NS44MDUzMzddIFIxMzogZmZmZmZmZmZiNWJlM2YyMCBSMTQ6IGZmZmZmZmZmYjViZTNmMjgg
UjE1OiBmZmZmOTYyNDk4ZWEzOWQ4DQpbIDE3NTUuODA1MzM5XSBGUzogIDAwMDAwMDAwMDAwMDAw
MDAoMDAwMCkgR1M6ZmZmZjk2MjRjZmEwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAw
DQpbIDE3NTUuODA1MzQxXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAw
MDgwMDUwMDMzDQpbIDE3NTUuODA1MzQyXSBDUjI6IDAwMDA1NWZiYjU5Y2Q4ZTggQ1IzOiAwMDAw
MDAwMDRhYTBhMDA2IENSNDogMDAwMDAwMDAwMDE2MDZlMA0KWyAxNzU1LjgwNTM0NF0gQ2FsbCBU
cmFjZToNClsgMTc1NS44MDUzNTBdICBvcHNfZXhpdF9saXN0LmlzcmEuMCsweDNiLzB4NzANClsg
MTc1NS44MDUzNTNdICBjbGVhbnVwX25ldCsweDFmMC8weDMwMA0KWyAxNzU1LjgwNTM1OV0gIHBy
b2Nlc3Nfb25lX3dvcmsrMHgxZWIvMHgzYjANClsgMTc1NS44MDUzNjNdICB3b3JrZXJfdGhyZWFk
KzB4NGQvMHg0MDANClsgMTc1NS44MDUzNjddICBrdGhyZWFkKzB4MTA0LzB4MTQwDQpbIDE3NTUu
ODA1MzcwXSAgPyBwcm9jZXNzX29uZV93b3JrKzB4M2IwLzB4M2IwDQpbIDE3NTUuODA1MzczXSAg
PyBrdGhyZWFkX3BhcmsrMHg5MC8weDkwDQpbIDE3NTUuODA1Mzc4XSAgcmV0X2Zyb21fZm9yaysw
eDM1LzB4NDANClsgMTc1NS44MDUzODJdIC0tLVsgZW5kIHRyYWNlIDgzMmE3NWFkOTZmODEwNWUg
XS0tLQ0KWyAxNzU1LjgwNTQxMF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0t
DQpbIDE3NTUuODA1NDE2XSBXQVJOSU5HOiBDUFU6IDggUElEOiAyNjM1IGF0IGZzL3Byb2MvcHJv
Y19zeXNjdGwuYzoxNzE0IHJldGlyZV9zeXNjdGxfc2V0KzB4MTQvMHgxOA0KWyAxNzU1LjgwNTQx
N10gTW9kdWxlcyBsaW5rZWQgaW46IHZib3huZXRhZHAoT0UpIHZib3huZXRmbHQoT0UpIHZib3hk
cnYoT0UpIG1kNCBubHNfdXRmOCBjaWZzIGxpYmFyYzQgZnNjYWNoZSBsaWJkZXMgY2ZnODAyMTEg
bmxzX2lzbzg4NTlfMSBpbnRlbF9yYXBsX21zciBpbnRlbF9yYXBsX2NvbW1vbiB4ODZfcGtnX3Rl
bXBfdGhlcm1hbCBpbnRlbF9wb3dlcmNsYW1wIGNvcmV0ZW1wIGt2bV9pbnRlbCBwZWFrX3VzYiA4
ODEyYXUoT0UpIGpveWRldiBwbGluKE9FKSBrdm0gaW5wdXRfbGVkcyBwY2FuKE9FKSBlZWVwY193
bWkgc25kX2hkYV9jb2RlY19oZG1pIHNuZF9oZGFfY29kZWNfcmVhbHRlayBub3V2ZWF1IHBjbWNp
YSBzbmRfaGRhX2NvZGVjX2dlbmVyaWMgYXN1c193bWkgcGNtY2lhX2NvcmUgY3JjdDEwZGlmX3Bj
bG11bCBnaGFzaF9jbG11bG5pX2ludGVsIHBlYWtfcGNpIHNqYTEwMDAgcGVha19wY2llZmQgbGVk
dHJpZ19hdWRpbyB0dG0gYWVzbmlfaW50ZWwgZHJtX2ttc19oZWxwZXIgc25kX2hkYV9pbnRlbCBz
bmRfaW50ZWxfZHNwY2ZnIGZiX3N5c19mb3BzIHN5c2NvcHlhcmVhIHN5c2ZpbGxyZWN0IHN5c2lt
Z2JsdCBjYW5fZGV2IHNuZF9oZGFfY29kZWMgc25kX2hkYV9jb3JlIGNyeXB0b19zaW1kIHNuZF9o
d2RlcCBjcnlwdGQgc25kX3BjbSBnbHVlX2hlbHBlciBzbmRfc2VxX21pZGkgc25kX3NlcV9taWRp
X2V2ZW50IHNuZF9yYXdtaWRpIHNuZF9zZXEgc25kX3NlcV9kZXZpY2Ugc25kX3RpbWVyIHNwYXJz
ZV9rZXltYXAgaW50ZWxfY3N0YXRlIGludGVsX3JhcGxfcGVyZiBzbmQgdmlkZW8gbWVpX21lIG1l
aSBzb3VuZGNvcmUgd21pX2Jtb2YgaW50ZWxfd21pX3RodW5kZXJib2x0IG14bV93bWkgbWFjX2hp
ZCBzY2hfZnFfY29kZWwgcGFycG9ydF9wYyBwcGRldiBscCBwYXJwb3J0IGRybSBpcF90YWJsZXMg
eF90YWJsZXMgYXV0b2ZzNCBoaWRfZ2VuZXJpYyB1c2JoaWQgdWFzIHVzYl9zdG9yYWdlIGhpZCBj
cmMzMl9wY2xtdWwgaWdiIGUxMDAwZQ0KWyAxNzU1LjgwNTQ1NF0gIGFoY2kgaTJjX2k4MDEgaTJj
X2FsZ29fYml0IGxwY19pY2ggbGliYWhjaSBkY2Egd21pDQpbIDE3NTUuODA1NDYwXSBDUFU6IDgg
UElEOiAyNjM1IENvbW06IGt3b3JrZXIvdTI0OjAgVGFpbnRlZDogRyAgICAgICAgVyAgT0UgICAg
IDUuNC4wLTM5LWdlbmVyaWMgIzQzLVVidW50dQ0KWyAxNzU1LjgwNTQ2MV0gSGFyZHdhcmUgbmFt
ZTogQVNVUyBBbGwgU2VyaWVzL1g5OS1FIFdTLCBCSU9TIDQwMDEgMDUvMjcvMjAxOQ0KWyAxNzU1
LjgwNTQ2M10gV29ya3F1ZXVlOiBuZXRucyBjbGVhbnVwX25ldA0KWyAxNzU1LjgwNTQ2N10gUklQ
OiAwMDEwOnJldGlyZV9zeXNjdGxfc2V0KzB4MTQvMHgxOA0KWyAxNzU1LjgwNTQ2OV0gQ29kZTog
MDAgMDAgMDAgMDAgNDkgYzcgNDAgNDggMDAgMDAgMDAgMDAgNDkgYzcgNDAgNTAgMDAgMDAgMDAg
MDAgYzMgOTAgMGYgMWYgNDQgMDAgMDAgNTUgNDggOGIgNDcgNTggNDggODkgZTUgNDggODUgYzAg
NzUgMDIgNWQgYzMgPDBmPiAwYiA1ZCBjMyAwZiAxZiA0NCAwMCAwMCA1NSA0OCA4OSBlNSA0OCA4
MyBlYyA2MCA0OCA4OSA0YyAyNCA0OA0KWyAxNzU1LjgwNTQ3MV0gUlNQOiAwMDE4OmZmZmZiMTJk
MDE2OWZkYzAgRUZMQUdTOiAwMDAxMDI4Mg0KWyAxNzU1LjgwNTQ3M10gUkFYOiBmZmZmOTYyNGE2
OTdhZDU4IFJCWDogZmZmZjk2MjQ3NjQyYTY4MCBSQ1g6IDAwMDAwMDAwODAxNTAwMDkNClsgMTc1
NS44MDU0NzVdIFJEWDogZmZmZjk2MjQ3NjQyYTZiMCBSU0k6IGZmZmZmZmZmYjViZmViNDggUkRJ
OiBmZmZmOTYyNDc2NDJhNzMwDQpbIDE3NTUuODA1NDc2XSBSQlA6IGZmZmZiMTJkMDE2OWZkYzAg
UjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogZmZmZmZmZmZiNDc3NmQwMA0KWyAxNzU1LjgwNTQ3
N10gUjEwOiBmZmZmOTYyNGNhZDBhOWMwIFIxMTogMDAwMDAwMDAwMDAwMDAwMSBSMTI6IGZmZmZi
MTJkMDE2OWZlMjANClsgMTc1NS44MDU0NzldIFIxMzogZmZmZmZmZmZiNWJmZWI0MCBSMTQ6IGZm
ZmZmZmZmYjViZmViNDggUjE1OiBmZmZmOTYyNDk4ZWEzOWQ4DQpbIDE3NTUuODA1NDgxXSBGUzog
IDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjk2MjRjZmEwMDAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwDQpbIDE3NTUuODA1NDgyXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAw
MDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQpbIDE3NTUuODA1NDgzXSBDUjI6IDAwMDA1NWZiYjU5
Y2Q4ZTggQ1IzOiAwMDAwMDAwMDRhYTBhMDA2IENSNDogMDAwMDAwMDAwMDE2MDZlMA0KWyAxNzU1
LjgwNTQ4NV0gQ2FsbCBUcmFjZToNClsgMTc1NS44MDU0OTBdICBzeXNjdGxfbmV0X2V4aXQrMHgx
NS8weDIwDQpbIDE3NTUuODA1NDkzXSAgb3BzX2V4aXRfbGlzdC5pc3JhLjArMHgzYi8weDcwDQpb
IDE3NTUuODA1NDk2XSAgY2xlYW51cF9uZXQrMHgxZjAvMHgzMDANClsgMTc1NS44MDU1MDBdICBw
cm9jZXNzX29uZV93b3JrKzB4MWViLzB4M2IwDQpbIDE3NTUuODA1NTAzXSAgd29ya2VyX3RocmVh
ZCsweDRkLzB4NDAwDQpbIDE3NTUuODA1NTA3XSAga3RocmVhZCsweDEwNC8weDE0MA0KWyAxNzU1
LjgwNTUxMF0gID8gcHJvY2Vzc19vbmVfd29yaysweDNiMC8weDNiMA0KWyAxNzU1LjgwNTUxMl0g
ID8ga3RocmVhZF9wYXJrKzB4OTAvMHg5MA0KWyAxNzU1LjgwNTUxN10gIHJldF9mcm9tX2Zvcmsr
MHgzNS8weDQwDQpbIDE3NTUuODA1NTIwXSAtLS1bIGVuZCB0cmFjZSA4MzJhNzVhZDk2ZjgxMDVm
IF0tLS0NCg0KDQoNCuKAlCBTdMOpcGhhbmUNCg0KLS0tLS1NZXNzYWdlIGQnb3JpZ2luZS0tLS0t
DQpEZSA6IGxpbnV4LWNhbi1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWNhbi1vd25lckB2
Z2VyLmtlcm5lbC5vcmc+IERlIGxhIHBhcnQgZGUgT2xpdmVyIEhhcnRrb3BwDQpFbnZvecOpIDog
amV1ZGkgMTYganVpbGxldCAyMDIwIDIwOjM4DQrDgCA6IFBoaWxpcHAgTGVobWFubiA8bGVwaDEw
MTZAaHMta2FybHNydWhlLmRlPjsgd2dAZ3JhbmRlZ2dlci5jb207IG1rbEBwZW5ndXRyb25peC5k
ZQ0KQ2MgOiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOyBjaHJpc3RpYW4uc2F1ZXIud0BzZXct
ZXVyb2RyaXZlLmRlDQpPYmpldCA6IFJlOiBbQnVnXSBLZXJuZWwgUGFuaWMgb24gRGVsZXRpb24g
b2YgdGhlIG5ldHdvcmstbmFtZXNwYWNlIGNvbnRhaW5pbmcgdGhlIFNvY2tldENBTiBpbnRlcmZh
Y2UNCg0KSGkgUGhpbGlwcCwNCg0KdGhhbmtzIGZvciB0aGUgcmVwb3J0IGFuZCBpdHMgcmVwcm9k
dWNlciENCg0KSSBhc3N1bWVkIHRoZSBpbnRlcmZhY2VzIC0gYXQgbGVhc3QgaW4gdGhlIGNhc2Ug
b2YgJ3JlYWwnIGhhcmR3YXJlIENBTiBpbnRlcmZhY2VzIC0gdG8gbWUgbW92ZWQgYmFjayB0byB0
aGUgcm9vdCBuYW1lIHNwYWNlIC4uLiB3ZWxsLg0KDQpJJ2xsIHRha2UgYSBsb29rIGF0IGl0Lg0K
DQpCZXN0IHJlZ2FyZHMsDQpPbGl2ZXINCg0KT24gMTYuMDcuMjAgMTg6NDYsIFBoaWxpcHAgTGVo
bWFubiB3cm90ZToNCj4gSWYgYSBTb2NrZXRDQU4gSW50ZXJmYWNlIChUZXN0ZWQgd2l0aCBhIFBD
QU4tVVNCIGFkYXB0ZXIpIGlzIG1vdmVkIGludG8gYSBuZXR3b3JrLW5hbWVzcGFjZSBhbmQgdGhl
IG5ldHdvcmsgbmFtZXNwYWNlIGlzIGRlbGV0ZWQgYWZ0ZXJ3YXJkcywgd2l0aG91dCBtb3Zpbmcg
dGhlIGRldmljZSBvdXQgb2YgdGhlIG5hbWVzcGFjZSBwcmlvciB0byB0aGUgZGVsZXRpb24uIFRo
ZSBkZXZpY2UgY291bGQgbm90IGJlIGZvdW5kIGluIGFueSBvZiB0aGUgbmV0d29yayBuYW1lc3Bh
Y2VzIGFmdGVyd2FyZHMsIG9ubHkgYSByZWJvb3Qgb2YgdGhlIHN5c3RlbSBmaXhlcyB0aGlzLiBJ
ZiB0aGUgZGV2aWNlIGlzIGluc3RlYWQgcmVtb3ZlZCBmcm9tIHRoZSBVU0ItQnVzIHdpdGhvdXQg
YSByZXN0YXJ0LCBhIGtlcm5lbCBwYW5pYyBpcyB0aGUgcmVzdWx0Lg0KPg0KPg0KPiBPdXRwdXQg
b2YgdW5hbWUgLXIgW0xpbnV4IGNwYzR4IDUuNC4wLTQwLWdlbmVyaWMgIzQ0LVVidW50dSBTTVAg
VHVlDQo+IEp1biAyMyAwMDowMTowNCBVVEMgMjAyMCB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUv
TGludXhdDQo+DQo+DQo+IFRoZSBidWcgY291bGQgYmUgcmVwcm9kdWNlZCB3aXRoIHRoZSBmb2xs
b3dpbmcgc3RlcHM6DQo+DQo+DQo+IDEuIENvbm5lY3QgdGhlIChVU0IpLVNvY2tldENBTiBkZXZp
Y2UgdG8gdGhlIGhvc3QNCj4NCj4gMi4gQWRkIGEgbmV3IG5ldHdvcmsgbmFtZXNwYWNlIFtzdWRv
IGlwIG5ldG5zIGFkZCB0ZXN0XSAzLiBNb3ZlIHRoZQ0KPiBDQU4taW50ZXJmYWNlIHRvIHRoZSBu
ZXR3b3JrIG5hbWUtc3BhY2UgW3N1ZG8gaXAgbGluayBzZXQgZGV2IGNhbjANCj4gbmV0bnMgdGVz
dF0gNC4gRGVsZXRlIHRoZSBuYW1lc3BhY2UgW3N1ZG8gaXAgbmV0bnMgZGVsZXRlIHRlc3RdIDUu
DQo+IFJlbW92ZSB0aGUgYWRhcHRlciBmcm9tIHRoZSBVU0ItQnVzLiBJbiBtb3N0IGNhc2VzIHRo
aXMgc2hvdWxkIHJlc3VsdA0KPiBpbiBhIGtlcm5lbCBwYW5pYw0KPg0KDQotLQ0KUEVBSy1TeXN0
ZW0gVGVjaG5payBHbWJIDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQgRGFybXN0YWR0IC0gSFJCIDkx
ODMNCkdlc2NoYWVmdHNmdWVocnVuZzogQWxleGFuZGVyIEdhY2ggLyBVd2UgV2lsaGVsbQ0KVW5z
ZXJlIERhdGVuc2NodXR6ZXJrbGFlcnVuZyBtaXQgd2ljaHRpZ2VuIEhpbndlaXNlbg0KenVyIEJl
aGFuZGx1bmcgcGVyc29uZW5iZXpvZ2VuZXIgRGF0ZW4gZmluZGVuIFNpZSB1bnRlcg0Kd3d3LnBl
YWstc3lzdGVtLmNvbS9EYXRlbnNjaHV0ei40ODMuMC5odG1sDQo=
