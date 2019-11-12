Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8BFF8DBD
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 12:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfKLLOd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 06:14:33 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:5959
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfKLLOd (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 12 Nov 2019 06:14:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ0LyTuDgjutRwaue77h8T211Nma6fevsJnrR7ucAwx4S80TP05AVSF43Bf2nispdmbBq1VsD56d73mRy5lDXssLbw1jhNpW06tOvzlvRg98QXYuXCtsQijZLdXCL4cYKuCDfT8mC5FSYBB5+Lw2+Xa5iP46w4CLcfdddpJhsmAM4Qk5ip1VunPC5sejtsloUlS32Y/LMcO8PWxZ3buN9UaeW3X0FdvcXuNosPbMrCNvFGqoyONwo1sNgNbvM//VOefqzePJB+rPQvEVHDpSP9JnlOikRrMtT7v58qgk+qpbnpvodHSgL/uIiPJlafuPnmS5P4NhLimrg7cnxZv+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32W1PabxRHdR2SdtNpL3hvbxWOv6+3dSvI3+YB7Stwo=;
 b=MVcAcLnOJb4t9YTpZl3ZnuUDf866AMw3iAl9zMG289GkysZObQULPTWTjvG1AJqUph1FTCK8OfQ+ZKUKSKO2ThfOswtWbHBHhO2gbYcGypxKcdLV0f1ajkwpcUu38WzlZvh0+Nmi+hRg6Ui4w3ImpL6LmT9RLUeuN57T5qNWwiACdLFfzd3uggnIAyWnIdoNTSeX0AR0BUHsGWf80hwzTMXFTurlb2lnU3syXT7HC0TLauMdARtnPaX45qo8zE35il5IfDBqPNHL5A8sH6P9Kzx8iRaErKZkmaUbUnSeDIMqGAxIh40AZsarxwUn/UaWGqqG2VLDsM7UIo4dBW8IQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32W1PabxRHdR2SdtNpL3hvbxWOv6+3dSvI3+YB7Stwo=;
 b=g1ubudHHrtteCs91b17lOQMLzLm1dUVg9L+4rfLoiBMkdkTi1pGhS4XzhO5VBPwPzAOP507nrsXbH8WOgZt11khDPsVEklXAIddj2k834yyXLc3b8skgew5aFXzdoc0+ZqWRXECzFhzMwjx4s5AuYOWJqtsW/GaSHm4+WxzIxcI=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB5196.eurprd04.prod.outlook.com (20.176.234.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Tue, 12 Nov 2019 11:14:28 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:14:28 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Topic: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Index: AdWYdOEh/tYWI8MXSASMqe9cVeZH0AAAx0KAACvRiZAAA1AVAAAERDYwAADUY4AAABC9MAAALnGAAAANmKA=
Date:   Tue, 12 Nov 2019 11:14:27 +0000
Message-ID: <DB7PR04MB4618D7ED7A7520E0D934C940E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
 <DB7PR04MB4618061107733A9D53F75FA3E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <a232c1f6-cd91-8526-6fc9-163e9500bdf9@pengutronix.de>
 <DB7PR04MB46185028D8CAEAB201792526E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <eb9b7dda-0d9d-1c71-fd87-a0f1abff9311@pengutronix.de>
 <DB7PR04MB461839FCB6AC004B2A2BFE74E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <330217d8-16cf-5bdc-1b8f-fa2a7ce214e2@pengutronix.de>
In-Reply-To: <330217d8-16cf-5bdc-1b8f-fa2a7ce214e2@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: befa4db2-ea9d-4f21-9525-08d767617bd7
x-ms-traffictypediagnostic: DB7PR04MB5196:
x-microsoft-antispam-prvs: <DB7PR04MB5196953CDF949B0BAE6A4C46E6770@DB7PR04MB5196.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(13464003)(199004)(189003)(5660300002)(2501003)(2906002)(71200400001)(476003)(11346002)(446003)(486006)(71190400001)(6506007)(53546011)(102836004)(14444005)(256004)(26005)(3846002)(76176011)(7696005)(25786009)(6116002)(110136005)(74316002)(229853002)(7736002)(305945005)(316002)(8936002)(81156014)(81166006)(6306002)(8676002)(76116006)(33656002)(86362001)(478600001)(2201001)(52536014)(55016002)(99286004)(66946007)(66446008)(66476007)(66556008)(64756008)(6246003)(9686003)(66066001)(6436002)(966005)(14454004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5196;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TsTWyzZgMkLPWcessZKVjYxU+SmKPmWLAQYPJ97z49iDnQ50dhlRRJU89q/erLrTsNJH1pafs6SCUWnagnrEWuOPHCO/wcdeazwt+IBtsv9CwM1TuP6oFX1BHrygf8dU3DCE4nbeam0PQhlTCxe3caV0nfJK1UurPD3eD67dJPlXcZwBuWqjbkrxCPHo0fa29FRyoCQPZGNk7cs7zkn8/uoix4U60HktRh91uR+fbowiDBGY5QEL1W6PPRmTRCiHuGaZQC97cJiRvAin3+Sm89saThKJt+qqTrtEXgiio4jPVKQZOMLlxrxPc9UhUrlnh6zNfaviGsVTwoh8f8aWC2JcfFLEXwcdNK791BHEhFviTTML8Q7Zbon3Ysz3xIKnFD5lyGH1TQGujf4rPqS3a5+AVannSc7cWfTxmI/DuNN6YW++ryuXzgXJ5FS0WiRE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befa4db2-ea9d-4f21-9525-08d767617bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 11:14:28.1960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8f3rYCc6D+BY97APwI4dJOiwdNN+oqs+cXEEzKRGBhqPbrGWUFmpbUuNFUfonfG44BNCTsjxq+19fSWz+egqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5196
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQxMeaciDEy5pelIDE5OjExDQo+
IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgc2VhbkBnZWFuaXgu
Y29tOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBXYWtlIHVw
IGlzc3VlIGFib3V0IEZsZXhjYW4gZHJpdmVyIGluIHY1LjQga2VybmVsDQo+IA0KPiBPbiAxMS8x
Mi8xOSAxMjoxMCBQTSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+PiBUaGUgcXVlc3Rpb24gcmVt
YWlucywgaGFzIHRoZSB3YWtldXAgdGltZSBpbmNyZWFzZWQgY29tcGFyZWQgdG8gb2xkZXINCj4g
Pj4ga2VybmVscz8gT3Igd2FzIGl0IHB1cmUgbHVjayB0aGF0IHlvdSBoYXZlIG5vdCBzZWVuIHRo
aXMgcHJvYmxlbSBpbg0KPiA+PiBvbGRlciBrZXJuZWxzPw0KPiA+DQo+ID4gSSBoYXZlIHRlc3Rl
ZCBhbGwgdXBzdHJlYW0gdmVyc2lvbiBzaW5jZSBzdG9wIG1vZGUgZW5hYmxlZCh2NS4xLCB2NS4y
LA0KPiA+IHY1LjMsIHY1LjQpLCB0aGlzIGlzc3VlIGFsbCBleGlzdC4gV2l0aCBvdXIgbG9jYWwg
NC4xNCBhbmQgNC4xOSwgaXQgaXMNCj4gPiBmaW5lLCBtYXliZSB3ZSBvcHRpbWl6ZSBzdXNwZW5k
L3Jlc3VtZSBhdCBsb2NhbC4NCj4gDQo+IE9rLiBJIHNlZSBtb3JlIHBhdGNoIG9wcG9ydHVuaXRp
ZXMgb24geW91ciBzaWRlLg0KDQpNYXJjLCBhbnkgaWRlYSB0byBmaXggdGhlIGlzc3VlLCBJIHRo
aW5rIEkgY2FuIHRyeSB0byBpbXByb3ZlIHdha2UgdXAgY2FzZSwgdGhhbmtzIQ0KDQpCZXN0IFJl
Z2FyZHMsDQpKb2FraW0gWmhhbmcNCj4gTWFyYw0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5L
LiAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KPiBFbWJl
ZGRlZCBMaW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRl
ICB8DQo+IFZlcnRyZXR1bmcgV2VzdC9Eb3J0bXVuZCAgICAgICAgIHwgUGhvbmU6ICs0OS0yMzEt
MjgyNi05MjQgICAgIHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBGYXg6
ICAgKzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0KDQo=
