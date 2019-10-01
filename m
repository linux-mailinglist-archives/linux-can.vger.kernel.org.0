Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93316C4232
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2019 23:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJAVBT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Oct 2019 17:01:19 -0400
Received: from mail-eopbgr140109.outbound.protection.outlook.com ([40.107.14.109]:15239
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbfJAVBT (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 1 Oct 2019 17:01:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1Lb6CThIR+LsHjZRgNbMG5AgBkje4do/fJ9UL0QU0pF6LeYP7KQqcCTltymq3TMHdELRrYtXnhU6IL17pvNO5D/VTkGXPKGdritK1wqt8Bb1TIfBaUFfPUXhOOz9GOcVb7SMzoghS1z6k5WnGessqxavkpKv0BO3qxA/H48GGTpw4mopJrCQApwelFKGrW4CU0wu2E8i59n/yA8eC2ylDSXcec09fQD3niiiCxYF8iTeEwRWlhAucFThEyZm7/OA6mNr1sBxaq2SlGAGJOUZDl8SHavbcm7MwR/0+WmebJu4pcZM28/KZNo0XKLmzcrClu8RGYTA/huvUAQVin6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWbLOBYY/t0ktMjZQKe/uaVE6+Xx+fHJX4HerU+eQvc=;
 b=gy1u3BjLDXq9uMcaI/IaQmA9T0eGoVLBxcGFHR5Zk8nQxYu3wYpWIaAOurTAvQk2o+naiSgrAQVG1Iqb1K0FO+YlLIazZSzn1GmcmKKmi5sX8FFARAFwxAEI+tQwFvxUSCi0xdF51D/INRdKXlKqjRK6AelyT4UgjQj7aHvVmKZVGRp2EeNZ0wS5v13hVANjL2Gqht3zdL3VIhT9clEy2Q80sj10NTbR36kRD/Llqn0+hPG+qQjT+sLDT+DKjW31FA5teO+RGhpQBD61DtcZjsFy51HuXkMspBH2udbv1hxBl3z0m0+I0Fqar55viK7sb8nd0RqUgPxlqkjZMa78TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWbLOBYY/t0ktMjZQKe/uaVE6+Xx+fHJX4HerU+eQvc=;
 b=u2umR7FMArFZ+wYFLUqcfF2lrTaX0rBpx7qQ3yHj5vffy3D3tOv3V4i3XDH/4e2c0WVDS+5VXZv/k4FNwKud2tYzjx2uImzRG0wPyf3WyF4TCOf2si9SllINcy18Kcft6IUNU3mSf0EaEkPl/hi/xW7HlYeZ1QmChkkDIL+j9UU=
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com (10.173.82.19) by
 VI1PR0701MB2813.eurprd07.prod.outlook.com (10.173.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Tue, 1 Oct 2019 21:01:15 +0000
Received: from VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::dc92:2e0d:561a:fbb1]) by VI1PR0701MB2623.eurprd07.prod.outlook.com
 ([fe80::dc92:2e0d:561a:fbb1%8]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 21:01:14 +0000
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH v2 0/2] can: CAN_C changes
Thread-Topic: [PATCH v2 0/2] can: CAN_C changes
Thread-Index: AQHVeJtcqMb5w4t4uE2y7LYrQkKKrA==
Date:   Tue, 1 Oct 2019 21:01:14 +0000
Message-ID: <20191001210054.14588-1-jhofstee@victronenergy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:1c01:3bc5:4e00:5c2:1c3a:9351:514c]
x-clientproxiedby: AM0PR05CA0060.eurprd05.prod.outlook.com
 (2603:10a6:208:be::37) To VI1PR0701MB2623.eurprd07.prod.outlook.com
 (2603:10a6:801:b::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhofstee@victronenergy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f335d90-f5ef-4ea3-9648-08d746b27ee1
x-ms-traffictypediagnostic: VI1PR0701MB2813:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0701MB2813CB2B1C4E9EE46F51F78EC09D0@VI1PR0701MB2813.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(366004)(39850400004)(136003)(376002)(199004)(189003)(99286004)(316002)(46003)(6436002)(6486002)(386003)(6506007)(6916009)(5640700003)(186003)(102836004)(7736002)(305945005)(52116002)(86362001)(14454004)(478600001)(107886003)(4326008)(25786009)(8936002)(6512007)(81166006)(81156014)(8676002)(66446008)(66556008)(14444005)(66946007)(36756003)(2351001)(50226002)(64756008)(1076003)(66476007)(256004)(2906002)(486006)(5660300002)(476003)(2616005)(71200400001)(2501003)(6116002)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB2813;H:VI1PR0701MB2623.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: victronenergy.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dIb4R5daLDf9c16X0bAvE7+OFA3TO1LAQdmlvPihVYx3+fxu0i3S3pSWLRxixr85D5fUmMucCoQcASz5qCOMfuZHWNCdZfVXgDzSpfIhwMJOIF3W8fSjzs5o9id989P3mZvzvWVcP+u7E1UzktvXMP/YveD2WLc8QMgs/Umar/PC4c8Ja5wcMI3A+UR8wmuGwcpI145yJ+zQLwWHrgQ0Ha7FVwvMu54mx1ayuO88V2BEZv23T3b2HOnpt8+sVNTEPaRZxAZx2USWdOziJ+76Qtql1Jebfw7wur4KWsm5prO+pcElwHARfVQ2oHyZyRwQ9GfOleejaIqd0nFVgaejUZtoLTAkHl8E9w0dQNs3bFDxl8XZg7hou5CWHOPdFVXXI1aNQVfbvVCkgGwk3EQv7PN3MqMAM5rZRCyhqDWtvuA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f335d90-f5ef-4ea3-9648-08d746b27ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 21:01:14.7698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9OY2NnXGzglEyxdBnA8gkiOaYWeudIItgS/3GIXSSgEEHBVsJEyLSaBTZVSAUYkTomhlYjqwcvgACRpLsBr+5WptrxeMErbqEmUBde4fSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2813
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

v2:
  * rename the static software_reset to c_can_software_reset
  * fix typo s/update/updated in the commit description
  * add tags from Kurt Van Dijck

Jeroen Hofstee (2):
  can: D_CAN: perform a sofware reset on open
  can: C_CAN: add bus recovery events

 drivers/net/can/c_can/c_can.c | 46 +++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

--=20
2.17.1

