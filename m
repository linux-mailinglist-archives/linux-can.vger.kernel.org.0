Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7FD5856
	for <lists+linux-can@lfdr.de>; Sun, 13 Oct 2019 23:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfJMVcJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Oct 2019 17:32:09 -0400
Received: from mail-eopbgr60133.outbound.protection.outlook.com ([40.107.6.133]:9537
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727492AbfJMVcI (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 13 Oct 2019 17:32:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRzKnG+w1uEUPvhhj+Us6sXRSOo6UBjKxURkEvPLdb4F+XEKqAEpLifuap7GTzzPlCHSOYlBSl9QzjrW+k4RRRGb+z6Wev1YLniJZ76YSyAuVFScToIyKj6e44md9BSdrzGSS7y2IHhNQRetleejXcDWh4YsPWgk7bhTk41FC6+fiLhQX2pAdqI/T1A9Mxk7iffv9Q2aHx+kpYQv72rjYlVWZ3elhsRyopjvdCgL2fHJj6GAjrGe2VMYU3uZcr614qC4uggM0DSv3P6Z60iXyiK27OEQP6kq635+vqRXZ/8+O1IPKPW4LtlsnD19VzrJWKkHR0C0rsqNnpXStRTkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onERzc3YXU/YClUIDDE4ZD2+8gn5gUNYDYruVy5Wrs4=;
 b=VPnR2pFtUk/Oym1AQC4xTPI7w+gAFvz8ZjRz8T/RX3ftx2/YwWKw6NdqA0ZJQZYKEOBu9phnJ8aziDME2CwjgfTLk8inn/4KBlQ5I0aCvnMMA7H3nVZ1ftVMG0jXpLwUd1oBvzXipGVR77pV0uA4j5kdZhBiZmpBKzId7/qgT6m/rbpK9GpEl7hgoTOywz4vhQHXk0c1oklqvxzlWXXCA1x50yRn7p15qiLvKJpM2f8+GT0JFH2u65eI3/KJ9VZankbEaNv6/dzb8nG2q1ZlaylHVan99J84q5FzzXH9aasN7+1EgCZliABwXJzzAXIMC921nnYHpPjK6ac4zL7R+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onERzc3YXU/YClUIDDE4ZD2+8gn5gUNYDYruVy5Wrs4=;
 b=AEXsCU02CrjqXI9eQqDXmymnQOT1n+I9tFw2aZNEiP18by681xpkpJ6byQlSAti7IiKGSUwNbsDQ5Ck7qY67CBiqRwZuxeiJ0KxE3gRoSBMwSjLDNv1L9s80vKkwXlVG6TMhSRmlUZfr2iTRpMcUq0voJf1L7I91EAKqCVU8ghU=
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com (10.173.82.19) by
 VI1PR0701MB2479.eurprd07.prod.outlook.com (10.168.139.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Sun, 13 Oct 2019 21:32:05 +0000
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::49b7:a244:d3e4:396c]) by VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::49b7:a244:d3e4:396c%9]) with mapi id 15.20.2347.021; Sun, 13 Oct 2019
 21:32:05 +0000
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH v3] can: ti_hecc: add fifo overflow error reporting
Thread-Topic: [PATCH v3] can: ti_hecc: add fifo overflow error reporting
Thread-Index: AQHVgCAguFhKP2bs0kekMqoJRIs1hadZGw6A
Date:   Sun, 13 Oct 2019 21:32:05 +0000
Message-ID: <ed816e38-c81c-4a83-884d-29642e10fd79@victronenergy.com>
References: <20191011103909.19908-1-mkl@pengutronix.de>
In-Reply-To: <20191011103909.19908-1-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2001:1c01:3bc5:4e00:fc62:6962:688d:c507]
x-clientproxiedby: AM0PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::28) To VI1PR0701MB2623.eurprd07.prod.outlook.com
 (2603:10a6:801:b::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhofstee@victronenergy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1396cf7-2d62-45b4-db2b-08d75024caea
x-ms-traffictypediagnostic: VI1PR0701MB2479:
x-microsoft-antispam-prvs: <VI1PR0701MB24798CE64ED9858EBBF0E821C0910@VI1PR0701MB2479.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01894AD3B8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(366004)(39840400004)(396003)(199004)(189003)(66946007)(66476007)(66556008)(66446008)(31686004)(64756008)(4744005)(6512007)(86362001)(6436002)(31696002)(6486002)(5660300002)(6246003)(81166006)(81156014)(8676002)(8936002)(58126008)(110136005)(2906002)(316002)(6116002)(7736002)(446003)(229853002)(2501003)(186003)(102836004)(46003)(476003)(305945005)(486006)(2616005)(11346002)(65956001)(65806001)(99286004)(53546011)(6506007)(386003)(52116002)(76176011)(36756003)(25786009)(14454004)(256004)(71200400001)(71190400001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB2479;H:VI1PR0701MB2623.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: victronenergy.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZwnW+rJtYcQDnY/L9DM7XK4wTdlowPsW4gB8EAx6oKukjX1DEjT/bzQS5T28iAGV/OUkzcZTdNB+kv9S+qw0mTG0AM7LNXWUbZP5WiJkgRUdEJpnc6L5s0IRhUR2ulEir8JWSyJtgaTGMJY9LPFMG+lSeDyuASrbx9O6s8M/KwFMzTI9JypiG8+JjrPFrKYBHTuXN7CL3ZF4SYBoFflqf4Em7KRuAgKRdUei3z0IiB1klqsskH0982ZVQkUwzUfIO15/q/3ltFAcvtJvvim9wxRcE39sfO3i72tGT7bMSgTxoFIdztUrMLSWVw9bqooaprIwfEyjlocrwwudMYioo28xp4SkPV6pz2Tl/daV92neRx5sNZa6FhOVVVMCe0BSc8+gzAB8ULgUvb26X9YfiPPwLai8NWyHgxpKqSA+WA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <822270105C74B4458ABCA3B2C394F18B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1396cf7-2d62-45b4-db2b-08d75024caea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2019 21:32:05.1617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiwc1R/FAv3xB7kfE0IoHKurJujmE9AoM4J2fvfk815fSA9fEH5Il9bl+CYGrqSume/z0krov2sLtgG2lqzMTyeUgwyHpx7JC1EM7rwEu2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2479
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gTWFyYywNCg0KT24gMTAvMTEvMTkgMTI6MzkgUE0sIE1hcmMgS2xlaW5lLUJ1ZGRlIHdy
b3RlOg0KPiBGcm9tOiBKZXJvZW4gSG9mc3RlZSA8amhvZnN0ZWVAdmljdHJvbmVuZXJneS5jb20+
DQo+DQo+IFdoZW4gdGhlIHJ4IEZJRk8gb3ZlcmZsb3dzIHRoZSB0aV9oZWNjIHdvdWxkIHNpbGVu
dGx5IGRyb3AgdGhlbSBzaW5jZQ0KPiB0aGUgb3ZlcndyaXRlIHByb3RlY3Rpb24gaXMgZW5hYmxl
ZCBmb3IgYWxsIG1haWxib3hlcy4gU28gZGlzYWJsZSBpdCBmb3INCj4gdGhlIGxvd2VzdCBwcmlv
cml0eSBtYWlsYm94IGFuZCBpbmNyZW1lbnQgdGhlIHJ4X292ZXJfZXJyb3JzIHdoZW4NCj4gcmVj
ZWl2ZSBtZXNzYWdlIGxvc3QgaXMgc2V0LiBEcm9wIHRoZSBtZXNzYWdlIGl0c2VsZiBpbiB0aGF0
IGNhc2UsIHNpbmNlDQo+IGl0IG1pZ2h0IGJlIHBhcnRpYWxseSB1cGRhdGVkLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKZXJvZW4gSG9mc3RlZSA8amhvZnN0ZWVAdmljdHJvbmVuZXJneS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQoN
Cg0KQWNrZWQtYnk6IEplcm9lbiBIb2ZzdGVlIDxqaG9mc3RlZUB2aWN0cm9uZW5lcmd5LmNvbT4N
Cg0KWW91IG1pZ2h0IHdhbnQgdG8gY2hhbmdlIHRoZSBjb21taXQgbWVzc2FnZSB0aG91Z2gsDQpz
aW5jZSBJIGRvdWJ0IGl0IHN0aWxsIGluY3JlbWVudHMgcnhfb3Zlcl9lcnJvcnMsIGF0IGxlYXN0
IHRoaXMNCnBhdGNoIG5vIGxvbmdlciBkb2VzLiBCdXQgYWZhaWMgeW91IGRvbid0IG5lZWQgdG8g
cmVzZW5kDQp0aGF0Lg0KDQpSZWdhcmRzLA0KDQpKZXJvZW4NCg0K
