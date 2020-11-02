Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EEB2A336C
	for <lists+linux-can@lfdr.de>; Mon,  2 Nov 2020 19:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgKBS5E (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Nov 2020 13:57:04 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:59609 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBS5E (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Nov 2020 13:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604343423; x=1635879423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XNfjrqM9aOWqxXCQwJeP0OGdRxaqaneNmt7crwb8VJE=;
  b=An/OppHd1epkuePhXUkO2EUjwhAHpqnxWRMDSN2fZTrEZXYFgwMylsE8
   mJz5OiI1dBk/MW6uZCqopkWksGPampPyTB/0HPVz+ZjT7mH8yDksUjB2m
   KNKFp7nMvX5XgZb4T0204G8rbEeKECrw5xC7TS3rEz3t/JwUlRJWwlfzU
   u4y/ozQq3tX/0F4wPD4nAFadkWBl/EBxw4u2rHhA3UkztVX0In9IMrg9o
   kMxFWDHIP3VWoUIX3jp3l0hGCkZ6WyMA86kPtd03FWjbgLffO0XxHSrSI
   l8cEcuAkXEncbxcQb4uG7cAcqo3TmuRF37nUadYlTbdtP7aYNrkbiC92c
   g==;
IronPort-SDR: n8XoEslLGGkF4WEiEAuGkAm+Ejt9oEgmiHY/hfkkwH8oObetYOv+lKi0x/sJh/0zTP9i40kxkc
 0xBlHRVpuJuV+35UwmpwhD0xQtz8aVB4i/KaHLLTwxHE6bHVeUnYfju+0nOamB3YoQd+i39MYM
 i0kcovhzK0dfkhpEI34N6unnbrzr2xMWu81toh0QQMt7/h1zkGc/3BzP6YTZUVumtOMjOkIGUl
 Tf/pXlQPvyCPSI4vjFojjUwQGe2s2AA7rXPWiBgA711unVqizmquXyLROp1yUbIJnaKy78jIHl
 eHk=
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="101850341"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2020 11:57:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 2 Nov 2020 11:57:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 2 Nov 2020 11:57:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=benQRetGDGro1+frISFW79m5uqTZ0Bw02zBmQr5ttDmALrBOseIzd2ilfJ/mM7OwytdSaQgfP8fiVrbw6JBsEP611FeOVuC0GdcvFtZWUIbJef2P5fyb5ymCmRyg8Vf1xk9AiUCWrk1eRQlXMnqzuryeC2VEAqduQoBi7785hwF4RZ+C2UI103KzoTZdr9sBrN62d3lc1u1sRJdSL877cxmeHl3Dukx7R+YRbsH34/b003ka1v2UldSzd5Ub0GzDdfADwsQWGHjg6QT4u47Q/eHwSZQAIQHacEBiICsTi+tIjoZDXXtodUsiixE/6V01WPE0eJKsf0/aUCZFMtMeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNfjrqM9aOWqxXCQwJeP0OGdRxaqaneNmt7crwb8VJE=;
 b=laVYCkBSMVF/+ccxijdpvhAJcrlHDv2AsKG2os3DqRCuZZRZEnQIW86PB4pV3pZV3IpCXrfh+hpyvLPde4/8bc3gZT7+ACOwd+oe3eWuhg9kjOHVh/O2nwza8wAsHNqDbWZTHtMQh85Li9LxHATU8Mwzlm5GBQ8UVjQm5XuO2tsqejla6L2so610AJnTZfB9RgB8D4CChroEcVWmzMup83gp7eB5En+espYCvYGVF/jVeHJny/I34EpMWZCtwqSC3O+KYJNZI06nITGGow5AGDTWuQ/Mjbq9drCwT9zpEdD+VwVED5LG50WbyyxTzjgOJvqjk9HIzR/kcPYyZi4elw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNfjrqM9aOWqxXCQwJeP0OGdRxaqaneNmt7crwb8VJE=;
 b=sFpeSvHGdilJzM4tojYOb1yYygASd+g6y9SrrZ+yYpmFEbZ8uklKxNxMeIglKLLmeRj8kEhPdMHrviCZbgamLtv2/Gm8KmzvTEcspjLeYV6tXeT06CBhfwxAdi17N3HbpBdUdtIcnWH4kBFyl47p9vqLg3hGvhyRltlUhGgZMuI=
Received: from DM6PR11MB4283.namprd11.prod.outlook.com (2603:10b6:5:206::32)
 by DM6PR11MB2985.namprd11.prod.outlook.com (2603:10b6:5:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Mon, 2 Nov
 2020 18:57:01 +0000
Received: from DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::e97c:9647:f0c8:e603]) by DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::e97c:9647:f0c8:e603%5]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 18:57:01 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <menschel.p@posteo.de>, <mkl@pengutronix.de>,
        <drew@beagleboard.org>
CC:     <socketcan@hartkopp.net>, <linux-can@vger.kernel.org>,
        <josh@macchina.cc>
Subject: RE: mcp251xfd on RPi 5.4 downstream
Thread-Topic: mcp251xfd on RPi 5.4 downstream
Thread-Index: AQHWqCDoCFfsNWP42k6nfA0WlXA416mjIPwAgAAJTACAAMuIAIADyR+AgABIX4CAACPhAIAAcVKAgAAIj4CAAAfZAIAAejuAgAAOLgCAAHJzAIAAeGIAgAACjoCAAJ0rAIAARniAgAAI6YCAALuRAIAAAU+AgAHH5N2ABB4yAIAALqOAgAAF4YCAAGqigIACP+sAgAAtPl2AAG32AIAAFHIAgAABNJA=
Date:   Mon, 2 Nov 2020 18:57:01 +0000
Message-ID: <DM6PR11MB4283DF81AFCFEBB886559B5AFB100@DM6PR11MB4283.namprd11.prod.outlook.com>
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj6nu475YeeWXc3wWO8sAmn8stz2Qr3nQ=HABd8CKR-c+w@mail.gmail.com>
 <41b606d5-5991-4d4f-bd6f-aaaf31cbc9b5@pengutronix.de>
 <6a7061a4-771d-6703-1e30-273050abfb9d@posteo.de>
 <2593d8e0-2d42-0461-e2e1-86a71b415476@pengutronix.de>
 <CAPgEAj5JheUirqr2kLrjJpwCaK3+HZyo8r8uKk25zMREVXWT3Q@mail.gmail.com>
 <CAPgEAj4W61tCSkdrCP2J4dL7WwQ1NKzFCUGjY9o4_qj+NG5KEA@mail.gmail.com>
 <3d19330b-860b-7d76-bc6d-768a7b00ed4b@pengutronix.de>
 <CAPgEAj6qZxfsyuarVgvnXkHd3ZUAP-3fgD-nONCcn-C5xY44+Q@mail.gmail.com>
 <e955f39f-2417-4dca-ee3c-70b328c1014d@posteo.de>
 <3a5f81d6-13ba-71b8-67a7-fe6e8a13f84a@posteo.de>
 <CAPgEAj7B5O5nwqr-nMBXNqgx9tD5=9XPG0W0=C21FMD6S+bR-A@mail.gmail.com>
 <3b7b6353-0493-210a-7c14-e7ccc1067365@pengutronix.de>
 <CAPgEAj7LcX3cb+syhtR1i3Uo1XkYYFQ_wDPV8GniaA-YwPk2Hg@mail.gmail.com>
 <08a1fb36-5efb-27d8-f5b9-bd2a923479a2@pengutronix.de>
 <9e9db79d-9357-19bd-0584-3f97ed49c731@posteo.de>
 <cd778ddb-eb0e-bff9-5c14-06731ffb35a0@posteo.de>
In-Reply-To: <cd778ddb-eb0e-bff9-5c14-06731ffb35a0@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: posteo.de; dkim=none (message not signed)
 header.d=none;posteo.de; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [37.49.108.103]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebde68ab-8ecf-41d5-a323-08d87f611516
x-ms-traffictypediagnostic: DM6PR11MB2985:
x-microsoft-antispam-prvs: <DM6PR11MB2985D8959AE2C7ADBECD52D2FB100@DM6PR11MB2985.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IhMwXMi/D38klaGBX5GL6f0rWsUene/2uB9cPnLyiKy1GJjvEDdXbz62G3Uat0McHEL03UM/ndd54/tc4WiDpQpgS/Tnl1W1rbu9zqJj7GqDej+lV72EFwm0G5izHUkuvjWgCSNU5YWpaOamLkcTeU/OEj6NTKB/CBicXnPYnWbtWfQRRdkukTm6/W7Iv4XSXwLEDjtCcHOUry594Ihc6X7bjRi3XoQSy8IzeD7sMzHe63TcLOaNUPnkUK/jswJhj1tP8InyTzPIeGx7H4/8WIJfbrYNYUTPF4FebnYv3wdOZ7yYvECYjg4A/Fq4iQ3kdxa8K7sd5WMEYcdkRxs9MR7O+pHOT9cOUGyMj/AtrR6f5UJPeiU7Xoa6LHfrYTxqDVi6M3rM/W7dGdOvYqNOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(396003)(39860400002)(55016002)(33656002)(86362001)(2906002)(76116006)(8936002)(8676002)(64756008)(66446008)(66556008)(71200400001)(66476007)(316002)(66946007)(54906003)(110136005)(7696005)(478600001)(26005)(966005)(52536014)(9686003)(5660300002)(4326008)(83380400001)(186003)(6506007)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yMrNsyuFbPSxoYyJYRp2JzXWCJS66I6zO2PBpI/PpqrlMkVa6Bk0715H+Axzx7yd2YltPK5Tt8jFWS+Z4YCiAWLorIwy49dB8mRW4poHd2R4PetvA3MOVmsI8tV/Ayzm0Vwljf8K6xV15V+IPMJ6koicrGkq2gYe1ZFFLMRvhSTy60y5wx0bQUIH/ixUcPgdBdLYGnzZkb6iHQQSO/ReyrDeabrpa3Pdgm0QHSaDRXxdWlGvat4NAy8gQpvNRbjDhdmQzN8JP055wje4vYznSy6ff1hlOa3QEo33cwsIAJ+X/gY4YF8Em+5ulAuDrlHssGxccwqeI58DRf3o/tWAqde7CMNVgDOPP9QZAlsGacCgXw0ZmnhPGuqyILKIJDVUTe9o34482ASH+rEkwyK5NBjPMEidHPh0p9w+3VYQNKW6jBYdrcxrcUDoo5u2P2hYx7KkcbLJzjsGLraPczHfwmSzX215b0UjG/OzLENJwHb+KC5n2L1pC0VMvyJ9wcua6z8BrkYnDfrkzgV9dz1kIh4P2PDGf7LEAap+XqEddtcG9Hj05JolAFbLcsojs2w/4HYMGNFNfNwlwZZIlAwP4S97ASakEbVUsYq3vtBA9bBBuLa0LuAHMoRFp5e6zeRWSTHpBLDInb0zcZQDVx6dXw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebde68ab-8ecf-41d5-a323-08d87f611516
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 18:57:01.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BSnTLKXlSsgI2+WvHMNZPr/ORYskPwgQf+oRiroAuwXRfTbcu4QwzBljQ5KXiAb7gNlkwrsHLHsVBgSRKjKEZPslLWFycqK2fc/QdeKHNI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2985
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBJdCBtYXkgYmUgYSBibHVudCBndWVzcywgYnV0IGFjY29yZGluZyB0byBwYWdlIDk5DQo+IA0K
PiBodHRwczovL3d3dy5yYXNwYmVycnlwaS5vcmcvZG9jdW1lbnRhdGlvbi9oYXJkd2FyZS9yYXNw
YmVycnlwaS9iY20yNw0KPiAxMS9ycGlfREFUQV8yNzExXzFwMC5wZGYNCj4gDQo+IFBpbiAyNiBp
cyBwdWxsZG93bi4gU28gaXQgd29ya3MgaWYgaXQgcmVtYWlucyB1bnVzZWQgYmVjYXVzZSB0aGUg
cGluIGlzDQo+IGlucHV0IHdpdGggcHVsbGRvd24gdGh1cyB0aGUgY2hpcCBpcyBzZWxlY3RlZCBi
eSBkZWZhdWx0Lg0KPiANCj4gSSBkb24ndCBrbm93IGlmIHRoZSBDRSBwaW4gY2FuIGFjdHVhbGx5
IHdvcmsgaWYgdGhlcmUgaXMgbm8gbWF0Y2hpbmcgYWx0DQo+IGZ1bmN0aW9uIGluIHBpbnNlbGVj
dCByZWdpc3Rlci4NCj4gDQo+IC0tDQo+IFBhdHJpY2sNCkRvIHlvdSBzdWdnZXN0IHRoYXQgdGhl
IGNvbW11bmljYXRpb24gd29ya3Mgd2l0aCBhIHBlcm1hbmVudCBsb3cgb24gQ1MvQ0U/DQpXaXRo
b3V0IHRoZSBDUy9DRSBwaW4gaGF2aW5nIGVkZ2VzIHlvdSB3aWxsIG5vdCBiZSBhYmxlIHRvIHNl
bmQgbXVsdGlwbGUgDQpjb21tYW5kcy4gVGhlIGRyaXZlciBpcyB3cml0aW5nL3JlYWRpbmcgbXVs
dGlwbGUgdGltZXMgd2hlbiBicmluZ2luZyB1cCB0aGUNCmNoaXAuIElmIHlvdSBoYXZlIGEgcGVy
bWFuZW50IGxvdyB0aGF0IHdpbGwgZmFpbC4gU28gc29tZWhvdyB0aGUgQ1MgZG9lcyANCmdlbmVy
YXRlIHRoZSByaWdodCBlZGdlcy4NCg0KVGhvbWFzDQo=
