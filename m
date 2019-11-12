Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD48F8C41
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 10:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfKLJxz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 04:53:55 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:57283
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbfKLJxy (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 12 Nov 2019 04:53:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMxNzfnXfLGK1Qi3ohJ0fQSDruaWbT85y5OcmZ/AVuTFoqJIlkIXNZuZXi1Y3RbDOOVbegTYvQ07sgorxNJPX09xG+n497fxtXNHyZDyhEfhfOyK1j2wzrSXCJaTCultRsJ/SgbXWKqqDQFxEt/hSXugkZ9LnqHd4bMlccda9KwMedkPHieSM99p11X4q9l2vdqx4LoIdBYfjnNQY8zz54OHSRMQvHXB7iiYm+XMlozQXPZwQz/D6AoFUPRqbUIm1c+cJEv3H4AI25at4HowTqvtJMCklaFWYdKwRS3J1qULLDcgMYkrLYM+QpZQqK0UMrkcoHV4Fz+e2W0wqHjM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhTBxV/UFn26P2vKwWsy/+JwUaL3GozaXJcRhAW23ao=;
 b=AJMasoLQtTFsX241VVdKK5JoumIfdjISwR8L9itPGSY9NhoAy/znO7d+wMuu63DEqyBUMuzZTZe7uVFN9hKDrjyvYsai34jjTlwPtwwTGAKh1Kp6Jc/meaS2yHIbfvYF92Y/RRaAlefASQkkuyLbdFaYxxyP+wStA7Yfe+daaG7+MpSCkPuw4vO/NInvVlpJK4nIPZxbAy0XlNZpQ69j3dqvdQk/1S6nrD3z0WDxzbVsE/jJv3mUk12NiSwUMd87VVOqBlaziMtfouiy/IMX+q+LITiyjQ8iXuB+dNRtZq1N8t477qpBlm7ZWQIBfqlhT/zxdlWg3NQlixKW4xWpVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhTBxV/UFn26P2vKwWsy/+JwUaL3GozaXJcRhAW23ao=;
 b=k3z0wpTMD9R8NBMs5XWXe0nP5nKQIm8Oy+GzuuzxzCVqTJtDH9K4TSENAmrAR++tRyvseReJ2LGVrh2Z77NRLVw3I4nKBJPYxOg55mKeLQyFRusWDvBpI4tSMxUAJD0z+VuiJcdWo55SxXLk3V3hrSL351f5kfCR6B7x+n46pSk=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB5147.eurprd04.prod.outlook.com (20.176.235.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 09:53:50 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 09:53:50 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Topic: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Index: AdWYdOEh/tYWI8MXSASMqe9cVeZH0AAAx0KAACvRiZAAA1AVAAAAc9fQAACXyQAAAWdfoA==
Date:   Tue, 12 Nov 2019 09:53:49 +0000
Message-ID: <DB7PR04MB4618C4D57D79DF5CE1CE5FBBE6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
 <DB7PR04MB4618061107733A9D53F75FA3E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <a232c1f6-cd91-8526-6fc9-163e9500bdf9@pengutronix.de>
 <DB7PR04MB4618BCC08EE8A9BDDA208C2AE6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <65288408-c12b-8a5f-9b56-132f0f4b3057@pengutronix.de>
In-Reply-To: <65288408-c12b-8a5f-9b56-132f0f4b3057@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90c35a51-9604-446a-3cca-08d7675637ff
x-ms-traffictypediagnostic: DB7PR04MB5147:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB5147B5A5787787DEC3E8C346E6770@DB7PR04MB5147.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(13464003)(199004)(189003)(66946007)(8936002)(2906002)(81166006)(81156014)(229853002)(66476007)(3846002)(66446008)(64756008)(66556008)(99286004)(76116006)(6436002)(110136005)(6116002)(8676002)(6246003)(52536014)(5660300002)(316002)(33656002)(53546011)(966005)(66066001)(14454004)(478600001)(7696005)(71200400001)(76176011)(71190400001)(256004)(25786009)(9686003)(11346002)(446003)(86362001)(6306002)(74316002)(486006)(2201001)(186003)(476003)(305945005)(55016002)(7736002)(2501003)(102836004)(26005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5147;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pphg3Wt8aFs5KdKVxPI4YRVBTfFICMxj9phQauMba/smvztZ+wpH1cINeYv+uyERM9rq/8uGI3IgRXmAuVKCVorBVzgiZGS46WPA1VF8vJ5QXY59Di9tEAmlgc3sDG2qXhKWZajUeNM4dzqszwuf38PwK868gaylf5vA9jvEuLLWi2LnmEjRlpwTJjn4PXcJCHzvnh1LMracS6SGXNXU6khxp3fHr8aIHhvVmx+823LjJ0L25wSDKQfii9Tavy7nm1aiqvfGcwu5j/5YHeX8jiZg2os44m/36LK13zZIwTNqeLeExf1KmuMBfb72oaQHdaiIUtUGzLbQdAJYDbmA3FOK2M+whbFQxVuJDOuBXYINydzAqICd2iBWrdWIvOqONZNFLXISi+jWUM4C/emxergqgYpd+hmJYhRJX25MCDGCaIT+xd0+M1/rp858FspyPgWWOq9zhvwFVfovBPiK3zpoh0uMhljOz+6YVi9XUxk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c35a51-9604-446a-3cca-08d7675637ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 09:53:49.9767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35/TsHv+CnD5b6ngQffHEPTSnzRO3kF5WXIlM+Wwknlp7YvgRhiuWUSBvL1tJhGV+xwFFkoP5cULirxO3YmXFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5147
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQxMeaciDEy5pelIDE3OjA4DQo+
IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgc2VhbkBnZWFuaXgu
Y29tOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBXYWtlIHVw
IGlzc3VlIGFib3V0IEZsZXhjYW4gZHJpdmVyIGluIHY1LjQga2VybmVsDQo+IA0KPiBPbiAxMS8x
Mi8xOSAxMDowMSBBTSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0
cm9uaXguZGU+DQo+ID4+IFNlbnQ6IDIwMTnlubQxMeaciDEy5pelIDE2OjM4DQo+ID4+IFRvOiBK
b2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgc2VhbkBnZWFuaXguY29tOw0K
PiA+PiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBXYWtlIHVw
IGlzc3VlIGFib3V0IEZsZXhjYW4gZHJpdmVyIGluIHY1LjQga2VybmVsDQo+ID4+DQo+ID4+IE9u
IDExLzEyLzE5IDg6MTIgQU0sIEpvYWtpbSBaaGFuZyB3cm90ZToNCj4gPj4+IEkgZHVtcCBzb21l
IGluZm8gaW4gd2FrZSB1cCBjYXNlIGZyb20gdjUuMy4xMCB3aXRoIGJlbG93IGNoYW5nZToNCj4g
Pj4+IHByaW50aygiXG5tYWlsYm94X251bSA9ICV1LCB0aW1lc3RhbXAgPSAldSwgY2FuX2lkID0g
JXhcbiIsIG4sDQo+ID4+PiAqdGltZXN0YW1wLCBjZi0+Y2FuX2lkKTsNCj4gPj4NCj4gPj4gS2Vl
cCBpbiBtaW5kLCBhIHByaW50aygpIGNvbXBhcmVkIHRvIGEgdHJhY2VfcHJpbnRrKCkgd2lsbCBp
bnRyb2R1Y2UNCj4gPj4gYmlnZ2VyIGxhdGVuY2llcy4NCj4gPg0KPiA+IFRoYW5rcyBNYXJjLCBJ
IHdpbGwgbGVhcm4gaG93IHRvIHVzZSB0cmFjZV9wcmludGsoKSBsYXRlciBhcyBpdCBjYW5ub3QN
Cj4gPiB3b3JrIGF0IG15IHNpZGUgbm93Lg0KPiANCj4gT2sNCj4gDQo+ID4gSG93ZXZlciwgdGhl
IHNhbWUgb3V0cHV0IHdpdGhvdXQgcHJpbnRrKCksIHNvIHRoZSBsYXRlbmNpZXMgaGVyZSBoYXMN
Cj4gPiBubyBlZmZlY3QuDQo+IElmIHByaW50aygpIG91dHB1dHMgdG8gc2VyaWFsIGNvbnNvbGUg
aXQgaGFzIGEgaHVnZSBvdmVyaGVhZC4gRnVydGhlcg0KPiB0cmFjZV9wcmludGsoKSBpcyBkZXNp
Z25lZCB0byBoYXZlIHZlcnkgbG93IG92ZXJoZWFkLCBldmVuIHdoZW4gY29tcGFyZWQgdG8NCj4g
cHJpbnRrKCkgbm90IG91dHB1dHRpbmcgdG8gY29uc29sZS4NCg0KR290IGl0Lg0KDQo+IFsuLi5d
DQo+IA0KPiA+PiBZZXMsIHRoZXNlIHRpbWVzdGFtcHMgYXJlIGFsbCBvdmVyIHRoZSBwbGFjZS4g
SXQncyBkdWUgdG8gdGhlICJiaWciDQo+ID4+IGdhcCBvZiAxMDBtcyBiZXR3ZWVuIHRoZSBDQU4g
ZnJhbWVzLiBXaGF0J3MgdGhlIGNvbmZpZ3VyZWQgYml0cmF0ZSBvZg0KPiB5b3VyIGJ1cz8NCj4g
Pg0KPiA+IGlwIGxpbmsgc2V0IGNhbjAgdXAgdHlwZSBjYW4gYml0cmF0ZSAxMDAwMDAwDQo+IA0K
PiBXaXRoIDFNYml0L3MgeW91IGhhdmUgb3ZlcnJ1bnMgZXZlcnkgNjVtcyAod29yc3QgY2FzZSku
DQoNClllcy4gV2hhdCdzIHRoZSBiaXRyYXRlIHlvdSB3YW50IG1lIGhhdmUgYSB0ZXN0Pw0KDQpJ
IGhhdmUgYSBxdWVzdGlvbiwgbWFpbGJveCByZWFkIGhhcyB0YWtlbiBjb3VudGVyIG92ZXJmbG93
IGludG8gY29uc2lkZXJhdGlvbiwgd2h5IGRvZXMgb3ZlcmZsb3cgcXVpdGUgb2Z0ZW4gd2lsbCBj
YXVzZSB0aGUgZnJhbWUgZGlzb3JkZXI/DQoNCkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0K
PiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICB8IE1h
cmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgICB8DQo+IEVtYmVkZGVkIExpbnV4ICAgICAgICAgICAg
ICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgIHwNCj4gVmVydHJldHVuZyBXZXN0
L0RvcnRtdW5kICAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTkyNCAgICAgfA0KPiBBbXRz
Z2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDktNTEyMS0yMDY5MTctNTU1
NSB8DQoNCg==
