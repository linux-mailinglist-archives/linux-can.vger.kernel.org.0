Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1E53C7789
	for <lists+linux-can@lfdr.de>; Tue, 13 Jul 2021 21:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGMT5b (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Jul 2021 15:57:31 -0400
Received: from mail-eopbgr60132.outbound.protection.outlook.com ([40.107.6.132]:46081
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhGMT5a (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 13 Jul 2021 15:57:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+wNPAoiz1YTMN+zlbB9ciHWA1jfLqZ82uX7GVS3Vnw2x9m+vsMoRaQLPkYKCAhJMMSBkQdBlxAm1IMsnhQjsOofLXbhbhKMaFQ0FsQxy/6tmHnlshR6kRbWRu62TaV9KOj857yTDEA/f3kCuyz+A31fvpFexO2oQAhSOaIrYQPujA1gZMuroCoPEgZHW5t03wrOrVrydD9g0F128wB98/BttYkDes5J66HeBTTwCHBoNazcrk4IfO2IIONOD4XzkbW4eb0HzPlLT4NE/Vt8ml4q4X1Tk30xxg+BhQaxdsryL34hmUXi1Z0J+Xt+1LqG1lWgFJvKtHkm/+DB2xIr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbUmG5OY7SZ5vF0Gc2qcc6epn+eRtas7fOc83PaM1Ew=;
 b=gzFo32Ig2Fo8fMRVIRS7lwUcLIKn90IQpytcBWnifU/Tb5NkxTLaRwrvgas3Z0TaSYqe0wKswLrs1TDYZT/OmDWz9BOYwZOsFXCKqSIE+dkgpaDndxtH6KyYcPXrKHYVjSKdXUbifh9El3KdGaGOmD2a9u6b1ZnWUfeMWhvFAAw6MNFNEg5HxLxHEAXGs9NjJ4E1Yn2BQEaJSh0MLdptSxSg44pI6I3W+V6eY2UgModwva0a7iwmAhl4jGOOtlJxYhq37JGPnvsostyFDzzeDRAZKvj/wJIzCbGMJDBgYzvdJSCAj5YItzY2H2rWem7mOObjaB2Lm05C8ttPsMnFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbUmG5OY7SZ5vF0Gc2qcc6epn+eRtas7fOc83PaM1Ew=;
 b=HRFtJAp0nA9hPR8ce5uoC2nFcbdgJoE6+6IJQGng2BnASB3s5xEszhJnQVLFA0BkusDAcQ+5srrxVZq30qT+4vQRA3pRY7haxDgp/CpXuFEUN7nztPG9pmm8Q+g3FmXc/CN9Dzo8VHftjlstZ9wxZpqqfvLwoevUtW5kPJlcOxE=
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com (2603:10a6:20b:287::7)
 by AM0PR03MB5825.eurprd03.prod.outlook.com (2603:10a6:208:157::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Tue, 13 Jul
 2021 19:54:37 +0000
Received: from AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::6872:4ae0:6563:df20]) by AM9PR03MB6929.eurprd03.prod.outlook.com
 ([fe80::6872:4ae0:6563:df20%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 19:54:37 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "engnfrc@gmail.com" <engnfrc@gmail.com>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: ip link valid options checking
Thread-Topic: ip link valid options checking
Thread-Index: AddzV6mHoqDJXZTYR7O82+vlM/59OABYmgkAAAaCsoAAKDoLAACq+OIA
Date:   Tue, 13 Jul 2021 19:54:37 +0000
Message-ID: <2b9c5d4ee2470cde191c74adecaebc54353e3ed1.camel@esd.eu>
References: <002501d77357$d93c36b0$8bb4a410$@gmail.com>
         <CAMZ6RqLWLPtviMJHOXQJEc430cUPnZeP3N8BdvnV6_dLHYFTpg@mail.gmail.com>
         <b1da5bb9b940c7cb262184ec828568a38af8f5af.camel@esd.eu>
         <2b09f159-097c-feab-ad5f-d65523f90a5c@hartkopp.net>
In-Reply-To: <2b09f159-097c-feab-ad5f-d65523f90a5c@hartkopp.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 048bb81c-0b2e-4d10-d9aa-08d946380b95
x-ms-traffictypediagnostic: AM0PR03MB5825:
x-microsoft-antispam-prvs: <AM0PR03MB5825C5423A9F7CD1DD5DB04281149@AM0PR03MB5825.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRbCE8JWGNYh1nscow9qy10ii4R6L35MhEhnJGqLna0bNb9LJD48uofZLUq/4YIxjTRbF6ON4/B2Z5KW7jIHeq0OWD+dzI67Cq6Dpxe6g1UW2MjHli98jxJ88b28kIiACnYJX6Jt+ekyMLORTYzKvb5TNMWk43v6mYIal1sHg1IOis5cZlL9JCdlwE1NAR1/2dClL4AqLpG1wTSp0jNFnehid1OqbaqZ5kkyygpmREY9Ijsoso+3qwsbKSqhY7w7x0dYQMXlfusBJlm15OtEXjUMfWKIncP5F/XhhOqDkV8Cxas4IO5fEJ8dPWSRYFMB2YBgOpPHLVDK/QfvOubkvrUnHip+LzaU9Pppcgf1qdjFjCN+ckClBlY7o+R7aITMP4kJD4aJPQ4DPsun6hoX3DowlHMl8N+2IHIG8OBORYuR9rvWvKA4HIk1GLu1l2mvnwek3RcbQTuCUsuh0N2JR1wLPgGoO5yl58UckNBrv1KYyetBeE/lesVkaJAjL7zL8tnsRbFnQgmCiuZBhd14dxbUbrwenZsP0e3JjYB7yZ8guOdW5X0TIXsJpd76OlGgVsLHeFzKEZExIrQZM7chlceIAbWHWJ/TQlvN8yWCz3STtFh9aLDZOh3mv3rGhkR9bHj8F1UJ8f6ARxWc3y++rIo61K2WHOyb7BO0hXcnFDv/PBute5wKib0b3xHR0DrzU1Dy3bn+dbekMilLbVhIUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB6929.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(39830400003)(376002)(2906002)(6512007)(53546011)(85202003)(83380400001)(66574015)(85182001)(186003)(122000001)(8936002)(86362001)(6506007)(26005)(71200400001)(478600001)(64756008)(66556008)(66476007)(2616005)(110136005)(8676002)(66446008)(36756003)(4326008)(5660300002)(6486002)(76116006)(66946007)(38100700002)(91956017)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlQ3MnFZODB5ajhXWlZhNGFzbVk2QlNqNi9rL3hiWXdEMDllTnRZY3FKMk93?=
 =?utf-8?B?RDJkOVRqWVZFbmkvSWJRRGV0eHlDai9XaVpyNkU3NTdBRGdTeDVZZU9qVnAy?=
 =?utf-8?B?MHp0czNaRUFaMUwxVVk4bmI3dGdTZFcvUi83dVIxL3RyYXhRRkR2Y2phcEdm?=
 =?utf-8?B?NEc0eEhSOWlKbUM2R25oRDZYa3V5RzhkRVgwY2NkaEtPUVF2ZWphR3AvcU93?=
 =?utf-8?B?aXpGWVBTSERpbDMwSGRseGZIbjhwSDlEYnlaNHZyRjI4RnNPVG1BU3RnYzZj?=
 =?utf-8?B?bG5KUHNvNkpCVFh3alFuRVBWeVV3UWxIMGk0V2FZR0I3Z0RSRkhiQnRQL1k4?=
 =?utf-8?B?bk9KWVFBMzlSZTlyYW9yeGhhQ2E2Y0d2RC9qdnBzVktDSHltc3dvaWxTbXQ3?=
 =?utf-8?B?WlV3dnVTVzRYQmVZeEhoR0dCckhIZ3gxODJOeEFlTEloYkNXMzdKaldLdGtk?=
 =?utf-8?B?eGxzcEoyVHRQeGFrRHIxQmJyMlNkaXV1VEgzd2tjcko3WGUrTURIdUk5SjRj?=
 =?utf-8?B?Nm9nVlBzQ3RFeGk1V2dTNWZaRk9mYS9wZGZNbjRWU1BwNTlpWVJqVDV6ZzBF?=
 =?utf-8?B?Mkxyc3pLWU5WSGVRdjl2MHhsQmVKTzBIRm0zMzdwVkdyemJ6Nk5qWnBhK1dp?=
 =?utf-8?B?U2RyTE90VFM2NlN1M0ppQWp6ZHNkdmwwVCtrbXovVUJxT3YrY0NXNVowVCt0?=
 =?utf-8?B?RVR4V3BHcGtDR2QwWlZWSUpJRXpJbHFYaWtxYVlXblFDRUd5eStJQnlKV3oz?=
 =?utf-8?B?K2I3OXpvYzUvNzNFN0F4eXRPVVd3VXREOVBRd2ZrZytGeStPQUljSk40Qi83?=
 =?utf-8?B?aENuMUgvV3UySjdLNlpxM3V4K0tjZnUrTHJQZ0NRMEx0SUJZQ3BjcUtrT3BS?=
 =?utf-8?B?MlkxdEJieDhYVmN6eEhaMjZFYnd1emFGQmJJYit0OW1SVXNDS1I2UlozVEVn?=
 =?utf-8?B?UlM4Z3VKUE1hZGVQRllTY1BXeWFjeVJjaTJXWldyM1VBSUxrWkUzaGdHQ2Zt?=
 =?utf-8?B?YnNITGtUNXNBMlpldHVxdks2OEFodmI3ejNyMVhNYmhDYVdFYm9CaWx5UkZS?=
 =?utf-8?B?aC9ZYldheUZtVTNVTUgySEpNOVRkbU92T05McmFDeVBFRFNpSHBhNExueDVt?=
 =?utf-8?B?d05tNUZweUpLbzdQZERLQk84MmwrSldaSGZOVnJ1ektpTHU1bUc3SFgva2hu?=
 =?utf-8?B?TFVySjVhNXRpdUs3WEZremN5WmVhdFcrVUNUTFV0OStFTkprTTREV0Z4SHFZ?=
 =?utf-8?B?cWhSM0tsTUQrdjhnV04vQmVxa3BwSnBrVDNPSGkveGhFV1BHRjFRSlFkUXJS?=
 =?utf-8?B?d21yelAwcUo4MUhOSEd5SWhod2dzczJoOTIwSE03aU5XU2NMTzY4WGJjNFBQ?=
 =?utf-8?B?Q2IxcnhHZkx1MTRJRUM2MFFNMUlIR2RUaitmQmdUKzJRV010bmppaTZyemgy?=
 =?utf-8?B?ZmpPVnhZbS9yVDNsS3Y1WmFnaHZpYjcrN0tmMUwxWlhmb2l2WmFFYmd3bUM4?=
 =?utf-8?B?V1MvN0IrSCtaQklSY09pdS9MU1dhQ1lDcGJ5dVY1bzdUMkxtSUhHajA3UGRD?=
 =?utf-8?B?Z2lSR1BiRDdwbGMvdmNFaUNweE9kbE5Fd3NVakQzcklhbHY0Qjl4YkRSdmRH?=
 =?utf-8?B?ZVZYazlhRXd4VnowRFViRUF0Vjk3R1hiczRUQzdiSTMvZGhFZEFXS3BsT05S?=
 =?utf-8?B?UWVtNjZsamNsT2tNWjloa1UzQ3A3bmg2ZW9aWFRnQi9DbEZYaXJPdUo0Z2h3?=
 =?utf-8?Q?aAIf+sC4FTfJvCrjHTUf76whQlXRjP+M5qNHQFb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <00E59C1ECBD3FD4498673605ABE653F5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB6929.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048bb81c-0b2e-4d10-d9aa-08d946380b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 19:54:37.5391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJpK5Ippoo9+MqsyVBCkARcz4BEKTbUVHHTRzBeGW0JXqlPbTrqOSAgOM0XxK7P6MfCXx4EwJnuhgrjR4FTH8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5825
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

QW0gU2Ftc3RhZywgZGVuIDEwLjA3LjIwMjEsIDEyOjE5ICswMjAwIHNjaHJpZWIgT2xpdmVyIEhh
cnRrb3BwOg0KPiBIaSBTdGVmYW4sDQo+IA0KPiBPbiAwOS4wNy4yMSAxNzowNywgU3RlZmFuIE3D
pHRqZSB3cm90ZToNCj4gPiBBbSBGcmVpdGFnLCBkZW4gMDkuMDcuMjAyMSwgMTQ6MDAgKzAyMDAg
c2NocmllYiBWaW5jZW50IE1BSUxIT0w6DQo+ID4gDQo+ID4gVW5mb3J0dW5hdGVseSB0aGUgbmV0
bGluayBrZXJuZWwgaW50ZXJmYWNlIGdpdmVzIGFjY2VzcyBvbmx5IHRvIHRoZQ0KPiA+IElGTEFf
Q0FOX0NUUkxNT0RFIGRhdGEgd2hpY2ggYm9pbHMgZG93biB0byBhbiBhY2Nlc3Mgb2YgdGhlIG5l
dGRldl9wcml2KGRldiktDQo+ID4gPiBwcml2LT5jdHJsbW9kZSBmbGFncyBzZXQgaW4gdGhlIGRy
aXZlciAoc2VlIGFsc28gaW4gYSBMaW51eCB0cmVlIHVuZGVyDQo+ID4gDQo+ID4gZHJpdmVycy9u
ZXQvY2FuL2Rldi9uZXRsaW5rLmMpLiBCdXQgdGhlICJjdHJsbW9kZSIgZmxhZ3MgcmVwcmVzZW50
IG9ubHkgdGhlDQo+ID4gY3VycmVudCBzZXR1cC4gU28geW91IGNhbiBzZWUgaWYgQ0FOLUZEIG1v
ZGUgaXMgY3VycmVudGx5IGVuYWJsZWQuDQo+ID4gDQo+ID4gQnV0IEkgdGhpbmsgdGhlIHRocmVh
ZCBvcGVuZXIgd2FudHMgdG8ga25vdyBpbiBhZHZhbmNlIGlmIHRoZSBrZXJuZWwgZ2l2ZXMgdXMN
Cj4gPiB0aGUgaW5mb3JtYXRpb24gd2hhdCBtb2RlcyBhIGNlcnRhaW4gZHJpdmVyIHN1cHBvcnRz
LiBUaGF0IGlzIGVuY29kZWQgaW4NCj4gPiBuZXRkZXZfcHJpdihkZXYpLT5wcml2LT5jdHJsbW9k
ZV9zdXBwb3J0ZWQgYW5kIG5ldGRldl9wcml2KGRldiktPnByaXYtDQo+ID4gPiBjdHJsbW9kZV9z
dGF0aWMuIEJ1dCBmb3IgdGhlc2UgZmxhZ3MgdGhlcmUgaXMgbm8gbmV0bGluayBpbnRlcmZhY2Ug
dG8NCj4gPiANCj4gPiBpbnRlcnJvZ2F0ZSB0aGF0IHNldHRpbmdzIGF0IHRoZSBtb21lbnQuDQo+
ID4gDQo+ID4gU28geW91IGNhbid0IHNlZSBpbiBhZHZhbmNlIGlmIGEgQ0FOIGRyaXZlciB3b3Vs
ZCBzdXBwb3J0IGZvciBpbnN0YW5jZSB0cmlwbGUtDQo+ID4gc2FtcGxpbmcgb3IgdGhlIENBTl9D
VFJMTU9ERV9DQ19MRU44X0RMQyBtb2RlLiBUbyBrbm93IGl0IHlvdSBtdXN0IHRyeSB0byBzZXQN
Cj4gPiBzdWNoIG9wdGlvbiBhdG0uIEkgdGhpbmsuDQo+IA0KPiBZZXMsIGJ1dCB0aGUgc2V0dGlu
Z3Mgb2YgcHJpdi0+Y3RybG1vZGVfc3RhdGljIG1heSBsZWFkIGludG8gcHJvYmxlbXMgDQo+IHRv
byBhcyB0aGVyZSBtaWdodCBiZSBhIGZpeGVkIHNldHRpbmcgdGhhdCBjYW4gbm90IGJlIGFsdGVy
ZWQuDQo+IA0KPiBBcyB5b3UgYWxyZWFkeSBwb2ludGVkIG91dCB0aGUgbmV0bGluayBpbnRlcmZh
Y2Ugb25seSBwcm92aWRlcyB0aGUgDQo+IGN1cnJlbnQgc2V0dGluZyBvZiBwcml2LT5jdHJsbW9k
ZS4NCj4gDQo+IEJ0dy4gdGhlIHN0cnVjdCBjYW5fY3RybG1vZGUgaGFzIHR3byB1MzIgZWxlbWVu
dHMsIHNvIHdlIGNvdWxkIHVzZSB0aGUgDQo+IG1hc2sgZWxlbWVudCB0byBwYXNzIHRoZSBwcml2
LT5jdHJsbW9kZV9zdXBwb3J0ZWQgdmFsdWUgdG8gdGhlIHVzZXIgc3BhY2U6DQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL2Rldi9uZXRsaW5rLmMgYi9kcml2ZXJzL25ldC9jYW4v
ZGV2L25ldGxpbmsuYw0KPiBpbmRleCBlMzhjMjU2NmFmZjQuLjkxYzZhZTA2YTU3NiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL2Rldi9uZXRsaW5rLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvY2FuL2Rldi9uZXRsaW5rLmMNCj4gQEAgLTI1OSwxMSArMjU5LDEyIEBAIHN0YXRpYyBzaXpl
X3QgY2FuX2dldF9zaXplKGNvbnN0IHN0cnVjdCBuZXRfZGV2aWNlIA0KPiAqZGV2KQ0KPiAgIH0N
Cj4gDQo+ICAgc3RhdGljIGludCBjYW5fZmlsbF9pbmZvKHN0cnVjdCBza19idWZmICpza2IsIGNv
bnN0IHN0cnVjdCBuZXRfZGV2aWNlIA0KPiAqZGV2KQ0KPiAgIHsNCj4gICAgICAgICAgc3RydWN0
IGNhbl9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYoZGV2KTsNCj4gLSAgICAgICBzdHJ1Y3QgY2Fu
X2N0cmxtb2RlIGNtID0gey5mbGFncyA9IHByaXYtPmN0cmxtb2RlfTsNCj4gKyAgICAgICBzdHJ1
Y3QgY2FuX2N0cmxtb2RlIGNtID0gey5mbGFncyA9IHByaXYtPmN0cmxtb2RlLA0KPiArICAgICAg
ICAgICAgICAgLm1hc2sgPSBwcml2LT5jdHJsbW9kZV9zdXBwb3J0ZWR9Ow0KPiAgICAgICAgICBz
dHJ1Y3QgY2FuX2JlcnJfY291bnRlciBiZWMgPSB7IH07DQo+ICAgICAgICAgIGVudW0gY2FuX3N0
YXRlIHN0YXRlID0gcHJpdi0+c3RhdGU7DQo+IA0KPiAgICAgICAgICBpZiAocHJpdi0+ZG9fZ2V0
X3N0YXRlKQ0KPiAgICAgICAgICAgICAgICAgIHByaXYtPmRvX2dldF9zdGF0ZShkZXYsICZzdGF0
ZSk7DQo+IA0KPiBBZGRpdGlvbmFsbHkgd2UgY291bGQgYWxzbyBtYWtlIHRoZSBtYXNrIGVsZW1l
bnQgaW4gc3RydWN0IGNhbl9jdHJsbW9kZSANCj4gYSB1bmlvbiB3aXRoIGEgJ3N1cHBvcnRlZCcg
ZWxlbWVudCAuLi4NCj4gDQo+IEJ1dCB0aGlzIGlzLCB3aGF0IHdvdWxkIGJlIG5lZWRlZCBoZXJl
LCByaWdodD8NCg0KSXQgbG9va3MgbGlrZSBhIHN0ZXAgaW4gdGhlIHJpZ2h0IGRpcmVjdGlvbi4g
QnV0IEkgd2FudCB0byBhZGQgdHdvIHBvaW50cyB0byANCnRoZSBkaXNjdXNzaW9uLg0KDQoxKSBJ
IHRoaW5rIHRoZSBmbGFncyBtZW1iZXIgb2Ygc3RydWN0IGNhbl9jdHJsbW9kZSBzaG91bGQgY29u
dGFpbiB0aGUgDQpjdHJsbW9kZV9zdGF0aWMgZmxhZ3MgaW4gYW55IGNhc2UsIGJlY2F1c2UgdGhl
IGN0cmxtb2RlX3N0YXRpYyBmbGFncyBhbHNvIGRlc2NyaWJlDQphIHBhcnQgb2YgdGhlIGN1cnJl
bnQgc2V0dGluZy4gSS4gZS4gdGhlIGNoYW5nZWQgbGluZXMgaW4geW91ciBwYXRjaCBzaG91bGQg
cmVhZCB0aGVuOg0KDQorICAgICAgIHN0cnVjdCBjYW5fY3RybG1vZGUgY20gPSB7LmZsYWdzID0g
cHJpdi0+Y3RybG1vZGUgfCBwcml2LT5jdHJsbW9kZV9zdGF0aWMsDQorICAgICAgICAgICAgICAg
Lm1hc2sgPSBwcml2LT5jdHJsbW9kZV9zdXBwb3J0ZWR9Ow0KDQpJIGJlbGlldmUgdGhpcyBkaWQg
bm90IHNob3cgdXAgYXMgYW4gZXJyb3IgdGlsbCBub3cgYmVjYXVzZSBjdHJsbW9kZV9zdGF0aWMN
CmlzIG5vdCB1c2VkIGJ5IGFueSBkcml2ZXIgYXRtLg0KDQoNClRoZW4gYW4gYXBwbGljYXRpb24g
Y2FuIHBvc3NpYmx5IGRvIHNvbWV0aGluZyBsaWtlIHRoaXMgdG8gZ2V0IHRoZSBuZWVkZWQgDQpp
bmZvcm1hdGlvbiAocHNldWRvIGNvZGUpOg0KDQphcHBfZGVjb2RlX2N0cmxtb2RlIChzdHJ1Y3Qg
Y2FuX2N0cmxtb2RlICpjbSkgew0KCXUzMiBhcHBfY3RybG1vZGUsICBhcHBfY3RybG1vZGVfc3Vw
cG9ydGVkLCBhcHBfY3RybG1vZGVfc3RhdGljOw0KDQoJYXBwX2N0cmxtb2RlID0gY20tPmZsYWdz
OwkJCS8qIGN1cnJlbnQgc2V0dGluZyAqLw0KCWFwcF9jdHJsbW9kZV9zdXBwb3J0ZWQgPSBjbS0+
bWFzazsgCQkvKiBjaGFuZ2VhYmxlIHNldHRpbmdzICovDQoJYXBwX2N0cmxtb2RlX3N0YXRpYyA9
IGNtLT5mbGFncyAmIH5jbS0+bWFzazsJLyogZml4ZWQgc2V0dGluZ3MgKi8NCn0NCg0KDQoyKSBJ
IGRvbid0IGtub3cgaG93IGFuIGFwcGxpY2F0aW9uIGxpa2UgdGhlICJpcCIgdG9vbCBjb3VsZCBk
aXNjcmltaW5hdGUgd2hldGhlciANCml0IHRhbGtzIHRvIGEga2VybmVsIHdpdGggdGhlIG5ldyBp
bnRlcmZhY2UgKG1hc2sgZWxlbWVudCBjb250YWlucyANCmN0cmxtb2RlX3N1cHBvcnRlZCkgb3Ig
dG8gYSBrZXJuZWwgd2l0aCB0aGUgb2xkIGludGVyZmFjZS4gVGhpcyBpcyBiZWNhdXNlIG9uIA0K
YW4gb2xkIGtlcm5lbCB0aGUgbWFzayBlbGVtZW50IGNvbnRhaW5zIHVuaW5pdGlhbGl6ZWQgZGF0
YSBmcm9tIHRoZSBrZXJuZWwgDQpzdGFjayBhcyB0aGUgbWFzayBlbGVtZW50IGlzIG5vdCBzZXQg
dGlsbCBub3cuDQoNCkkgZG9uJ3Qgc2VlIGhvdyB0aGlzIGRlY2lzaW9uIGNvdWxkIGJlIG1hZGUg
YnkgdGhlICJpcCIgdG9vbC4NCg0KQmVzdCByZWdhcmRzLA0KICAgIFN0ZWZhbg0KDQo=
