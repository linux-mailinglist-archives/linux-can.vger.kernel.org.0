Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536CF27C530
	for <lists+linux-can@lfdr.de>; Tue, 29 Sep 2020 13:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgI2LcM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Sep 2020 07:32:12 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24133 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgI2LaG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2020 07:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601379007; x=1632915007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k2diZ9vY3DhB3YIh7xEodFh2NZ4a3r4j+K8pi+DiPNg=;
  b=WO5LSz/NYx/22EygMtHD9g1E+dgGYHAFKuPdsrv3CrB0y5PClZpFvHKN
   vicFRQGEG5NGYuTeYY9JC/x0VsAeeiOV2eC1CKPQ/vvVQZhvhSBU+67+W
   W4Ku0GsMpbAzIyclV0gbeqQN7r6jrhZZK6gTihavmLK/a8SbTKcsZq8IG
   5r0T/zT4HN5KG1A7nKCpGL76fQ8PXcf1akZ2Mffbh9n+7A3ifcQ/g/D1d
   j2Pfpsb6hdr3JmfJfWQCX3xWCLaIkgjZ3LIZDTU0CMesezJOgaa4rxeh5
   sR4dIGiPUpf+n4Hl3gSHVNMq/qfT1Xw7V8HjnIwSXoXQjpD276HEP+Ivk
   Q==;
IronPort-SDR: ajmADmWFW2J1HkYANdRQ+gQ2ktCGLG96nI8ivfnYEuAUKs25IBXcVZj3ZqYurl460I3HpiO8am
 EiHhTV9YpeO7TRzG0cLYQuUw6ffZP0uLEYvMzDYQOuqomiaavCM42Eyq1AV3K52OO0cXWQFfLE
 UhBQ+YFIhKrmKFq765MMeqzCTX/YeSekrWjqgo63SCtXg+2qJNYFMBEbPNckjOhAgSEA8egoF9
 lUz4gd0Ut2d9OMnrcX0GVrWsLaEHz2oDmV0ytacTzi9MXjV1L14mMMmkxB4FmiNwtZFz5shQTs
 aJo=
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="92767086"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 04:25:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 04:25:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 29 Sep 2020 04:25:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxwN5Cxk8FylNSlzMgCpraawJ9VtnzwUN806gyqIwnFcWeAAVfe8+9SEODEcj+DIKcTUF7WynvjHA40B0JAuIvYrFnng2TSoI9kv6XQOVjAbw8OCK7EKiAL4nVuIAu2muRJsjmfXIX2BU1Wt0doGU2pWtj89yQyvWfnqWBPpaN9iy17ZTGLnYYm9/kGI+VVzk8XhaATkgtrAQcku0I6xfYbGFZ5EodZshTP7cPL/eCyv/IFOJtbQ+qVI/RfbInb6YpgV6b3G5Aous5VG8xvm+7AIMLLv/35Wfs1Ll38NF06mfQlAsIF4VDdNgkiodfJxUDJsKYLfBiBvKMy9N2SINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2diZ9vY3DhB3YIh7xEodFh2NZ4a3r4j+K8pi+DiPNg=;
 b=EinA0MDr9VcyWKK3zpCEUcMby8xikc7O31YZkpHdTEkYnmo0cMOLLIW8pzirlPVayq1ob3mzMeNH8MrXTZB6bhPoHR/C3r72I6rfqEbb8EjhH5KM1zpdInFK56OMk5ZMH+mjybi3LZLuEif6NDB6i9OcntLRj+XEtMD56gjt4YUPdBN3sV3enrtSeSzq7So5rJNVeMangIq+4gYF18xG4SBY2XiK8l3C8/nnVT4zxIKgV1wjqV8GhLNw51bNH7L1Ua2lwSHSU4IKoOIy5YMo5hcrv0ZebT7rx1TBdGhjwOWGzS/L9VY4uobudWvtP85GKoFpkNutQmuxYxiqxUGMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2diZ9vY3DhB3YIh7xEodFh2NZ4a3r4j+K8pi+DiPNg=;
 b=KOGJjhNPsy39gJpq8I1+STpCa+LTbngF6QLOVQmNag3OOz8tBZWqgLnhxLswaCCTH8K4rhA3jjNULS/XXcW7hKxPwy7GWpMOSvKnTxw/bXfKSc46teZCzYA6/qiQltcOUcCqBi40okv11GKuQ1TlXsIKOhh96yrLXgtdGeBqTc8=
Received: from DM6PR11MB4283.namprd11.prod.outlook.com (2603:10b6:5:206::32)
 by DM6PR11MB3868.namprd11.prod.outlook.com (2603:10b6:5:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 11:25:56 +0000
Received: from DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::e97c:9647:f0c8:e603]) by DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::e97c:9647:f0c8:e603%5]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 11:25:56 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <geert@linux-m68k.org>,
        <manivannan.sadhasivam@linaro.org>, <o.rempel@pengutronix.de>
CC:     <wg@grandegger.com>, <robh+dt@kernel.org>,
        <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dev.kurt@vandijck-laurijssen.be>
Subject: RE: [PATCH 2/6] dt-bindings: can: mcp25xxfd: document device tree
 bindings
Thread-Topic: [PATCH 2/6] dt-bindings: can: mcp25xxfd: document device tree
 bindings
Thread-Index: AQHWh7qHzwbkY+uxckSZ1SssJeansKl/e10AgAAFjQCAABY4wA==
Date:   Tue, 29 Sep 2020 11:25:56 +0000
Message-ID: <DM6PR11MB4283A6A532ED88F7D1058A8BFB320@DM6PR11MB4283.namprd11.prod.outlook.com>
References: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
 <20200910133806.25077-3-manivannan.sadhasivam@linaro.org>
 <CAMuHMdVkwGjr6dJuMyhQNqFoJqbh6Ec5V2b5LenCshwpM2SDsQ@mail.gmail.com>
 <cbfa3fdb-bcfd-cca5-fcf5-95a78da0447d@pengutronix.de>
In-Reply-To: <cbfa3fdb-bcfd-cca5-fcf5-95a78da0447d@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [93.241.63.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d61fecd1-7ae4-4043-0f2c-08d8646a6f22
x-ms-traffictypediagnostic: DM6PR11MB3868:
x-microsoft-antispam-prvs: <DM6PR11MB386825C8492649503875A346FB320@DM6PR11MB3868.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lBOdafeqklu/i/M+cJJNGT/Ej2rUaDeB3KIwK0LDop4sbvoqP7+BTHuiAjyAXSS/BV5nFiY66CYT1xl3n89a9RAZ/jss2OHu1ojci1ji2xfbqYQgkj4GGslIyVA3sLsnlVtykWogDsGZJac47Xb0bGs5BylMRzE2mMl4WMoCZByBaNHsSI+xYe/61pB0TRZDPHZOa3jUIePOnPvxFrESQZ55dVO9XkHWwuQC0lseruC7Pj8IBFXPll8edod5Jti8jxBAoE5bw+1hd+8UFyxudXNnsPjP+6bmY9+FtuQcHEbsgw3f7OlREtAlSNUEQMPFrzD0EQYJ6DCuwE7KE+VZ8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(376002)(366004)(66476007)(66946007)(66556008)(64756008)(66446008)(55016002)(6506007)(26005)(71200400001)(86362001)(76116006)(4326008)(8676002)(7416002)(5660300002)(186003)(52536014)(4744005)(33656002)(7696005)(2906002)(54906003)(110136005)(8936002)(478600001)(316002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SQScqTG6XFSfNsucuH7NsUemqOw+EYpnqiaJrt6KNg0rB2+uuMxM6tMKjn0+uKKt10Igbbh6eqL7WdM0AX6a9XrJoCrkG81XNgDYRfmkMb5G5QH0/6xGETXTk3XFDhjPt3Jxrq/hAs9e1kxmstLZQoCFih4b4PIkd7wRUHCpVQmojCdOhrA9F+VIOTjjznnYGOKS3kfE6OdijlApAFfr8NCSPGFERJmLxsTDk0YOxLSTib3R5K3LLHTDRzBFbv8mUszWgKXxC8aHwRYAt1GvEbgYkl/N8EkHyJMb+rew2JkGzCqkRcg6CXh7JQSWJsD4XYLd0VsXOuMQfT7ieFPoJ8bWFi4zIrJU7rVakF59cv2KdnzrMdUfDdDXW5ZXEG+Yhkx98TIHsz/UooXuprP/shCX7zX/DW1JkK/A8ZAr5tyEvKVC1XUm8utubx9flTB1Zk+iMMfibQJTTR+B7//m3XptkCmf4vQNVdlqxt5AoBNkKyAAdXId4Wng5nmmpjGXk+kaxPfr4vjW4kw6EO34GchClNNfaooy+UXnz5xU+zyTH9bPS0HmYDDH56scF/VvMbfUQ8F4r43Xzn41kqUdre0v8SGSNdtDwp2DVH1Hr+GiF859WxH3sVWU6Hne+Xo9LEb+qMyV4SAD7osx1j7dSQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61fecd1-7ae4-4043-0f2c-08d8646a6f22
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 11:25:56.5070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HV/GzYwT/nZgU6BYBNKOemWO058ctGh979C9jv9kz4IBEmgYFio6nhL/0PKodjyTdkv1FdOKFSPOYiy/PgVVZR/5tX/EB/fD0tHzIg6dMOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3868
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBTbyBmYXIgaW4gdGhhdCBuYW1lIHNwYWNlIHRoZXJlIGFyZSB0aGUgbWNwMjUxMCwgbWNwMjUx
NSBhbmQgbWNwMjU2MjUuDQo+IEZyb20gdGhlDQo+IFNXIHBvaW50IG9mIHZpZXcgdGhlIDI1MTUg
YW5kIDI1NjI1IGFyZSBpZGVudGljYWwgd2hpbGUgYmVpbmcgY29tcGF0aWJsZQ0KPiB0byB0aGUN
Cj4gbWNwMjUxMCBidXQgb2ZmZXIgbW9yZSBmZWF0dXJlcy4gVGhlcmUncyBhIHNpbmdsZSBkcnZl
ciAobWNwMjUxeCkgZm9yDQo+IHRoZXNlLg0KPiBUaGVzZSBjaGlwcyBpbXBsZW1lbnQgdGhlIENB
Ti0yLjAgc3RhbmRhcmQuDQo+IA0KPiBSZWdhcmRpbmcgdGhlIG1jcDI1MTdmZCBhbmQgbWNwMjUx
OGZkLCB0aGUgImZkIiBpbiB0aGUgbmFtZSByZWZlcmVuY2VzDQo+IHRoZQ0KPiBDQU4tRkQgc3Rh
bmRhcmQgKHN1Y2Nlc3NvciB0byBDQU4tMi4wKS4NCj4gDQo+IE1heWJlIFRob21hcyBLb3BwIChD
YydlZCkgZnJvbSBNaWNyb2NoaXAgY2FuIHNheSBzb21ldGhpbmcgdG8gdGhpcy4NCj4gDQo+IFdl
IGNhbiByZW5hbWUgdGhlIGNvbXBhdGlibGUgdG8gbWNwMjUxeGZkIHRvIG1ha2UgaXQgbW9yZSBz
cGVjaWZpYy4NCkkgYWdyZWUgdGhhdCBtY3AyNTF4ZmQgd291bGQgYmUgYSBnb29kIGZpdC4gV2Ug
YWxyZWFkeSBoYXZlICh0aGVvcmV0aWNhbCkNCmNvbmZsaWN0cyBmb3IgdGhlIHh4IGluIHRoZSBu
YW1lc3BhY2UgZS5nLiB0aGUgTUNQMjU0MkZEIHdoaWNoIGlzIGEgDQp0cmFuc2NlaXZlciB3aXRo
b3V0IGFueSBjb250cm9sbGVyIGZ1bmN0aW9uYWxpdHkuDQoNCkFsdGhvdWdoIGhhcmQgdG8gZ3Vh
cmFudGVlIEkgdGhpbmsgaXQncyBmYWlyIHRvIGFzc3VtZSB0aGF0IG5vIE1DUDI1MXhGRCANCndp
bGwgYmUgcmVsZWFzZWQgdGhhdCBpcyBpbmNvbXBhdGlibGUuDQoNClRob21hcw0K
