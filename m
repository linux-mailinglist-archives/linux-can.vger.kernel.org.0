Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238642CBD02
	for <lists+linux-can@lfdr.de>; Wed,  2 Dec 2020 13:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgLBM26 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Dec 2020 07:28:58 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:14567
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbgLBM25 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 2 Dec 2020 07:28:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES5neDH5sZg6WM3aI1UPNs2nx9MROBiUITojwyHbYM/yMSJIE34PourinQu3GL69hzzng0DsSRmZ9XXPvJl+IGN2btmzHrHLkHDxLSgnkqrrlnbSJiMnBOMA2rQaABpp2UKrX2iL0Yk2ieDoGGcJ5ynUVscBScEvQED4DxpWiigwIIem2lZd33mhZifnC60d6pLbT+uxMFaDKJ20Ac43BN3p5Estfze+j3K6PRLTCPqu7dSsv4QdkswS0APjtd0YfRAD/evc1wIXInm9BMFAZTCY3jUUFqJO+eCaLWiLNII5ncCRPsOWpMLr2974v48ghm1R12IhhQBvR+AgEMD9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfCyCJmM/mrqrpuifxOD+G1FZRlVtnFvChglgWcIxHw=;
 b=NPp4gQPH7Mz0bnnl8/0pRqchoQmtOt+fP1TKyFS52CPjevJKaBEwUFKQyRPxbKbEVdYHauxo6Q9jbwD9mVQqh9s9jITZrtHKd3q1QMHWTZPIE4PuJFmWYZTjIGtQmIQKP3I+Q5sTE27cBOK6Xy9WNv/e41N+D31BNE7BTdCULNMdABMQYZM98U2U4pbrV/WXADhFXpWM40ShKnZoDH0FNyMFizLzzWaLcfJyDS2qX77Wnc3zElr26rT0xRjMdVHxARMQCAFurBsH7ndmPnuJNghcARJWPh8/h8f4+OFmrKIv6OLH2sPqhRx8UxfHXkncW7XSggoJXXPuhdJJNG7hHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pa-systems.de; dmarc=pass action=none
 header.from=pa-systems.de; dkim=pass header.d=pa-systems.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mahapa.onmicrosoft.com; s=selector2-mahapa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfCyCJmM/mrqrpuifxOD+G1FZRlVtnFvChglgWcIxHw=;
 b=C9eNxwDuUX6IFpTMa64pke7ztFwAQxnqEHb4PiasDzHnKnKLjtUmqM/347nGUICiPqqW25ZMlQ7kVe8Y3vfztuyKAt6ICqaSiEem9Idc8wNO6vWDWiWJR8DVYmyQ9WBgEgAXMiF1/cUgSp8b7dQ9OgfP3AykR2eWVLKihjBG5Bk=
Received: from AM9PR06MB7283.eurprd06.prod.outlook.com (2603:10a6:20b:2d3::15)
 by AM0PR0602MB3345.eurprd06.prod.outlook.com (2603:10a6:208:20::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 12:28:08 +0000
Received: from AM9PR06MB7283.eurprd06.prod.outlook.com
 ([fe80::e14b:5647:7ace:196c]) by AM9PR06MB7283.eurprd06.prod.outlook.com
 ([fe80::e14b:5647:7ace:196c%6]) with mapi id 15.20.3632.017; Wed, 2 Dec 2020
 12:28:08 +0000
From:   Thomas Wagner <thomas.wagner@pa-systems.de>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "thwa1@web.de" <thwa1@web.de>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>
Subject: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
Thread-Topic: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
Thread-Index: AdbIokQ7wYkfmwdQQtioWWQAsiVkcg==
Date:   Wed, 2 Dec 2020 12:28:08 +0000
Message-ID: <AM9PR06MB72834DE8FE187784AE914AB2B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=pa-systems.de;
x-originating-ip: [2003:ed:270f:fb00:5526:5c56:1d57:7797]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 392a1e5b-6b8f-4fad-2422-08d896bdb9e0
x-ms-traffictypediagnostic: AM0PR0602MB3345:
x-microsoft-antispam-prvs: <AM0PR0602MB334570A132602EF102B88DBAB5F30@AM0PR0602MB3345.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tm/DEwGnS6TjkNnom4YtLAhIf5qPoo7hQCI3XElhvZwYEFd/8iWqyuYHQAdNx/kyFkeP1mtMKMNPiJMpQdo17ENo+O8ySDV5X00htCRLwEWYTcWMwi2S3BNQiNWIqeC3VYtj1dpdd+IQDtDN1CkghuhCgoyYsjhogIsjEEXNpxLgy0PboW376WdvKQbnrbEsFsensLsVDrrCLw2WcNUydwHEI7SBzEyv5lNLG/AHpwSX9QuH0aDb77SBxuYaSQU7qUApyAl1own8ShCr2wMYo3UIWY++cmwrAWchZyJxmsi0epqWtGtH7ufuVWMoVv53m7ud92zLAWKKo42vcwuSbofjDgGXLiD9u1JsoR3hha3/0ZUtsS77KsK0E2lMa6cgkjVpSfhV3h/ay6CMLZ0NPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7283.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39830400003)(366004)(376002)(136003)(7696005)(8936002)(316002)(54906003)(33656002)(9686003)(55016002)(66476007)(5660300002)(52536014)(71200400001)(6506007)(2906002)(8676002)(86362001)(478600001)(76116006)(44832011)(6916009)(66946007)(83380400001)(4326008)(64756008)(66446008)(66556008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MGpBOHBuZE1PcnIzT1RXUmptamJNejNVTjFsOXJOWTZmMHlYVHpoL3F6R3pE?=
 =?utf-8?B?eUtYT1JLaVE4UnVhMlB6N1NmWXBrUVM5Qjl2cjM0Z3dZM21oWGIwWDJmTzJw?=
 =?utf-8?B?UU1FUFEyZDkrd2EvZzUrQlhHKzlzSkFWdnNVU2NtRC85dTVQOG9PR1cxK3E5?=
 =?utf-8?B?SmMrd3Jlc3VGVUFiQjR1bFY2OUVNVkxLaW1TeGdpM3kvRHQzckJBOFp4dEt6?=
 =?utf-8?B?WEJCaGVSaDJhMGx2VUsxQUFPWDI3U1A5dlVFdzdubnpnRktHSGZQZmJ0TGZZ?=
 =?utf-8?B?aVFCSFY2NEtxNnREcGViUEhteENKWmdVT3FhNTFuTkRtUUNjZ0JrYUovT2Uy?=
 =?utf-8?B?eEl4WWtxNmhCbVYvNzVQZE5GUUxRRkNTSTBjZzZ2L2h0ejNHVm5uZ2RmcVRZ?=
 =?utf-8?B?MjRUSFNIdzArOHBQZ2sxTUFMOWxyTWs0Q2VLVlZRR3FNeTlvN0h3V2VQRjVl?=
 =?utf-8?B?QzBxQ3RNZEJsRm93V1puWmJwQ0U4dnROMld4WW1veUVLSEJZZEl2bm5iWjRK?=
 =?utf-8?B?VzBZODFjQzF0V25mZ3pMbVVtK3djRUFPQTRQVWNiSHRHZVFoWUw0S21qRkZQ?=
 =?utf-8?B?eDNEMytDeXRkckJXR2dNaTF4SWZ5YldrZFlwL2FTMEl1S29NT3BMcmg1amps?=
 =?utf-8?B?K0JsaDhucnBSVUVweWhYN213d2FhQ3gyVDIxZko2N1JjYjl3VmQvcWR1U3VM?=
 =?utf-8?B?Tk5FRXVxd25uL3lzczY5WXlyRWtON05PK240SW1peHc5OWRjaGxyYTU1bTZv?=
 =?utf-8?B?amZ4UGliUysxUmZveEYvN2xkVWZZaEQ5bTRtVzFjWkpXQkUrYkppZWVneEYx?=
 =?utf-8?B?WnhCbWRwUk5hbFgwd3V2TytDUm9SNXI1aFNKNnYzMjcxQWR3UEhCZG1YNG96?=
 =?utf-8?B?Sm5GMDJ3NTlsU0FWNjB5dm4yUkx0a3lmbXNKVHdRRVNUblFRNDBLb0RzcTNK?=
 =?utf-8?B?RFJrVFFTb1h2eDNBN0dwbnBiT0FDWFlLZ1JYYW82VUlzSFJTYzZjMjVRQSth?=
 =?utf-8?B?MjFQNjVWTXhlL0ZtUysvc0JtT0hpdDhaMjhpeTErZ1FhU1YxL3lHcXpVQjdo?=
 =?utf-8?B?V2drVzUwZkFWTGZDZUEvdjBHMlVwYjR1Ym1zRE1lSEQxeXBDRkN2NlRpSXlQ?=
 =?utf-8?B?KzUrNGRUOGZXOTJNaWJ4V3BWdDliOVFDbXg4ME5oNCtZNlVtc3lldGp5b0xI?=
 =?utf-8?B?VEo2OU10NHF0MHhUUmxSSy9sUkhtcE5GUW5SRHozNC9OT2F5KzZSenVWa3BU?=
 =?utf-8?B?SG16ZzkvWnduQW9xdUlOUmZ2cmhVdFpPN1ZYUTFmVlhHeEFXYXZ5bUhWNTVt?=
 =?utf-8?B?TXFpZnpFNW16a3A3WWN1U0d2dkFWTkVBcHM2U3RDZ2lyOGsxcmVmbXhDZXF4?=
 =?utf-8?Q?3WzyweQAfnu8EYhV+peUTWFFnOLFGzyk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pa-systems.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7283.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392a1e5b-6b8f-4fad-2422-08d896bdb9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 12:28:08.3618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8c1b19d-12b7-4029-a8de-e069486288e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQ9RfzGnp+6KUJ04qHKOKZOQk94Aw5r7e+jJE6hz/80gBMc0XrLtMHULpykrObzzwb+le8XpxJU3QU0Oe6edAiizQCujxoIJUcK4h8y/q0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0602MB3345
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgYWxsLA0KDQphcyBhbHJlYWR5IGRpc2N1c3NlZCB3aXRoIE9saXZlciBIYXJ0a29wcCB2aWEg
R2l0aHViIChodHRwczovL2dpdGh1Yi5jb20vaGFydGtvcHAvY2FuLWlzb3RwL2lzc3Vlcy8zNiks
IEkgc3VnZ2VzdCBhIG5ldyBvcHRpb24vZmxhZyB0byBlbmFibGUgSVNPLVRQIHNvY2tldHMgd2l0
aCBqdXN0IGEgVFggYWRkcmVzcywgd2hpbGUgdGhlIFJYIGFkZHJlc3MgaXMgYmVpbmcgaWdub3Jl
ZC9kaXNjYXJkZWQuIFRoaXMgY2FuIGJlIHVzZWZ1bCBmb3IgT0JEMi9VRFMgdXNhZ2UsIHdoZXJl
IGZ1bmN0aW9uYWwgcmVxdWVzdHMgYXJlIHVzZWQgYW5kIHNlbnQgaW4gYSAxLXRvLU4gc2NlbmFy
aW8sIHdoaWxlIHN0aWxsIGhhdmluZyBhbiBJU08tVFAgc3R5bGUgUENJLg0KDQpPbGl2ZXI6DQo+
IEl0IHdvdWxkIGJlIHNvbWV0aGluZyBsaWtlIGEgbmV3IGZsYWcsIGUuZy4gQ0FOX0lTT1RQX0ZB
RERSX1RYX09OTFkgd2hlcmUgb25seSB0aGUgdHAudHhfaWQgaXMgdXNlZCBhdCBiaW5kKCkgdGlt
ZSAobm8gcmVnaXN0ZXJpbmcgb2YgYSB0cC5yeF9pZCkgYW5kIHdoZXJlIHlvdSBvbmx5IGNhbiBz
ZW5kIFBEVXMgdGhhdCBhcmUgbWF4IDcgYnl0ZXMgPT4gU0YuDQoNCkluIGRlcHRoIFVzZS1DYXNl
IGV4cGxhbmF0aW9uOg0KV2l0aCBPQkQyIGFuZCBVRFMgcmVxdWVzdHMgb24gQ0FOLCBJU08tVFAg
aXMgdXNlZCBhcyBhIHRyYW5zcG9ydCBwcm90b2NvbC4gUmVxdWVzdHMgY2FuIGJlIHBoeXNpY2Fs
bHkgYWRkcmVzc2VkIGJ5IGEgdGVzdGVyIHRvIGEgc3BlY2lmaWMgRUNVIHVzaW5nIHRoZSBDQU4t
SURzIDB4N0UwIHRvIDB4N0U3ICgxMS1iaXQgSURzKS4NClRoZSBFQ1VzIHJlc3BvbmQgdG8gdGhl
IHRlc3RlciB1c2luZyB0aGUgQ0FOLUlEcyAweDdFOCB0byAweDdFRi4gQSB0ZXN0ZXIgY2FuIG9w
ZW4gOCBJU08tVFAgc29ja2V0cywgdXNpbmcgdGhlIHNwZWNpZmljIFJYIGFuZCBUWCBhZGRyZXNz
ZXMsIHRvIGNvbW11bmljYXRlIHdpdGggZWFjaCBFQ1UuDQpJbiBzb21lIGNhc2VzIHJlcXVlc3Rz
IGFyZW4ndCBzZW50IHBoeXNpY2FsbHkgYWRkcmVzc2VkIHRvIGEgc3BlY2lmaWMgRUNVLCBidXQg
YnJvYWRjYXN0ZWQvZnVuY3Rpb25hbGx5IGFkZHJlc3NlZCB0byBhbGwgRUNVcyB3aG8gbWlnaHQg
Y2FyZS9jYW4gcmVzcG9uZC4gVGhpcyBpcyBkb25lIHVzaW5nIHRoZSBzcGVjaWFsIENBTi1JRCAw
eDdERi4NCkFueSBFQ1UgdGhhdCBtaWdodCByZXNwb25kIGRvZXMgc28sIHVzaW5nIGl0J3MgdG8t
dGVzdGVyIGFkZHJlc3MgKDB4N0U4IHRvIDB4N0VGKS4gVGhpcyB3YXkgYSAxLXRvLU4gYnJvYWRj
YXN0L3JlcXVlc3QgY2FuIGJlIGRvbmUsIGFmdGVyIHdoaWNoIG11bHRpcGxlIDEtdG8tMSBjb25u
ZWN0aW9ucyBjYW4gYmUgZXN0YWJsaXNoZWQgdG8gdHJhbnNmZXIgbGFyZ2UgUERVcy4NCg0KSW4g
dGhlIGN1cnJlbnQgSVNPLVRQL1NvY2tldENBTiBpbXBsZW1lbnRhdGlvbiwgYW4gYWRkaXRpb25h
bCA5dGggc29ja2V0IG5lZWRzIHRvIGJlIHVzZWQgZm9yIHRob3NlIGZ1bmN0aW9uYWwgcmVxdWVz
dHMuIFVzaW5nIGFuIElTTy1UUCBzb2NrZXQgYXMgOXRoIHNvY2tldCBmb3JjZXMgdGhlIHVzZXIg
dG8gY2hvb3NlIGFuIFJYIGFkZHJlc3MgdGhhdCBpcyBuZXZlciBhY3R1YWxseSB1c2VkLiBVc2lu
ZyBhIFJBVyBDQU4gc29ja2V0IGZvcmNlcyB0aGUgdXNlciB0byBjYWxjdWxhdGUvYnVpbGQgYSBQ
Q0kgbWFudWFsbHkgYW5kIGhhdmUgdGhlIHNvY2tldCBkaXNjYXJkL2ZpbHRlciBhbGwgUlggdHJh
ZmZpYy4gQUZBSUsgZnVuY3Rpb25hbCByZXF1ZXN0cyBhcmUgYWx3YXlzIDw3QiBkYXRhLCBzbyBJ
U08tVFAgd291bGQgYmUgZmluZSB3aXRob3V0IGEgUlggYWRkcmVzcyBmb3IgZmxvdyBjb250cm9s
IG9uIHRoZSA3REYgcmVxdWVzdCBzb2NrZXQuDQoNCg0KQW55IGZlZWRiYWNrL3Rob3VnaHRzIG9u
IHRoYXQ/IDopIA0KDQpNaXQgZnJldW5kbGljaGVuIEdyw7zDn2VuDQpCZXN0IFJlZ2FyZHMNClRo
b21hcyBXYWduZXINCg0K
