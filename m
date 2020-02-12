Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8750215A57B
	for <lists+linux-can@lfdr.de>; Wed, 12 Feb 2020 10:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgBLJ7U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 12 Feb 2020 04:59:20 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:45058 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgBLJ7U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 12 Feb 2020 04:59:20 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Thomas.Kopp@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="Thomas.Kopp@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Thomas.Kopp@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Bn5w0LPnQ3DN8i+39M9EPrigZqbWz9dA3vpxIiHtSyunwFKhJ86iTD6Kcxf//mBqFJodzMmJcv
 mAEKzKZ3ar8aGDHzxDHj+KJ3B6vznTML6Zjt4vNKCeez9R0U3bMUi8VRJviRhCp1twDf+8Bxdz
 seK2OVxa1s9lm8EXUH0gQlFGZKXpG0nISz3pFPFXh/bBmILS0PGYsCMxEqcO6upu/SQpfdoQ7h
 inUp8gYV/kBrM8KZylvlbowxK4d6hRGEI/1TMCTeFpr+QGZz0bAS02rEpZYmkLY1bt33YG64bp
 uYU=
X-IronPort-AV: E=Sophos;i="5.70,428,1574146800"; 
   d="scan'208";a="65124206"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Feb 2020 02:59:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 12 Feb 2020 02:59:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 12 Feb 2020 02:59:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdQma99aiyBwiqmeURlEHonK/ITjbMM5KMsk0H/+ZJo4JeCRMVlxs3vKuB5EnbO+RhKPePOQASFKtII0/fzJ95B0/1YPssXCD+uuy79/3HLLiuRp0qO/xMlEE0u27SMXBa0cEAmnWf9J8lOhsrmfq6qjB0SXhGsaJKv1SEbOaIYfazOgfE2J7XfuXT2qFvcAcRNSvEBqcDhTe598iQ8Qq9g9rhIDobo8CJtHABM20mHPSDiRpXF54LJLQRxgQBkKCpSlesc84sSPEte38dhCE25bVa/h8RUUkC6Zj1AkMIafRM5Zmghf/Pi7HUnQX1/1+nAYRNUUdvUp98Py5EIsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgtAfhnA7TCSIFvMfJaQr8yYXSfT/benFTsItLrDfTo=;
 b=LhUCxwhAURTfkDQfQulAzvKhhNLK/I6Y+W9UOYXzSNRPgnvsmPhR7wvD+kPUcU9csgpaHGcknbWQ2TSdI1mTR1vZOUShjpWCkNspF6zc9DTD8VAqdPd592q9sWNqpYOCTFzFBIBTH3AQu8S/tA6jOWHLNB0rZZrgtwt13mE+JUOAIqPdPPqrKpa9H7rPVCGNDNjMa9S3N2gQkPhaGuzvIe0lBGmmSUflzAUIcs0RpkdGC1cIc9MCkj4e1wdInIybp4P1rsVK5j/U1OHWqwJB60ank3UFIf/u4kazTn4WhvvoRWGYPr6fSewtGTxhSvMMI9DB2p8wHfco5AFZ93rTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgtAfhnA7TCSIFvMfJaQr8yYXSfT/benFTsItLrDfTo=;
 b=m3/520lvgFwuOjkuXsNmf+9OK7aNU/5s+rU8KbPnWOUCXV54xjJHj+WPOt0SXIVepAv9T4Dww3Nom2f5ipZ7NdA6uPr6ZxEk/TJ3sxqO6+dOt+etl/Hr+Yn3Ey87NhfSFqFHnn+giRIOOEIJUkXw83pCy2E425/+tDbQaARJhcw=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (20.178.254.13) by
 MN2PR11MB3662.namprd11.prod.outlook.com (20.178.251.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Wed, 12 Feb 2020 09:59:17 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::98d2:cf68:f0fc:501c]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::98d2:cf68:f0fc:501c%7]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 09:59:17 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
Subject: RE: mcp25xxfd: missing cerrif
Thread-Topic: mcp25xxfd: missing cerrif
Thread-Index: AQHV4NpbFcBokjWjJkKD+9lAnrPjz6gV/F+wgAAGqgCAAUzHcA==
Date:   Wed, 12 Feb 2020 09:59:17 +0000
Message-ID: <MN2PR11MB36458E1696285A0196B6E46FFB1B0@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <a933c5be-c95f-36d5-57ce-c312fbaa81db@pengutronix.de>
 <MN2PR11MB36450B9C2BE91F6CBA897002FB180@MN2PR11MB3645.namprd11.prod.outlook.com>
 <532b4fed-a984-0875-d933-43c6a90fcc1a@pengutronix.de>
In-Reply-To: <532b4fed-a984-0875-d933-43c6a90fcc1a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [93.241.63.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d66b201-2042-4ca0-3d62-08d7afa2392a
x-ms-traffictypediagnostic: MN2PR11MB3662:
x-microsoft-antispam-prvs: <MN2PR11MB36624EDB35F36BD917774457FB1B0@MN2PR11MB3662.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(396003)(346002)(199004)(189003)(6506007)(26005)(186003)(55016002)(2906002)(9686003)(316002)(110136005)(4744005)(5660300002)(7696005)(81156014)(66946007)(52536014)(33656002)(8936002)(8676002)(71200400001)(86362001)(76116006)(66446008)(66556008)(66476007)(64756008)(478600001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3662;H:MN2PR11MB3645.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /roeS4guqNik+ybu1LNkE1iJrfYmpQSENYVpRcXIGaE47U8hcJBK+Xrl0Pt344NkE9z+w4sMa1MEjxWCdh24ja43sXHJtOyRk7HOCHItEkXi6zbB4TgiftYZVQ73cgHkzMDSyk6z0FM8qRq3AgFIYfGsjHDWiTZme91GIPvqc9xK7IxeRGg1zQg1j/PbTH+HYJeubWhtsmBnvW+vz1i9YmqGq92W+et3F7MLLaVXmoAw7KvC5VAkgYIM/+D1HchR1dvhpmU53RyZpPphYnEPfHtqBGaw5SnHhY1xT/XfiV7eSUP+4VcabOBMRrHGCNC41ITzXOqwZrPU8mkYjVEq29+QESrIQ/wn90ixcwXV3Q5f88Ckf65vNWpQHptTBMEx2Ro8sjhUw3ztsm9t/N1SrWWvv/6dcQnJaJlDdUtjhyeOt8Mc9mLGfh1+Aa0pipkg
x-ms-exchange-antispam-messagedata: zr/zXtb/ia2mifaCVFpHWuX0fNvahn3AgugW6I2C7zBrgxfUgXCakVUfbZ0Hor7PaJSMuxq5ZC+OhZngFATY9i90/K6bGrCFwqm/i93xc8pVBox61IEc0NlwN8nLpy+dU+DdAndPvvt1sfpWGvdDMQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d66b201-2042-4ca0-3d62-08d7afa2392a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 09:59:17.2738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMhqvaml9phcJelS5nm1KgKKsshYaDo38Q2zzIwrSK6lH9UldGTbI224UEQAyMPDTMre2Q6RF2e3r1sJKDhEOG7CE7805LZ1mvrD44uQ7Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3662
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBPbiB0aGUgdHJhbnNpdGlvbiBmcm9tICJUWCBFUlJPUl9XQVJOSU5HIC0+IFRYIEVSUk9SX0FD
VElWRSIgdGhlDQo+IENFUlJJRg0KPiBpcyBub3Qgc2V0Lg0KDQpNaG0sIGRvIEkgbWlzdW5kZXJz
dGFuZCB5b3VyIHBvaW50IGhlcmU/IFRoZSBUcmFuc2l0aW9uIFRYIEVSUk9SX1dBUk5JTkcgLT4g
VFggRVJST1JfQUNUSVZFIGlzbid0IGNvdmVyZWQgYnkgdGhlIENFUlJJRiBpbnRlcnJ1cHQgKHdo
aWNoIG1hdGNoZXMgdGhlIGRvY3VtZW50YXRpb24pLiBUaGUgaW50ZXJydXB0IGJpdCBnZXRzIHNl
dCBvbiBFUlJPUl9QYXNzaXZlIHRvIEVSUk9SX0FDVElWRSAoVEVDL1JFQyBnb2VzIGZyb20gMTI4
IHRvIDEyNykuIEF0IHRoYXQgdHJhbnNpdGlvbiBJIGRvIHNlZSB0aGUgQ0VSUklGIGJpdC4gSXQg
aXMgY29ycmVjdCBhbmQgaW50ZW5kZWQgKHRob3VnaCBtYXliZSBub3QgMTAwJSBpbnR1aXRpdmUp
IHRoYXQgZ29pbmcgZnJvbSBFUlJPUl9XQVJOSU5HIHRvIEVSUk9SX0FDVElWRSBURUMvUkVDIDk2
IHRvIDk1IENFUlJJRiBpcyBOT1QgYmVpbmcgc2V0Lg0KDQpCZXN0IFJlZ2FyZHMsDQpUaG9tYXMN
Cg==
