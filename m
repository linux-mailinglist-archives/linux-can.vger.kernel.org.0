Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4946CE6F0E
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2019 10:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbfJ1J2j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Oct 2019 05:28:39 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:53742
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731120AbfJ1J2j (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 28 Oct 2019 05:28:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6ivNWSlzfYi/Q3h7A7FbABNoqpIjfyPJP2ja40ZsRBjzuh6qypfC5DVXx7uXOKl/Hsisyb7uNR2lRx97/FdR5gj5nPRSaCN2r1EicbEoGsb5LwB887hN4CgD9r+ox0V4H9sJXXSTvVX8dlseYaAfy2KZ+k4krywQxXaQ427H2ds4pIgpgqyh8lPsk3NulBWWItuck3fVC3FMx6GSgwOFiPLQMf7Jq+bQ37R6jTiP9Jgobf9SCKdVNph1lwjPCdeowHO8dlBc7Qe3sWJF66K2Km30EiZK5/nb9mkGMCcIMifHzkAPAVTiYMT5ThuH3gTCDRORiMI3SVov8gbhW6Zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg12950Up6DrkzpZ3NqArhBhTuXNqVsLWzPifBFzK6k=;
 b=ea/rZ+o+5JP+A2B/a2apFq+Vg7+yL+WOVO83N3DIfAIgoKU9ppmr09oCKk7lFcOg4Y48K5+nGPeblv4DE3vwhiEgRAZ1Ye5dKrq/yFKkzGkhMPcZqrwwN606THeePMN30w3XOVqzmzXiXap1lH6XnX4Lnz5jPBlzX2fNueRix7jNusGuUMwZLpVQcHzOv0IRaXic3tAH8YGf6ESNFmpuBLXSWHp69ypGTmfSiMDip7SCD4+Lz/QruzQq5MekePD/GKAN004jXbTIghRIIiXY975k+bolC+bAS1tJlAAVJDyJbelc1KQdbd3LtBYRwuCdWcq07R3HRO6piY9WgwXumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg12950Up6DrkzpZ3NqArhBhTuXNqVsLWzPifBFzK6k=;
 b=vIq6TXqFU0DinKvuOYcCpOFxxFgcCwor4vRI7VidJhWJ4JItLFKU3MgUDee1XjF4v7f0s6sjnBeYo0b283Pcnf1nALIDM4AiRiV3iCenY8i1vLdiiro0U7MXx/goy3d9qrTZbQwmsI/p8zgpnThdY+dkkoLbfPzGsvrSBs5xkkQ=
Received: from AM6PR03MB4006.eurprd03.prod.outlook.com (20.177.37.97) by
 AM6PR03MB3702.eurprd03.prod.outlook.com (52.134.113.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Mon, 28 Oct 2019 09:28:32 +0000
Received: from AM6PR03MB4006.eurprd03.prod.outlook.com
 ([fe80::e93e:a46a:3c6a:c0f7]) by AM6PR03MB4006.eurprd03.prod.outlook.com
 ([fe80::e93e:a46a:3c6a:c0f7%7]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 09:28:31 +0000
From:   =?utf-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 2/2] can/peak_usb/pcan_usb: add support of rxerr/txerr
 counters
Thread-Topic: [PATCH 2/2] can/peak_usb/pcan_usb: add support of rxerr/txerr
 counters
Thread-Index: AQHVfbPIskM4lsaY10OX0UftlC6fNqdQjXSAgAsbXvCAFDQnkA==
Date:   Mon, 28 Oct 2019 09:28:31 +0000
Message-ID: <AM6PR03MB4006023FEAB2803B17D258C2D6660@AM6PR03MB4006.eurprd03.prod.outlook.com>
References: <20191008083545.4569-1-s.grosjean@peak-system.com>
 <20191008083545.4569-3-s.grosjean@peak-system.com>
 <4416597c-6db7-057d-36b5-dc4b2c15117f@pengutronix.de>
 <AM6PR03MB4006315428304DA4419935E4D6930@AM6PR03MB4006.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB4006315428304DA4419935E4D6930@AM6PR03MB4006.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=s.grosjean@peak-system.com; 
x-originating-ip: [185.109.201.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef1d656a-320a-4550-e359-08d75b8932e6
x-ms-traffictypediagnostic: AM6PR03MB3702:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <AM6PR03MB3702D0DE2693402E2986F482D6660@AM6PR03MB3702.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(366004)(346002)(396003)(376002)(39840400004)(13464003)(199004)(189003)(86362001)(85202003)(76176011)(66476007)(66946007)(6506007)(66556008)(64756008)(66446008)(102836004)(76116006)(53546011)(3846002)(316002)(186003)(508600001)(52536014)(85182001)(15974865002)(6116002)(6246003)(4326008)(26005)(14454004)(7696005)(66574012)(486006)(7736002)(5660300002)(6436002)(55016002)(74316002)(9686003)(66066001)(6306002)(8936002)(229853002)(33656002)(2906002)(8676002)(81166006)(81156014)(446003)(11346002)(99286004)(966005)(476003)(71200400001)(256004)(305945005)(71190400001)(25786009)(6916009)(14444005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB3702;H:AM6PR03MB4006.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: peak-system.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QD4mO+U9sK6YDAzo20HN+pFciAhVUeeG6JxMWq1qlI+jN7qQH5yrj9+MzQHuUStYPbKBVKJIqRfEw+xiKcZJEOVVrrcpNQ74Y3JwbWPJqQP8jlaCEgrikcN+wgEhwoJks6F5ZXS26Sj+TzubxT3PWG0RsgxWztYYKd+NeZm/L/ATCzZAezhnWz9fiJ7HVc/xdPoGYVYDLRlaHcPTHVp2fRVoz5b1YyT/2DN54kczM9Nx2dgi1PQ1LpCollvmZX7vpgTt4MlrfpF0kSL1Ez3PpYzZRGJ8Ic4UNRJ1IRUiBT9zi+ZfxHHAtNIvPvgsuMn3SksxPU8+x4PSbXkSdeNGToFd4KqbZlaw4Ij0OfqeDg+pHeuYd/Ndinl2osUG5y3sWhXG76PzoOMv8T71SVk4y08Y4D/GIZdwM7oo0llgiBmwoUHprHj9tjipZi14p6UwrGsH0fI3mel6GytVhqTDtgDlrNy5qGJxJt9ba5Grzow=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1d656a-320a-4550-e359-08d75b8932e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 09:28:31.7084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWOd/NAux9QQYtrMbXq4JPONO246VGzmVtyssStu8yiSCSvANddEPg9fta2pURU3T3Y+DcWS89HtcKRvdZEGMZGDnVyiYK45DMqqGPxbK+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3702
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gTWFyYywNCg0KQ2FuIHlvdSBhbnN3ZXIgdG8gbXkgcXVlc3Rpb24gYmVsb3cgc28gdGhh
dCB3ZSB3aWxsIGJlIGFibGUgdG8gaW5jbHVkZSB0aGUgYmVyciBzdXBwb3J0IHdpdGggdGhlIFBD
QU4tVVNCIHBsZWFzZT8NCg0KVGhhbmtzIGFuZCByZWdhcmRzLA0KDQrigJQgU3TDqXBoYW5lDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtY2FuLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtY2FuLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJl
aGFsZiBPZiBTdMOpcGhhbmUgR3Jvc2plYW4NCj4gU2VudDogbWFyZGkgMTUgb2N0b2JyZSAyMDE5
IDE0OjIxDQo+IFRvOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBD
YzogbGludXgtY2FuIE1haWxpbmcgTGlzdCA8bGludXgtY2FuQHZnZXIua2VybmVsLm9yZz4NCj4g
U3ViamVjdDogUkU6IFtQQVRDSCAyLzJdIGNhbi9wZWFrX3VzYi9wY2FuX3VzYjogYWRkIHN1cHBv
cnQgb2YgcnhlcnIvdHhlcnINCj4gY291bnRlcnMNCj4NCj4gSGVsbG8gTWFyYywNCj4NCj4gU2Vl
IG15IGNvbW1lbnRzIGJlbG93Lg0KPg0KPiBUaGFuayB5b3UsDQo+DQo+IOKAlCBTdMOpcGhhbmUN
Cj4NCj4gPiA+ICAvKg0KPiA+ID4gICAqIHN0YXJ0IGludGVyZmFjZQ0KPiA+ID4gICAqLw0KPiA+
ID4gIHN0YXRpYyBpbnQgcGNhbl91c2Jfc3RhcnQoc3RydWN0IHBlYWtfdXNiX2RldmljZSAqZGV2
KSAgeyAgc3RydWN0DQo+ID4gPiBwY2FuX3VzYiAqcGRldiA9IGNvbnRhaW5lcl9vZihkZXYsIHN0
cnVjdCBwY2FuX3VzYiwgZGV2KTsNCj4gPiA+ICtpbnQgZXJyOw0KPiA+ID4NCj4gPiA+ICAvKiBu
dW1iZXIgb2YgYml0cyB1c2VkIGluIHRpbWVzdGFtcHMgcmVhZCBmcm9tIGFkYXB0ZXIgc3RydWN0
ICovDQo+ID4gPiBwZWFrX3VzYl9pbml0X3RpbWVfcmVmKCZwZGV2LT50aW1lX3JlZiwgJnBjYW5f
dXNiKTsNCj4gPiA+DQo+ID4gPiArcGRldi0+YmVjLnJ4ZXJyID0gMDsNCj4gPiA+ICtwZGV2LT5i
ZWMudHhlcnIgPSAwOw0KPiA+ID4gKw0KPiA+ID4gKy8qIGJlIG5vdGlmaWVkIG9uIGFueSBlcnJv
ciBjb3VudGVyIGNoYW5nZSAqLw0KPiA+DQo+ID4gRG9lcyB0aGUgZGV2aWNlIG9mZmVyIHRoZSBw
b3NzaWJpbGl0eSB0byByZWFkIHRoZSBlcnJvciBjb3VudGVycz8gSWYNCj4gPiBzbyBwbGVhc2Ug
ZG8gaXQgaW4gcGNhbl91c2JfZ2V0X2JlcnJfY291bnRlcigpLg0KPiA+DQo+DQo+IE5vcGUhIFRo
ZSB2YWx1ZSBvZiB0aGUgZXJyb3IgY291bnRlcnMgY2FuIG9ubHkgYmUgb2J0YWluZWQgdGhyb3Vn
aCB0aGUNCj4gYmVsb3cgImJ1cyBlcnJvciIgbm90aWZpY2F0aW9uIG1lY2hhbmlzbToNCj4NCj4g
PiA+ICtlcnIgPSBwY2FuX3VzYl9zZXRfZXJyX2ZyYW1lKGRldiwgUENBTl9VU0JfRVJSX0VDQyB8
DQo+ID4gPiArICAgICBQQ0FOX1VTQl9FUlJfUlhFUlIgfA0KPiA+IFBDQU5fVVNCX0VSUl9UWEVS
UiB8DQo+ID4gPiArICAgICBQQ0FOX1VTQl9FUlJfUlhFUlJfQ05UIHwNCj4gPiA+ICsgICAgIFBD
QU5fVVNCX0VSUl9UWEVSUl9DTlQpOw0KPiA+DQo+ID4gQmV0dGVyIG9ubHkgZW5hYmxlIGJ1cyBl
cnJvcnMsIGlmIHRoZSB1c2VyIGhhcyByZXF1ZXN0ZWQgdGhlbS4gU2VlOg0KPiA+DQo+ID4NCj4g
PiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMv
bmV0L2Nhbi9zamExMDAwDQo+ID4gL3NqYTEwDQo+ID4gMDAuYyNMMTUyDQo+ID4NCj4NCj4gT2su
ICBCdXQgdGhpcyBhbHNvIG1lYW5zIHRoYXQgdGhlIHJ4L3R4IGVyciBjb3VudGVycyB3aWxsIGFs
d2F5cyBiZSAwIGlmIHVzZXINCj4gZGlkbid0IHJlcXVlc3QgImJlcnItcmVwb3J0aW5nIG9uIi4g
SXMgdGhpcyBvaz8NCj4NCj4gPiA+ICtpZiAoZXJyKQ0KPiA+ID4gK25ldGRldl93YXJuKGRldi0+
bmV0ZGV2LA0KPiA+ID4gKyAgICAiQ0FOIGJ1cyBlcnJvciBjb3VudGVycyBub3QgYXZhaWxhYmxl
IChlcnIgJXUpXG4iLA0KPiA+ID4gKyAgICBlcnIpOw0KPiA+ID4gKw0KPiA+ID4gIC8qIGlmIHJl
dmlzaW9uIGdyZWF0ZXIgdGhhbiAzLCBjYW4gcHV0IHNpbGVudCBtb2RlIG9uL29mZiAqLyAgaWYN
Cj4gPiA+IChkZXYtPmRldmljZV9yZXYgPiAzKSB7IC1pbnQgZXJyOw0KPiA+ID4gLQ0KPiA+ID4g
IGVyciA9IHBjYW5fdXNiX3NldF9zaWxlbnQoZGV2LA0KPiA+ID4gIGRldi0+Y2FuLmN0cmxtb2Rl
ICYNCj4gPiBDQU5fQ1RSTE1PREVfTElTVEVOT05MWSk7DQo+ID4gPiAgaWYgKGVycikNCj4gPiA+
IEBAIC05MDYsNCArMTA1MCw1IEBAIGNvbnN0IHN0cnVjdCBwZWFrX3VzYl9hZGFwdGVyIHBjYW5f
dXNiID0gew0KPiA+ID4gLmRldl9lbmNvZGVfbXNnID0gcGNhbl91c2JfZW5jb2RlX21zZywgIC5k
ZXZfc3RhcnQgPQ0KPiBwY2FuX3VzYl9zdGFydCwNCj4gPiA+IC5kZXZfcmVzdGFydF9hc3luYyA9
IHBjYW5fdXNiX3Jlc3RhcnRfYXN5bmMsDQo+ID4gPiArLmRvX2dldF9iZXJyX2NvdW50ZXIgPSBw
Y2FuX3VzYl9nZXRfYmVycl9jb3VudGVyLA0KPiA+ID4gIH07DQo+ID4gPg0KPiA+DQo+ID4gTWFy
Yw0KPiA+DQo+ID4gLS0NCj4gPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgfCBN
YXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KPiA+IEluZHVzdHJpYWwgTGludXggU29sdXRp
b25zICAgICAgICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0ICAgICB8DQo+ID4gVmVydHJldHVu
ZyBXZXN0L0RvcnRtdW5kICAgICAgICAgIHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy01NTU1IHwN
Cj4gPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgfCBodHRwOi8vd3d3LnBlbmd1
dHJvbml4LmRlICAgfA0KPg0KPg0KPiAtLQ0KPiBQRUFLLVN5c3RlbSBUZWNobmlrIEdtYkgNCj4g
U2l0eiBkZXIgR2VzZWxsc2NoYWZ0IERhcm1zdGFkdCAtIEhSQiA5MTgzDQo+IEdlc2NoYWVmdHNm
dWVocnVuZzogQWxleGFuZGVyIEdhY2ggLyBVd2UgV2lsaGVsbSBVbnNlcmUNCj4gRGF0ZW5zY2h1
dHplcmtsYWVydW5nIG1pdCB3aWNodGlnZW4gSGlud2Vpc2VuIHp1ciBCZWhhbmRsdW5nDQo+IHBl
cnNvbmVuYmV6b2dlbmVyIERhdGVuIGZpbmRlbiBTaWUgdW50ZXIgd3d3LnBlYWstDQo+IHN5c3Rl
bS5jb20vRGF0ZW5zY2h1dHouNDgzLjAuaHRtbA0KPg0KPiAtLQ0KPiBQRUFLLVN5c3RlbSBUZWNo
bmlrIEdtYkgNCj4gU2l0eiBkZXIgR2VzZWxsc2NoYWZ0IERhcm1zdGFkdCAtIEhSQiA5MTgzDQo+
IEdlc2NoYWVmdHNmdWVocnVuZzogQWxleGFuZGVyIEdhY2ggLyBVd2UgV2lsaGVsbSBVbnNlcmUN
Cj4gRGF0ZW5zY2h1dHplcmtsYWVydW5nIG1pdCB3aWNodGlnZW4gSGlud2Vpc2VuIHp1ciBCZWhh
bmRsdW5nDQo+IHBlcnNvbmVuYmV6b2dlbmVyIERhdGVuIGZpbmRlbiBTaWUgdW50ZXIgd3d3LnBl
YWstDQo+IHN5c3RlbS5jb20vRGF0ZW5zY2h1dHouNDgzLjAuaHRtbA0KDQotLQ0KUEVBSy1TeXN0
ZW0gVGVjaG5payBHbWJIDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQgRGFybXN0YWR0IC0gSFJCIDkx
ODMNCkdlc2NoYWVmdHNmdWVocnVuZzogQWxleGFuZGVyIEdhY2ggLyBVd2UgV2lsaGVsbQ0KVW5z
ZXJlIERhdGVuc2NodXR6ZXJrbGFlcnVuZyBtaXQgd2ljaHRpZ2VuIEhpbndlaXNlbg0KenVyIEJl
aGFuZGx1bmcgcGVyc29uZW5iZXpvZ2VuZXIgRGF0ZW4gZmluZGVuIFNpZSB1bnRlcg0Kd3d3LnBl
YWstc3lzdGVtLmNvbS9EYXRlbnNjaHV0ei40ODMuMC5odG1sDQo=
