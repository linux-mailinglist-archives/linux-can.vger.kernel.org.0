Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526F1CF4FA
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 10:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfJHIYw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 04:24:52 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com ([40.107.8.121]:26882
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730292AbfJHIYv (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 8 Oct 2019 04:24:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffe/kplofKQGMhJ0jHZdDZ5ExRArQV6PlV3tfE70Dt/c+WyABPHvha+q0WSl5U3bJdsyGSiyhcizLZuqictaR4H0Sf0USdtw0Ge115a6JnGQ+I7Z+c7FwSPB7KvWSL/6EE8P4ockhKMtGWNRppsh+3FuNwaxV6xpDzUEASBYaKEmgvadWVlt4PXEpCM3rjeTjfAbx985sTG8iPDVpOHo6T4enHG0Xl7xBAYPOj6OxylIwhvT9ea5jR1B6U1nDCg2d6VIylNSd9AO2clw7djwXFUJO+JZJmC5n6PN1rlKCeBItbJgUt0uNVh+y3YstSTEFCqGOn47pKl0ZjtVJCbKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hHRN0mMboHJt9s3L9yTX9yLnuZs180NGhsSRrcirRM=;
 b=HF914XG4ZY+zUue8nsAWbn7nzpOjd9L89/WSbWQU6YQoWn1f67Pd5Qt+VKxirmtgFHVk/JvlcC7SAzL5iD90nKyVNmZDZCmoSE+ZmiMzC67++mDrPadzfRwkxoHtXPLL0WTKUD6Fc9kQAxI+l/8zDaihm/fbJ7o3FdZom8XRSAtwb23UQZNJfBvPTpyzO3sd6/OoZgE4q5uVMmBeAf9i8vOgou65GBV+d4Ht92x3AI0W3LVIZbwjjrqND1Ty44L+m8sahBLcZEaavlL0Iz9TrBxP3Drh3ZCUW1CWxwyfh8KF2MOkRrVPWlkth38Zu9r5YiU99Ck47Io1HO6qQ6O7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hHRN0mMboHJt9s3L9yTX9yLnuZs180NGhsSRrcirRM=;
 b=wfeXxOOS4zm4d+elKjxH+1TLdJUnj1f3JtFO0+kF00757PmOjym1qAzYftLsNoYsms0OjdCtP+m+8wj3as4f2pcKQd2SvYlfx04VAZrzRRG1LUmXqUP6agP9+aZ5PUi9LAd6rKTTtMiyFH2v4lz8QCC0J9Rb+JAGh9dK3g45n3w=
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com (10.173.82.19) by
 VI1PR0701MB2510.eurprd07.prod.outlook.com (10.168.139.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.11; Tue, 8 Oct 2019 08:24:46 +0000
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::49b7:a244:d3e4:396c]) by VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::49b7:a244:d3e4:396c%9]) with mapi id 15.20.2347.016; Tue, 8 Oct 2019
 08:24:46 +0000
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH] can-rx-offload: free echo_skb when not queued
Thread-Topic: [PATCH] can-rx-offload: free echo_skb when not queued
Thread-Index: AQHVePL9IgaqPT8nOUyUpPWh6btP4qdQb/eAgAAB0AA=
Date:   Tue, 8 Oct 2019 08:24:46 +0000
Message-ID: <4996dc74-bbf4-a667-60bf-c77f79f8fb3b@victronenergy.com>
References: <1570001287-32420-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <20191008081815.GB20524@x1.vandijck-laurijssen.be>
In-Reply-To: <20191008081815.GB20524@x1.vandijck-laurijssen.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2001:1c01:3bc5:4e00:58f1:a5aa:4c48:a7ed]
x-clientproxiedby: AM0PR02CA0019.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::32) To VI1PR0701MB2623.eurprd07.prod.outlook.com
 (2603:10a6:801:b::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhofstee@victronenergy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7961f2a5-b9b0-4fcf-4cfb-08d74bc8fa30
x-ms-traffictypediagnostic: VI1PR0701MB2510:
x-microsoft-antispam-prvs: <VI1PR0701MB251080FAF0DEA70F117D3456C09A0@VI1PR0701MB2510.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39850400004)(396003)(366004)(136003)(189003)(199004)(66446008)(486006)(476003)(2351001)(102836004)(186003)(7736002)(305945005)(53546011)(66476007)(66556008)(64756008)(31696002)(66946007)(6506007)(8936002)(6512007)(386003)(446003)(11346002)(86362001)(46003)(6486002)(8676002)(65806001)(6436002)(65956001)(25786009)(52116002)(6916009)(81166006)(81156014)(36756003)(256004)(2616005)(229853002)(76176011)(99286004)(5640700003)(31686004)(6246003)(58126008)(6116002)(2906002)(316002)(2501003)(14454004)(5660300002)(478600001)(71200400001)(71190400001)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB2510;H:VI1PR0701MB2623.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: victronenergy.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aidn2yJSKzX3I4VTzN0uMwWhOOQYFU1IPjXVfeUj04f3snLBkjrqKgmlkxJK7l9zXBtelcXjuH26teD7q7a2KFEOq2b/zbZQysAx8TpdFhgRwAXkczFKECxNeQUifDmcxuT+fMTJi18JSR4anPxWzEXxL94hJy3idjrmkWMeJZiKjKAH+C9KQDPu420B9uS+84L1AIa7x+f0z+FfvkQmCNH9LtqcwWaZBnh5yBmswo4tqw9X3N5qfhSd1wYOS/mzR0niL9I8MoUPM6b3xPT/Dt6MXxmT6ath8YQ4FYv4m2yJchkGsJJw/Byl9jicpz4EEwaEFngHRcfAJzGIEHmMi036J2hTso8w02OQYkysQYBtB8zi+7VZEmKQrxc1lhbEKsFPAHUttKdJ0TIzmBy9Fp9+xL/iZLogVXftGqI9jJU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <61D347C78B1EAB4AAC3B48636C6ADAFF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7961f2a5-b9b0-4fcf-4cfb-08d74bc8fa30
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 08:24:46.2174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+pT/j3RirMo+LqDv1nU2hiSqLafoKUVklx2xX+lPRNFbC0i36zswdcngUtVhmprc0xrGiBMOL4yuAcBsyS2VFAUpwxoMnAoY+mCF69Hblo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2510
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gS3VydCwNCg0KT24gMTAvOC8xOSAxMDoxOCBBTSwgS3VydCBWYW4gRGlqY2sgd3JvdGU6
DQo+IFBpbmcNCj4gTWFyYywNCj4NCj4gRGlkIHlvdSBsb29rIG92ZXIgdGhpcyBvbmUuDQo+IEkg
aGFkIGl0IGluIGEgc2VwZXJhdGUgdGhyZWFkIGFzIGl0IGNvdmVycyBhbiBpc29sYXRlZCB0aGlu
Zy4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IEt1cnQgVmFuIERpamNrIDxkZXYua3VydEB2YW5kaWpj
ay1sYXVyaWpzc2VuLmJlPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvbmV0L2Nhbi9yeC1vZmZsb2Fk
LmMgfCAxICsNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9yeC1vZmZsb2FkLmMgYi9kcml2ZXJzL25ldC9jYW4v
cngtb2ZmbG9hZC5jDQo+PiBpbmRleCBlNmE2NjhlLi5hOGFjYjJhIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9uZXQvY2FuL3J4LW9mZmxvYWQuYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvY2FuL3J4
LW9mZmxvYWQuYw0KPj4gQEAgLTIzOCw2ICsyMzgsNyBAQCB1bnNpZ25lZCBpbnQgY2FuX3J4X29m
ZmxvYWRfZ2V0X2VjaG9fc2tiKHN0cnVjdCBjYW5fcnhfb2ZmbG9hZCAqb2ZmbG9hZCwNCj4+ICAg
DQo+PiAgIAllcnIgPSBjYW5fcnhfb2ZmbG9hZF9xdWV1ZV9zb3J0ZWQob2ZmbG9hZCwgc2tiLCB0
aW1lc3RhbXApOw0KPj4gICAJaWYgKGVycikgew0KPj4gKwkJa2ZyZWVfc2tiKHNrYik7DQo+IEFt
IEkgcmlnaHQgdGhhdCB0aGUgc2tiIHdvdWxkIGhhdmUgYmVlbiBsb3N0IGluIGNhc2UgdGhlIHF1
ZXVlIHJlYWNoZWQNCj4gaXQgbWF4IGxlbmd0aCBhbmQgeW91J3JlIGRyb3BwaW5nIG1lc3NhZ2Vz
Pw0KPg0KPj4gICAJCXN0YXRzLT5yeF9lcnJvcnMrKzsNCj4+ICAgCQlzdGF0cy0+dHhfZmlmb19l
cnJvcnMrKzsNCj4+ICAgCX0NCj4+IC0tIA0KPj4gMS44LjUucmMzDQo+Pg0KZm9yIHdoYXQgaXQg
aXMgd29ydGgsIEkgbG9va2VkIGF0IGl0IGFuZCBJIHRoaW5rIGlzIGNvcnJlY3QsDQpidXQgY29t
cGxldGVseSB1bnRlc3RlZC4uDQoNClJlZ2FyZHMsDQoNCkplcm9lbg0KDQo=
