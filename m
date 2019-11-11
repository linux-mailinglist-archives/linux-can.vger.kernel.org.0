Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35BDAF714F
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 11:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfKKKCg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Nov 2019 05:02:36 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:13540
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbfKKKCg (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 11 Nov 2019 05:02:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc1luY5fJ40GnTT+S1blEcCDZpe7Wi11gupEnlvg0NQ7x+NdSp/jRCHkdfjI8IKYoRkD1bagdqUn+SqbFGXuyfpaCVJUW+/H8tdAUaXB/MNilKR3ub/NsJy2BIpPeE8OsnWjQy3EvMxnkDf+4mVGML+v0/Z7uIXbDyqnsvFsg0lwSVfnuhb/iEhwKFP7JDAD5xlbfSH3VsqlaRycOVdrRnU8EBU+0FDhKy1aSCrWu8N7O2bNrh0akhoU1NecB5zyNbVu4fzjP5UDbpltbODIetXROh7P6aZbriRp5mwcJj6+bOpaEbTVAwKPF7zy8qlVrzEGBZkL89gnG4yYDz+R3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL6jtV9Az9L0lwH4qlx7dGbjsf5KgRBZcdeHRKbwijc=;
 b=HHIaKD3VqQRJI6AwXB+mabI+g19JRTgFsG1T5EU40ZOuLBL/CyA9GFZQbLJO0zVcoppAKZVg78gMl7yebB4+Xjruc0o8f7iffpcQIA4CCflfWx4OP2DQMYjwcRdvk4WFoQufiMqrN6ydB3dgLxQUlZvJrtBNyRsAB5HrlvyX9rXPQrYywrja4qu3t6DaHPgk4cKQjcWeYSAZ3f7lkS9w3R9oz2ioM/Jr7KLhT04ZOZzHgfrFo3O5pWKH4gUJ+V9S9040kpHahbEklxP9cpfdeqqDE2RG6jTINwqJ8um27R+MlhVuHnoDTxbOYlk2eu4Bf+z+HcowyO1DXwVJkfpHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL6jtV9Az9L0lwH4qlx7dGbjsf5KgRBZcdeHRKbwijc=;
 b=A52XKoXmylmGlZu7DkHDnv4kKAgjUtaUedZvl9RyzDs9X3KbsFqfMmCQ1Ie9c2U1rAXv8kT64Uc85WYUCT8AOOlvHx51qDYI0F0w861KSV/XhNE385A/Eoc2/Xv1QfnmvnSRWbEV5YBA75u8WowgPkbnueI8Z+n1GJ4bfx/J4EI=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4185.eurprd04.prod.outlook.com (52.134.111.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 10:02:33 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 10:02:33 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Topic: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Index: AdWYdOEh/tYWI8MXSASMqe9cVeZH0AAAKz4AAABdd4A=
Date:   Mon, 11 Nov 2019 10:02:33 +0000
Message-ID: <DB7PR04MB461805D9999B0E9DAE584FCCE6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <5d672fd5-0b89-bba4-0591-662ff2b769b6@pengutronix.de>
In-Reply-To: <5d672fd5-0b89-bba4-0591-662ff2b769b6@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4c126cf-e0f8-467c-4c68-08d7668e4579
x-ms-traffictypediagnostic: DB7PR04MB4185:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB4185CCDACB9527D96452E47CE6740@DB7PR04MB4185.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(13464003)(189003)(199004)(2906002)(8936002)(6436002)(81156014)(229853002)(81166006)(6116002)(3846002)(99286004)(66446008)(64756008)(8676002)(76116006)(316002)(110136005)(6246003)(66946007)(66476007)(66556008)(4744005)(52536014)(5660300002)(33656002)(966005)(14454004)(478600001)(7696005)(76176011)(71200400001)(66066001)(71190400001)(256004)(25786009)(9686003)(11346002)(446003)(86362001)(6306002)(74316002)(305945005)(486006)(2201001)(186003)(476003)(7736002)(6506007)(55016002)(102836004)(2501003)(26005)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4185;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: icsQTT/WWzV/ktETqUd4IW+tRmP2qGpU4cpnjvMvDnF4qsYY+TpSZeNLVMEgB9ghQJrz4bDawy7EgSM/MemUwagh58SdUXq0U685S3bCA/o9dfdr8hz8kZxtjKGv1OVTbHiVxVknaJFvBVTSbpDDUe3fAbA3d1iFBZ32D9EzKh3oMgwE7NpvLZV6aUz0yOsrHhfg2xAnjMKaIVdMaH/skBVf3vuNWIbpWgrPTd09ZAbBNWcfndgnMnTkSyhnFP6zUDDmbMc8xu4IxpzZeMaj5BCqxkq2AJoUeFuU5o6LMalFKCRaJ7XtW/1hHV0tgz5vzgfrwysgtafx8tn9Zf1/WYrLiAyFjCPS1Z4D0OTaQxhR7Ob+mtYJAYkum7YgH50LZ4xcUR17igeA3g5X9uqUCxVGFW2eJmOCnjtCQKH0QdsTyuTebsKlboSoi/gQB8gAoVx0m3kJoSxAv4Yprd/EPK8BIA8S65c8KXdncyvg5ds=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c126cf-e0f8-467c-4c68-08d7668e4579
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 10:02:33.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9bTS3T5+d7Vh7LqvIpd7TWOc7zDu9J7F+T+DR3xNgw2umjOPCCAgWA4SX8m0WzczfVZLbQzA1w7UOlVuiMw4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4185
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQxMeaciDEx5pelIDE3OjUxDQo+
IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgc2VhbkBnZWFuaXgu
Y29tOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBXYWtlIHVw
IGlzc3VlIGFib3V0IEZsZXhjYW4gZHJpdmVyIGluIHY1LjQga2VybmVsDQo+IA0KPiBPbiAxMS8x
MS8xOSAxMDo0OCBBTSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4g
SSBoYXZlIGJlZW4gZGVidWdnaW5nIGZvciBhIGZldyBkYXlzLCBJIGNvdWxkIHRoaW5rIHNvbWV0
aGluZyBjaGFuZ2UNCj4gPiBmcm9tIENBTiBmcmFtZXdvcmsgbGVhZCB0byB0aGUgcHJvYmxlbSwg
ZXhjbHVkZSB0aGUgaXNzdWUgZnJvbSBDQU4gZHJpdmVyLg0KPiA+DQo+ID4gQ291bGQgeW91IHBs
ZWFzZSBwb2ludCB0byBtZSB3aGF0IGNhbiBJIGRvIGZvciBmdXJ0aGVyIGRlYnVnZ2luZz8gSXQN
Cj4gPiByZWFsbHkgYm90aGVycyBtZQ0KPiANCj4gSWYgeW91IGhhdmUgYSB3b3JraW5nIGFuZCBh
IG5vbiB3b3JraW5nIHZlcnNpb24sIHVzZSBnaXQtYmlzZWN0IHRvIGZpbmQgdGhlIHBhdGNoDQo+
IHRoYXQgaW50cm9kdWNlcyB0aGUgcHJvYmxlbS4NCg0KVGhhbmtzIE1hcmMsIEkgd2lsbCBoYXZl
IGEgdHJ5IQ0KDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAg
ICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgIHwNCj4gRW1iZWRkZWQgTGludXgg
ICAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSAgfA0KPiBWZXJ0
cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0ICAg
ICB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0OS01MTIx
LTIwNjkxNy01NTU1IHwNCg0K
