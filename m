Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626E1C288F
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2019 23:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfI3VRt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Sep 2019 17:17:49 -0400
Received: from mail-eopbgr20090.outbound.protection.outlook.com ([40.107.2.90]:51266
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729190AbfI3VRt (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 30 Sep 2019 17:17:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UllK+9J6KIXcJyafp39lGxpL6t1IarXlqyv7tBOpUHuKXyZsqKv4j2P3EPpfq7m5B7RowBNIHIQxnnpVwG2CQt6tphAsVfUIGhlfk4n4ff93vBqV8KJA4Orj+DRyXPdZwZ//c4p4RVWNp8GydeveyNeLOYGpcDsN4uhLoVjSw9B/jKL42IKf9fEo/kIlwY4HNpwNLi5Xt398tiA8pnAJgFG0TH+0pzmMPwR3PIBWpt59Tzz0pT4VkGMajMXrV1Zn2iQaBsJ8SgcxXu7sU1VpxjIDaBC+X7pjAR6WTkcrGxyR/+5bPOCY+bW+ucq6oPmKvIu7xWIZmq+SrqN2FjWvjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSCsErbXLoECCw8Lbb/xXHBX6vM82QPPSNntv3SwuR0=;
 b=GrEAfgbDWqKk3If//s6wEEyO+QLUYIS/+8IOSmk+14L0iZUK6u3wRoVLPupYp4wkJLso4A7OilsbLp6CxdC1etr17KRHJQn13b2QLwQqPo7lrEt5/Co7aFueItvvMNg488nixRM0DeyJRc9mYqFnq0gP4TnJvKfvXCCW4M7OS5R08KL2dZYTdkWwO9h4GK75KirOAb7vwJpLL+9pn6CzbK/xED0mFkGamjpfkT60bMh1iojI2+NZba4eKLWfZZHFe4gr6oNzL5ukQ9lCOa/+1/FyxEYFhsEb+KkTG6sop68DA93ARGhXyC+OsxCs30hMck3r0M9uYxd5dNUvPJkycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSCsErbXLoECCw8Lbb/xXHBX6vM82QPPSNntv3SwuR0=;
 b=JNBdZHwYfAQPEa2hMbAMAVDRj9qD/3zAqa0SqoWj8zWuI/TzVH5L1q/Hbl1ifK0isTKGk9LQhUd7zgxyl/sD3pZjgZIPlO9d3X/TfR7PkeK07liqE077Kog7Mh3xxnVqzBZnn4zmQ0c5MlsahIZQxFSi2JMhWRHAmI/4ul0A2mY=
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com (10.173.82.19) by
 VI1PR0701MB2288.eurprd07.prod.outlook.com (10.169.130.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.9; Mon, 30 Sep 2019 21:17:44 +0000
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::dc92:2e0d:561a:fbb1]) by VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::dc92:2e0d:561a:fbb1%8]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 21:17:44 +0000
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [RFC] c_can improvements
Thread-Topic: [RFC] c_can improvements
Thread-Index: AQHVd9ALofWyf5UdhESfsE7dEhT6wKdEuV0A
Date:   Mon, 30 Sep 2019 21:17:44 +0000
Message-ID: <6f043fdd-8ade-c8cc-1894-152a2ecdc51f@victronenergy.com>
References: <1569871843-28655-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
In-Reply-To: <1569871843-28655-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2001:1c01:3bc5:4e00:68d9:7b1a:3391:f6c7]
x-clientproxiedby: AM4PR0902CA0022.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::32) To VI1PR0701MB2623.eurprd07.prod.outlook.com
 (2603:10a6:801:b::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhofstee@victronenergy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab0adf77-1989-429f-d168-08d745eba283
x-ms-traffictypediagnostic: VI1PR0701MB2288:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0701MB2288B5A857CDE7383DFF1F90C0820@VI1PR0701MB2288.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(366004)(376002)(136003)(39850400004)(189003)(199004)(53546011)(31696002)(386003)(65956001)(6506007)(8936002)(2906002)(65806001)(6512007)(486006)(316002)(4744005)(8676002)(81166006)(81156014)(110136005)(86362001)(76176011)(58126008)(102836004)(52116002)(6306002)(66476007)(66946007)(66556008)(14454004)(6436002)(64756008)(66446008)(6246003)(99286004)(71200400001)(229853002)(5660300002)(71190400001)(6486002)(36756003)(305945005)(31686004)(966005)(186003)(2501003)(256004)(14444005)(7736002)(446003)(478600001)(6116002)(11346002)(46003)(2616005)(476003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB2288;H:VI1PR0701MB2623.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: victronenergy.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K/RJSF16pxmKBBU+T/XuSpMROqGUGYjKCRz5yPgvqjMIqe+v1TwQKXJ943kdAOAF6G9MwzFYMF0EuJvucUOSVRtueDaUgsOxbpSuEU5i8DGn3zZTO9jRxXHo+yT1VsopQTy0P+DLNHolVbNJyYfByCBTSgodrQ+6FHu/hyxQeI7665e3+MllnFRi/fJmZl2OAg5boW5foGbSYUoxLRtS/Y+qmKJ8tWbf8oRKpnSWCxeLa2TycLm+kvc2MZUCRLM+0mHiDvlGBJruFThvtZx/EDHeJnQfNGJqBopIKwiuNBhZ5D9AHt9vhd5m9ZegjkVJuocUw3i3onfwhBhGsblacu+YEv4PiP8DdYf3BxQ+mOvvXLpoCTWWr2DF8pDA672bgfy7LuOHiv3ttf9oY99rGHd1cjDeYSir8yCncrT0MWkFWhArht7Uuzc6WUIZur/pnfBtQxqQtwXLWmd/bfe+tg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC18A14E135C0A40B3E2E1D678252A11@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0adf77-1989-429f-d168-08d745eba283
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 21:17:44.3792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RT9oMM5N6Rggl/17cgBA1rtE2vlAeULH7+epxeLRdfcifER/FBwKgEfN1GI5WgmjfSRAXD6FxVUy23F0dWP4QjHkH8A8a/aUNkcFkCEEIZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2288
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gS3VydCwNCg0KT24gOS8zMC8xOSA5OjMwIFBNLCBLdXJ0IFZhbiBEaWpjayB3cm90ZToN
Cj4gRmlyc3QgcGF0Y2ggd2lsbCAodHJ5IHRvKSByZW1vdmUgbG9zdCBidXNvZmYgY29uZGl0aW9u
cyBieSBub3QgcmVhZGluZw0KPiB0aGUgc3RhdHVzIHJlZ2lzdGVyIHdpaHRvdXQgcGVuZGluZyBz
dGF0dXMgaW50ZXJydXB0Lg0KPiBUaGlzIGhhcyByYW4gZm9yIHNldmVyYWwgd2Vla3MsIGFuZCBu
b3QgcHJvZHVjZWQgYW55IGxvc3QgYnVzb2ZmIChJJ20NCj4gbm90IHN1cmUgaXQgd291bGQgaGF2
ZSBpc3N1ZWQgYSB0cnVlIHBvc2l0aXZlIGluIHRoaXMgdGltZSkuDQo+IEkgcnVuIHRoaXMgb24g
YSBiZWFnbGVib25lLWFsaWtlIGJvYXJkLg0KPg0KPiBOZXh0IHBhdGNoIHdpbGwgdGVhciBjX2Nh
biBib3R0b20gaGFsdmUgaXNyIG91dCBvZiBuYXBpIHNvIEkgY2FuIGJldHRlciBjb250cm9sDQo+
IGl0J3MgUlQgcHJpb3JpdHkgd2l0aG91dCBhZmZlY3Rpbmcgb3RoZXIgbmFwaSBoYW5kbGVycyBp
biB0aGUgc2FtZSBzb2Z0aXJxLg0KPg0KPiBMYXN0IHBhdGNoIHdpbGwgY29tYmluZSB0b3AgYW5k
IGJvdHRvbSBoYWx2ZSBpc3IgaW4gY2FzZSBvZiBmb3JjZSBpcnEgdGhyZWFkaW5nDQo+IGxpa2Ug
b24gYW4gUlQga2VybmVsLiBIYXZpbmcgdGhlIGlycSBzcGxpdCBhY3Jvc3MgMiB0aHJlYWRzIGRv
ZXMgbm90IHNlZW0gd2lzZS4NCg0KSSB3aWxsIGhhdmUgYSBiZXR0ZXIgbG9vayBhdCB0aGlzLCBi
dXQgY2FuIHlvdSBhbHNvDQpsb29rIGF0IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xp
bnV4LWNhbi9tc2cwMjMwMi5odG1sPw0KSXQgbWlnaHQgc29sdmUgcGFydCBvZiB5b3VyIGlzc3Vl
LCBidXQgYXQgbGVhc3QgdGhlcmUgaXMgYQ0KbWVyZ2UgY29uZmxpY3QgdGhlcmUsIEkgdGhpbmsu
Lg0KDQpSZWdhcmRzLA0KDQpKZXJvZW4NCg0K
