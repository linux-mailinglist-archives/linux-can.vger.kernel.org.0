Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5CF8EC7
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 12:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKLLmY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 06:42:24 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:46145
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfKLLmY (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 12 Nov 2019 06:42:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjpeGewiAXyJpcWPEnwdj3WuOENdRa5tnUFqOYZFo71Q6bsHfyv7veczKkLCKylfEgaUz5BU5xfryCcq6Essj0UD0b1A+c//wI0VEuhmcJjV1LpU4SItLp2pLFA0DYo5fH6ra2+R0EX9CqNR4JyDG0nSEuDwidYbWlgWuZNZASxkahzk+9qFXrvO+p7ALd9bgYIaAtSIBXyDwSxXL9GuHyhW44TJdxheZcDLW6VVfLoAL2sjXTzmVD6SDLDlRExRSgdWTo5ZEoKugxInxOKncaHOaHbtWC4VfLgG/H1Oz1kDgq9sB3tEEf8+ScltfbZshuGTqrZ9IhLlTJ34vPQa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJxFYy/KlcktTVPTQoDBjaahLieh6IHu5TxW3trc7Ew=;
 b=XwVcE6MVEd+c2gGZFtjAL5iqr4j4Lp9JeYKypRSlc1x4VKGM2ixBPVo4HkbKByEdVnGzSW2WSNG2wA86fIReQrfSeQj0YLhcsnK7Ww+yc8rxo3zpZ2TfTO18jBqj6RPWS9K12Y+DFWLPQmoNabNSbZFiLAJ26i6/dtLMp9I6RiL6hixij81q8MvgcEOLNRMGWsnmz+PrvLDkfhj35hHFLtDfrn32mD97XIQZgvsI2d3+WoX7cpTl0rC5CSxL+zz1eI8aYs3ysIeGBZavLzkltJpTxyznmYvfQlhEw3HC2gW8p2JPb6amhQtijknbV/jZSo5bm/kuswE9aMcg1F5x0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJxFYy/KlcktTVPTQoDBjaahLieh6IHu5TxW3trc7Ew=;
 b=DoIqANqDaOSlWhrbTimEXeTXO34HtIdusu0yA9b/70fL8kqojT93bHGBx5Ghn1gzzlojpUFMRds9iimBXAQkOQPM/fRuDDPiDj9bGDH9PYxHS8C9MXErZ/MntGQKQjDGcC1ndPJVf8o9ATqf48CEtJXvdt97nW5aX8apqSDAsQc=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB5065.eurprd04.prod.outlook.com (20.176.234.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 11:42:20 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 11:42:20 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Topic: Wake up issue about Flexcan driver in v5.4 kernel
Thread-Index: AdWYdOEh/tYWI8MXSASMqe9cVeZH0AAAx0KAACvRiZAAA1AVAAAAc9fQAACXyQAAAWdfoAACB6aAAAAdeDAAAY+JAAAAPH+g
Date:   Tue, 12 Nov 2019 11:42:19 +0000
Message-ID: <DB7PR04MB461841958EA118B1C717E2C9E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
 <DB7PR04MB4618061107733A9D53F75FA3E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <a232c1f6-cd91-8526-6fc9-163e9500bdf9@pengutronix.de>
 <DB7PR04MB4618BCC08EE8A9BDDA208C2AE6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <65288408-c12b-8a5f-9b56-132f0f4b3057@pengutronix.de>
 <DB7PR04MB4618C4D57D79DF5CE1CE5FBBE6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <ea3765aa-25ab-fe12-3c95-8444a75641dc@pengutronix.de>
 <DB7PR04MB4618888D202DAC80E6CC1BE6E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <80526cf4-b4f3-c559-ef70-a5dc8629406e@pengutronix.de>
In-Reply-To: <80526cf4-b4f3-c559-ef70-a5dc8629406e@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06322e2a-45a2-4696-c2dc-08d76765604c
x-ms-traffictypediagnostic: DB7PR04MB5065:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB5065C49D58EA8601D2C5AE9FE6770@DB7PR04MB5065.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(13464003)(189003)(199004)(7696005)(76176011)(53546011)(76116006)(26005)(476003)(25786009)(486006)(14454004)(74316002)(305945005)(71200400001)(86362001)(71190400001)(5660300002)(66946007)(6436002)(6246003)(99286004)(9686003)(64756008)(14444005)(256004)(66446008)(55016002)(66476007)(561944003)(11346002)(446003)(66066001)(229853002)(66556008)(6506007)(6306002)(102836004)(110136005)(3846002)(6116002)(186003)(81156014)(8676002)(81166006)(8936002)(2501003)(478600001)(316002)(7736002)(966005)(52536014)(2201001)(33656002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5065;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jwIxACvs6wi7cMynf+R2jqUbkKbgq4pW9RxEmDInCPgI186nznMlaiWaeOsYf7ZDg1lutEeQNU2+pjpeR+mPQKb0B/tMy9Annl/P5Ns/Lm3wH3HpUH+AtOUZOHWCfsH3Mvh3FNcVhm5mjNw1MEl2MIPi0enk6TgyYuUTcTBy2u0rnwNF8LFpoer33P/yeKqLaXprqFC63rSgucfjLcPhBeGQkKAeLM2VQfEqEpZvUcS31tOVQ22Oy4K/2r7gcwR0WJv1EKxNTBLGAuC6LGJF7FDO5XEY1LeMLYIOZkfvdltiE1LA92N45GSKT4+u2WqZB9Q57qAo+i4r7KOK6ntCWc2eYxuCMaOkhj2IkqwwfnuBiQp2j5K0/uZRekIzLFvi0qFxbWvwEsbpNcOIlBNCVxXc3YyyNy1rvQxq5J5BCR8+YdfVKaySQM5sK0kfzZ6j+1u5cSpJ1DHGSS8sYANrZ+mSkgWp5hJfSpVz2BIMBUM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06322e2a-45a2-4696-c2dc-08d76765604c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 11:42:19.9856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kqULv5Rn+ilmKfjfYy2LslB4LsyGjj6wLAOzmsjXGWEbgyli3JbDIrxhsC/Su+tgo1QEIAdH8vx2YLoCQgsmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5065
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQxMeaciDEy5pelIDE5OjM0DQo+
IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgc2VhbkBnZWFuaXgu
Y29tOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBXYWtlIHVw
IGlzc3VlIGFib3V0IEZsZXhjYW4gZHJpdmVyIGluIHY1LjQga2VybmVsDQo+IA0KPiBPbiAxMS8x
Mi8xOSAxMjowMiBQTSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+PiBJIHN1Z2dlc3QgdG8gc2V0
IGEgZmxhZyBpbiB0aGUgc3VzcGVuZCBoYW5kbGVyIGFuZCBldmFsdWF0ZSB0aGUgZmxhZw0KPiA+
PiBpbiB0aGUgaW50ZXJydXB0IGhhbmRsZXIuIElmIHRoZSBmbGFnIGlzIHNldCwgd2UgaGF2ZSB0
byBpZ25vcmUgdGhlIHRpbWVzdGFtcC4NCj4gPg0KPiA+IE5vdCBxdWl0ZSB1bmRlcnN0YW5kLCBj
b3VsZCB5b3UgZXhwbGFpbiBtb3JlPyBUaGFua3Mg8J+YiQ0KPiANCj4gV2l0aCBhIHdha2V1cCB0
byBJUlEgbGF0ZW5jeSBoaWdoZXIgdGhhbiB0aGUgdGltZSBzdGFtcCBjb3VudGVyIG92ZXJmbG93
DQo+IHRpbWUgd2UgY2Fubm90IHJlbHkgb24gdGhlIHRpbWVzdGFtcHMgb2YgdGhlIENBTiBmcmFt
ZXMgaW4gdGhlIGZpcnN0IElSUQ0KPiBoYW5kbGVyIHJ1biBhZnRlciB3YWtldXAuDQo+IA0KPiBN
eSBwcm9wb3NhbCBpcyB0byBzZXQgYSBmbGFnIGluIHRoZSBzdXNwZW5kIGhhbmRsZXIsIGUuZy4N
Cj4gcHJpdi0+aWdub3JlX3RpbWVzdGFtcCA9IHRydWU7DQo+IA0KPiBGb3Igbm93IG1ha2UgYSBj
b3B5IG9mDQo+ICAgICBjYW5fcnhfb2ZmbG9hZF9pcnFfb2ZmbG9hZF90aW1lc3RhbXAoKQ0KPiBj
YWxsIGl0DQo+ICAgICBjYW5fcnhfb2ZmbG9hZF9pcnFfb2ZmbG9hZF9pZ25vcmVfdGltZXN0YW1w
KCkNCj4gcmVwbGFjZQ0KPiAgICAgX19za2JfcXVldWVfYWRkX3NvcnQoJnNrYl9xdWV1ZSwgc2ti
LCBjYW5fcnhfb2ZmbG9hZF9jb21wYXJlKTsgYnkNCj4gICAgIHNrYl9xdWV1ZV90YWlsKCZvZmZs
b2FkLT5za2JfcXVldWUsIHNrYik7DQo+IA0KPiBJbiB0aGUgSVJRIGhhbmRsZXIsIGNoZWNrIGlm
IHRoZSBmbGFnIGlzIHNldCwgY2FsbA0KPiAgICAgY2FuX3J4X29mZmxvYWRfaXJxX29mZmxvYWRf
aWdub3JlX3RpbWVzdGFtcCgpDQo+IGFuZCB1bnNldCB0aGUgZmxhZy4NCj4gDQo+IENoZWNrIGlm
IHRoYXQgaGVscHMuDQoNCkdyZWF0ISBJIHdpbGwgdHJ5IHRvIGltcGxlbWVudCBpdCEgVGhhbmtz
IGZvciB5b3VyIGVmZm9ydCENCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+IE1hcmMN
Cj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVp
bmUtQnVkZGUgICAgICAgICAgIHwNCj4gRW1iZWRkZWQgTGludXggICAgICAgICAgICAgICAgICAg
fCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSAgfA0KPiBWZXJ0cmV0dW5nIFdlc3QvRG9ydG11
bmQgICAgICAgICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0ICAgICB8DQo+IEFtdHNnZXJpY2h0
IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCg0K
