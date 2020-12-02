Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC0F2CC02C
	for <lists+linux-can@lfdr.de>; Wed,  2 Dec 2020 16:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgLBO6w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Dec 2020 09:58:52 -0500
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:58950
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728273AbgLBO6w (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 2 Dec 2020 09:58:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezJF5Cm7EyTKks4TDqXiOd8BjJuOmB/0KG+PZh5h7AS6rXNKcasHcZ6q4ROWROCWfcJsgMFzkJpxBUWBkB25EsWU1LmmXaVcASvRnrMm49luwr8hRhozJ+JrGQdhFGtQL2RSoWj7CrGxA2AWTJjkmPHph/+ujKVoTr8GS+JVfdoWBsyetSOyj2HifLW/w9BmQtF7mztlPUbSazRpzxWH3knearPzwcpAQJv+KFGMQ5FLsQmC1d4Gv9o6/jXCIJqPDEYQm+9KMe+x+Kw4rR0CJ3Q5hHxgB8TabIczLUqcUp2A+KOmBlmf98Wgqw4/TfxU5/i9Ek0gzhVSymE+3chU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P9LUJrkep40pUramOgqLvj3dlriwStGNuwOdF4jU5M=;
 b=lUHWJlGu5os9W/y5QrhkJzJfkf4QUrji5bkf+a2k5q2ts83fjyJyzVD1PFLiF9qBgyYGnHdaqiipJSxmou0P2CQwpSixc6Pj+15M7+LkVc5BkrrS9lmiacVqe7Qss37F0jMKMpG0tnwSfsj0X2iSAShaAMmgaH/TNLjyjTJCPayTceqC/bPOztE402oS/wFza7ZCf6Tjm4mH8DnsHjjyCgI5lhDUjct+paW+Cxzv8Va5p1MvgNo9AI6aB0vr2lb+gJmx/NUlbwk38R/ZXh4CNRgyhsuR7iUB8nFR0cG+DeYnmBqB8kMhJZ4EjG495Wh1qhpvS9uoqUPhz+lZi8Vmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pa-systems.de; dmarc=pass action=none
 header.from=pa-systems.de; dkim=pass header.d=pa-systems.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mahapa.onmicrosoft.com; s=selector2-mahapa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P9LUJrkep40pUramOgqLvj3dlriwStGNuwOdF4jU5M=;
 b=PcfSCfx4P31zDCg+Xk48Z9v154PqiSNRxXkXaNJtqxclXidlbkmjQ+9nXnWiAbRWKmGYrf3TjRNUEwyA62w6h7wpo2wjNYg4XHmGAAfzf6ZAQgBTp+288sbf6G6jRT+211GueLZLlUTRrFOjCjywP2mGnjn8Py6X1Ws1KZJNiSY=
Received: from AM9PR06MB7283.eurprd06.prod.outlook.com (2603:10a6:20b:2d3::15)
 by AM0PR0602MB3602.eurprd06.prod.outlook.com (2603:10a6:208:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 2 Dec
 2020 14:58:03 +0000
Received: from AM9PR06MB7283.eurprd06.prod.outlook.com
 ([fe80::e14b:5647:7ace:196c]) by AM9PR06MB7283.eurprd06.prod.outlook.com
 ([fe80::e14b:5647:7ace:196c%6]) with mapi id 15.20.3632.017; Wed, 2 Dec 2020
 14:58:03 +0000
From:   Thomas Wagner <thomas.wagner@pa-systems.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "thwa1@web.de" <thwa1@web.de>
Subject: RE: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
Thread-Topic: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
Thread-Index: AdbIokQ7wYkfmwdQQtioWWQAsiVkcgADUMmAAAFyUvA=
Date:   Wed, 2 Dec 2020 14:58:03 +0000
Message-ID: <AM9PR06MB7283F123B4B9B5A781597379B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
References: <AM9PR06MB72834DE8FE187784AE914AB2B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
 <bf1b3dd2-1a43-0bc7-d1db-f4ad010944ed@hartkopp.net>
In-Reply-To: <bf1b3dd2-1a43-0bc7-d1db-f4ad010944ed@hartkopp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hartkopp.net; dkim=none (message not signed)
 header.d=none;hartkopp.net; dmarc=none action=none header.from=pa-systems.de;
x-originating-ip: [2003:ed:270f:fb00:5526:5c56:1d57:7797]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e43dd2e8-bb54-48ae-daac-08d896d2ab1d
x-ms-traffictypediagnostic: AM0PR0602MB3602:
x-microsoft-antispam-prvs: <AM0PR0602MB360253ECDB05DD17E7F5A5C8B5F30@AM0PR0602MB3602.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NkD0g9By0aCj/1k06Hypj8L2NLdhxqXOEMfeLOphjmTl/N+MnMHbH0sUbWNOuvV5gfntSX8k+uX6wYgJHMK9PvhlfE8Cq17gAndZxyaN+caLFwhsy7Lump04MIugJw976Ek06JJMZGSf0j3Go9vdxjOxSNCYyFcaoEy6T7QM63NpbZsvI9XiYzMLDUT6pTY7kwojfwgeR4BvrjhsSek/v4fo68HSHjNib29kosicDAm3fS9nzr5YoeLBsICSFG6bi27CJII+pWTO+SehT0R3ZVMAiBgTiT1b+qsj3fLdwC5zBRh+/+JptTh1qoxlqe0rhJythrBXeY9CzIbr5vhwLv0klzOaDWzgXND83gNin/KiF+rBbOIGvIbYfuQWoSzkwdMPPpVkkPvzUuxqSCrdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7283.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(136003)(376002)(346002)(366004)(478600001)(53546011)(6506007)(2906002)(86362001)(4326008)(186003)(7696005)(44832011)(9686003)(64756008)(66476007)(66946007)(55016002)(76116006)(66556008)(66446008)(71200400001)(316002)(83380400001)(110136005)(33656002)(8676002)(5660300002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NUFVVHIvT2lpQ3htR2ljS3FzaFlGVEdqYUJ3VnlWYUl0Sjg1KysvbVE1c0d2?=
 =?utf-8?B?SFBjVVZ2cGU5RzMwTUJ6dm5GN1h4cmxRNjFaNnF4eFloUU1zTDNTT0NYRUdo?=
 =?utf-8?B?cExLT1pKcmJiMHh1M2RtWVQ4UGlqUUYzNk9HbUJyZi9raWZXc2FQOUtNN3NW?=
 =?utf-8?B?L0ZtMHFud3g5U2xYdndJK2dlT0hYWjhYaGRlaU1TamtOd25vRVRmUEpsWmxv?=
 =?utf-8?B?UGNiQkhONzQ2ejJKRUpXNVJUaWtzQzRLaWltNkJuWlIyRWxMWFRIMnMxOS9W?=
 =?utf-8?B?WUlsbVF4Z0NyTkVRK2RJQWM2ZjZxVDVROVV2ZUZScjAxUVNIQkUyZWdUSmUy?=
 =?utf-8?B?Z3Zpa3JhWUczUC90RXg4QTlqdkovc1B6bzBhcUprQUd1enFoTmNOajYwQnF0?=
 =?utf-8?B?Y1k5WW1PT1lZbjRvWDlEVmhZMThXZEVtN2RZdWtQbFpkL0RMSnhrKzVnOUJh?=
 =?utf-8?B?aGlqMHhPQUpXYU5LYnIwc3lkV3VJTzltOGpNYVI1cUZ3SEc5bmo4OHpSZVZl?=
 =?utf-8?B?T1dRWGMxTnlVbE1wbTdkeWZhYmRUQkJNbnk3TUs5MXp4SHRTN3JEeHJZQU9Q?=
 =?utf-8?B?K3ZoQWQxeWpXNjlHVnIxQys2TEpvTlNHZDRhWXdzUE8vY3hPS1JnbGV0TFJj?=
 =?utf-8?B?aDlCUHNzVURGZ3ZXQW41OS9CenVEejVRRWlhQjN3NlVyTW02YnJidHRXT1lU?=
 =?utf-8?B?eklRRlZDa0pFQlFOMGltR1hoU3VrRERIN1JUU3hEMERKOVNqT3RWampiSE1S?=
 =?utf-8?B?KzBETUtSb2JscUV5clRvcWJWSEdiUUw1OWFNUk1JU2hiZitkRWk4dW9uWUpj?=
 =?utf-8?B?YUlJeis2VkVXeFltYVIwek9xVndTTDZLRGg1a0M1YWpXY0RXd21kb2NqNVRj?=
 =?utf-8?B?NXhXbkJBbHZlenpsNUZLNGFTbFVkZXhoLzdKakFZbTIraWxUaEJGWTJOTzA3?=
 =?utf-8?B?cGs5ZmorbW5IVXk4aWRPOFdubFk4WmNpdkFJU2ZldCtMbm1lQmJ5Yk9kbTFL?=
 =?utf-8?B?OE05TkhvT2RrdjFaMXdubG45K2ZHUFZVb3ZYcUk5ZHY2UTZ5SjdXZ1cyaEpr?=
 =?utf-8?B?SE1TaktucjNqNkJVSFRpV1RZVitOekprTGc2YjI3M1dKbE1zbVMxc3FrVDBK?=
 =?utf-8?B?cFZpak8ydmFZSzZiSFhyRlM3RXl4M1V1TjNHZXNidUdnOUx2eENqczRQcWZM?=
 =?utf-8?B?Y1RmeTg4MGp4dmREaEVXNDZCQVQ5ckFFeUFNNElScG9CUktBOVZ0YllwSytI?=
 =?utf-8?B?b0VVZDYxRTlZTU9tamhvRm5DUTZUTXFTTnZrL3Iwc2QwQVlrZmdlRUsrUW13?=
 =?utf-8?B?VXBxSmxoT0tndjNKTHkwT3YyOGpWSURTM2I5d05lUFFzVGFsNHAzNGNjclYr?=
 =?utf-8?Q?bgncIT2xdmYbETB7y8kgPPgvbmJqKu7c=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pa-systems.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7283.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43dd2e8-bb54-48ae-daac-08d896d2ab1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 14:58:03.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8c1b19d-12b7-4029-a8de-e069486288e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qvm2fktuKVI0+mzwLxhAFJr37KfsDOpSvylARbtj00WirOwcGInKgbXuoblyQr7kFYTrQGP6NY+2VebFvFmrTvXcQ7V2DpgjepI6N1vACwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0602MB3602
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgT2xpdmVyLA0KDQp0aGFua3MgZm9yIHRoZSB3ZWxjb21lLi4uIEkgZ290IGN1cmlvdXMgYXMg
eW91IG1lbnRpb25lZCB0aGUgbWFpbGluZyBsaXN0IGl0IG9uIEdpdEh1Yi4NCg0KT24gV2VkLCBE
ZWMgMDIsIDIwMjAgMjozMiBQTSwgT2xpdmVyIEhhcnRrb3BwIHdyb3RlOg0KPiBIaSBUaG9tYXMs
DQo+IA0KPiB0aGFua3MgZm9yIHNob3dpbmcgdXAgaGVyZSBvbiB0aGUgTGludXgtQ0FOIG1haWxp
bmcgbGlzdCENCj4gDQo+IE9uIDAyLjEyLjIwIDEzOjI4LCBUaG9tYXMgV2FnbmVyIHdyb3RlOg0K
PiANCj4gPiBhcyBhbHJlYWR5IGRpc2N1c3NlZCB3aXRoIE9saXZlciBIYXJ0a29wcCB2aWEgR2l0
aHViIChodHRwczovL2dpdGh1Yi5jb20vaGFydGtvcHAvY2FuLWlzb3RwL2lzc3Vlcy8zNiksIEkg
c3VnZ2VzdCBhIG5ldw0KPiA+IG9wdGlvbi9mbGFnIHRvIGVuYWJsZSBJU08tVFAgc29ja2V0cyB3
aXRoIGp1c3QgYSBUWCBhZGRyZXNzLCB3aGlsZSB0aGUgUlggYWRkcmVzcyBpcyBiZWluZyBpZ25v
cmVkL2Rpc2NhcmRlZC4gVGhpcyBjYW4gYmUgdXNlZnVsIGZvcg0KPiA+IE9CRDIvVURTIHVzYWdl
LCB3aGVyZSBmdW5jdGlvbmFsIHJlcXVlc3RzIGFyZSB1c2VkIGFuZCBzZW50IGluIGEgMS10by1O
IHNjZW5hcmlvLCB3aGlsZSBzdGlsbCBoYXZpbmcgYW4gSVNPLVRQIHN0eWxlIFBDSS4NCj4gPg0K
PiA+IE9saXZlcjoNCj4gPiA+IEl0IHdvdWxkIGJlIHNvbWV0aGluZyBsaWtlIGEgbmV3IGZsYWcs
IGUuZy4gQ0FOX0lTT1RQX0ZBRERSX1RYX09OTFkgd2hlcmUgb25seSB0aGUgdHAudHhfaWQgaXMg
dXNlZCBhdCBiaW5kKCkgdGltZSAobm8NCj4gPiA+IHJlZ2lzdGVyaW5nIG9mIGEgdHAucnhfaWQp
IGFuZCB3aGVyZSB5b3Ugb25seSBjYW4gc2VuZCBQRFVzIHRoYXQgYXJlIG1heCA3IGJ5dGVzID0+
IFNGLg0KPiANCj4gWWVzLiBJIHdvdWxkIGJlIGZpbmUgd2l0aCBpdC4NCj4gDQo+IEJ0dy4gSSB3
b3VsZCBsaWtlIHRvIGFzayBhYm91dCB0aGUgbmFtaW5nIG9mIHRoZSBmbGFnLg0KPiANCj4gQ0FO
X0lTT1RQX0ZBRERSX1RYX09OTFkNCj4gQ0FOX0lTT1RQX0ZVTkNBRERSX1RYDQo+IENBTl9JU09U
UF9GVU5DX0FERFINCj4gQ0FOX0lTT1RQX0ZVTkNfQUREUl9UWA0KPiAoPz8gb3RoZXIgaWRlYXMg
Pz8pDQoNCkkgZ3Vlc3MgYnJvYWRjYXN0IENBTl9JU09UUF9CUk9BRENBU1Qgd291bGQgYmUgYSBt
b3JlIGdlbmVyaWMgZGVzY3JpcHRpb24sIGltcGx5aW5nIHRoZSAxLXRvLU4gbmF0dXJlIHdoZXJl
IGxpc3RlbmVycyBtaWdodA0KZXN0YWJsaXNoIGEgMS10by0xIGNvbm5lY3Rpb24gYXMgbmVlZGVk
LiBCdXQgY29uc2lkZXJpbmcgdGhlIGZsYWcgd291bGQgcHJvYmFibHkgbWFpbmx5IGJlIHVzZWQg
d2l0aCBPQkQvVURTIGZ1bmN0aW9uYWwgYWRkcmVzc2luZw0KQ0FOX0lTT1RQX0ZVTkNfQUREUiBk
b2Vzbid0IHNlZW0gaGFsZiBiYWQgSU1PLg0KDQo+ID4gSW4gZGVwdGggVXNlLUNhc2UgZXhwbGFu
YXRpb246DQo+ID4gV2l0aCBPQkQyIGFuZCBVRFMgcmVxdWVzdHMgb24gQ0FOLCBJU08tVFAgaXMg
dXNlZCBhcyBhIHRyYW5zcG9ydCBwcm90b2NvbC4gUmVxdWVzdHMgY2FuIGJlIHBoeXNpY2FsbHkg
YWRkcmVzc2VkIGJ5IGEgdGVzdGVyIHRvIGENCj4gPiBzcGVjaWZpYyBFQ1UgdXNpbmcgdGhlIENB
Ti1JRHMgMHg3RTAgdG8gMHg3RTcgKDExLWJpdCBJRHMpLg0KPiA+IFRoZSBFQ1VzIHJlc3BvbmQg
dG8gdGhlIHRlc3RlciB1c2luZyB0aGUgQ0FOLUlEcyAweDdFOCB0byAweDdFRi4gQSB0ZXN0ZXIg
Y2FuIG9wZW4gOCBJU08tVFAgc29ja2V0cywgdXNpbmcgdGhlIHNwZWNpZmljIFJYIGFuZCBUWA0K
PiA+IGFkZHJlc3NlcywgdG8gY29tbXVuaWNhdGUgd2l0aCBlYWNoIEVDVS4NCj4gPiBJbiBzb21l
IGNhc2VzIHJlcXVlc3RzIGFyZW4ndCBzZW50IHBoeXNpY2FsbHkgYWRkcmVzc2VkIHRvIGEgc3Bl
Y2lmaWMgRUNVLCBidXQgYnJvYWRjYXN0ZWQvZnVuY3Rpb25hbGx5IGFkZHJlc3NlZCB0byBhbGwg
RUNVcyB3aG8NCj4gPiBtaWdodCBjYXJlL2NhbiByZXNwb25kLiBUaGlzIGlzIGRvbmUgdXNpbmcg
dGhlIHNwZWNpYWwgQ0FOLUlEIDB4N0RGLg0KPiA+IEFueSBFQ1UgdGhhdCBtaWdodCByZXNwb25k
IGRvZXMgc28sIHVzaW5nIGl0J3MgdG8tdGVzdGVyIGFkZHJlc3MgKDB4N0U4IHRvIDB4N0VGKS4g
VGhpcyB3YXkgYSAxLXRvLU4gYnJvYWRjYXN0L3JlcXVlc3QgY2FuIGJlIGRvbmUsDQo+ID4gYWZ0
ZXIgd2hpY2ggbXVsdGlwbGUgMS10by0xIGNvbm5lY3Rpb25zIGNhbiBiZSBlc3RhYmxpc2hlZCB0
byB0cmFuc2ZlciBsYXJnZSBQRFVzLg0KPiANCj4gQnR3LiBJZiB5b3UgYWxyZWFkeSBoYXZlIGVz
dGFibGlzaGVkIHRoZSA4IDEtdG8tMSBzb2NrZXRzIGFzIGRlc2NyaWJlZA0KPiBhYm92ZSB0aGUg
RUNVIGNhbiBhbHNvIHNlbmQgUERVcyB3aXRoIGxlbmd0aCA+NyBieXRlcyBhcyB5b3VyIHNvY2tl
dA0KPiB3b3VsZCBkbyB0aGUgcHJvdG9jb2wgaGFuZHNoYWtlLg0KDQpZZXMsIHRoYXQncyB0aGUg
d2F5IEkgaGF2ZSBiZWVuIHdvcmtpbmcgbW9zdCBvZiB0aGUgdGltZS4gRXZlbiB3aGVuIHNlbmRp
bmcgZnVuY3Rpb25hbCByZXF1ZXN0cyB0byBhbGwgRUNVcywgdGhleSB3aWxsIHJlc3BvbmQgdG8g
dGhvc2UgDQo4IDEtdG8tMSBzb2NrZXRzIGFuZCBoZW5jZSBJIGFtIGFibGUgdG8gcmVjZWl2ZSBy
ZXNwb25zZXMgdGhhdCBhcmUgcXVpZXQgbG9uZy4gRS5nLiBJIGNhbiBzZW5kIGEgc2luZ2xlIGZ1
bmN0aW9uYWwgcmVxdWVzdCB0byBtYWtlIGFsbA0KYXZhaWxhYmxlIEVDVXMgaWRlbnRpZnkgd2l0
aCBhbiBJRCwgd2hpY2ggaXMgbm9ybWFsbHkgbG9uZ2VyIHRoYW4gNyBieXRlLg0KDQo+ID4gSW4g
dGhlIGN1cnJlbnQgSVNPLVRQL1NvY2tldENBTiBpbXBsZW1lbnRhdGlvbiwgYW4gYWRkaXRpb25h
bCA5dGggc29ja2V0IG5lZWRzIHRvIGJlIHVzZWQgZm9yIHRob3NlIGZ1bmN0aW9uYWwgcmVxdWVz
dHMuIFVzaW5nIGFuDQo+ID4gSVNPLVRQIHNvY2tldCBhcyA5dGggc29ja2V0IGZvcmNlcyB0aGUg
dXNlciB0byBjaG9vc2UgYW4gUlggYWRkcmVzcyB0aGF0IGlzIG5ldmVyIGFjdHVhbGx5IHVzZWQu
IFVzaW5nIGEgUkFXIENBTiBzb2NrZXQgZm9yY2VzIHRoZQ0KPiA+IHVzZXIgdG8gY2FsY3VsYXRl
L2J1aWxkIGEgUENJIG1hbnVhbGx5IGFuZCBoYXZlIHRoZSBzb2NrZXQgZGlzY2FyZC9maWx0ZXIg
YWxsIFJYIHRyYWZmaWMuDQo+IA0KPiBZb3UgY2FuIHNpbXBseSByZW1vdmUgdGhlIHNpbmdsZSBk
ZWZhdWx0IENBTl9SQVcgZmlsdGVyIHdoaWNoIHJlY2VpdmVzDQo+IGFsbCBDQU4tSURzOg0KPiAN
Cj4gKHNlZSBpbiBjYW5zZW5kLmMgY29kZSkNCj4gDQo+IHNldHNvY2tvcHQocywgU09MX0NBTl9S
QVcsIENBTl9SQVdfRklMVEVSLCBOVUxMLCAwKTsNCg0KUGVyZmVjdCENCg0KPiA+IEFGQUlLIGZ1
bmN0aW9uYWwgcmVxdWVzdHMgYXJlIGFsd2F5cyA8N0IgZGF0YSwgc28gSVNPLVRQIHdvdWxkIGJl
IGZpbmUgd2l0aG91dCBhIFJYIGFkZHJlc3MgZm9yIGZsb3cgY29udHJvbCBvbiB0aGUgN0RGIHJl
cXVlc3QNCj4gPiBzb2NrZXQuDQo+IA0KPiBOb3cgSSBzZWVkIHdoYXQgeW91IG1lYW50IHdpdGgg
Ijw3QiIgLi4gIjw3IGJ5dGVzIg0KPiA6LUQNCg0KSWYgSSBldmVyIGNvbWUgdXAgd2l0aCBhIGtl
cm5lbCBwYXRjaCwgSSBwcm9taXNlIEkgd2lsbCB0cnkgdG8gY2hvb3NlIGNsZWFyZXIgYWJicmV2
aWF0aW9ucyA6RA0KDQo+ID4gQW55IGZlZWRiYWNrL3Rob3VnaHRzIG9uIHRoYXQ/IDopDQo+IA0K
PiBJJ20gY3VycmVudGx5IHdvcmtpbmcgb24gdGhlIHNqYTEwMDAgYXJiaXRyYXRpb24gbG9zdCB0
b3BpYyBidXQgSSBjYW4NCj4gc2VuZCBhIFJGQyBwYXRjaCBmb3IgdGhpcyBzdWdnZXN0aW9uIGFm
dGVyd2FyZHMuDQo+IA0KPiBBcmUgeW91IGN1cnJlbnRseSB3b3JraW5nIG9uIGEgTGludXggNS4x
MC1yYyBrZXJuZWwgd2l0aCBJU08tVFAgaW5jbHVkZWQNCj4gaW4gdGhlIHRyZWUgLSBvciB3b3Vs
ZCB5b3UgbGlrZSB0aGUgdGVzdGluZyBiYXNlZCBvbiBteSBHaXRIdWIgaXNvdHAgcmVwbz8NCg0K
SSB3b3VsZCBtdWNoIHByZWZlciB0byB3b3JrIG9mIHRoZSBHaXRIdWIgcmVwbyBpZiBwb3NzaWJs
ZSwgYXMgSSBkb24ndCBoYXZlIGEgc2V0dXAgZm9yIG5ld2VyIGtlcm5lbHMgd2l0aCBDQU4gaGFy
ZHdhcmUuDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQo=
