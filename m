Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D7B5797D6
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 12:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiGSKo1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 06:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGSKo0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 06:44:26 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130128.outbound.protection.outlook.com [40.107.13.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608B6175B6
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 03:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9pN/9y9D99HIm9KX5hTL7DpshwexsMBhL9eQcP5Kfut9VTRi1z9AQmiLpt1SC+0G9rjj57KhqyypVMuVWvc3O+5JTYE9lC5O8Hco6hzAjXNBF1gG+4WkM5DupCvijQtBstWLqKytWFbLUpPog75QHfAaiWJTtcmwJbME1v7QWKOWfsCKMw3XEG1HboAftpL3a/XaP3c1Spoo0z+ethW5kNLq7K85C6D4ENoqjIRToq1pbEzuUK74UGbZ5VFYErMv+A6tznE6Td5BlsPIvaiVnEXFQCF3QvdLBCgj356PmqVEl1vexOTQtsqfdOrIIMAOY8hCgqtUx1oirCamx9C+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85vqmjPAyjXwE7nbChwgzL49xYy9yW1nxnDpnJHyzDs=;
 b=Gsy5D9GircM2bsiY3gE93E4mgFaRJnUAnkRVTuM5WVy9cvPc+Txyw3tjXTixKcQyQFLaICj3i3Yat5S43FkkotFJFbt1xmPZ/FdaYqCtaNTLg3DM9V3l/ZuZdFfjd4RRpQ24OZhGFcrh1udI2jjxWLK85O5YZAUsgJkwX36R1WZv41Pdsk072yhPqnl61mKCg/SWDbAgf1pzJyXhnNxLv8fFKgb2i/cmifwzzlhOJ5TSpP/QHsq+9wO6BfO4ZIbh5VCqIGKwJ0fwv9kVj+n5giMGUBnQfm4SI47tFlvK62eB7XAgDCAu5cpbipu+iYLuZ0xkXMPP3vgAy9K/5mpnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85vqmjPAyjXwE7nbChwgzL49xYy9yW1nxnDpnJHyzDs=;
 b=XU3DuJ6UZ8TLPmDPK/+VpAP/6CnTG7GvvINT0bvfNapboMssUZXsIHnwJZoJIz8L4jq5hEHbHdv5LbCvUBcIE0ZYtawy9QNTxVZeMPy0w6MRhf2r6jsbakjsVXNLjLWoAEnzWgTYLQTO0FkpX2K85qZ6SHV77nP3/tgn55sgrQ0=
Received: from AM6PR03MB4296.eurprd03.prod.outlook.com (2603:10a6:20b:3::16)
 by DU0PR03MB8219.eurprd03.prod.outlook.com (2603:10a6:10:314::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 10:44:20 +0000
Received: from AM6PR03MB4296.eurprd03.prod.outlook.com
 ([fe80::1892:99ca:372b:c024]) by AM6PR03MB4296.eurprd03.prod.outlook.com
 ([fe80::1892:99ca:372b:c024%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 10:44:20 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
CC:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        Frank Jungclaus <Frank.Jungclaus@esd.eu>
Subject: Re: [PATCH v1 10/12] can: error: specify the values of data[5..7] of
 CAN error frames
Thread-Topic: [PATCH v1 10/12] can: error: specify the values of data[5..7] of
 CAN error frames
Thread-Index: AQHYlgTE2TPhG9W3FUONZkWsUmnuAK2FjPWA
Date:   Tue, 19 Jul 2022 10:44:20 +0000
Message-ID: <4341b5a443449721e9655e65f742c50684f53ffe.camel@esd.eu>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
         <20220712153157.83847-11-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220712153157.83847-11-mailhol.vincent@wanadoo.fr>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5-1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2483d73-95df-43fe-b0bf-08da6973a31e
x-ms-traffictypediagnostic: DU0PR03MB8219:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dVIdLAdH9BcrKZU1ZUxUQM3J9iOH47tSNZllbT5itpM/wicAcb0omLeCfIshlKR8FLmkm2Yfe1PbRfSl8M93/ltIzpAr27IcWCWZ8Xa5iUr2sH+hg6mIJpa3kTm/9WXw7nNICwMgcP1ywBcv2UIAFal8wcaFrFVWmZQUhxUPsTtrxr5oTrs6vNzDzVYAUg3v+7pzEkTkFtHcdqmxpAzsuBFJfV1WZTIiP3MMZxpd9befmII1SVix2WS1wiRz37FSo9m+I/mkXUDVAU2I3cPcUILDKAd41pSCY3Za+aL+zH2VnNrvsah6+GxgmKNYp0J4IvSI/ml+RZ865TmU3BZSUxFGCOc2uUSMVZyAgrSbiXlIe5ixFotaZuji4ob0Q4aXDAuQzyRKZOiiZJ985A4W0uEwf7UoZHUQwfjW73HQjcEOEPXv9Nr2eBTm8e5NDgtjBf5/8aWiTRaYzIn39tcgKChcIJV+b6zMfr4GgBEWUDpWhfCGu6/tga4I8gaMR55d7UjwbfN4CnMEQNwfjnrUF089S4SIilDTSZJiVeFwx/4kSYkN2cdaFTPWnjl+wkwC4upVPlWW3IR2bntDNyQb1Q600idIRDZphLFbKbeHcK2dhLJqqAvEOjZktneo5MW+31+8PirZ5QwXQv9IJiJ6QxbAm6GdZ4XRVnNjuYqNv04o7T8ebL+65Sodie+BcQ7ncL93O84QZvn9Nwf1Q9KtcZHghdS/6akVAz/oh3dx/7zzHVPlKmmLYG3l9MyBQPR59IpdqO5pi6Wdaa4BhLt0LkCzzePunuVURtnrLHB12LT0Flgxp2u1bDTKgJKETlp+eF7sgzZUZoL94qt4f1pbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB4296.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(376002)(366004)(39830400003)(85182001)(122000001)(54906003)(186003)(2616005)(6512007)(85202003)(36756003)(66446008)(41300700001)(2906002)(110136005)(478600001)(6486002)(71200400001)(86362001)(38100700002)(316002)(38070700005)(5660300002)(83380400001)(6506007)(66946007)(66556008)(4326008)(76116006)(66476007)(64756008)(8936002)(8676002)(101420200003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzU4eDR5UWo3OGZ3cWJBclFMb3FlakNIUHdJY1BXc2tHNWgrRndQamp5ZTg2?=
 =?utf-8?B?RHJDcm1qc1BNdm1lZ1dQamFoNzQrV1lZbk1SYTZOWWxZK0JEUVUzcisxKzVE?=
 =?utf-8?B?OGxCS1JQSzdFMUJkU2VwdW00ZHZrZ005RE81RUpYWlg3Ty8xaVFFZWRPY1JW?=
 =?utf-8?B?Nm5tN3dxOG9EeG1FM3QwV21tODd3NkEvaHhlU2c0Q0RYSnNoMTNhNUFYUFRG?=
 =?utf-8?B?eDRoWWE5QXBxTks0dU8zYVFkNHcrZWhEcm1JUFZEUW1mV1p0c2NnZmRYd254?=
 =?utf-8?B?YVhoTXJGeEw3SHdLdXpYVFNuN0RqdU1paHFSZGJzWm1OdHhEcTFHM01yZS83?=
 =?utf-8?B?dmhPS3hlTzZRcjJyd2d1QWJ1dG8wWHRLOGd3MzRtN2F5d043WnVWTmpwV2ZE?=
 =?utf-8?B?SjQyMnY0cDA0eHQrSE1wZEpuclhOUXJjUkx4NTNRZllvcjYyVG9CUWU5dTBI?=
 =?utf-8?B?dXl6bE5sVDN6UzE5eXBmL0dyZFdIZDI1a3g3TkRLYWt2Y3hxZlhyK0s2ZW1E?=
 =?utf-8?B?bDhJNVJ1Sk9jM01YdnQ3LzlobHZLQWdsTGkzVU1CRzRScUgvYlJ3QlZQZDFx?=
 =?utf-8?B?SWIzNGtnb2pJQzFRblowRDFWTzEvMG5BUU9uUXA2WmRTYXlUMHhrVTNhb2Rj?=
 =?utf-8?B?ZmVZSUZ0MkF0UTJkencwdlo0UDIyYTZUUDVXYjhMMUx6N1ZZYkhOWGhReURI?=
 =?utf-8?B?anN0VmRFWnJsaml5VHl4VFBJRzJhUWVVVWNGUE10emErcHNqbmRTR3FtQ3Iz?=
 =?utf-8?B?VGFUUEUwNURPY3hlZnRScDNBYmdQWXRsQ3F1SFMySjM0Zm54WldEaTk3a3Fa?=
 =?utf-8?B?TzFybnozREh4a2ZkajBVdEtnL3VOTVE3UHNFdVBsSm5xSFE1ck41dGVTZ011?=
 =?utf-8?B?eDlVcDJiRThUTlpOeUc1a05rNzd1ZjBGWFRSOVNrVTdPU0VtRlc5OGNjQzlN?=
 =?utf-8?B?WjA3MHFvYXJsUGF6ZVlMZUk5NkdMZ2VzRFYrUk9CTWhkSEwwNUE3QXRWVThJ?=
 =?utf-8?B?U2V2SjNxeUFvbWNDVjhGcktTTnhMUG96QkJOa0ZMamRvZGdJWUtjSmRkaUdZ?=
 =?utf-8?B?STNkMjhyUTVneFB2VkQ5T080SVVVMFhmK2pjT1FDVHNJNlZNUDhIUGdJVUkr?=
 =?utf-8?B?Mlc3ak5ScVlNRWVQVzFvT2tPQTE3KzIzYytqMjAranNxZ2daekhjWmYvd2tD?=
 =?utf-8?B?NVRCMFE2bEVVUnJuTHliU0RzT3JzaHZkZXkrdXRlb0dBcnhVeEF5YUtGZ0JG?=
 =?utf-8?B?aFBLQWhnSGpVd2pmekdMQ1hWR294WjY0c3o1dnpWUk5aVWYvSTYyZnB5WnpC?=
 =?utf-8?B?VUZyTTZRWU5nL095L2Y2czcxaXFPOU9oZ21BeU8zaGN3aE1EMWY5YzdCVS9O?=
 =?utf-8?B?bDFzRTF0Q1Z2RnYxcjZnbklsOXp4cG8xRzJJRmxWdFEreFV1T3RrOWRhNXFh?=
 =?utf-8?B?NFdUYVg0TnVhTGU3TDBaanhIZ01wN2x4eW9JV0UxcjZ3cFg2dmlhTDJUZE5E?=
 =?utf-8?B?dVNlTjB5cTdTcTJjWm9WZTNwRitDMFVSZjFkekpiQkdzSmF2UlQwNzluRXRs?=
 =?utf-8?B?NVFvbmxLc1FZVXRtOUJEZEZ6aWFLSUtUNjZpWHNLSjQxNlZ2Z0xNR05FUlpD?=
 =?utf-8?B?ZGwxWjRDbXdXQiswV0dGM3A0ZGhaVHhQNUlVT2Q3RGw0aXdSM3cvMHZmdXc1?=
 =?utf-8?B?Yy9BVHRxcEtMU2JYc00wVGMvMGsrMUpBeERBWnF2cDVRZzdpWGV6YXJ1L3Jq?=
 =?utf-8?B?VUI1MEU1Z2JaanBQZ1ZPK2lGYy9vNWdjaFVNL1FLdzlEcFpTY09pUUQvMVY5?=
 =?utf-8?B?Q1d6cmFsUVhjVUJuUmFFWXlDOUkyZlNaRjljM29ZSjVwbURocW1ZWWxkUFNp?=
 =?utf-8?B?SDI3S1BILzFXUFVGeko3ZzM4Q2NhRHNtK2pvS0htanRIWE55c1BMMmJHd2k3?=
 =?utf-8?B?M3dmdmpLZkNCMk1MRWFlYU5RYlJ0dmE0N2N0YkYvekE0VFBvY1RDVE14c2Ro?=
 =?utf-8?B?NzJnYzVZbG91NUoraFBMdXY4S3lsS0ltSE12VUhyWmpJZVA2V0dpL2pwUmZ6?=
 =?utf-8?B?L01EOEdVM1gwSXdNQXRlVnYrcUhTUWdINWxaMFlDbVhUcEhPYzYxWHNBUkVW?=
 =?utf-8?B?RFhOMUZwRkw3Z2FuOWJEL01QSm1zeittbW1jMGFQN3VpR1l1M2F3cjFYK3k3?=
 =?utf-8?Q?9z6SqDR7UYRGzmJ6W3hpUgv+6066i9QwlltxOJaCVZ44?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9173871420078041831582F9B8D16AD8@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB4296.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2483d73-95df-43fe-b0bf-08da6973a31e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 10:44:20.4730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAmJEUZqoGHUs+QdygAbvthI9RhDTGFwp4StQirrzaGLehWlZBmCv8YbS7lYbj/Au3q13J9yC2eCTDSIhgTelQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8219
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgVmluY2VudCwNCg0KSSdtIGEgYml0IGxhdGUgdG8gdGhlIHBhcnR5LCBidXQgc2hvdWxkbid0
IHRoZSBwYXRjaCBkbyB0aGF0IHdoYXQgeW91IHByb21pc2UgaW4NCnRoZSBjb21taXQgbWVzc2Fn
ZT8gU2VlIGF0IHRoZSBlbmQuDQoNCkJlc3QgcmVnYXJkcywNCiAgICBTdGVmYW4NCg0KQW0gTWl0
dHdvY2gsIGRlbiAxMy4wNy4yMDIyLCAwMDozMSArMDkwMCBzY2hyaWViIFZpbmNlbnQgTWFpbGhv
bDoNCj4gQ3VycmVudGx5LCBkYXRhWzUuLjddIG9mIHN0cnVjdCBjYW5fZnJhbWUsIHdoZW4gdXNl
ZCBhcyBhIENBTiBlcnJvcg0KPiBmcmFtZSwgYXJlIGRlZmluZWQgYXMgYmVpbmcgImNvbnRyb2xs
ZXIgc3BlY2lmaWMiLiBEZXZpY2Ugc3BlY2lmaWMNCj4gYmVoYXZpb3VycyBhcmUgcHJvYmxlbWF0
aWMgYmVjYXVzZSBpdCBwcmV2ZW50cyBzb21lb25lIGZyb20gd3JpdGluZw0KPiBjb2RlIHdoaWNo
IGlzIHBvcnRhYmxlIGJldHdlZW4gZGV2aWNlcy4NCj4gDQo+IEFzIGEgbWF0dGVyIG9mIGZhY3Qs
IGRhdGFbNV0gaXMgbmV2ZXIgdXNlZCwgZGF0YVs2XSBpcyBhbHdheXMgdXNlZCB0bw0KPiByZXBv
cnQgVFggZXJyb3IgY291bnRlciBhbmQgZGF0YVs3XSBpcyBhbHdheXMgdXNlZCB0byByZXBvcnQg
UlggZXJyb3INCj4gY291bnRlci4gY2FuLXV0aWxzIGFsc28gcmVsaWVzIG9uIHRoaXMuDQo+IA0K
PiBUaGlzIHBhdGNoIHVwZGF0ZXMgdGhlIGNvbW1lbnQgaW4gdGhlIHVhcGkgaGVhZGVyIHRvIHNw
ZWNpZnkgdGhhdA0KPiBkYXRhWzVdIGlzIHJlc2VydmVkIChhbmQgdGh1cyBzaG91bGQgbm90IGJl
IHVzZWQpIGFuZCB0aGF0IGRhdGFbNi4uN10NCj4gYXJlIHVzZWQgZm9yIGVycm9yIGNvdW50ZXJz
Lg0KPiANCj4gRml4ZXM6IDBkNjY1NDhhMTBjYiAoIltDQU5dOiBBZGQgUEZfQ0FOIGNvcmUgbW9k
dWxlIikNCj4gU2lnbmVkLW9mZi1ieTogVmluY2VudCBNYWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRA
d2FuYWRvby5mcj4NCj4gLS0tDQo+ICBpbmNsdWRlL3VhcGkvbGludXgvY2FuL2Vycm9yLmggfCA1
ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2Nhbi9lcnJvci5oIGIvaW5j
bHVkZS91YXBpL2xpbnV4L2Nhbi9lcnJvci5oDQo+IGluZGV4IDM0NjMzMjgzZGU2NC4uNGViN2Rh
NTY4ZGRlIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvY2FuL2Vycm9yLmgNCj4g
KysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Nhbi9lcnJvci5oDQo+IEBAIC0xMjAsNiArMTIwLDkg
QEANCj4gICNkZWZpbmUgQ0FOX0VSUl9UUlhfQ0FOTF9TSE9SVF9UT19HTkQgIDB4NzAgLyogMDEx
MSAwMDAwICovDQo+ICAjZGVmaW5lIENBTl9FUlJfVFJYX0NBTkxfU0hPUlRfVE9fQ0FOSCAweDgw
IC8qIDEwMDAgMDAwMCAqLw0KPiAgDQo+IC0vKiBjb250cm9sbGVyIHNwZWNpZmljIGFkZGl0aW9u
YWwgaW5mb3JtYXRpb24gLyBkYXRhWzUuLjddICovDQo+ICsvKiBkYXRhWzVdIGlzIHJlc2VydmVk
IChkbyBub3QgdXNlKSAqLw0KPiArDQo+ICsvKiBUWCBlcnJvciBjb3VudGVyIC8gZGF0YVs2XSAq
Lw0KPiArLyogVFggZXJyb3IgY291bnRlciAvIGRhdGFbN10gKi8NCg0KLyogUlggZXJyb3IgY291
bnRlciAvIGRhdGFbN10gKi8NCiAgIF4NCg0KPiAgI2VuZGlmIC8qIF9VQVBJX0NBTl9FUlJPUl9I
ICovDQo=
