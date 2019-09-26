Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86846BEDCD
	for <lists+linux-can@lfdr.de>; Thu, 26 Sep 2019 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfIZIug (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 26 Sep 2019 04:50:36 -0400
Received: from mail-eopbgr70132.outbound.protection.outlook.com ([40.107.7.132]:43671
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbfIZIug (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 26 Sep 2019 04:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMTsG3VzCp+4/7ngUT0vYmFbxurAeSb2JmYWVFWVO2tL2gIx6QUZ5vYrZsVCe85iPlMnt3ZdWWNZ/scel+G6RoARp6MS4wRhUqNGQytO5XMKNrCOzDltri6V6hKHVglvv33vzAM/K8U3lzQz0DQ+libOmcvpmNDTYohuIdKfjh23tNvC81hVnlIpjXlanJRzCrHDBD4ai4vvVe91L7nKGAPWyyKMI5onGcLvqtu+pK6gyDajGlEDRimBwWSn3fS+DNihTgXT/o7IhnEGVSd3H3w/fJWs69G+RLm6PJ/P8kyWSGwEI/V23V75Jl0qFvMaq3wBiE1f6PoNS6LR8Mx8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOkRF3zXHiCNqFMho479MaOEtLG0gWNw7VxMmmAwSPA=;
 b=J32m7+HQVSGWhszZiYKzbRSZCF6CE30yT+BAURO8v0fNTmmxxcdYzV8/0DZVzSdGD3XqLVxLPA3ATPA2ESOK8/F8ypKuXfc8LzfnQEqru27dYWUhQ3xEGtTXKS6FDgaZzkYYijOEYeE7qvWX+uSaiS51Q8I3qAKJFOQi/bLbwJ1QWLdntp7LErwXGYFj9fu1yZAAXVI3bFAT/fy6IW/YJRYK3R+IF5mxpmW7Av31unTUjnz/4ocLQi+M7x4LdRYSNyWTXgC0gUe9xjqq59TbDWIA0mBIT9OgCqSl0DmtXBOT7Yj9k4BXvydcHz2BUyrwSP133UgmNyS/3VRJ6GCWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOkRF3zXHiCNqFMho479MaOEtLG0gWNw7VxMmmAwSPA=;
 b=OeApSh/3cpQ1oyEPzn9df7M/1WjdfcVFvJnzoIRpZ8LApqBOzn2xz+D7yFtkWW/LTkituXs5RgilMwRZiltdb8IHf4H6jB4eQE2y598UlyO/sCa7dE38cxAoWFpDBvsEy/jLUzm72nnFUXQHaAd6B+EYHz/xcAKirMtKOQ5mD4w=
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com (10.173.82.19) by
 VI1PR0701MB2144.eurprd07.prod.outlook.com (10.169.137.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Thu, 26 Sep 2019 08:50:29 +0000
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::dc92:2e0d:561a:fbb1]) by VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::dc92:2e0d:561a:fbb1%8]) with mapi id 15.20.2305.017; Thu, 26 Sep 2019
 08:50:29 +0000
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH 0/2] can: CAN_C changes
Thread-Topic: [PATCH 0/2] can: CAN_C changes
Thread-Index: AQHVdEdyw85PGbrL2U6DrAktfRGFag==
Date:   Thu, 26 Sep 2019 08:50:29 +0000
Message-ID: <20190926085005.24805-1-jhofstee@victronenergy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.126.8.10]
x-clientproxiedby: AM0PR0102CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::40) To VI1PR0701MB2623.eurprd07.prod.outlook.com
 (2603:10a6:801:b::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhofstee@victronenergy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a95d530-d37f-4d34-36b8-08d7425e94f5
x-ms-traffictypediagnostic: VI1PR0701MB2144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0701MB21447FA09EEF413F736E19C4C0860@VI1PR0701MB2144.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(396003)(39850400004)(136003)(346002)(199004)(189003)(14444005)(50226002)(99286004)(8676002)(81166006)(81156014)(52116002)(2906002)(14454004)(186003)(8936002)(478600001)(6512007)(5640700003)(6486002)(6436002)(107886003)(66066001)(2351001)(102836004)(26005)(25786009)(1076003)(4326008)(2616005)(386003)(6506007)(486006)(86362001)(316002)(2501003)(5660300002)(305945005)(71200400001)(7736002)(71190400001)(3846002)(66476007)(6916009)(66556008)(64756008)(66446008)(66946007)(476003)(256004)(36756003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB2144;H:VI1PR0701MB2623.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: victronenergy.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TrDu3SQ5SrTneX2t6moEScYZ+Dcht1WLudXXG8D2SRAsT3mH5PixMxKSvx9k65eVY1yMkHNoX8wiFnoqufn2w4iANiunbbSl7NJNwJlGsBt9enZbNDJ1ntwbEFqTI717n4M2fCAA78QE6twp3+svHFfBb6zyI9wGKvj2mDfHbqHjgal0lDdp5EpebgDJeSc8/VzYl+O44wCaa4bPgD8gCD/STwkA6MFsVT0W2/o6Sd1L4jeLhl7fH3vwmPTzoRYkK3oLgmB1DdOwRb/nD/QP72Io1dAeiATK72SSczBgwrvQGFociKLKkuEQpCfz63LY/Vol7MNkcH0m7qiktOs9McK/mCQDdV0qGEcu3KqSntmp2Pe8ZsMZp8nFtz5v40Gt5X/+xFpvXo/WmS3C8UVkx2Hsc+FK795m5A/LjtajVAg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a95d530-d37f-4d34-36b8-08d7425e94f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 08:50:29.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADqMNWzKtbCRDw+3Gf/+VtijSFR0YZredVeEPRr2Udgf18jwhZy2+oXSPe2nMGXK1MJQ1JDU80NIRLDkHNI8Q3ojkcQtN41EDZZlZG0BU/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2144
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This includes two patches for the C_CAN. The first one is D_CAN
specific though. The state issue is easily reproducable, with
nothing connected to the CAN-bus, do:

ip link set can0 up type can bitrate 250000
cansend can0 123#1122334455667788
ifconfig can0 down
ifconfig can0 up
ip -details link show can0

2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEF=
AULT group default qlen 10
    link/can  promiscuity 0 minmtu 0 maxmtu 0
    can state ERROR-ACTIVE (berr-counter tx 128 rx 0) restart-ms 0
      bitrate 250000 sample-point 0.875
      tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
      c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
      clock 24000000numtxqueues 1 gso_max_size 65536 gso_max_segs 65535

And then the interface reports it is error active, while the
error counters reveal it is actually error passive.

After this patch it is:
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEF=
AULT group default qlen 10
    link/can  promiscuity 0 minmtu 0 maxmtu 0=20
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0=20
	  bitrate 250000 sample-point 0.875
	  tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
	  c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
	  clock 24000000numtxqueues 1 gso_max_size 65536 gso_max_segs 65535

The other patch adds events when the state is going down and goes through
error warning again when the bus recovers.

Jeroen Hofstee (2):
  can: D_CAN: perform a sofware reset on open
  can: C_CAN: add bus recovery events

 drivers/net/can/c_can/c_can.c | 46 +++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

--=20
2.17.1

