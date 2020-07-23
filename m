Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4064E22AB9F
	for <lists+linux-can@lfdr.de>; Thu, 23 Jul 2020 11:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGWJSz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 Jul 2020 05:18:55 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:54217
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbgGWJSz (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 23 Jul 2020 05:18:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n654Vu90dwr6oUF+d0uT/lv0eyulh0CPlIcDE+osAyxTjCNiRuSOoEFGt6TAYlDtCAw+a+A0MNZaYx88lwSxQVr556AmsX2IER76xFNrJghrJXaFd86N7PgVv7xmtDuBO+m33dINkVJSIqqK94/jQeVAHr69Ok9B7EBzCXnHvXZhW4dVHqcfUbPng7MShrxpKimnmI4MwNQtINU/2k2IquJVv91GX89AoKo4F+KCcmV66X0Q9zejsLrODwmh9U30G1KVM/Fhb9vUR1S7blNZTGXk7oBVAMTIL9yg4G3gXaaLEd+/5zgLGU1V/Cai84aL0fGvuixtr0CkDuFCqlJqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APoOfy5PzVwsj8Px8bYsTiJxic/RBcj4mDK+/fPhNcQ=;
 b=Rw3Qv1So40Z9MnGG6JvYG+R0LPkQiAzgivpGSFDtiVvKBL5xjTv8q6CKQ797SITjnv4CELNjS4qLZ2vFYg6E0v3FENpT2jZbCtPgjKuuxjygvyKFUwITPxH/A8BIdQ/S6cpVUQyV2vuvHmMaavSQMYba59B6BpYOehx3fWuSo2pRraMj5USjtfxwhWPH1FktYx9j31WVXwcT+eWmjlYUSOqFb4ixaV6rZB5YQiMPiEgJG403fY5Ki0nlG2bkLH9cP7+UV2kUIYpmzcNxszO65aSKZMOlAE/AIB+2+XVJWf565wyhOeXyivo7D3ui2wlqk/FG9yjY9D+0D0+ilceVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APoOfy5PzVwsj8Px8bYsTiJxic/RBcj4mDK+/fPhNcQ=;
 b=VLxoBSYspFVrUgP6NJuufNosMh1PGpSv4TerkkzRLl2iCbEnq4LO1xL8ondGBgdYVa5+nDPxrrUgZwkWQhcHMj3HFtyv9JQxEyJJhoBVHaGdCm0q5GHdWEAGS60a3G+2LANykJxc7D1WaG+eHTM04/ae/NGbXKo3hPQlzZ9ulLs=
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com (2603:10a6:803:bb::18)
 by VE1PR03MB5309.eurprd03.prod.outlook.com (2603:10a6:802:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Thu, 23 Jul
 2020 09:18:51 +0000
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9]) by VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9%5]) with mapi id 15.20.3216.021; Thu, 23 Jul 2020
 09:18:51 +0000
From:   =?utf-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: About sysfs usage by socket-can drivers
Thread-Topic: About sysfs usage by socket-can drivers
Thread-Index: AQHWYMJqyKFd+ukln06ck5U8OSEP4KkU4sxc
Date:   Thu, 23 Jul 2020 09:18:51 +0000
Message-ID: <VI1PR03MB5053197AAA73DC22A681610DD6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
References: <VI1PR03MB5053976465B2A1EAB995BA02D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
In-Reply-To: <VI1PR03MB5053976465B2A1EAB995BA02D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [89.158.154.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d172ad4-5b4e-4546-7d41-08d82ee96a1f
x-ms-traffictypediagnostic: VE1PR03MB5309:
x-microsoft-antispam-prvs: <VE1PR03MB5309D5ED78D60E2B2EEE2DC6D6760@VE1PR03MB5309.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8BKh6M46XaT6om6xNqaV2h/ZG2m1lZMpAiKNVdatLzu1jJbO+6hsg1z6gD8v6gZ7OnqfdpZAvRSqCnrF2R+x9zQi4LwQp8q0YaYMTr2wWsJKztZVxIoE0CTecaZEGWc45FI5h7t7j21TLbk0W/0WKjOzlJSZGqu4pR0NACdz5ZY4HSbeOKJHpYHg1QWbddJdtdgA52saXLqJ81KoFtf4MyeIgNwhl7G1jrV8lammK4w1VQ/1A9YJq3iEOn8TZHGlauGuQt68uWMht8JJ7N8zxC6vA4d1vVxH0fAPiXjjNSW13+GQXSS6b0Osw14/XEESSzApTsMwc81Bz7hUB3u9DQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB5053.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39840400004)(396003)(366004)(346002)(376002)(186003)(26005)(71200400001)(2940100002)(8936002)(508600001)(15974865002)(8676002)(85182001)(316002)(33656002)(7696005)(6506007)(6916009)(55016002)(9686003)(85202003)(52536014)(5660300002)(4744005)(64756008)(66446008)(2906002)(66476007)(66946007)(91956017)(76116006)(66556008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uFLNNxyu5aXaQ7GHgCqbjhd1RLRq9Cf7Td7jmxaDEYHaKxwREZ8QarypG4B7ZHOLYUBzQmpckBbKSLeySn7luVbx1O7du6AnDYByXIiY4gdMGNCwhxy8v2RMu/EBBYoVBY2uamYXnGP7Rew8O2Z1FIg0SLNCyNavTuF+KGhTtfk0xQZWnCXY6uBx9YzzdhaHrTSiV5xwB0FvLcLQeMfxvoCILK2LOnsRoGVUfLjJQ4TXLvAuccWDtyM/pLLe/6XK5YgL/ReJcbJl19F0ujR0C2BePWVT3QUd0wIssI7ccm+lxQUDArhKsOpRSaIes1QtPOFhpASt7Jxh18uoz68rGPfeGsod9zPapQAJGG0pPbf8T/Uf1vbp9HL68DqqmbAFJiTIFcpdY9Bw3/m8q3acWyiGuIFrYEsMPGV7uionvoEjnwI5NHt359fy6qbU7gQlb3AWyG+vycFzJj8reX1PAkn/0fQBVA64CFjFoN1VC8XzQuCEH5DfUrioWr8LU9hS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB5053.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d172ad4-5b4e-4546-7d41-08d82ee96a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 09:18:51.4452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZChiWp+R//9jbjuyu6fMcD/qevp8MhoW2cIZW84V7onKQqodw4W6p7WCftmKkHyLSvmbJRBvSNLCNlGeT6ojldm4n5YTEE8yM44CQovXPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5309
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8sDQoNCkFyZSB0aGVyZSBydWxlcyBmb3IgdXNpbmcgbmV0d29yayBpbnRlcmZhY2Ugc3lz
ZnMsIGluIHBhcnRpY3VsYXIsIGNhbiBhIHNvY2tldC1jYW4gZHJpdmVyIGFkZCBpdHMgb3duIGF0
dHJpYnV0ZXMsIHBsZWFzZT8NCg0KUmVnYXJkcyzigIsNCg0KLS0tIFN0ZXBoYW5lDQoNCi0tDQpQ
RUFLLVN5c3RlbSBUZWNobmlrIEdtYkgNClNpdHogZGVyIEdlc2VsbHNjaGFmdCBEYXJtc3RhZHQg
LSBIUkIgOTE4Mw0KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBBbGV4YW5kZXIgR2FjaCAvIFV3ZSBXaWxo
ZWxtDQpVbnNlcmUgRGF0ZW5zY2h1dHplcmtsYWVydW5nIG1pdCB3aWNodGlnZW4gSGlud2Vpc2Vu
DQp6dXIgQmVoYW5kbHVuZyBwZXJzb25lbmJlem9nZW5lciBEYXRlbiBmaW5kZW4gU2llIHVudGVy
DQp3d3cucGVhay1zeXN0ZW0uY29tL0RhdGVuc2NodXR6LjQ4My4wLmh0bWwNCg==
