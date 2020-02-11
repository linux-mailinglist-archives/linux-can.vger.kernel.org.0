Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48963158FF4
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2020 14:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgBKNbt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Feb 2020 08:31:49 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:51362 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgBKNbs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2020 08:31:48 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Thomas.Kopp@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="Thomas.Kopp@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Thomas.Kopp@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: i09GBB39KHw3ZIKODzyNwJbX+opPbQCRNTpHTZVUIqVCMPvDgxHSzzG1BcQkUi6BQZMTAxmZiY
 PgMxIS0ttje6IuKqGN++CF0mJuClhMs+nBLJa3YrVMiHkpOvvy1QoxeS++F5q2oM0vPdD8nPXm
 zOPuYhcfVf1w3QgQ1GzC1NIzYKP72lf/Jn6Ex3hU8LcshGK+A/4HYIGcjxQzk65MfOyMUQMCp5
 EAqtl+UYkqCBvJrvMisijey6sJG3MERm96ARutwg7c8Mtpjyo6t40rHhR2vytCRSZikOrTbSa5
 z3w=
X-IronPort-AV: E=Sophos;i="5.70,428,1574146800"; 
   d="scan'208";a="68037096"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2020 06:31:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Feb 2020 06:31:47 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 11 Feb 2020 06:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLibukrWzS5/H+WhipKD5gKyhvSkK5LFqzveAXPD+Vl18DYEuIiHqTR19Gir5f271IcSIzof3X7tkpNYgV+zSUUAJ05iByVRU7nonGGY8BcFTFCZXtqEvwE44wpga50Y207zAn9Mr/u1RyUD0zYn9lBcIatWWSOap/M36+/evZzFruY8HbP+1kDlKZWdwoc0Rddp1dK+W28bF2xOeZqrSu44ePhGRFHA4USN38JskdzjS43oGvOtns5SkkI+Xv5nhtD1PR3i823CHLpElokhRNZwt34+j1nqPHEVZD/xEUlxUyFWFLCl22ltr7MwVqWK5loa+H62BpCsWWhkok0Wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdDhCWF8WbhjOOpb5UB2OsuJjSTeVXogWqBtWdNl7PU=;
 b=UxIEJ7aDFK0a/sfnqBCWRnj1UPN8ghr9sbkyBSu3x8b1u5o8wIryUF7OrtsUhKu7lHlkhi+9pzcV77wlxaK0vEm6nL8AvjrsSENbV++kob8BatKU7tTXBX6RGaOYe+Fq5nKEDLE3BWPR6KQXh/xBJFeJNC+Crhaz6B9+06LBjdmVt5YMM7ZoY5Ws8DXjZSAv3/XcoGtlZ75MThlCr65HmgXXu3EPHc3m0WnFGoT8MwTT1erAGnolo2r3hvOpBWGUZ+yxM1Qww6GB3De8/+jhwHIQuw+1hTF0zf7i3k7cqWuCQ7XpHLZjiq1NYdNO4fEGt9PtGSnl355P4kphfACkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdDhCWF8WbhjOOpb5UB2OsuJjSTeVXogWqBtWdNl7PU=;
 b=c8+4u2flp3gvBJuGyWvk1FnhOPPxmeWApS/fHZFDnLMaU8MXjq8KUJQUaJDAxta+V5Yr1WOfCAy2v6C2wpnTLUPuCmMbxmgRJlzbhlEybQDVbnDzzXKUCFgVt+FapP4JLuXv+6vUaA1q22pF27Ptyl+E+q79hXErIxITTS0S3M0=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (20.178.254.13) by
 MN2PR11MB3616.namprd11.prod.outlook.com (20.178.251.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 13:31:45 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::98d2:cf68:f0fc:501c]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::98d2:cf68:f0fc:501c%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 13:31:45 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
Subject: RE: mcp25xxfd: missing cerrif
Thread-Topic: mcp25xxfd: missing cerrif
Thread-Index: AQHV4NpbFcBokjWjJkKD+9lAnrPjz6gV/F+w
Date:   Tue, 11 Feb 2020 13:31:44 +0000
Message-ID: <MN2PR11MB36450B9C2BE91F6CBA897002FB180@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <a933c5be-c95f-36d5-57ce-c312fbaa81db@pengutronix.de>
In-Reply-To: <a933c5be-c95f-36d5-57ce-c312fbaa81db@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [93.241.63.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8381a58-6c88-4fa6-76dc-08d7aef6bce2
x-ms-traffictypediagnostic: MN2PR11MB3616:
x-microsoft-antispam-prvs: <MN2PR11MB36165910A61496D662FD72ECFB180@MN2PR11MB3616.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(199004)(52536014)(66946007)(478600001)(66446008)(64756008)(66556008)(66476007)(6506007)(26005)(76116006)(186003)(316002)(5660300002)(71200400001)(7696005)(4744005)(55016002)(9686003)(110136005)(33656002)(8936002)(2906002)(81156014)(81166006)(8676002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3616;H:MN2PR11MB3645.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JPnA6nxKsSI8VtZU2/F9CIo6c4bw0BUTKXJ7an4wo+NHKO+PgEWb/XPy8N32RxI+bJ//IqJjSgk1QKAIZ+IP5/TtemK9bENRzhusT8DkJ2BrXUh5RWmYjaiyLl57p9PCUudkA7tJURS2xSw+5BQbaIhxn2leQbqrAdDi8AX8yu2yva/eKfnrfSpYgKiAPbHpI7KPSjI28+93be+8yz17A1tEGso+pBy1VUVXFnoUdIriB979zjbOmTqZwHVaUiDyebptO6+NACdCt11gMt57h+ZoVHSt+mBIcUPPyjTyPIZ9qL8wXR0raQFyLLV/TaamTujF8YL/HzTwapJzULzGfw5zG7nls+3DznGW8MRRyElWcVDMhe8njGaBFZ1fIbFxI4XKBj7bcYo2Kk8zkqrEdzcFDL1NSSbeK29yxqV62kY5Gaz7P9VdFmikPj7PVfzm
x-ms-exchange-antispam-messagedata: GGJTDozLkLhjEo5vwrDZKWlFxP1E69MXi4tE0ac8vVewcL7dB6mECRpC13dKoajsqR2m1z0eCwsR71/7dE2me3f+ap3sn269C67sGXSGAYrFqdZbJmhGZEOZmdBbjFAr9bPDHXrLVDVDSMaR5PEM2Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d8381a58-6c88-4fa6-76dc-08d7aef6bce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 13:31:44.8781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0mwEUdmM5wSTyV2mxebg9ndgdIXx2MD4alCyL6ql4L1exUTG8QwCkx98An6GwPpyt1g44j769BG8jjCo1bvHj3n/VY77Ne6g1mRSA89lHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3616
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgTWFyYywNCg0KPiBJIGRvbid0IHNlZSB0aGlzIGludGVycnVwdCwgbmVpdGhlciBvbiB0aGUg
bWNwMjUxN2ZkIG5vciBvbiB0aGUNCj4gbWNwMjUxOGZkIHJldjAuMC4NCg0KV2hhdCBkbyB5b3Ug
bWVhbiB5b3UgZG9uJ3Qgc2VlIHRoZSBpbnRlcnJ1cHQ/IEkganVzdCBkaWQgYSBxdWljayB0ZXN0
IChub24gbGludXggZW52aXJvbm1lbnQgYnV0IHdpdGggb3VyIHRlc3QgYm9hcmQgYW5kIEkgZG8g
c2VlIENFUlJJRiBiZWluZyBzZXQgYW5kIGl0J3MgcG9zc2libGUgdG8gY2xlYXIgdmlhIFNQSSku
IFdoYXQgZXhhY3RseSBhcmUgeW91IGNoZWNraW5nPw0KDQpCZXN0IFJlZ2FyZHMsDQpUaG9tYXMN
Cg==
