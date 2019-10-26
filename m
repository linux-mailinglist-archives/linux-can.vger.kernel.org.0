Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8209BE5FB4
	for <lists+linux-can@lfdr.de>; Sat, 26 Oct 2019 23:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfJZVWc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 26 Oct 2019 17:22:32 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com ([40.107.8.108]:59921
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfJZVWc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 26 Oct 2019 17:22:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeVr1kM+GP2HC8MecfvHYXbj2uQcyD7X3wzaBgtz7zzTUavWcW9JjzIqKKA2Woh+Rkpb3MXSGl//E6ZR2nk9192Idy4/NJVxW8ZxxkpwlSFe4Il9XV7oXWZuUabFGl4UsyH9uR3oNRQT7m3BehqybyS5n2cy4TddbR/ihl+ox4rG6go2qaKdW+tNdUAu2HNppkfz7sidHiVNlSP+KqlNduhrd4qm+OTra5qC9fzWRgATwd0Kjo1ugaAPy/jaJpUZfjFpecu5ENtCXHxxK0D5bOw885Qr207TyqQaHygLxdYqI/1eJ2D6tBUQr/yp1xga7Avnoqd9xpiYOsNYQwLr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS1FwWpKRsgaRv694hPouB0WIxHW3Qj/DZ4VLzYHXhc=;
 b=jIObSlFBHcEN3eiZb/x5M6tn7xT0YOnfVrrX2iRj2CqyEMZwCTxuMav+FM8UAKklP3Gi+6PVGiR//I1s4c7zf01+tKdE7xLBbD+Xvb/HpuTqelVf+S478gIOj3yAqVWA6D5ukYouEbse93VsrwOwYyH6mir72X8q7z+Vj4iUnNtMPIkpVxHm1lslkWZ91aQeIk3VrzDa3J4p6Wr19iqL6JbOa+odaxFd3vZxheyg/u5RVWsJj+tua5KVhF354sDdohTyFDdeBVZ+cNk8O5kYNnY2sRFWMTbLOBiAWP0Q/KTxT0ev9Uqx4VpOot6VxG2Op4nRQCYtv7wKYeeFztZXZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS1FwWpKRsgaRv694hPouB0WIxHW3Qj/DZ4VLzYHXhc=;
 b=xRx2GDDiDgZtVG574FZOs5uAiroJzVFdGp4dxZ2MnlOnPuW5WhrqKKnvzVT9ZcwphJjrOM+nVm+JwZiwxIJx4vaPuaI//IzgXoZCI0ObEKb0bOIHGgUX0GrQqHTXsLJe1b/F5f2EGfJaikaTZA1l9q+8hC06SdgJZsE5nmZXRSI=
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com (10.173.82.19) by
 VI1PR0701MB2413.eurprd07.prod.outlook.com (10.168.138.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.14; Sat, 26 Oct 2019 21:22:26 +0000
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::49b7:a244:d3e4:396c]) by VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::49b7:a244:d3e4:396c%9]) with mapi id 15.20.2408.014; Sat, 26 Oct 2019
 21:22:25 +0000
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
To:     Jacob Schloss <jacob.schloss@suburbanembedded.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: CAN FD support in slcan - protocol extension?
Thread-Topic: CAN FD support in slcan - protocol extension?
Thread-Index: AQHVjDNvVfk/HZhozkyg1cBuUDLVH6dtboOA
Date:   Sat, 26 Oct 2019 21:22:25 +0000
Message-ID: <97900bc5-48cc-b167-203d-ec7735009009@victronenergy.com>
References: <CACj_+4Y8904tbswy76Fpp6wGKZPdNpSrfDq6BvfTAGzs4zHT8w@mail.gmail.com>
In-Reply-To: <CACj_+4Y8904tbswy76Fpp6wGKZPdNpSrfDq6BvfTAGzs4zHT8w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2001:1c01:3bc5:4e00:4d63:6fc9:988:d2f1]
x-clientproxiedby: AM4PR08CA0059.eurprd08.prod.outlook.com
 (2603:10a6:205:2::30) To VI1PR0701MB2623.eurprd07.prod.outlook.com
 (2603:10a6:801:b::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhofstee@victronenergy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a78c8aa-efc8-4963-00ec-08d75a5a98ba
x-ms-traffictypediagnostic: VI1PR0701MB2413:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <VI1PR0701MB2413EE5A7E63F5ECD403C70AC0640@VI1PR0701MB2413.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0202D21D2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(366004)(39840400004)(376002)(189003)(199004)(6246003)(8676002)(66476007)(256004)(25786009)(2501003)(81156014)(81166006)(65806001)(65956001)(7736002)(305945005)(2906002)(8936002)(229853002)(2616005)(476003)(11346002)(110136005)(71200400001)(486006)(71190400001)(58126008)(31686004)(446003)(6512007)(5660300002)(14454004)(46003)(6306002)(66946007)(64756008)(66556008)(36756003)(66446008)(53546011)(99286004)(52116002)(76176011)(316002)(6116002)(31696002)(186003)(86362001)(6506007)(386003)(102836004)(478600001)(6486002)(966005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB2413;H:VI1PR0701MB2623.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: victronenergy.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RJXU4tOC3Ij6kDlo1R/spzoG2PPxrL91q6C+lu0epwfyJH9QAZQbIhvGK/qJ2RjyiS0f1vMIJlq1BxJlsn2x8y3J17+NyCpOYy4guOog4Loe1wc0Uq3xEfhRNnlx07GemUhHLTb5zed309PS1BdRqFRys60XmSPRQRqaYJLEO3pmEdApw8y8yD7lAI3pCJLGEF3Abm9gCHXkf2sAin6OBv02XrKrABgA5POqedZJ3npQzDR39UkZSYPz3RpvyrhmvFRn4t7WgKX5BOgV+dMO0edzRvJYMTtTOKJhE0HrOg3JapdgoGw5bJlc6EPnoRdRBOESl8vGzaeiz4LkRRh/ib6fdWJzDAZWPMgnKoNtJCIkcCC+6RpvMueuz74fUP4mTjcmyO0e/gtHpbQ+1+SkcnhRXpMfncSHNDpJtipuawqA2N5j0YVVrgwdk0y4XsThhfkV2xp7l5z60lWxvDnPio6m57jBYdkJb6BL+lthjAY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7922C89E9DFB90469DD8A5363414308F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a78c8aa-efc8-4963-00ec-08d75a5a98ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2019 21:22:25.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bfv9okxr2PQGYFzoBkboTbmR18Xa2ClnApGp3Ssf06D8lrOwC4cCg+R5F/s4UitF6WcLVRVmmaRaGZ2dvT4xe/5T0HXrNZQ7Z+uRbS5Cd1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2413
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gSmFjb2IsDQoNCk9uIDEwLzI2LzE5IDk6MjcgUE0sIEphY29iIFNjaGxvc3Mgd3JvdGU6
DQo+IEhpLA0KPg0KPiBXZSd2ZSBtYWRlIGEgbGl0dGxlIENBTi1VU0IgYWRhcHRlciB0aGF0IGlz
IG1vc3RseSBjb21wYXRpYmxlIHdpdGggdGhlDQo+IExhd2ljZWwgQUIgdGV4dCBtb2RlIHByb3Rv
Y29sIHRoYXQgaXMgY29tbW9uIGZvciBzZXJpYWwtdG8tY2FuDQo+IGFkYXB0ZXJzLCBidXQgd2l0
aCBzb21lIGV4dGVuc2lvbnMgZm9yIENBTiBGRC4NCj4NCj4gaHR0cHM6Ly9naXRodWIuY29tL3N1
YnVyYmFuZW1iZWRkZWQvaGFkb3VjYW4tZncNCj4gaHR0cHM6Ly93d3cudGluZGllLmNvbS9wcm9k
dWN0cy9zdWJ1cmJhbmVtYmVkZGVkL2hhZG91LWNhbi11c2ItY2FuLWZkLWFkYXB0ZXIvDQo+DQo+
IFVzZXIgR3VpZGUNCj4gaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL29wZW4/aWQ9MU10WUVBVkRG
Mkltb1ZfNm5tZmpQM285c0dNTXd4Y2syd1JxTFJDV2hhVFUNCj4NCj4gVGhlIGRldmljZSBzdXBw
b3J0cyBDQU4gRkQsIGFuZCBJIGFyYml0cmFyaWx5IHBpY2tlZCBhIG5ldyBhc2NpaQ0KPiBjb21t
YW5kIHRvIHN1cHBvcnQgc2VuZGluZyBhbmQgcmVjZWl2aW5nIENBTiBGRCBwYWNrZXRzLCBidXQg
aXQgd291bGQNCj4gYmUgaW50ZXJlc3RpbmcgaWYgd2UgY291bGQgc3RhbmRhcmRpemUgRkQgc3Vw
cG9ydCBhbmQgYWRkIGl0IHRvIHNsY2FuLg0KPg0KPiBSaWdodCBub3cgSSdtIHVzaW5nICdkJyBm
b3IgYW4gRkQgbWVzc2FnZSB3aXRoIGFuIDExIGJpdCBpZCwgJ0QnIGZvciBhDQo+IEZEIG1lc3Nh
Z2Ugd2l0aCBhIDI5IGJpdCBpZCwgYW5kIHBlcm1pdHRpbmcgRkQgZnJhbWVzIHRvIGhhdmUgRExD
DQo+IGNvZGVzIDktRi4gSSBjYW4gY2hhbmdlIHRoYXQgaWYgbmVlZGVkLiBCUlMgaXMgZW5hYmxl
ZCBzZXBhcmF0ZWx5IHZpYQ0KPiBhIGNvbmZpZyBzZXR0aW5nLg0KPg0KPiBEb2VzIGl0IG1ha2Ug
c2Vuc2UgdG8gdHJ5IGFuZCBjb29yZGluYXRlIGFuIGV4dGVuc2lvbiB0byB0aGUgdGV4dCBtb2Rl
DQo+IHByb3RvY29sPyBJJ2QgbGlrZSB0byBiZSBhYmxlIHRvIHNlbmQgQ0FOIEZEIGZyYW1lcyB0
aHJvdWdoDQo+IHNsY2FuZC9jYW5zZW5kIGV0YyBhbmQga2VlcCBjb21wYXRpYmlsaXR5IHdpdGgg
YW55IG5ldyBoYXJkd2FyZSB0aGF0DQo+IG1pZ2h0IHN0YXJ0IGNvbWluZyBvdXQuDQoNCkFyZSB5
b3UgYXdhcmUgb2YgaHR0cHM6Ly9naXRodWIuY29tL2NhbmRsZS11c2IvY2FuZGxlTGlnaHRfZnc/
DQpUaGF0IHVzZXMgYSBvbmUgb24gb25lIGJpbmFyeSB2ZXJzaW9uIG9mIHRoZSBzb2NrZXRjYW4g
ZHJpdmVyLg0KDQpUaGF0IF9taWdodF8gYmUgc3RyYWlnaHRmb3J3YXJkIHRvIGV4dGVuZCB0byBG
RC4gQW5kIHRoYXQgcmVhbGx5DQppcyBhIG1pZ2h0LCBzaW5jZSBJIGRvbid0IGtub3cgaG93IGl0
IGlzIGltcGxlbWVudGVkLCBidXQgSSB3b3VsZA0KZ3Vlc3MgaXQgaXMgYSBmbGFnLg0KDQpXaXRo
IGtpbmQgcmVnYXJkcywNCg0KSmVyb2VuDQoNCg==
