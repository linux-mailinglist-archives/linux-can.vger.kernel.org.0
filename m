Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDA4F8E18
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 12:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfKLLTV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 06:19:21 -0500
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:34116
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727786AbfKLLTV (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 12 Nov 2019 06:19:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzLvq1EIeX34jm3JvtXgtfMLlNXgZW4TfBLnkpM8YpMZk9BTUhjHCTGIHBspYrQwjbYg+IDLEz3sRpP9O0XKooJ/cnKVoBBObeX1HAB/I8SyBvrURvrMFftIqJw+Uemoc+jUFyQ5sik+tpkl0Y0vFauNfXYdp4dHjd6z5mob3z9y1y8UATmHgm/ur+Qd7eixAD6YmYgPmjz8MnEEfKNviV0+qEstMbVygKa0fvcqSZgyRyJisqJUBrCQ+V+pj9SGRBL5uh3K8cj9T26wA+LI7eHDrfhmM3g2mXw4TRRqKMZghZ2aX7NXDlQu/KW0rJ00Or7aV+rOFO9hZAKP1Rpwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWSwZZO/8byH8FPHKqvEEdn5fSNJohhF15stoLjsn/0=;
 b=NcBbFUDkPOn8Da8EE4Kday/BQs7X24RUhupIW0Crm7bjzt7D98yNd5egZyM1Q2nELPBeB6k+QdZfUP6AS6r9mSgunwYQH/qlv5iKTkl/YRMUCzjJUP1MvMpA0SVnCcVoyfzUUNkU1ZVdHzyjpgn0I6tzKPIELbe6dcQrx8ifJ97oJqDzK7iC5VJbdI/JX3pOW4bkXK8x2DZqYd0z8Ay/2jX6oO+WZiABwkMMSSLCh9sJjAu6mEiBeAXsMm06uTvoBVMQ0EPEngc6mgf1DAZzuFRnQx4aOGyNdcG9VEfl0+3blAJsgeTPM8ony08Iry1OMLWii438EOTqO+qDmtSY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWSwZZO/8byH8FPHKqvEEdn5fSNJohhF15stoLjsn/0=;
 b=T/+xlRta3a+hMzNQ/ZdzyOBaxtQaI6jEDQtbQZCvSc8N/jqIjGwRzDIGR0ueUHFudOsFeeVKJnZaYBRrGe9BDDvWCZF89r3E4q0yz3J3Ga1lnRJ9Ze5kszq0o2gKBsU3LnWw+hs5ajOsBfE7n/QnMHaOqYFxjQXNQKe7AZydMoY=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4284.eurprd04.prod.outlook.com (52.135.131.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 11:19:18 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:19:18 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Topic: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Index: AdWYdOEh/tYWI8MXSASMqe9cVeZH0AAAx0KAACvRiZAAA1AVAAAERDYwAADUY4AAABC9MAAALnGAAAAzl/A=
Date:   Tue, 12 Nov 2019 11:19:18 +0000
Message-ID: <DB7PR04MB46188186E97B4ADC9330620AE6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 6908aa30-67ed-4b51-6f14-08d767622896
x-ms-traffictypediagnostic: DB7PR04MB4284:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB42848E5F8A2248962728DC91E6770@DB7PR04MB4284.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(13464003)(9686003)(966005)(66476007)(81166006)(81156014)(66446008)(64756008)(66556008)(66946007)(76116006)(2201001)(110136005)(6246003)(2501003)(14444005)(305945005)(6306002)(55016002)(256004)(71190400001)(7736002)(316002)(71200400001)(14454004)(86362001)(478600001)(8676002)(76176011)(33656002)(66066001)(7696005)(6506007)(99286004)(6436002)(53546011)(186003)(74316002)(52536014)(2906002)(8936002)(229853002)(26005)(102836004)(6116002)(3846002)(476003)(486006)(11346002)(5660300002)(25786009)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4284;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFrwGedpSjMsS0bLj9PRF7OEC4Sx+U0dEmedu8DDd81aAqf/Cjkqd7xZHD6hMos0brq5U5OmLeJPg5leRkDnqj7VLNhOB/Iw5j077rARHotbblpx+78MpV0PSKfOEKxnTf0TGAIGRRnq9wGJ02OAwTS+Uo0x/Spfa80+OifuDy0V0EXMGJcPEVRh16JL1dVwxgY29dDM0g9KaGcz2el55/wLtV81aLMDiEWZZ2If7AKkCEhzEybHPTvocXn6CKbvtIj6wXrmtaEXel3HAAPEnJjkl3wGfG52cdXt/orcL3goog2My+8zAa95asEHJLYFiVGgVWlGt+fCTdcLq9fJXc7nPYXK+cArnGKXU2MmuJHjWVJoXfxeQWD5B2mh92kcFI8kjE5V9loyo9LntMTvOChxORMs8AkoN92fIYlIMWg2gcG/babTXD+hyu3FgwJGT9yOFoQNxo42HzF1RwvFXj3UzrTo/5D0Q7r10QWVXZM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6908aa30-67ed-4b51-6f14-08d767622896
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 11:19:18.1108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1tiDOCKy6qaoKgxyb2a/McjgZ32VI/g2zirEtxpDJOtBTF8UhgNunCUhdyZr2AYxR9DMjn7cwfob3OM4FZdDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4284
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
ZXMgb24geW91ciBzaWRlLg0KDQpIaSBNYXJjLA0KDQpDb3VsZCB5b3UgcGxlYXNlIHBpY2sgdXAg
dGhlIHBhdGNoIGZvciB3YWtldXA/IFRoaXMgaGFzIGJlZW4gcGVuZGluZyBmb3IgYSBsb25nIHRt
ZS4NCmNhbjogZmxleGNhbjogZml4IGRlYWRsb2NrIHdoZW4gdXNpbmcgc2VsZiB3YWtldXANCmNh
bjogZmxleGNhbjogYWRkIExQU1IgbW9kZSBzdXBwb3J0IGZvciBpLk1YN0QNCg0KQmVzdCBSZWdh
cmRzLA0KSm9ha2ltIFpoYW5nDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4g
ICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgIHwNCj4gRW1iZWRk
ZWQgTGludXggICAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSAg
fA0KPiBWZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICB8IFBob25lOiArNDktMjMxLTI4
MjYtOTI0ICAgICB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAg
ICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCg0K
