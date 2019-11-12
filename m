Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A91F8DA2
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 12:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfKLLKE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 06:10:04 -0500
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:57255
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfKLLKE (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 12 Nov 2019 06:10:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdqc6DvsMiVpyp6mQbDtA7Gc7lmK4gE2t4wXcVP3JN3cmTj2hL/tmfMttFV57Zz93w5b+ayN2hUUsMAJtsuIopZbMtjrZ6nXkLRFx9ZR2WaBN7/m+NvYIoijL+4tQSyf+0YvDAPFBFcB5eyJppheJnxScjBKaviZjrk+D5trnKKNqo/qiDTvU4zylsCMU3Dc2lXU8ONMlGu5S6pElgaFwtXeLrg7clNXT3bHxbTEGJy1baNTKjokr/+8DFWIff340fiwOeDNzZFiiuHBoM0XtrEAEN8SE14mImXlaAmCYtNdtP/5R1FU5IT/yhFlLU8rgtulFPGtTelW7GMthWt4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cygU+IWl7Dmg6tYqnu3HWjbMbnUgP4XlwH7AJSj182o=;
 b=kOmxxVD0CnI/jBWREtXCnp8l7GjEZiBSh1qVuGXSRrW8s8fsswi0JukKveTPRCl66xkgsR0ixQMZwUyv9nMvG2SQmgii/11W34K0r1OsEe5CgCib5u6KH9ZQ0cZv79M+mbM0PimJMKqlpJZofbg6i/zb2l/ib/CNQD0dkPyuiezpDCcc9reRXBLn/BBCYNhbPmifG8Hyb2At31vsb6Ca7OMoaEe+dalM2mTmOB1MffAfBaF8XxetHo6gdBcaAzX/g1Se0ba/0dvJPV4bo65SF0dFCOEz2zTFhAt6QkuZ3gSngFx+TeBUlXsNUAZcNrZRIwoTylKhyTQ9i6gKzydmFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cygU+IWl7Dmg6tYqnu3HWjbMbnUgP4XlwH7AJSj182o=;
 b=ASs7ETeojHDq7SbM8t7Q/hHiiUALwG1SoaUgwXigvk/pMJtNiCfJdurVSqwzReMlCZBMuH7H9mDqyRH3Xg4If79uAPrWgJwEfEtIxAiNGjYX4buze9E+BUhCEQZm8wYFjyd5z2TuMSDl86j+hhBXIfE+4BCezwoPBNl+JI1wwM8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4284.eurprd04.prod.outlook.com (52.135.131.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 11:10:00 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:10:00 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Topic: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Index: AdWYdOEh/tYWI8MXSASMqe9cVeZH0AAAx0KAACvRiZAAA1AVAAAERDYwAADUY4AAABC9MA==
Date:   Tue, 12 Nov 2019 11:10:00 +0000
Message-ID: <DB7PR04MB461839FCB6AC004B2A2BFE74E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
 <DB7PR04MB4618061107733A9D53F75FA3E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <a232c1f6-cd91-8526-6fc9-163e9500bdf9@pengutronix.de>
 <DB7PR04MB46185028D8CAEAB201792526E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <eb9b7dda-0d9d-1c71-fd87-a0f1abff9311@pengutronix.de>
In-Reply-To: <eb9b7dda-0d9d-1c71-fd87-a0f1abff9311@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28dd3506-a0e4-4b51-b5f3-08d76760dc3a
x-ms-traffictypediagnostic: DB7PR04MB4284:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB42846B7EBA62B6F893E664F0E6770@DB7PR04MB4284.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(13464003)(189003)(199004)(6506007)(7696005)(6436002)(53546011)(99286004)(76176011)(478600001)(8676002)(66066001)(33656002)(3846002)(6116002)(5660300002)(446003)(25786009)(486006)(476003)(11346002)(52536014)(8936002)(2906002)(74316002)(186003)(102836004)(26005)(229853002)(76116006)(2201001)(66946007)(110136005)(66446008)(81156014)(81166006)(9686003)(966005)(66476007)(64756008)(66556008)(86362001)(14454004)(71200400001)(316002)(305945005)(6306002)(2501003)(6246003)(14444005)(71190400001)(256004)(7736002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4284;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0LJYwthuyFuLi7v/or8OmMIKN0I/TGp0zH6TTjdyH5Kqlc2bT3oWl6+cU+n1rlIKArvh2jrqCsaW27U2p4mii0iOat/wlJxPX40aqxIiJKj2lSakZO6SHbM2D/K93qq/ROu5fng6TkUdGWmBObRNEqKlylKcN9sXJgM7kM2Fi4Co9mTHbgPcXqoRZ6NFgvPyLKyWIzXg7rgYfuLwVAM/2ydOx+589wriYlakTubbPFIIQFUsk9Z/ArB3dCHC5CT3pknCfMgHScHzd3W1ZMqIAj3L1f+0vCYIbnF3+tMXopJXj4LQQE9viEEVAXdq193ahVc1/41JBuIRJxWnsBfUXR8hfuwQMfbujWyeK94DcCerLRZ29d+mVWGNWUwsGxriXrpzPG8douEnu+VPFiG20wq4tB8GhOzPMidg21SdbCeH1yXVgLFaP7bCqge6eBso9MtLXPWZOUmecRZ+I3Svk0oooBJaI98TMbb/aO1x4Ao=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dd3506-a0e4-4b51-b5f3-08d76760dc3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 11:10:00.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/f6/AEG8Wxg1X/rHcb7pGOStHsbUUy+wym423h5HFkx1LuvOlqt8sH/FTaPfY2mXi2vAOI1w294YC1gE7yIjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4284
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQxMeaciDEy5pelIDE5OjA0DQo+
IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgc2VhbkBnZWFuaXgu
Y29tOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBXYWtlIHVw
IGlzc3VlIGFib3V0IEZsZXhjYW4gZHJpdmVyIGluIHY1LjQga2VybmVsDQo+IA0KPiBPbiAxMS8x
Mi8xOSAxMTo0NyBBTSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+PiBJIHRoaW5rIHdlIGNhbiBl
eHBsYWluIGNhc2UgMiksIGJ1dCBJIHRoaW5rIGNhc2UgMSkgaXMgZGlmZmVyZW50LiBDYW4NCj4g
Pj4geW91IHJlcGVhdCB0ZXN0Y2FzZSAxKSBzZXZlcmFsIHRpbWVzIGFuZCBzZW5kIHRoZSBvdXRw
dXQ/DQo+ID4NCj4gPiBJIGRvIG5vdCBxdWl0ZSB1bmRlcnN0YW5kLiBCdXMgYml0cmF0ZSAxTWJw
cywgc28gdGhlIGNvdW50ZXIgb3ZlcnJ1biBldmVyeQ0KPiA2NW1zOg0KPiA+IENhc2UgMSkgZGVm
YXVsdCBmcmFtZSBnYXAgaXMgMjAwbXMsIGNhc2UgMikgY29uZmlndXJlZCBmcmFtZSBnYXANCj4g
PiAxMDBtcywgd2h5IHdlIGNhbiBleHBsYWluIGNhc2UgMik/IFdoYXQgaXMgdGhlIGVzc2VuY2Ug
b2YgdGhlc2UgdHdvPw0KPiANCj4gT2gsIEkgbWlzc2VkIHRoZSBmYWN0IHRoYXQgMSkgdXNlcyB0
aGUgZGVmYXVsdCBnYXAgb2YgMjAwbXMuDQo+IA0KPiBUaGUgcHJvYmxlbSBpcyB3YWtldXAgbGF0
ZW5jeSBmcm9tIGZyYW1lIHJlY2VwdGlvbiB0byBJUlEgaGFuZGxlciBpcyBtdWNoDQo+IGJpZ2dl
ciB0aGFuIHRoZSBjb3VudGVyIG92ZXJmbG93Lg0KPiANCj4gVGhlbiB3ZSBjYW4gZXhwbGFpbiBj
YXNlcyAxKSBhbmQgMikuDQo+IA0KPiBUaGUgcXVlc3Rpb24gcmVtYWlucywgaGFzIHRoZSB3YWtl
dXAgdGltZSBpbmNyZWFzZWQgY29tcGFyZWQgdG8gb2xkZXINCj4ga2VybmVscz8gT3Igd2FzIGl0
IHB1cmUgbHVjayB0aGF0IHlvdSBoYXZlIG5vdCBzZWVuIHRoaXMgcHJvYmxlbSBpbiBvbGRlcg0K
PiBrZXJuZWxzPw0KDQpJIGhhdmUgdGVzdGVkIGFsbCB1cHN0cmVhbSB2ZXJzaW9uIHNpbmNlIHN0
b3AgbW9kZSBlbmFibGVkKHY1LjEsIHY1LjIsIHY1LjMsIHY1LjQpLCB0aGlzIGlzc3VlIGFsbCBl
eGlzdC4gV2l0aCBvdXIgbG9jYWwgNC4xNCBhbmQgNC4xOSwgaXQgaXMgZmluZSwgbWF5YmUgd2Ug
b3B0aW1pemUgc3VzcGVuZC9yZXN1bWUgYXQgbG9jYWwuDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtp
bSBaaGFuZw0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAg
ICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgICB8DQo+IEVtYmVkZGVkIExpbnV4ICAg
ICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgIHwNCj4gVmVydHJl
dHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTkyNCAgICAg
fA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDktNTEyMS0y
MDY5MTctNTU1NSB8DQoNCg==
