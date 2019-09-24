Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA82BD260
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2019 21:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405979AbfIXTHy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 24 Sep 2019 15:07:54 -0400
Received: from mail-eopbgr50133.outbound.protection.outlook.com ([40.107.5.133]:18561
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405389AbfIXTHy (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 24 Sep 2019 15:07:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0hCNAqxF0Leef1FFGpgOfI83NtLi35VVu2uL1nbWGA+It7NUVcRPwRqO0zeLXCu/U/9BOCisv5KKrhJ/KEGuZyn6K2smcMHKxPyR+DlkUzGEfaQxDbc6pHv8RxzyzP0gdnTdFy6SZoKo7Xd20hEUyShd7UEYuHgvhhpE7f7UYG/J8lu0TvjFp0r9NAMHvu+argpoRH9y5nKlfxnT+rl/Idyxp4IsTb8WUUMs3IVfGFaLQ6zBrVxASP+2OVzPdIt80il4nRfd5eh5dLttOR4E1EcQTas1qi5gN9UVg6FQRqh00y9zvB967UVUSpftId54nSV5XIyVXswZNQwxi7jcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIpQRlEndrtBQmV6bfrNcpj9JjARSI7ATT9ks26DV8s=;
 b=LbCmD0QuH6j1MmhSeH3kJ317qV3DbKhckdTejX5fKOgDU3+oJCMKEEKUyQ92piubBBTJobPY+hV88hsM1X8y1Js2H+6iBFp1HCPBoBJuP5EWzUt/mEkHNXHlSV5QBhmIY3jyF58FUiEicHlLjoIobOYUR09PzolxwDK3tVn72D+AjmJe2J6DDKLtObzJtzpBssOO7Ene9W/406k7ODM2iNpu5fFd4sTF4O8wWnjz9y0aT4NIF+XC85LQ2tQKsAvkAP+njjxyXYa9HHWqsKtZdHn/c/qNoKT8FS7A2t6nEva1bJ2H6rYompFef5Eltu4QHMT7qMstjEMTBbsWDezJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIpQRlEndrtBQmV6bfrNcpj9JjARSI7ATT9ks26DV8s=;
 b=e4c1t3IdzOb7XDU/XpC/BsDTsb3NR/r3hsYZT7vJK4ahZ+GcG9dQpHxng1wXl0i1WVeATgTKzjUz2ZbeVWWzgq+SW0Qs5zFgnhak8ZZwuJnUp6cF0mR4PxDYjGcJjI1+99vdNVNtzZc07Iy+MtpSh2i3awS3o1oZh+whdh+6dRo=
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com (10.173.82.19) by
 VI1PR0701MB2879.eurprd07.prod.outlook.com (10.173.73.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.11; Tue, 24 Sep 2019 19:07:49 +0000
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::dc92:2e0d:561a:fbb1]) by VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::dc92:2e0d:561a:fbb1%8]) with mapi id 15.20.2305.013; Tue, 24 Sep 2019
 19:07:49 +0000
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
To:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH 0/7] can: ti_hecc changes
Thread-Topic: [PATCH 0/7] can: ti_hecc changes
Thread-Index: AQHVcwg6BSrribc3JkGUBFOahCqBrqc7MKIA
Date:   Tue, 24 Sep 2019 19:07:49 +0000
Message-ID: <f3666a0a-ff73-767c-4257-823fec5b4ba6@victronenergy.com>
References: <20190924184437.10607-1-jhofstee@victronenergy.com>
In-Reply-To: <20190924184437.10607-1-jhofstee@victronenergy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2001:1c01:3bc5:4e00:c415:8ca2:43df:451e]
x-clientproxiedby: AM3PR03CA0070.eurprd03.prod.outlook.com
 (2603:10a6:207:5::28) To VI1PR0701MB2623.eurprd07.prod.outlook.com
 (2603:10a6:801:b::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhofstee@victronenergy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74c40576-519e-444e-98d5-08d741227ddf
x-ms-traffictypediagnostic: VI1PR0701MB2879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0701MB2879875A231566455E54D0ECC0840@VI1PR0701MB2879.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39850400004)(396003)(376002)(346002)(189003)(199004)(8936002)(305945005)(2501003)(256004)(11346002)(7736002)(52116002)(86362001)(5660300002)(46003)(99286004)(386003)(478600001)(6506007)(8676002)(6486002)(81166006)(81156014)(486006)(476003)(2616005)(36756003)(6246003)(446003)(71190400001)(71200400001)(316002)(110136005)(66446008)(58126008)(66556008)(66476007)(64756008)(6436002)(65956001)(6116002)(14454004)(65806001)(229853002)(66946007)(25786009)(31686004)(2906002)(53546011)(102836004)(186003)(76176011)(31696002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB2879;H:VI1PR0701MB2623.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: victronenergy.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: io3i0Ywx+2zH8E3ZQkzfOFv+WvBvon+w+lvjqz34BukxoTMGVYgmKc22SsOBEkTsqdYVNHDXwYlCLSFig6I9+BwfNiwrmL8AR0gx4dqIZ7mlHYchhfkEJHYVLmufcdaTstusrBsaBpJQ9MMzkBIJ4GsiNf8u3lzkIxBCrGhNf5Aey+PcW5ScPJGQSuyDOftEU/R25w9IEKrXh5b7M7zzJuI15hhsdg9xp3gAbP8el1jWM5QoXWt4pLLwuLEh7D14VQ6ms0mAhUwRjtjWsFXyAVTjK/g0quhnK+1v66owykTRKsth8W4HD3eEaGNfuLh3YquBC2eaKpV30+7k+uRPdZuzDkckyIZFVBAPAxai1d3SAuzn6bS1a0gu+lurGqu4TWjvKlj+X3PKVKfIWZYGbhxDob0mXm/QTUDmehp+0Q4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <283D1C08ED0B984A9A6C78337D24C7DE@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c40576-519e-444e-98d5-08d741227ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 19:07:49.4932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8MEceDSxivWqLRsjI+125orulE177iKh7Zqa3jZ2DYEdRUjPvAk/4zuurk1cF2I95ZIKXVdQuSn1zwYy/rThTmKLRrXIzZuJ5tsXN4cdVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2879
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGksDQoNCk9uIDkvMjQvMTkgODo0NSBQTSwgSmVyb2VuIEhvZnN0ZWUgd3JvdGU6DQo+ICogTWFy
YyBLbGVpbmUtQnVkZGUgc3VnZ2VzdGVkIHRvIHJlbGVhc2UgdGhlIHJ4IG1haWxib3hlcyBhIGJp
dCBlYXJsaWVyLA0KPiAgICB0aGF0IGlzIGluY2x1ZGVkIGhlcmUuIEl0IGlzIHByZWNlZGVkIGJ5
IGEgc21hbGwgY2hhbmdlIGluIHJ4LW9mZmxvYWQNCj4gICAgdG8gbWFrZSBpdCBjbGVhciB0aGF0
IGFsbCBtYWlsYm94ZXMgYXJlIHJlYWQuIEl0IGlzIG5vdCBhIGZ1bmN0aW9uYWwNCj4gICAgY2hh
bmdlLg0KPiAqIFRoZSBDQU4gcHJvdG9jb2wga2VybmVsIChDUEspIHNob3VsZCBiZSBzdG9wcGVk
IHdoZW4gdGhlIGludGVyZmFjZQ0KPiAgICBnb2VzIGRvd24uDQo+ICogVGhlIHR4IHBhdGggaGFz
IGEgKGhhcm1sZXNzKSByYWNlIGZvciBIRUNDX0NBTk1JTS4gSnVzdCBrZWVwIGl0IHNldC4NCj4g
KiBUaGUgaW50ZXJmYWNlIHN0YXRlIGtlZXBpbmcgY2FuIGxhY2sgcmVzdWx0aW5nIGluIHdyb25n
IGludGVyZmFjZSBzdGF0ZXMsDQo+ICAgIHRoZSBzdGF0ZSBpcyBub3cgYmFzZWQgb24gdGhlIGlu
dGVycnVwdCBmbGFncyBhbmQgYXJlIHVwZGF0ZWQgZGlyZWN0bHkuDQo+ICogVGhlIGRyaXZlciBs
YWNrZWQgYSBtYW5uZXIgdG8gbG93ZXIgdGhlIHN0YXRlIGFnYWluLiBUaGlzIGlzIGFkZGVkDQo+
ICAgIGJhc2VkIG9uIHRoZSBlcnJvciBjb3VudGVycy4NCj4NCj4gSmVyb2VuIEhvZnN0ZWUgKDcp
Og0KPiAgICBjYW46IHJ4LW9mZmxvYWQ6IGNvbnRpbnVlIG9uIGVycm9yDQo+ICAgIGNhbjogdGlf
aGVjYzogcmVsZWFzZSB0aGUgbWFpbGJveCBhIGJpdCBlYXJsaWVyDQo+ICAgIGNhbjogdGlfaGVj
Yzogc3RvcCB0aGUgQ1BLIG9uIGRvd24NCj4gICAgY2FuOiB0aV9oZWNjOiBrZWVwIE1JTSBhbmQg
TUQgc2V0DQo+ICAgIGNhbjogdGlfaGVjYzogYWRkIGZpZm8gdW5kZXJmbG93IGVycm9yIHJlcG9y
dGluZw0KPiAgICBjYW46IHRpX2hlY2M6IHByb3Blcmx5IHJlcG9ydCBzdGF0ZSBjaGFuZ2VzDQo+
ICAgIGNhbjogdGlfaGVjYzogYWRkIG1pc3Npbmcgc3RhdGUgY2hhbmdlcw0KPg0KPiAgIGRyaXZl
cnMvbmV0L2Nhbi9yeC1vZmZsb2FkLmMgfCAgIDIgKy0NCj4gICBkcml2ZXJzL25ldC9jYW4vdGlf
aGVjYy5jICAgIHwgMjA4ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAxMjYgaW5zZXJ0aW9ucygrKSwgODQgZGVsZXRpb25zKC0pDQo+DQoN
CkkgZm9yZ290IHRvIG1lbnRpb24gdGhhdCBJIGFkZGVkIHRoZSBmaWZvIHVuZGVyZmxvdyBjb3Vu
dGVyLi4uDQoNClJlZ2FyZHMsDQoNCkplcm9lbg0KDQo=
