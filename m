Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06C7211A1
	for <lists+linux-can@lfdr.de>; Fri, 17 May 2019 03:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfEQBLF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 May 2019 21:11:05 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:39515
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfEQBLF (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 16 May 2019 21:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA4Qz20I4euCFke4UZxjN/44PDZkgrampi9GuipHPwc=;
 b=LeCmk9ho0d3BOugGIeB74t1/JlMpKdl3KRlyqJUlET9Ih5d0Pddw35q2mHBMJqyTxsYiKJ6lNXQhIVTFUVHHn5CEAp9Aoc89GS/yOR9in23I2Vv5X589MdPTZq6vw4qMgfk5f9LSsJPVHwHQXqYWmRWICy1g5TbEtSh6uywEWE4=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4682.eurprd04.prod.outlook.com (52.135.139.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Fri, 17 May 2019 01:11:00 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::bd02:a611:1f0:daac]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::bd02:a611:1f0:daac%6]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 01:11:00 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Documentation: can: flexcan: Add flexcan clocks'
 information
Thread-Topic: [PATCH v2 1/2] Documentation: can: flexcan: Add flexcan clocks'
 information
Thread-Index: AQHVC78dekBepVQkMECF4SeBYAzjF6ZugouA
Date:   Fri, 17 May 2019 01:11:00 +0000
Message-ID: <DB7PR04MB4618432A6FFDE8FDCC5DBAC3E60B0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190516133556.15872-1-pankaj.bansal@nxp.com>
 <20190516133556.15872-2-pankaj.bansal@nxp.com>
In-Reply-To: <20190516133556.15872-2-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97d246de-bd1e-4f29-1823-08d6da64869c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4682;
x-ms-traffictypediagnostic: DB7PR04MB4682:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB4682A10149299656653E112EE60B0@DB7PR04MB4682.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39860400002)(13464003)(189003)(199004)(52536014)(3846002)(86362001)(305945005)(25786009)(74316002)(33656002)(73956011)(7736002)(76116006)(66066001)(53936002)(14454004)(99286004)(8936002)(68736007)(64756008)(66556008)(4326008)(66946007)(66446008)(6116002)(966005)(81156014)(8676002)(81166006)(66476007)(6246003)(55016002)(45080400002)(478600001)(76176011)(7696005)(6436002)(26005)(71190400001)(186003)(53546011)(6506007)(11346002)(14444005)(102836004)(71200400001)(446003)(476003)(316002)(256004)(6306002)(110136005)(54906003)(9686003)(5660300002)(2906002)(486006)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4682;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0bwFhHfygbk35F2mi3cIhyjSHaUmqj+WW9bwdOx30KHyiE5lXQp1bpc0PH5QEa62PHug3tbOHX6+2Nai43PPgWsgF5mPQ6+4ph8pCJXM/GV6HbcoI46TaJWiwJq8+YHfsaxY7hnQzeNtyNrg40EHyS3BeAhT5mvmK5SOOorQ06EAywzh4GKRRZxA26xfwVKIoSNy2AAIb9FOLGXcf9lSE+BRpGInW4kmUWpCc5S1/FupKLh+Tbiv5/h3di2edMkEImA5+VW+yWfowh7bL0KCtyy5kc+JoVDtUkNQXY0WRhIow7BSo5B4fRwDs2u0M3VdoO8euE9Ip8X3SiB+gUrgNhdh86Svwls2iwbLiwQ8eOucx6LI2RR43L0Rb8XzA5taD4DtT6hxubYw1uCeK6Ng0MXEsqe9kzPaMBJUdpC1ALE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d246de-bd1e-4f29-1823-08d6da64869c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 01:11:00.8356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4682
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LWNhbi1vd25lckB2
Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWNhbi1vd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+IE9uIEJl
aGFsZiBPZiBQYW5rYWogQmFuc2FsDQo+IFNlbnQ6IDIwMTnlubQ15pyIMTbml6UgMTY6MTINCj4g
VG86IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2Vy
bmVsLm9yZz47IE1hcmsNCj4gUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBXb2xmZ2Fu
ZyBHcmFuZGVnZ2VyDQo+IDx3Z0BncmFuZGVnZ2VyLmNvbT47IE1hcmMgS2xlaW5lLUJ1ZGRlIDxt
a2xAcGVuZ3V0cm9uaXguZGU+DQo+IENjOiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMS8yXSBEb2N1bWVu
dGF0aW9uOiBjYW46IGZsZXhjYW46IEFkZCBmbGV4Y2FuIGNsb2NrcycNCj4gaW5mb3JtYXRpb24N
Cj4gDQo+IFRoZSBjbG9ja2luZyBpbmZvcm1hdGlvbiBpcyBtaXNzaW5nIGZyb20gZmxleGNhbiBk
ZXZpY2UgdHJlZSBiaW5kaW5ncy4NCj4gVGhpcyBpbmZvcm1hdGlvbiBpcyBuZWVkZWQgdG8gYmUg
YWJsZSB0byB1c2UgZmxleGNhbi4gRG9jdW1lbnQgdGhlIHNhbWUuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBQYW5rYWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54cC5jb20+DQo+IC0tLQ0KPiANCj4g
Tm90ZXM6DQo+ICAgICBEZXBlbmRlbmNpZXM6DQo+ICAgICAtDQo+IGh0dHBzOi8vZXVyMDEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2Vy
DQo+IG5lbC5vcmclMkZwYXRjaHdvcmslMkZjb3ZlciUyRjEwMjQ1MzYlMkYmYW1wO2RhdGE9MDIl
N0MwMSU3Q3FpYQ0KPiBuZ3FpbmcuemhhbmclNDBueHAuY29tJTdDNDI2MTc1ODNkMmMyNDI1MjFh
OGUwOGQ2ZDlkNjNlZTclN0M2OA0KPiA2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0Mw
JTdDMCU3QzYzNjkzNTkxMTUzNDQwNTE4MSZhDQo+IG1wO3NkYXRhPVVPQzdtSUhQc25aYksyNzQy
bVRqWWtMMyUyQm1DN0VxVVA0RTEyN1VNNWJXWSUzRCYNCj4gYW1wO3Jlc2VydmVkPTANCj4gDQo+
ICAgICBWMjoNCj4gICAgIC0gUmVtb3ZlZCBjbG9jay1mcmVxdWVuY3kgZnJvbSBvcHRpb25hbCBw
cm9wZXJ0aWVzDQo+ICAgICAtIEFkZGVkIERlcGVuZGVuY2llcyBpbiBOb3Rlcw0KPiANCj4gIC4u
Li9iaW5kaW5ncy9uZXQvY2FuL2ZzbC1mbGV4Y2FuLnR4dCAgICAgICAgIHwgNDYgKysrKysrKysr
KysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbmV0L2Nhbi9mc2wtZmxleGNhbi50eHQNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbmV0L2Nhbi9mc2wtZmxleGNhbi50eHQNCj4gaW5kZXggYTA0MTY4NjA1OTk4Li43
M2M2MTZjYTBmOWEgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9uZXQvY2FuL2ZzbC1mbGV4Y2FuLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9mc2wtZmxleGNhbi50eHQNCj4gQEAgLTEyLDkgKzEyLDQy
IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAtIHJlZyA6IE9mZnNldCBhbmQgbGVuZ3RoIG9m
IHRoZSByZWdpc3RlciBzZXQgZm9yIHRoaXMgZGV2aWNlDQo+ICAtIGludGVycnVwdHMgOiBJbnRl
cnJ1cHQgdHVwbGUgZm9yIHRoaXMgZGV2aWNlDQo+IA0KPiAtT3B0aW9uYWwgcHJvcGVydGllczoN
Cj4gK0Nsb2NraW5nIGluZm9ybWF0aW9uIGlzIG11c3QgZm9yIGZsZXhjYW4uIHBsZWFzZSByZWZl
ciBiZWxvdyBpbmZvIGZvcg0KPiArdW5kZXJzdGFuZGluZyBjbG9ja2luZyBpbiBmbGV4Y2FuOg0K
PiArDQo+ICvigKIgVGhlIEZMRVhDQU4gbW9kdWxlIGlzIGRpdmlkZWQgaW50byB0d28gYmxvY2tz
LiBDb250cm9sbGVyIGhvc3QNCj4gK2ludGVyZmFjZQ0KPiArICAoIkNISSIpIGFuZCBQcm90b2Nv
bCBFbmdpbmUgKCJQRSIpDQo+ICvigKIgQm90aCB0aGVzZSBibG9ja3MgcmVxdWlyZSBjbG9jay4N
Cj4gK+KAoiBDSEkgaXMgcmVzcG9uc2libGUgZm9yIHJlZ2lzdGVycyByZWFkIHdyaXRlIGluY2x1
ZGluZyBNQiByZWFkL3dyaXRlLg0KPiArICBXaGlsZSBQRSBpcyByZXNwb25zaWJsZSBmb3IgVHJh
bnNmZXIvcmVjZWl2ZSBkYXRhIG9uIENBTiBidXMuDQo+ICvigKIgVGhlIGNsb2NrcyBmZWVkaW5n
IHRvIHRoZXNlIHR3byBibG9ja3MgY2FuIGJlIHN5bmNocm9ub3VzIChpLmUuIHNhbWUNCj4gK2Ns
b2NrKQ0KPiArICBvciBhc3luY2hyb25vdXMgKGkuZS4gc2VwYXJhdGUgY2xvY2tzKS4NCj4gK+KA
oiBTZWxlY3Rpb24gaXMgbWFkZSBpbiB0aGUgQ0xLX1NSQyBiaXQgKGJpdCAxMykgb2YgQ29udHJv
bCAxIFJlZ2lzdGVyLg0KPiArICAtIENMS19TUkMgPSAwLCBhc3luY2hyb25vdXMgaS5lLiBzZXBh
cmF0ZSBjbG9ja3MgZm9yIENISSBhbmQgUEUNCj4gKyAgLSBDTEtfU1JDID0gMSwgc3luY2hyb25v
dXMgaS5lLiBDSEkgY2xvY2sgaXMgdXNlZCBmb3IgUEUgYW5kIFBFDQo+ICsgICAgICAgICAgICAg
ICAgIGNsb2NrIGlzIG5vdCB1c2VkLg0KPiAr4oCiIElmIHRoaXMgYml0IGlzIG5vdCBpbXBsZW1l
bnRlZCBpbiBTT0MsIHRoZW4gU09DIG9ubHkgc3VwcG9ydHMNCj4gK2FzeW5jaHJvbm91cw0KPiAr
ICBjbG9ja3MuDQo+ICvigKIgRWl0aGVyIG9mIHRoZSBjbG9jayBjYW4gYmUgZ2VuZXJhdGVkIGJ5
IGFueSBvZiB0aGUgY2xvY2sgc291cmNlLg0KPiAr4oCiIFdoZW4gdGhlIHR3byBjbG9ja3MgYXJl
IGFzeW5jaHJvbm91cywgdGhlbiBmb2xsb3dpbmcgcmVzdHJpY3Rpb25zDQo+ICthcHBseSB0bw0K
PiArICBQRSBjbG9jay4NCj4gKyAgLSBQRSBjbG9jayBtdXN0IGJlIGxlc3MgdGhhbiBDSEkgY2xv
Y2suDQo+ICvigKIgSWYgbG93IGppdHRlciBpcyByZXF1aXJlZCBvbiBDQU4gYnVzLCBkZWRpY2F0
ZWQgb3NjaWxsYXRvciBjYW4gYmUNCj4gK3VzZWQgdG8NCj4gKyAgcHJvdmlkZSBQRSBjbG9jaywg
YnV0IGl0IG11c3QgYmUgbGVzcyB0aGFuIENISSBjbG9jay4NCj4gKw0KPiArQmFzZSBvbiBhYm92
ZSBpbmZvcm1hdGlvbiBjbG9ja2luZyBpbmZvIGluIGZsZXhjYW4gY2FuIGJlIGRlZmluZWQgaW4g
dHdvDQo+IHdheXM6DQo+ICsNCj4gK01ldGhvZCAxKFByZWZlcnJlZCk6DQo+ICsgIC0gY2xvY2tz
OiBwaGFuZGxlIHRvIHRoZSBjbG9ja3MgZmVlZGluZyB0aGUgZmxleGNhbi4gVHdvIGNhbiBiZSBn
aXZlbjoNCj4gKyAgICAtICJpcGciOiBQcm90b2NvbCBFbmdpbmUgY2xvY2sNCj4gKyAgICAtICJw
ZXIiOiBDb250cm9sbGVyIGhvc3QgaW50ZXJmYWNlIGNsb2NrDQoNCltKb2FraW0gWmhhbmddIElu
IGZsZXhjYW4gZHJpdmVyIG5vdywgImlwZyIgaXMgZm9yIENISSBjbG9jaywgInBlciIgaXMgZm9y
IFBFIGNsb2NrLiBJIHRoaW5rIGl0J3MgdW5uZWNlc3NhcnkgdG8gZXhjaGFuZ2UgaGVyZS4NCg0K
QmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+ICsgIC0gY2xvY2stbmFtZXM6IE11c3QgY29u
dGFpbiB0aGUgY2xvY2sgbmFtZXMgZGVzY3JpYmVkIGp1c3QgYWJvdmUuDQo+IA0KPiAtLSBjbG9j
ay1mcmVxdWVuY3kgOiBUaGUgb3NjaWxsYXRvciBmcmVxdWVuY3kgZHJpdmluZyB0aGUgZmxleGNh
biBkZXZpY2UNCj4gK01ldGhvZCAyKE5vdCBQcmVmZXJyZWQpOg0KPiArICAtIGNsb2NrLWZyZXF1
ZW5jeSA6IFRoZSBzeW5jaHJvbm91cyBjbG9jayBmcmVxdWVuY3kgc3VwcGxpZWQgdG8gYm90aA0K
PiArICBDb250cm9sbGVyIGhvc3QgaW50ZXJmYWNlIGFuZCBQcm90b2NvbCBFbmdpbmUNCj4gKw0K
PiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4gDQo+ICAtIHhjZWl2ZXItc3VwcGx5OiBSZWd1bGF0
b3IgdGhhdCBwb3dlcnMgdGhlIENBTiB0cmFuc2NlaXZlcg0KPiANCj4gQEAgLTQ3LDUgKzgwLDE0
IEBAIEV4YW1wbGU6DQo+ICAJCWludGVycnVwdHMgPSA8NDggMHgyPjsNCj4gIAkJaW50ZXJydXB0
LXBhcmVudCA9IDwmbXBpYz47DQo+ICAJCWNsb2NrLWZyZXF1ZW5jeSA9IDwyMDAwMDAwMDA+OyAv
LyBmaWxsZWQgaW4gYnkgYm9vdGxvYWRlcg0KPiArCX07DQo+ICsNCj4gKwljYW5AMjE4MDAwMCB7
DQo+ICsJCWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGFyMS1mbGV4Y2FuIjsNCj4gKwkJcmVnID0g
PDB4MCAweDIxODAwMDAgMHgwIDB4MTAwMDA+Ow0KPiArCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkg
MjEgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsJCWNsb2NrcyA9IDwmc3lzY2xrPiwgPCZjbG9j
a2dlbiA0IDc+Ow0KPiArCQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsNCj4gIAkJZnNsLGNs
ay1zb3VyY2UgPSA8MD47IC8vIHNlbGVjdCBjbG9jayBzb3VyY2UgMCBmb3IgUEUNCj4gKwkJc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gIAl9Ow0KPiAtLQ0KPiAyLjE3LjENCg0K
