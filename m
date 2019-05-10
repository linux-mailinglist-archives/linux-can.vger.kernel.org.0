Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE6919A8B
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2019 11:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfEJJYN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 May 2019 05:24:13 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:47012
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727190AbfEJJYN (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 May 2019 05:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Aj+wKbj/tOa3zIyI6+qlMHAqkq1iJMakD/Y4xDKiA8=;
 b=Ed2Eg9YIczq+uQLWiw3irjZXURju/F3LJ5TPl1F5QxrOL3FTsbwRuMdqjIybACM4UTWGNTLDVN5cec+TZYuH9bY/87m7v5SQSF9mCGMgB1LCjMjq61Y/D/lQuNJYERgCYeK++1ADygY4wnaXdh48dl9/IWTBEk9iMGMN0akzkJY=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2318.eurprd04.prod.outlook.com (10.169.132.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 09:24:07 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 09:24:07 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH 1/2] Documentation: can: flexcan: Add flexcan clocks'
 information
Thread-Topic: [PATCH 1/2] Documentation: can: flexcan: Add flexcan clocks'
 information
Thread-Index: AQHVBxIewsbNuBHz0keMnpYRL3CIAA==
Date:   Fri, 10 May 2019 09:24:07 +0000
Message-ID: <20190510144724.16447-2-pankaj.bansal@nxp.com>
References: <20190510144724.16447-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190510144724.16447-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYCPR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:405:1::28) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b84770a-1803-4e51-7875-08d6d529407d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2318;
x-ms-traffictypediagnostic: VI1PR0401MB2318:
x-microsoft-antispam-prvs: <VI1PR0401MB231827A1CF72FEB37BD81C3EF10C0@VI1PR0401MB2318.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(5660300002)(4326008)(2906002)(186003)(53936002)(6116002)(102836004)(1076003)(36756003)(478600001)(26005)(11346002)(446003)(2616005)(476003)(6512007)(14454004)(486006)(44832011)(3846002)(25786009)(8676002)(81166006)(81156014)(6436002)(68736007)(6486002)(54906003)(99286004)(8936002)(71190400001)(316002)(86362001)(305945005)(7736002)(50226002)(71200400001)(66476007)(64756008)(66556008)(66446008)(73956011)(76176011)(386003)(6506007)(14444005)(256004)(66946007)(52116002)(66066001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2318;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ncdk0OenfCmjn9Ja2JZkzL6TXNIv9ojelZaDZXGt0C+2f0aWDbtHapOBZFicvvd4tLkbjviIx3uPPPyS4y26lSmn9nVOYfZ39ADd9PBE6B0+cIfJxuEjx6kf7iIeMw5uH2ERIL+PvnlXVQ89FQbvp64RvC4di6hXrXdkK2CAxcEoV+f4/lWxpn9fFK7b91r2AxeHREJcoIai6/cNoM2EbcW2/mqKDDBF3JWCXRXRnGkLRc3hRghvi8HxzwmgdZ6B6zPF4Ahm/ATp+Qx5k0A3Sklx5+oOKq6xX/mEshYm06L3OSlRtC+z441IBVvGCYR76zbwNkX5U6LmNJkMZRQJZCkb1mN+cYRMOX8q93kuT+xPhvR01JsQs5Mxeo1bXeYHrIAVycNhNlM5dez59y8fZqUlk0ajQb7RKENz6gTt+Xs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CB25E0100517742A4FC29348F408AFC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b84770a-1803-4e51-7875-08d6d529407d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 09:24:07.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2318
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

VGhlIGNsb2NraW5nIGluZm9ybWF0aW9uIGlzIG1pc3NpbmcgZnJvbSBmbGV4Y2FuIGRldmljZSB0
cmVlIGJpbmRpbmdzLg0KVGhpcyBpbmZvcm1hdGlvbiBpcyBuZWVkZWQgdG8gYmUgYWJsZSB0byB1
c2UgZmxleGNhbi4gRG9jdW1lbnQgdGhlIHNhbWUuDQoNClNpZ25lZC1vZmYtYnk6IFBhbmthaiBC
YW5zYWwgPHBhbmthai5iYW5zYWxAbnhwLmNvbT4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9uZXQvY2Fu
L2ZzbC1mbGV4Y2FuLnR4dCAgICAgICAgIHwgNDcgKysrKysrKysrKysrKysrKystDQogMSBmaWxl
IGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL2ZzbC1mbGV4Y2FuLnR4
dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL2ZzbC1mbGV4Y2Fu
LnR4dA0KaW5kZXggYTA0MTY4NjA1OTk4Li40MTNlN2ZlZWEyYjcgMTAwNjQ0DQotLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9mc2wtZmxleGNhbi50eHQNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL2ZzbC1mbGV4Y2Fu
LnR4dA0KQEAgLTEyLDYgKzEyLDQxIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogLSByZWcgOiBP
ZmZzZXQgYW5kIGxlbmd0aCBvZiB0aGUgcmVnaXN0ZXIgc2V0IGZvciB0aGlzIGRldmljZQ0KIC0g
aW50ZXJydXB0cyA6IEludGVycnVwdCB0dXBsZSBmb3IgdGhpcyBkZXZpY2UNCiANCitDbG9ja2lu
ZyBpbmZvcm1hdGlvbiBpcyBtdXN0IGZvciBmbGV4Y2FuLiBwbGVhc2UgcmVmZXIgYmVsb3cgaW5m
byBmb3INCit1bmRlcnN0YW5kaW5nIGNsb2NraW5nIGluIGZsZXhjYW46DQorDQor4oCiIFRoZSBG
TEVYQ0FOIG1vZHVsZSBpcyBkaXZpZGVkIGludG8gdHdvIGJsb2Nrcy4gQ29udHJvbGxlciBob3N0
IGludGVyZmFjZQ0KKyAgKCJDSEkiKSBhbmQgUHJvdG9jb2wgRW5naW5lICgiUEUiKQ0KK+KAoiBC
b3RoIHRoZXNlIGJsb2NrcyByZXF1aXJlIGNsb2NrLg0KK+KAoiBDSEkgaXMgcmVzcG9uc2libGUg
Zm9yIHJlZ2lzdGVycyByZWFkIHdyaXRlIGluY2x1ZGluZyBNQiByZWFkL3dyaXRlLg0KKyAgV2hp
bGUgUEUgaXMgcmVzcG9uc2libGUgZm9yIFRyYW5zZmVyL3JlY2VpdmUgZGF0YSBvbiBDQU4gYnVz
Lg0KK+KAoiBUaGUgY2xvY2tzIGZlZWRpbmcgdG8gdGhlc2UgdHdvIGJsb2NrcyBjYW4gYmUgc3lu
Y2hyb25vdXMgKGkuZS4gc2FtZSBjbG9jaykNCisgIG9yIGFzeW5jaHJvbm91cyAoaS5lLiBzZXBh
cmF0ZSBjbG9ja3MpLg0KK+KAoiBTZWxlY3Rpb24gaXMgbWFkZSBpbiB0aGUgQ0xLX1NSQyBiaXQg
KGJpdCAxMykgb2YgQ29udHJvbCAxIFJlZ2lzdGVyLg0KKyAgLSBDTEtfU1JDID0gMCwgYXN5bmNo
cm9ub3VzIGkuZS4gc2VwYXJhdGUgY2xvY2tzIGZvciBDSEkgYW5kIFBFDQorICAtIENMS19TUkMg
PSAxLCBzeW5jaHJvbm91cyBpLmUuIENISSBjbG9jayBpcyB1c2VkIGZvciBQRSBhbmQgUEUNCisg
ICAgICAgICAgICAgICAgIGNsb2NrIGlzIG5vdCB1c2VkLg0KK+KAoiBJZiB0aGlzIGJpdCBpcyBu
b3QgaW1wbGVtZW50ZWQgaW4gU09DLCB0aGVuIFNPQyBvbmx5IHN1cHBvcnRzIGFzeW5jaHJvbm91
cw0KKyAgY2xvY2tzLg0KK+KAoiBFaXRoZXIgb2YgdGhlIGNsb2NrIGNhbiBiZSBnZW5lcmF0ZWQg
YnkgYW55IG9mIHRoZSBjbG9jayBzb3VyY2UuDQor4oCiIFdoZW4gdGhlIHR3byBjbG9ja3MgYXJl
IGFzeW5jaHJvbm91cywgdGhlbiBmb2xsb3dpbmcgcmVzdHJpY3Rpb25zIGFwcGx5IHRvDQorICBQ
RSBjbG9jay4NCisgIC0gUEUgY2xvY2sgbXVzdCBiZSBsZXNzIHRoYW4gQ0hJIGNsb2NrLg0KK+KA
oiBJZiBsb3cgaml0dGVyIGlzIHJlcXVpcmVkIG9uIENBTiBidXMsIGRlZGljYXRlZCBvc2NpbGxh
dG9yIGNhbiBiZSB1c2VkIHRvDQorICBwcm92aWRlIFBFIGNsb2NrLCBidXQgaXQgbXVzdCBiZSBs
ZXNzIHRoYW4gQ0hJIGNsb2NrLg0KKw0KK0Jhc2Ugb24gYWJvdmUgaW5mb3JtYXRpb24gY2xvY2tp
bmcgaW5mbyBpbiBmbGV4Y2FuIGNhbiBiZSBkZWZpbmVkIGluIHR3byB3YXlzOg0KKw0KK01ldGhv
ZCAxKFByZWZlcnJlZCk6DQorICAtIGNsb2NrczogcGhhbmRsZSB0byB0aGUgY2xvY2tzIGZlZWRp
bmcgdGhlIGZsZXhjYW4uIFR3byBjYW4gYmUgZ2l2ZW46DQorICAgIC0gImlwZyI6IFByb3RvY29s
IEVuZ2luZSBjbG9jaw0KKyAgICAtICJwZXIiOiBDb250cm9sbGVyIGhvc3QgaW50ZXJmYWNlIGNs
b2NrDQorICAtIGNsb2NrLW5hbWVzOiBNdXN0IGNvbnRhaW4gdGhlIGNsb2NrIG5hbWVzIGRlc2Ny
aWJlZCBqdXN0IGFib3ZlLg0KKw0KK01ldGhvZCAyKE5vdCBQcmVmZXJyZWQpOg0KKyAgLSBjbG9j
ay1mcmVxdWVuY3kgOiBUaGUgc3luY2hyb25vdXMgY2xvY2sgZnJlcXVlbmN5IHN1cHBsaWVkIHRv
IGJvdGgNCisgIENvbnRyb2xsZXIgaG9zdCBpbnRlcmZhY2UgYW5kIFByb3RvY29sIEVuZ2luZQ0K
Kw0KIE9wdGlvbmFsIHByb3BlcnRpZXM6DQogDQogLSBjbG9jay1mcmVxdWVuY3kgOiBUaGUgb3Nj
aWxsYXRvciBmcmVxdWVuY3kgZHJpdmluZyB0aGUgZmxleGNhbiBkZXZpY2UNCkBAIC00Nyw1ICs4
MiwxNSBAQCBFeGFtcGxlOg0KIAkJaW50ZXJydXB0cyA9IDw0OCAweDI+Ow0KIAkJaW50ZXJydXB0
LXBhcmVudCA9IDwmbXBpYz47DQogCQljbG9jay1mcmVxdWVuY3kgPSA8MjAwMDAwMDAwPjsgLy8g
ZmlsbGVkIGluIGJ5IGJvb3Rsb2FkZXINCi0JCWZzbCxjbGstc291cmNlID0gPDA+OyAvLyBzZWxl
Y3QgY2xvY2sgc291cmNlIDAgZm9yIFBFDQorCX07DQorDQorCWNhbkAyMTgwMDAwIHsNCisJCWNv
bXBhdGlibGUgPSAiZnNsLGx4MjE2MGFyMS1mbGV4Y2FuIjsNCisJCXJlZyA9IDwweDAgMHgyMTgw
MDAwIDB4MCAweDEwMDAwPjsNCisJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyMSBJUlFfVFlQRV9M
RVZFTF9ISUdIPjsNCisJCWNsb2NrcyA9IDwmc3lzY2xrPiwgPCZjbG9ja2dlbiA0IDc+Ow0KKwkJ
Y2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQorCQlmc2wsY2xrLXNvdXJjZSA9IDwwPjsgLy8g
c2VsZWN0IGNsb2NrIHNvdXJjZSAwIGZvcg0KKwkJCQkgICAgICAvLyBQRSBpLmUuIGFzeW5jaHJv
bm91cyBjbG9ja2luZw0KKwkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJfTsNCi0tIA0KMi4xNy4x
DQoNCg==
