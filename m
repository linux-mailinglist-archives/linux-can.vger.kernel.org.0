Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60AC2CD2C1
	for <lists+linux-can@lfdr.de>; Thu,  3 Dec 2020 10:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbgLCJkm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 3 Dec 2020 04:40:42 -0500
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:53934
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387667AbgLCJkl (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 3 Dec 2020 04:40:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9mwasETq/3QraX9Yn/zdnAQZOZ9AeWp+ZONIKbZ9tM+MuOEMP1lGQL421u5oD3rgHkz/58rCtlfqr/WGXbQEOkq5ZK9mmW8pBMB2TthDGiCEZmWFySh0UXtKOu5CxasqsJx+9GlvgHpziXt3Vklf/3qQpbOXnTS+P16K0JynS/GzdIbPYu96C5d+Zfc8Ws2D89OVSe23oerPGj0doTi16wXdzlnjoTY1jEB/uWJIdz6GNzuidqKQospRRdzCEZ2QOgw0RetO8aX4W3NTSSpprsVyVFbWXhlp6oaGzWINrDuRVvUjHTGd/X5Pu63NL1buU4KO53MNMAFXJTUejPeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM0vxyVtbtQICoj1Dc63acs4czKKogSiEKLBiH8nsrM=;
 b=kwxEopaL1ypqitUabwZZnR09YtM8wqHdkqYz7704OhrshfRMs+KsS7wzILPcbPJoSQIVYkY7XPjdLFoQ1pfzjxiUxnOAOW5xIG78Uu7fwibv+Y2MHC2sECyGMXPFHlxcRHKCm4mNIN3QryALaM3PwW7C/y14HtE4+g6jxLajC8tcPCgDMj1else/zpfF3as7RzQc70oMaCW+yWJAUzQqEKldSLz2q3dsvQjyAh0j1TUSayx4hKgQ4LGmkfTEc+yDbh7YHzMOtqiBh2CIrCRjpC3/fcFpXjOsZsLHA4z5PBVve+tV2exFhxpDgUVS1jQKU5KMVsk+iCebsYPyCqwn4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pa-systems.de; dmarc=pass action=none
 header.from=pa-systems.de; dkim=pass header.d=pa-systems.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mahapa.onmicrosoft.com; s=selector2-mahapa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM0vxyVtbtQICoj1Dc63acs4czKKogSiEKLBiH8nsrM=;
 b=h4GnZuH355+ZFuwuU/8vrOWc4SsYMYzbRy2XaS2c5oaRfWJcAhSv2RkQ4omPa5OpdQ8px6ScGEDyYlvPHHPso4tF5h5JRcgh1rhlomW7leBUuVooyrHJ9fr8ZSibgS2RU1fUwskjIpYqxmaUc6QHrSaq2s6ogMLVHe0/eWrZoJY=
Received: from AM9PR06MB7283.eurprd06.prod.outlook.com (2603:10a6:20b:2d3::15)
 by AM0PR06MB6451.eurprd06.prod.outlook.com (2603:10a6:208:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 3 Dec
 2020 09:39:53 +0000
Received: from AM9PR06MB7283.eurprd06.prod.outlook.com
 ([fe80::e14b:5647:7ace:196c]) by AM9PR06MB7283.eurprd06.prod.outlook.com
 ([fe80::e14b:5647:7ace:196c%6]) with mapi id 15.20.3632.017; Thu, 3 Dec 2020
 09:39:53 +0000
From:   Thomas Wagner <thomas.wagner@pa-systems.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "thwa1@web.de" <thwa1@web.de>
Subject: RE: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
Thread-Topic: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
Thread-Index: AdbIokQ7wYkfmwdQQtioWWQAsiVkcgADUMmAAAFyUvAAAx3IAAAKFjmAABqXJOA=
Date:   Thu, 3 Dec 2020 09:39:53 +0000
Message-ID: <AM9PR06MB7283E62151D53EF677B87517B5F20@AM9PR06MB7283.eurprd06.prod.outlook.com>
References: <AM9PR06MB72834DE8FE187784AE914AB2B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
 <bf1b3dd2-1a43-0bc7-d1db-f4ad010944ed@hartkopp.net>
 <AM9PR06MB7283F123B4B9B5A781597379B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
 <a01a36d2-725f-6de0-51bb-5a40be8d3e5b@hartkopp.net>
 <420f13ef-2993-7dd5-d537-085c1445be61@hartkopp.net>
In-Reply-To: <420f13ef-2993-7dd5-d537-085c1445be61@hartkopp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hartkopp.net; dkim=none (message not signed)
 header.d=none;hartkopp.net; dmarc=none action=none header.from=pa-systems.de;
x-originating-ip: [2003:ed:2713:f00:383f:de88:b80a:dcae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 055b294e-5b11-43d8-2e7e-08d8976f632e
x-ms-traffictypediagnostic: AM0PR06MB6451:
x-microsoft-antispam-prvs: <AM0PR06MB64517A145DA039285DAD99BAB5F20@AM0PR06MB6451.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8MTyrhvIbn1pjXtWKU4LIKxkUoNfeP8Q4Txe7QFV6HeYhINJXUi6UMjc69aPQRSO9SoFWmLNnKoPYmIkcLsFqJlQgF6wsDb06UecersFqhzm9WUa/mqEIvUgG9Mj9jaXW/Nlr6kkfi/SitABPbCKcAJyp0EjO9yKgQvMiiNo+X8/0I0CPezr5Z0e5C8nMKi/BrqMONBperDisLOBVyinrcFFFgbmi3ylqR0JqyX4oiHwdeVeKOx24Fdmj20bAGUGX9qVe+UXgup7nN0WaAfbLqQbzVN/XPAuP5SlO7cdpl+HWsrp8+PtaUJtV+XQckbI5kFpSrZK0LdzYzjsLvzFP1vKwBVZ5+S2w0e/uDXoI8a6ceyaDjuTC8SA8utumRivhdzIGwvdnUbAjQi9/lHdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7283.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39830400003)(396003)(366004)(136003)(4326008)(64756008)(55016002)(76116006)(966005)(86362001)(66446008)(110136005)(66946007)(66556008)(8676002)(52536014)(316002)(9686003)(5660300002)(478600001)(4744005)(66476007)(8936002)(2906002)(44832011)(6506007)(71200400001)(53546011)(186003)(7696005)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZXUxQ0lkLzl4YXlIN0djVnJsNFRpZnpTbEVYZFROVHY5dUJsSmhmOWRPdmk3?=
 =?utf-8?B?TXUxWEtabVk1VS9peUE1RVczOTRCU0lhck5HYjFqVVgxVUY1UlNOZVpjbHF1?=
 =?utf-8?B?REo0OVB1TGFQdmRkT0NrZWpETHZhQWp4RG93YUk2clAzdmdFV3ZLdE42TThz?=
 =?utf-8?B?eXh6MUtXMmFZUEVROVpCeDhYYmxDNTVZTVFGbG9uNXVmVGhabjBmOUZreXhi?=
 =?utf-8?B?SVQwT1FyVDVKMGljS2JRalpyM1M3bWxUWGxqRlNuY2RRVjBxd0hPdHFqNUlv?=
 =?utf-8?B?Y0xsVjlkMVc4VUU2REE4SS9uelNsaE51K1ZXNWJEYXEvV0ZsUXVxdFV0NnlD?=
 =?utf-8?B?cXhnWjF1QWkxaG1DbzBlSldZdy9UT1pkWWxqYkZTMUgxSG8zQm12MTFlNG9t?=
 =?utf-8?B?T0lyNytrb2k2VmVhSkVQV1pLVExLdXYxbjBRWEFFOGd5YzU4V21pRkFGY2N0?=
 =?utf-8?B?bkJCQnQycTF2eUI1MkZMcnd5dktKQTZXSmpaYU1rY1NlcHZ6d29SeHNLSVQr?=
 =?utf-8?B?VGhNTFluZXJ5dEZZeEJhZmtiWjlOeW5xeU8yZ29adkZITnNSTXo0TlRKbitP?=
 =?utf-8?B?NWdTZ2xTelY5S2htK0UxTzQ2TVZpanJPTEY5NWNPbWU1MFNrdnZSTnMvNm5s?=
 =?utf-8?B?dERTeE5MYThOQW8ydnJ4N2Qyai9YVWpuVVNKN2RHUjBhcld2KzF4d0VVLzEr?=
 =?utf-8?B?b2xaUWFGNTFZZHo0TGVHRTBFbk1sYW5QZmhwdUhUNGhwdzdyTG8wTnBObUln?=
 =?utf-8?B?b0RkbGdRL0VEWlo0aWdOenpzYjU0VUp5cEg5ZEkvamlZbm82YXVtUjNlWVhZ?=
 =?utf-8?B?Z2VibHI1Z3NycDlqanZQYmk4TzdIY2RZWDhIdVdnSEJ5TnNwczh0K2p2L2Vr?=
 =?utf-8?B?WllkVVJOQnVLNUloRHZKdVRMQkxUbm1YUWZVMm1tUkUySWl1ZWIxcTBhZDVl?=
 =?utf-8?B?U1pGbDlqRnJ1b0lPZ3BmemlGV3dYS09GTm4zSVQvYlJ1MVI0Yk16MXN6Y1Bt?=
 =?utf-8?B?eExQdFI0eFpKVWx6Tzc1VGpOblVXTnVMRjU2TjdwZGtJQTlxajBBbEZxY1Zz?=
 =?utf-8?B?ZFhVTnJENEs5aVRMbnpESXZmOVRXUFdPZjdVOVpvQVQ1RWJIZVd0NUdkTDZZ?=
 =?utf-8?B?VDI5MERxS2JwMjd3UjJQZC9neWFCR0J4SElZT2hNRmJlZkdCUGpySzJlWEYr?=
 =?utf-8?B?ajJmSGVlUUphVEJESlYvUU8yOWpyY2lkUDdGZUFOTzQ5RmVVdTJjSXJ0RGh1?=
 =?utf-8?B?UFVsOHVpa3NxQ05ZQi95RXBJbHlLdjhUZUdmdk1XZ2ZSQ29tQy81MmVMUHN3?=
 =?utf-8?B?c2pyRGd3SjFFeDlMeTh5U1U5YXhOdCthT1FHTlA0MnFCUTFic0ZPdG9zOGF3?=
 =?utf-8?Q?wKNlYldX1bOzpoDWmvYlJCBbocJIQNis=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pa-systems.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7283.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055b294e-5b11-43d8-2e7e-08d8976f632e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 09:39:53.3582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8c1b19d-12b7-4029-a8de-e069486288e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3Lh0XMUVIBHuMXTJdv9UbH358R/UmSwSuLkNi9QUZlCJNM/adI2gfckfVqHKgEa7AT2p7RFy1Hnu4yj2/g3krnH14c5HIqG+Fe+tm5w4Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6451
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgT2xpdmVyLA0KDQpPbiAwMy4xMi4yMCAyMTozMiwgT2xpdmVyIEhhcnRrb3BwIHdyb3RlOg0K
PiBPbiAwMi4xMi4yMCAxNjo0MiwgT2xpdmVyIEhhcnRrb3BwIHdyb3RlOg0KPiA+IE9uIDAyLjEy
LjIwIDE1OjU4LCBUaG9tYXMgV2FnbmVyIHdyb3RlOg0KPiA+PiBJIHdvdWxkIG11Y2ggcHJlZmVy
IHRvIHdvcmsgb2YgdGhlIEdpdEh1YiByZXBvIGlmIHBvc3NpYmxlLCBhcyBJIGRvbid0DQo+ID4+
IGhhdmUgYSBzZXR1cCBmb3IgbmV3ZXIga2VybmVscyB3aXRoIENBTiBoYXJkd2FyZS4NCj4gPg0K
PiA+IE9rLiBXaWxsIHNlbmQgYSBub3RpZmljYXRpb24gaGVyZSB3aGVuIHRoZSBSRkMgY29kZSBp
cyByZWFkeSB0byB0ZXN0Lg0KPiANCj4gSSBhZGRlZCBhIGJyYW5jaCBzZl9icm9hZGNhc3QgdG8g
dGhlIHJlcG86DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9oYXJ0a29wcC9jYW4taXNvdHAvY29tbWl0
cy9zZl9icm9hZGNhc3QNCg0KSSBwdWxsZWQgdGhlIGJyYW5jaCBhbmQgdGVzdGVkIHRoZSBmbGFn
IGJ5IHNpbXBseSByZXBsYWNpbmcgbXkgcHJldmlvdXMgaW1wbGVtZW50YXRpb24NCnRoYXQgdXNl
ZCB0aGUgUkFXIHNvY2tldHMuIFdvcmtzIHdvbmRlcmZ1bGx5IGxvYWRlZCBpbnRvIHRoZSBVYnVu
dHUgNS40LjAtNTYgYW5kDQphIDIuNi4zMSBjdXN0b20ga2VybmVsLiBJIGNhbiBkaXRjaCBhbGwg
dGhlIFJYLXBhdGgtc2V0dGluZ3MgYW5kIGp1c3QgdXNlIHRoZSBmbGFnIHdpdGhvdXQNCmFueSBl
cnJvcnMuIEVJTlZBTCBnZXRzIHRyaWdnZXJlZCBhcyBleHBlY3RlZCBmb3IgdG9vIGxvbmcgbWVz
c2FnZXMuICBBbGwgZGVmYXVsdCBJU08tVFAgDQpzb2NrZXRzIHN0YXkgdW5oYXJtZWQuIFdvbmRl
cmZ1bCwgdGhhbmtzIGZvciB0aGUgcXVpY2sgc29sdXRpb24hDQoNClJlZ2FyZHMNClRob21hcw0K
