Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708B626D11D
	for <lists+linux-can@lfdr.de>; Thu, 17 Sep 2020 04:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgIQC2Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Sep 2020 22:28:24 -0400
Received: from mail-vi1eur05on2040.outbound.protection.outlook.com ([40.107.21.40]:27585
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgIQC2W (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 16 Sep 2020 22:28:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeHfaCpzgqY06uAJh/IMvNvF2Jn9Rkk8OO1Pqq3qEw360p1yZYpKXMm95cN5sOxHLgzZm3NzPhfXfQFApwjPY8yWr8kqohKfQuQmc0MMcIcTYEtlgLhEtRMhiKPwwslTbBMOj3h+wBTIoTWCP5lswLiv0hWhlJtabM9ILBZrOB7rNWVy5iEgeTtn2BKFZ5HSiL58PpZhlI+Kvg2NtgwCXTsRbK5zv+2B0fVf8WLS2/TpBzYrHh2zmZEWGOO+9yv+cnAIMT2NN9EDJIHhWaxDy0Sl5XA6tqlX/L0iSfwVXyn9Hk/BBHSs+28CvP5v+n7JjrFcMcxlxZt7FETQWL9Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98Kdt8wMagAsWpVii1F57PPPi9+TCR975+YHMmoQ5Fc=;
 b=dUdWpcqSW5lK07Eon6rPyFhCntghFhIWbIX2nlA9t2zzZbXr2vCp5CvzH09vL1RUCbKbQGQujXulNHtB+aDCEm9/HRhTxgP7TwqLneOAyHV96qF8/aS8wiLTko/JQgPNoy8CilM6PQDFHDt6IiyS8JQxsIGin8xBfZA+QDGvW5dFP5O/Z9o527f54dzaZMOb3V4MNXlw8yUu3bUzEzM8YQ0Sh05I2MFvCkpmE9MBxje+bTjxPCGpPHKZWnDopex2TzMvw0FTFCKgAdtfz3rgqB5rKa2/6dpXqQCAfdNq/ngSl2hfv0cRxOlrKo6Y5GHaeBQxS4euJMKdkiouXa7Lew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98Kdt8wMagAsWpVii1F57PPPi9+TCR975+YHMmoQ5Fc=;
 b=DX+mwe7Ce0jMWS7JhQN4EZHhi70MKEEDr3QNGqMvYMJB5UeiT+kyqMxBDPGGTyyFx7SeEZIvORHJ7v6pic9tkqnXieWeOPBCgQ0F8BOUGzUmYELrBUI1F5caayOAkcY98wBYX6hifPlm5Q5LHSxQfuYWYLKRRDW7f6hjZCXHpXI=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0402MB2727.eurprd04.prod.outlook.com (2603:10a6:4:98::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 02:28:19 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::d12e:689a:169:fd68%8]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 02:28:18 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "Pankaj Bansal (OSS)" <pankaj.bansal@oss.nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: canfdtest on flexcan loopback
Thread-Topic: canfdtest on flexcan loopback
Thread-Index: AdaA1oPvF2ksseKmSLeb8OzLcaFJ8QLQkV0AAAAZ7gAAAPp9gAAAcdiAAACLxoAAHKBHIA==
Date:   Thu, 17 Sep 2020 02:28:18 +0000
Message-ID: <DB8PR04MB6795D95B0B9905C4B25D764EE63E0@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <VI1PR04MB4093944944C574B138371F51F12F0@VI1PR04MB4093.eurprd04.prod.outlook.com>
 <20200916110154.hp4up6yhyokduvf2@skbuf>
 <20200916110448.dsla6vjzy4fvdr22@skbuf>
 <12688d2b-a198-ef5e-dd8f-64957df36574@pengutronix.de>
 <20200916114533.3hlthhfd7xmpamoa@skbuf>
 <77d5c83d-1fb2-0d8a-f1ed-bec4857796e7@pengutronix.de>
In-Reply-To: <77d5c83d-1fb2-0d8a-f1ed-bec4857796e7@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: olteanv@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 403831d2-3b14-43d3-3798-08d85ab156fd
x-ms-traffictypediagnostic: DB6PR0402MB2727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2727B6078285B2006B0A2546E63E0@DB6PR0402MB2727.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0KrkUSFBriIucTGqXK8D/nwh4DN+h1dPOnI+gRKYS8rOk9yACS9wHekigBxidTFhzJKdRu3tmf8oUVvusRvBOE3sADmRPGZa/0UarRDEPv8UzflZDv2ey9X2TWLnehH46gf6t4WQaxmexZ2GrXE6DbAzIi3kkoqa04f5g8NJMzfZhTOIJcBYJXuaWYMD+9F57iICzl3AH6pVxmptJ/ad3vhHBYLJFfCpliR9aVCIlg/O2YHlPXt4UqnNx8ZSN1uCxjxKTYjhezRhyAlvb9ojwNPs3AQayeNLs519w3tIUMJ1y3ggXf5UrzXiHXN/EW9Z2WbM7/qZjVN8PdcfLZcxchs95Z1TbRKDnJ1exjiy9xGOGjFvL14jwzgQ1y6KNa5rhU2Ge4NE/ve1g5rkIBmZ4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(33656002)(7696005)(71200400001)(55016002)(83080400001)(83380400001)(53546011)(966005)(8936002)(6506007)(26005)(4326008)(5660300002)(110136005)(8676002)(3480700007)(54906003)(478600001)(86362001)(186003)(9686003)(76116006)(52536014)(316002)(66476007)(2906002)(66556008)(64756008)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2C1uyMoFOEZRbe29APUFkAkDvuKdYk/2Gfh6BcH45UAW6bBzPBvbWTEKmdcYMSDt7ttn/h/7CswhifzlnMLJ5YbcUnZd9O15kLhq85F7Yy5JSyCPf5kxlTCvU3k8kPA2BK6OIHlJdImYPbSZN1TrSvn/+5x78qafHo9vXpcL3KWi7uWWHkUHOLtYl40ia5qv3Wr2h1ay5ONJvv1J5ReKq064hFUCcsVDAoFpUamU124nkCenYH7xVqnH5lHt/j4tWnO1rz2JB21B6L3OxvJxYJcCHPguh3skeEqXuc+m03y7aERCrE96hCv5FiKXvRHmz1pKA0UqmlBpSZcjZg9/d7IZwwuStY1Zk0XnS2OURvQMfS079dxK9dqURT9lBVmBy/hXFJ5wmuMlun4+epBV8O0LbBaZ5TH3rI2gujlhZfYLLGm+pFZ2ePIyPV8H6dlY06TkWIgrnA3K8bXKIpg+jiU9E7NoQaKl0nl07vUOIh4SmuqMxr5P+URR+9AcT9qre7ArLnCNhMsGW7fQIgjByLpo5DfZ8wsEldVo4ljH9FBg4dfukL6LbEsGs+SuPlfDCM3/oKPgcmJbBzmbosLX9ZvVyEU2oUJG53H1RuzD4UB2r9ThU6mxv1sV9Hurslp0dpBJc2WCkeYE29Wks+mpXA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403831d2-3b14-43d3-3798-08d85ab156fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 02:28:18.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+03Y9YcK42s3vhT9EZGKJLJDa1nmQSuo6izXvFCA/8BguPO5LQmIJTXUvcwDB7lIOFv0KGcRjoldQUsNtt/9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2727
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjDlubQ55pyIMTbml6UgMjA6MDENCj4g
VG86IFZsYWRpbWlyIE9sdGVhbiA8b2x0ZWFudkBnbWFpbC5jb20+DQo+IENjOiB3Z0BncmFuZGVn
Z2VyLmNvbTsgUGFua2FqIEJhbnNhbCA8cGFua2FqLmJhbnNhbEBueHAuY29tPjsgUGFua2FqDQo+
IEJhbnNhbCAoT1NTKSA8cGFua2FqLmJhbnNhbEBvc3MubnhwLmNvbT47IGxpbnV4LWNhbkB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWly
Lm9sdGVhbkBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogY2FuZmR0ZXN0IG9uIGZsZXhjYW4gbG9v
cGJhY2sNCj4gDQo+IE9uIDkvMTYvMjAgMTo0NSBQTSwgVmxhZGltaXIgT2x0ZWFuIHdyb3RlOg0K
PiA+IE9uIFdlZCwgU2VwIDE2LCAyMDIwIGF0IDAxOjMyOjQ5UE0gKzAyMDAsIE1hcmMgS2xlaW5l
LUJ1ZGRlIHdyb3RlOg0KPiA+PiBXaGljaCBkcml2ZXIgYXJlIHlvdSB1c2luZz8gVGhlIG1haW5s
aW5lIGRyaXZlciBvbmx5IHVzZXMgb25lIFRYIGJ1ZmZlci4NCj4gPg0KPiA+IEFyZSB0aGVyZSBt
dWx0aXBsZSBmbGV4Y2FuIGRyaXZlcnMgaW4gY2lyY3VsYXRpb24/IFllcywgdGhlIG1haW5saW5l
DQo+ID4gZHJpdmVyIHdpdGggYSBzaW5nbGUgcHJpdi0+dHhfbWIuDQo+IA0KPiBJIGFzc3VtZSBu
eHAgaGFzIHNldmVyYWwgcGF0Y2hlcyBvbiB0aGVpciBrZXJuZWxzLiBBcmUgeW91IHVzaW5nIHRo
ZSBtYWlubGluZQ0KPiBrZXJuZWwgb3IgdGhlIG9uZSB0aGF0J3MgcHJvdmlkZWQgYnkgbnhwPw0K
DQpIaSBNYXJjLCBWbGFkaW1pciwNCg0KWWVzLCBWbGFkaW1pciB1c2VzIGtlcm5lbCBwcm92aWRl
ZCBieSBOWFAsIEkgYWxzbyBoZWxwIHRyeSB0byBsb29rIGludG8gdGhpcyBpc3N1ZSwgYnV0IGl0
IGNhbid0IGJlIHJlcHJvZHVjZWQgb24gaS5NWCBwbGF0Zm9ybXMuDQoNCk91ciBsb2NhbCBmbGV4
Y2FuIGRyaXZlciBpcyBhbG1vc3QgY2hlcnJ5LXBpY2tlZCBmcm9tIGxpbnV4LWNhbi1uZXh0L2Zs
ZXhjYW4gYnJhbmNoIHRvIGltcGxlbWVudCBDQU4gRkQgbW9kZSwgd2hpY2ggaXMgYSB2ZXJzaW9u
IHRoYXQgY2xlYW5lZCB1cCBieSB5b3UgYmVmb3JlLg0KSSBjb25maXJtIHRoYXQgd2Ugc3RpbGwg
dXNlIHNpbmdsZSBUWCBtYWlsYm94IHRvIHNlbmQgZnJhbWVzLCBwZXIgbXkgdW5kZXJzdGFuZGlu
ZywgcmVvcmRlciBzaG91bGQgbm90IG9jY3VyIGhlcmUuDQoNCkFjY29yZGluZyB0byBWbGFkaW1p
cidzIGRlc2NyaXB0aW9uLCBleGFjdGx5IGl0IGhhcHBlbnM6DQoiSSBoYXZlIGFkZGVkIHRyYWNl
IHBvaW50cyB0byB0aGUgZW5kIG9mIHRoZSBmbGV4Y2FuX3N0YXJ0X3htaXQgZnVuY3Rpb24sIHdo
aWNoIHByaW50IHRoZSBlbnRpcmUgc2tiLCBhbmQgdGhlIGZyYW1lcyBhcHBlYXIgdG8gYmUgd3Jp
dHRlbiB0byB0aGUgVFggbWVzc2FnZSBidWZmZXIgaW4gdGhlIGNvcnJlY3Qgb3JkZXIuIFRoZXkg
YXJlIHNlZW4sIGhvd2V2ZXIsIGluIHRoZSBpbmNvcnJlY3Qgb3JkZXIgb24gdGhlIHdpcmUuIg0K
DQpTaW5jZSBWbGFkaW1pciBvbmx5IHRlc3QgQ2xhc3NpYyBtb2RlLCBoZSBjYW4gdHVybiB0byA1
LjQgdXBzdHJlYW0ga2VybmVsIHRvIHNlZSBpZiB0aGlzIHJlb3JkZXIgaXNzdWUgYWxzbyBjYW4g
YmUgcmVwcm9kdWNlZC4gQFZsYWRpbWlyIE9sdGVhbiwgY291bGQgeW91IHBsZWFzZSBoYXZlIGEg
dHJ5Pw0KVG8gZWFzeSB0aGUgdGVzdCwgSSB0aGluayB5b3Ugb25seSBuZWVkIHJlcGxhY2UgYmVs
b3cgc2V2ZXJhbCBmaWxlcyBhdCBsb2NhbCBzaWRlLCB0aGVuIHVzZSAiZnNsLGxzMTAyMWFyMi1m
bGV4Y2FuIiBjb21wYXRpYmxlIHN0cmluZyBpbiBkdHMuDQpodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0L3RyZWUvZHJpdmVycy9u
ZXQvY2FuL2ZsZXhjYW4uYz9oPXY1LjQuNjUNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvdHJlZS9kcml2ZXJzL25ldC9jYW4v
cngtb2ZmbG9hZC5jP2g9djUuNC42NQ0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC90cmVlL2luY2x1ZGUvbGludXgvY2FuL3J4
LW9mZmxvYWQuaD9oPXY1LjQuNjUNCg0KSWYgaXQgY2FuJ3Qgd29yaywgc3VnZ2VzdCB0byB1c2Ug
NS40IHVwc3RyZWFtIGtlcm5lbCB0byByZXByb2R1Y2UgdGhpcyBpc3N1ZS4NCg0KQmVzdCBSZWdh
cmRzLA0KSm9ha2ltIFpoYW5nDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4g
ICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgIHwNCj4gRW1iZWRk
ZWQgTGludXggICAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSAg
fA0KPiBWZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICB8IFBob25lOiArNDktMjMxLTI4
MjYtOTI0ICAgICB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAg
ICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCg0K
