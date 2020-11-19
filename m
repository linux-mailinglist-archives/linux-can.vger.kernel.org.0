Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7DA2B8931
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 01:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgKSA7U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Nov 2020 19:59:20 -0500
Received: from mail-vi1eur05on2089.outbound.protection.outlook.com ([40.107.21.89]:6113
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbgKSA7T (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 18 Nov 2020 19:59:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkqwkKVx3JqSE2bO1K+J4ZlFgV8x5HNKAbp0qOvTMN624UvlMySFfZTSutqDWEJKnM2Of6dHDp4rj4HgnIBLN0DM2gD07GXqp30lv0uu+adgu2ZSOy7GnKKceg+BrOVsbbTTQwC205wvxfBV0wjTktsmOtnK0m/qQ7YVtC9I4W1tifFZlRsoBLeKjv7RDYR6leMYO9vrUCX3zrPL60Ne5HGABiKc43S9cBxYVF5YOlbUmsVrZMqXluuGfYxIVN54uN5kPEXl/aV5t7ILS6aN4q3L3bCDg8AGnu/200H9JYyb6ya98o5TrkNNTDcOuxaBYXuXt6PIQVO8VKGDg6Iusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCL1A9YzpXAkhiNqY2XzwW0ZaXrbbSr+1UfybujtBWA=;
 b=BxnTcLHAcE40V3Ao2hvjfVTrO6WD5PEikGhqqvc6pOczJVZqq/ePQxgtUBOEH5CVWUYCi4m2qmiJXW5vf4h7Xg+0BB+GK7BKL7cknidOT9zFkQJ3LmSKPK1Ca8/7mty9Z6abqhcz/HPVgnLsf8o46CyDWFxxavjcZz8ofLvYoYbjiKSBSmOdlRTpvWuPQ/dtsw9iifaAo7YlXRygM1roqS4mcnmwrBeYlqFL9b2QHWseVtd39OfNWm55wU2M/8EhhICBXk4b7waPq0jx2iZs6PxKpuFogMiXfFSyLsrh6ZEblye9qy/vOWs37StXcPqnLgtg73o29PJQcj+QSuoBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCL1A9YzpXAkhiNqY2XzwW0ZaXrbbSr+1UfybujtBWA=;
 b=JPTji03hzOfsSa5vAFoyY5dOhxYWfewzimXQSR4nzzT0+PGr5JwcG7jVhOYkk+dusE9G5KjB6fN1fAovLD0FQ8grHGrL4IDD5vI/kZWuuJoxTvQ4MFA7CLpOsMJwTYXVQoE4RK+XCAivyBOoEV55xHKTuIayA+oh5JUXb5ER9VQ=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4281.eurprd04.prod.outlook.com (2603:10a6:5:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 19 Nov
 2020 00:59:15 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%9]) with mapi id 15.20.3541.028; Thu, 19 Nov 2020
 00:59:15 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] can: flexcan: flexcan_chip_start(): fix erroneous
 flexcan_transceiver_enable() during bus-off recovery
Thread-Topic: [PATCH] can: flexcan: flexcan_chip_start(): fix erroneous
 flexcan_transceiver_enable() during bus-off recovery
Thread-Index: AQHWvbvAZHxY2gpVCEilwp3FVyEKn6nOongg
Date:   Thu, 19 Nov 2020 00:59:15 +0000
Message-ID: <DB8PR04MB6795CE8D32EB70C084AC07C7E6E00@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20201118150148.2664024-1-mkl@pengutronix.de>
In-Reply-To: <20201118150148.2664024-1-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4322b415-a49c-410e-394d-08d88c265640
x-ms-traffictypediagnostic: DB7PR04MB4281:
x-microsoft-antispam-prvs: <DB7PR04MB4281A17913777A795B9BB471E6E00@DB7PR04MB4281.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7cU2wo7sQPp2w7uRzOjWDHwEBP0WpeR+blEX2xdyHIkq4ELcrf8cz56/Zqxw2D1jq2tKAwm3P/qp4bVLNsRr/1N20NTT51/AtV8yf4n86la1meqJs0W6HwMFbWxqcL5bwAPBlAq2FugcuGe2+SagwHLIJGLVODTgZIJd/IWQMuQDRkzxCj1oijSEJ/Qs6PunLUKmBqukCzOHpB3tfX+83gF9+aJxZMLQCK14jxwPm72k1qRNZG01BdZIcoTIxZxNIucKbW9vwWs+4gwfOUo+SNmkIVL6rEkYBWBw2rQWFMXgzdyLhIQsu1ieOjibo1JgjZdFEgIDePAnR2p659yBdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(52536014)(186003)(316002)(66476007)(66446008)(110136005)(66556008)(76116006)(64756008)(66946007)(71200400001)(83380400001)(5660300002)(33656002)(9686003)(2906002)(55016002)(4326008)(8676002)(8936002)(86362001)(7696005)(478600001)(26005)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KG2s2TCfIT5Hp0v9z8gFiOiiDMrzEDy5fhqPeOxuo5spErv80CtIodFFqqY+ZO6xS38hfSDWgh/AIWtzrQl+wgjREqFPFxaqcsA0NxQHZLwvEeAi2y8y9UJVMMsrcKlGnofZYNrBFbiZnXD7Tpv1i+V3LFPIvYmsykSMcUNedjs+DxoY1yVs+DMt2Nqifo2OK/JVG+SszKK3SM4Hhbqlphln4AncHNO0JBW/sg4jk94H9SSHK1mxvw3KrYV9wlzLaT9QjFyTE+rAIoNs6i72bmVAMssWDAnh0j7AINT79Fj9yF1hgiPi9g2hpXRlQuTzvef4HJsOgPE63cdWYoJIIQnKHT1+jov23aFHfHO1dmR7YpHrhkXn/Y7KTl+gEvEiLh/AQJZJhqMOR8t2wYhpYDh5NpX+XvyM4EtElFrf+e3bf36JaK/1536usaFFrbt7SHmOV4gPJOqngpYGMdgEbN+ua9y1x93d8LAt+q/HVLtiETYPuV+kvY6N0TviMY5+C3X0bQf8IVVC78OvDKlo4MrxpkLwbbu3MW4bCElna2H8Ju8n0rGDReHevchnisCqfW0QKKjWrxDqT7c7LgWzUQ7VSMuRF8IOZDpnaXBZrwXyDjlMKmA1QBLDe3u2MmHYowqqduaNZuxPqyPlQtU0wxUVeMF0QAxuSxtY1DxFygYDe50uKjXOGOPuHF3gBvyuceKWYWduAs3p44/UMJ/HUK9oORtWOt3u41cM8DD268yeSYRA1qIHuUQReyTT9UUt/qQ+dyvOxnKmdqyorRmG9KlJ1KrFZsskv2YEA4QX1p/r4KTbD+0ARCX/cQ7YwRRjDKPYfg6YVsDxlB6Oundr9/dbHodJ9MdU08atOcqg0O83wRaref6QPmEc5T2c9cYUE+SYcbr16gExF8COkUs1+g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4322b415-a49c-410e-394d-08d88c265640
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 00:59:15.5704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctsD81HwlPphVBeV+oz6k8NVvMfH7rJfAqxUNKvgaUBXo9MnkHcCOkLTuNxYZI+iY/LzX5S3P3vYtys6V90YGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4281
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjDE6jEx1MIxOMjVIDIzOjAyDQo+IFRv
OiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IENjOiBKb2FraW0gWmhhbmcgPHFpYW5ncWlu
Zy56aGFuZ0BueHAuY29tPjsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBNYXJjDQo+IEtsZWluZS1C
dWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGNhbjogZmxleGNh
bjogZmxleGNhbl9jaGlwX3N0YXJ0KCk6IGZpeCBlcnJvbmVvdXMNCj4gZmxleGNhbl90cmFuc2Nl
aXZlcl9lbmFibGUoKSBkdXJpbmcgYnVzLW9mZiByZWNvdmVyeQ0KPiANCj4gSWYgdGhlIENBTiBj
b250cm9sbGVyIGdvZXMgaW50byBidXMgb2ZmLCB0aGUgZG9fc2V0X21vZGUoKSBjYWxsYmFjayB3
aXRoDQo+IENBTl9NT0RFX1NUQVJUIGNhbiBiZSB1c2VkIHRvIHJlY292ZXIgdGhlIGNvbnRyb2xs
ZXIsIHdoaWNoIHRoZW4gY2FsbHMNCj4gZmxleGNhbl9jaGlwX3N0YXJ0KCkuIElmIGNvbmZpZ3Vy
ZWQsIHRoaXMgaXMgZG9uZSBhdXRvbWF0aWNhbGx5IGJ5IHRoZSBmcmFtZXdvcmsNCj4gb3IgbWFu
dWFsbHkgYnkgdGhlIHVzZXIuDQo+IA0KPiBJbiBmbGV4Y2FuX2NoaXBfc3RhcnQoKSB0aGVyZSBp
cyBhbiBleHBsaWNpdCBjYWxsIHRvIGZsZXhjYW5fdHJhbnNjZWl2ZXJfZW5hYmxlKCksDQo+IHdo
aWNoIGRvZXMgYSByZWd1bGF0b3JfZW5hYmxlKCkgb24gdGhlIHRyYW5zY2VpdmVyIHJlZ3VsYXRv
ci4gVGhpcyByZXN1bHRzIGluIGENCj4gbmV0IHVzYWdlIGNvdW50ZXIgaW5jcmVhc2UsIGFzIHRo
ZXJlIGlzIG5vIGNvcnJlc3BvbmRpbmcNCj4gZmxleGNhbl90cmFuc2NlaXZlcl9kaXNhYmxlKCkg
aW4gdGhlIGJ1cyBvZmYgY29kZSBwYXRoLg0KPiBUaGlzIGZ1cnRoZXIgbGVhZHMgdG8gdGhlIHRy
YW5zY2VpdmVyIHN0dWNrIGVuYWJsZWQsIGV2ZW4gaWYgdGhlIENBTiBpbnRlcmZhY2UgaXMNCj4g
c2h1dCBkb3duLg0KPiANCj4gVG8gZml4IHRoaXMgcHJvYmxlbSB0aGUNCj4gZmxleGNhbl90cmFu
c2NlaXZlcl9lbmFibGUoKS9mbGV4Y2FuX3RyYW5zY2VpdmVyX2Rpc2FibGUoKSBhcmUgbW92ZWQg
b3V0IG9mDQo+IGZsZXhjYW5fY2hpcF9zdGFydCgpL2ZsZXhjYW5fY2hpcF9zdG9wKCkgaW50byBm
bGV4Y2FuX29wZW4oKS9mbGV4Y2FuX2Nsb3NlKCkuDQo+IA0KPiBGaXhlczogZTk1NWNlYWQwMzEx
ICgiQ0FOOiBBZGQgRmxleGNhbiBDQU4gY29udHJvbGxlciBkcml2ZXIiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KUmV2aWV3ZWQtYnk6
IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQoNCkJlc3QgUmVnYXJkcywN
CkpvYWtpbSBaaGFuZw0K
