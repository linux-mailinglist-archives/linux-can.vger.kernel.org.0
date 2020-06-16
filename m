Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8D51FAD13
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2020 11:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgFPJvF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Jun 2020 05:51:05 -0400
Received: from mail-db8eur05on2137.outbound.protection.outlook.com ([40.107.20.137]:33217
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbgFPJvE (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 16 Jun 2020 05:51:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyC6JsoLzW5vbmnAh62ffFNfKuQdT3cjp1BD/mY/IaVxA4zrlMZ/mKyWLSwka5ayVxy7RozXnoohRdws7bZW7tmfS314SyDWXWLX4l26Zts6OcCfU5fWhtQT7pKanOK09AeSxdw0UQnw+zl6ji8uXiJfnkJyqON7cZby2ECjrASXeTfZIP8VG3eg/Ae+4drv/ZSlo4AmMOa4rBWhreRsn/MzMfinbQje6+8dOztrGivgEpf3lV1ohsgHd71xsS7zBlD584jhCQYYK2VcPlPxN0vsTMO+IyhbwEmgGJ3VZwtkap5ukFuesQKXWyW88rMkDPgb8Yr/3gmofC7ZZu0m6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz9kN4o8P8e/2mjcG4xQ5wgssh2jUvqdU3629yMUGZM=;
 b=PmjMUcLXTwEVRi8gzQjrocMToqzM45a+vhpuEO0XJW8VpV72N1c5XN22DIvR8U4pBcg/W1qF2Ivd/EJhYrEjxOAtfOCivgRU8yGHjZFZE9Aa0cWSH5LH92KmnGTwtdrl5weVrZVOne0lzAvWUunJDFZ1AqxflKiCYG0tSDNNLZCIqDRmKbU9m0hTj1y46Vg/4j2vZC54ZsFNPtHTIgXvbZqSDCcn5kPjw3ezoDZiUkhZaZNW+wxeAUyvCJ2HwHqQGmpiJFDksnuHUmEd9I1La/dDj3rEufFWiEjT8Tpm3k7IU0l7HxGedNmPV/b+jrdfOkTT+22B/65S2HRN4S2Ktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sma.de; dmarc=pass action=none header.from=sma.de; dkim=pass
 header.d=sma.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sma.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz9kN4o8P8e/2mjcG4xQ5wgssh2jUvqdU3629yMUGZM=;
 b=v4tmPpOKCdS9137oWp4uZuktLl3emJJo2RbIwwhR4Njga30WqmFbNrmXIv1AgRHAcErpSDIdw1UxTZrZF6aOWJRafoYjgDyFsGAeiFs49jjd8hkHIkQsghoccX4InrnLaK+B3knSSNVn1Zqb/mBainRlHGxritd2QwsozmLgXYg=
Received: from AM0PR04MB6273.eurprd04.prod.outlook.com (2603:10a6:208:137::18)
 by AM0PR04MB6594.eurprd04.prod.outlook.com (2603:10a6:208:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.26; Tue, 16 Jun
 2020 09:51:00 +0000
Received: from AM0PR04MB6273.eurprd04.prod.outlook.com
 ([fe80::d016:2e70:4030:4fdc]) by AM0PR04MB6273.eurprd04.prod.outlook.com
 ([fe80::d016:2e70:4030:4fdc%6]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 09:51:00 +0000
From:   Felix Riemann <Felix.Riemann@sma.de>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Andre Kalb <Andre.Kalb@sma.de>
Subject: RE: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Thread-Topic: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Thread-Index: AQHWA1tqGNdHGBlIIU2zdPpKElX6gKha4XMAgAAHV9CAAFzIgIAA8mwAgASDhoCAAKhIwIAumyKAgAAFPQCAQe+IcIADFsMAgAAI+4CABPAU0IAAScCAgAEysQA=
Date:   Tue, 16 Jun 2020 09:51:00 +0000
Message-ID: <AM0PR04MB62734DA80CB35517656041FE889D0@AM0PR04MB6273.eurprd04.prod.outlook.com>
References: <20200326193837.GF760@x1.vandijck-laurijssen.be>
 <AM0PR04MB542742337A89900E12A8732288CC0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200330070203.GE22500@x1.vandijck-laurijssen.be>
 <AM0PR04MB54271EA5CC205263750BDBD288CB0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200429084733.GA27733@x1.vandijck-laurijssen.be>
 <20200429090618.GB27733@x1.vandijck-laurijssen.be>
 <AM0PR04MB6273640802E04C4009CE5BC588830@AM0PR04MB6273.eurprd04.prod.outlook.com>
 <20200612071044.GA25294@x1.vandijck-laurijssen.be>
 <20200612074253.GB25294@x1.vandijck-laurijssen.be>
 <AM0PR04MB62731627E4FC7368DB5051D4889C0@AM0PR04MB6273.eurprd04.prod.outlook.com>
 <20200615153109.GB28894@x1.vandijck-laurijssen.be>
In-Reply-To: <20200615153109.GB28894@x1.vandijck-laurijssen.be>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vandijck-laurijssen.be; dkim=none (message not signed)
 header.d=none;vandijck-laurijssen.be; dmarc=none action=none
 header.from=sma.de;
x-originating-ip: [93.209.172.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 983e572d-7735-4516-d6f4-08d811dac665
x-ms-traffictypediagnostic: AM0PR04MB6594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB65946BDD77CF7CD4E61A492F889D0@AM0PR04MB6594.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tlv1jqArm9JuW2iRmSaCaMvti82nXwVOBIVQTT+abBKKzN6Yf8qSl2c3+XHWighagHgfvlgIXh1p189nlFHHEc5joNT2b8K9MZ5/uCQQSupeR4f+jS/oMpJ3qNIL3jt/V81R3n6orufYY6y+0rdqZjqI8e7OWxdOyK4ggxjo4dIEPsai7pPFidDPbV01oyFKGS/IeXlRRM28XZmwr6yAY55cjCWw8O4L/QQ2Pw7f65TZmN4NNYLnBuC9yNg7JGDIb+A4UnqQYqhdXZwa/9KD2ubhqbnvzHOqMwHeNU5Pw5C+UX1mgIJpiRZdlGMaUoi8GUdmY0dKTt1z82qhUYS2TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(52536014)(186003)(26005)(8936002)(55016002)(7696005)(5660300002)(86362001)(9686003)(316002)(2906002)(54906003)(33656002)(8676002)(478600001)(6506007)(71200400001)(4326008)(6916009)(66946007)(64756008)(66476007)(66446008)(83380400001)(53546011)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: W0gMcqaxNBxrG9Jtzl5brRlDYM+rChHHagTufcRfCyJ+dLFztUX2/UrNhoZiaCgJoUEuH/qrA1LroTZZ9GIHWYdO52vgD/ddhp9ZTJjJAV6+r/2ieKdTlRr1Q842fEEcOsY/3kLpeXTvICASJaaeq3R5yX7MjEoUHXaZLenMYZW6Mq6WhBpuO47OJjoe8klgqPabUsAURJIOhEKUV5quQEd1qvVgARQ9R+jZD04xZSXleHtG+Ut/jmzkzUcf9QiTbORXHCfyu5NzLnoQIEAu6oPnAw0iVzMeCSqmrYhTKADSdE5XNxpc/35WTX56fvBmy+ko1z9MxttpyOAlefCXZvbvUVrNwLOUQqpH57HJXV6AgBV7nou3FW8ZLX/MpBVrVxh3Sjnz53s2jcwDzIuJHeyvnDqJHIN1YCNpnLray35rtMhMkrafLBxR61Oqa4qt4kTzxlnxSiI0c3fakvDv4vT8LNNB7DSuzwbvWEtFhUJpvBy2Y4hWWgW/gjIM+z9E
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sma.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 983e572d-7735-4516-d6f4-08d811dac665
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 09:51:00.1321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aI79P0ZsqFB9vixaJd9LPkqfhjBMWrss8ZdtDGs9MDQQyD4hG9MRaODFEoUmLULP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6594
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgS3VydCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdXJ0IFZh
biBEaWpjayA8ZGV2Lmt1cnRAdmFuZGlqY2stbGF1cmlqc3Nlbi5iZT4NCj4gU2VudDogTW9uZGF5
LCBKdW5lIDE1LCAyMDIwIDU6MzEgUE0NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2FuOiBjX2Nh
bjogSGFuZGxlIGxvc3QgYnVzLW9mZiBpbnRlcnJ1cHQgd2hpbGUgSVJRcyBhcmUNCj4gZGlzYWJs
ZWQNCj4NCj4gT24gbWEsIDE1IGp1biAyMDIwIDExOjExOjE3ICswMDAwLCBGZWxpeCBSaWVtYW5u
IHdyb3RlOg0KPiA+DQo+ID4gSGkgS3VydCwNCj4gPg0KPiA+IHNlZSBiZWxvdy4NCj4gPg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+DQo+ID4gPiBIaSBGZWxpeCwNCj4g
PiA+DQo+ID4gPiBOZXh0IHF1ZXN0aW9uIGNvbWVzIHVwLg0KPiA+ID4gU2VlIGlubGluZS4NCj4g
PiA+DQo+ID4gPiBPbiB2ciwgMTIganVuIDIwMjAgMDk6MTA6NDQgKzAyMDAsIEt1cnQgVmFuIERp
amNrIHdyb3RlOg0KPiA+ID4gPiBUaGFua3MgZm9yIHZlcmlmeWluZywNCj4gPiA+ID4NCj4gPiA+
ID4gSSdsbCB0YWtlIGEgbG9vayBob3cgdGhhdCBjYW4gaGFwcGVuLg0KPiA+ID4gPg0KPiA+ID4g
PiBJIHRoaW5rIHBhY2tldCBsb3NzIGlzIGJldHRlciAobGVzcyBwYWNrZXRzIGxvc3QpIHRoYW4g
YmVmb3JlLg0KPiA+ID4gPg0KPiA+ID4gPiBLdXJ0DQo+ID4gPiA+DQo+ID4gPiA+IE9uIHdvLCAx
MCBqdW4gMjAyMCAwODowODoyOCArMDAwMCwgRmVsaXggUmllbWFubiB3cm90ZToNCj4gPiA+ID4g
PiBIaSBLdXJ0LA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEkgaGF2ZSB0aGUgaW1wcmVzc2lvbiB0aGF0
IHRoZSByZWN2IHBhdGggaXMgY292ZXJlZCwgYXQgbGVhc3QNCj4gPiA+ID4gPiA+IHRoZSBudWxs
IHB0ciB3b3VsZCBoYXZlIGNhdXNlZCBpc3N1ZWQgZWFybGllciBhbHJlYWR5Lg0KPiA+ID4gPiA+
ID4gV291bGQgdGhlIHByb2JsZW0gYXJpc2UgaW4gY19jYW5fZG9fdHggZmV0Y2hpbmcgYSBOVUxM
IGVjaG9fc2tiPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSXQgcmVhbGx5IGxvb2tzIGxpa2UgaXQu
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBZGRpbmcgYSBCVUdfT04gdG8gdGhlIGxvb3AgaW4gY19j
YW5fZG9fdHggdHJpZ2dlcnMgd2l0aCBhIE5VTEwNCj4gPiA+ID4gPiBza2INCj4gPiA+IHJldHVy
bmVkIGJ5IF9fY2FuX2dldF9lY2hvX3NrYigpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRm9yIHRl
c3RpbmcgSSByZXBsYWNlZCB0aGUgQlVHX09OIHdpdGggYSBjaGVjayB0aGF0IHNraXBzIHRoZQ0K
PiA+ID4gPiA+IHNrYiBpZiB0aGF0DQo+ID4gPiBoYXBwZW5zIChub3Qgc3VyZSBpZiB0aGF0IHdv
dWxkIGJlIGEgdmFsaWQgZml4IGluIHRoYXQgcGxhY2UpOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
d2hpbGUgKChvYmogPSBjX2Nhbl9mZnM2NChwZW5kKSkpIHsgcGVuZCAmPSB+KCh1NjQpMSA8PCAo
b2JqIC0NCj4gPiA+ID4gPiAxKSk7IGNfY2FuX2ludmFsX3R4X29iamVjdChkZXYsIElGX1JYLCBv
YmopOyBpZHggPSBvYmogLQ0KPiA+ID4gPiA+IHByaXYtPm9iai5zZW5kX2Zyc3Q7IHNrYiA9IF9f
Y2FuX2dldF9lY2hvX3NrYihkZXYsIGlkeCwgJmxlbik7DQo+ID4gPiA+ID4gaWYoIXNrYikNCj4g
PiA+DQo+ID4gPiBJdCB3b3VsZCBiZSBpbnRlcmVzdGluZyB0byBrbm93IGlkeCBhbmQgcHJpdi0+
dHhfYWN0aXZlIGhlcmUuDQo+ID4NCj4gPiBUaGF0J3MgdGhlIHN0YXRpc3RpYyBvdmVyIGFib3V0
IDE2MDAgbGluZXMgSSBjYXB0dXJlZC4gRmlyc3QgbnVtYmVyIGlzIG51bWJlcg0KPiBvZiBvY2N1
cnJlbmNlczoNCj4NCj4ganVzdCBkb3VibGUtY2hlY2s6DQo+IFRoZXNlIGFyZSBhbGwgd2hlbiBf
X2Nhbl9nZXRfZWNob19za2IgcmV0dXJuZWQgTlVMTD8NCg0KWWVzLCB0aGF0J3MgY29ycmVjdC4g
VGhlIHByaW50b3V0IG9jY3VycyBkaXJlY3RseSBiZWZvcmUgaXQgc2tpcHMgdG8gdGhlIG5leHQg
aXRlbSBpbiB0aGUgbG9vcC4NCg0KRmVsaXgNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KDQpTTUEgU29sYXIgVGVjaG5vbG9neSBBRw0KQXVmc2lj
aHRzcmF0OiBVd2UgS2xlaW5rYXVmIChWb3JzaXR6ZW5kZXIpDQpWb3JzdGFuZDogVWxyaWNoIEhh
ZGRpbmcsIERyLi1JbmcuIEp1ZXJnZW4gUmVpbmVydA0KSGFuZGVsc3JlZ2lzdGVyOiBBbXRzZ2Vy
aWNodCBLYXNzZWwgSFJCIDM5NzINClNpdHogZGVyIEdlc2VsbHNjaGFmdDogMzQyNjYgTmllc3Rl
dGFsDQpVU3QtSUQtTnIuIERFIDExMyAwOCA1OSA1NA0KV0VFRS1SZWcuLU5yLiBERSA5NTg4MTE1
MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo=
