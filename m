Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5ECE701D7
	for <lists+linux-can@lfdr.de>; Mon, 22 Jul 2019 16:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfGVOEy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Jul 2019 10:04:54 -0400
Received: from mail-eopbgr80092.outbound.protection.outlook.com ([40.107.8.92]:52215
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728103AbfGVOEy (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 22 Jul 2019 10:04:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud5JWfGli3NPzr0KPul6Y/FNA9JgdI8vfQbw4uaWJ6U/Nnufhs2xrZL78qotrTg3IXkNCU53TAYjG6ngLqu6i4LrqXimS1FAvu5HORvryxTL9NIjh50Xi8jQ6eg+FXok++iIk4/akWmzgGHTCXUEqw24ZYvNo873vHxb3XFCdVIWrjBy8gVfZ6CEqz480Bcz+EBe2NS1hjKqDkYxgY8+cJKfcR6MgaYipwR427xKupUAm1yweCXcNlsq8uiJ+Da/wPeEWWCmzdXjcxGH3m4MKeX68ySD8cosfvtV5m5DyxUp3xtmiM7vli6NM00ZxIGJxyYUuXUHrZkZheFveLoTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHKspdx+I8ZD1HDDkmUUY9AEkfoPmAJos4U80EZgu8s=;
 b=hwZhrVq8ZyUCydv5slVtARblDIRpaqtGXI5PIhcNJI8O5uNuk5E3m4pCSj8wyNHVKygcr9ti0eRchcE4/nn/Gog0GKTLr9vyR4/d458+jAZhs97O55jR1fO8+mFsj/SKK+IkP/uMNfy+lekW3eJ5nrVwpXcHrmkOwI7PqmV8X6QrJIqZ8aKFO9loWtm+QS52ijz7h3zJfCM8kvEJJGtk/Ubn+U4TRAcuBm/Cx1ekLdq9kDw49vUu/M+dfIPzlD8xXroufThGAKr1MMPY3QkcyJD7OiKur7nIIw2tI98gp6n1TiMvck2jzOlB/4qKCvHAtUD4e/x2EZTninZpFu/evQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=prevas.se;dmarc=pass action=none
 header.from=prevas.dk;dkim=pass header.d=prevas.dk;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHKspdx+I8ZD1HDDkmUUY9AEkfoPmAJos4U80EZgu8s=;
 b=JlbZHX8+pIQmJEDpzzY4uWJ0vMYwJBUxd6ITh51qfAa4QRmK9pM0j/1k+riTCcMACIsWbM1EK3qlhGcARwBXEk4N2A5ipjSx039qRfetVE1hycEtx87OlWLy0KP3TycxszyJvm0DsS1v1PUunDRR9h3ObKzbh5qym24IoM536jY=
Received: from AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM (10.186.175.83) by
 AM0PR10MB3091.EURPRD10.PROD.OUTLOOK.COM (10.255.31.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 14:04:50 +0000
Received: from AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9451:861a:85cc:daa0]) by AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9451:861a:85cc:daa0%2]) with mapi id 15.20.2094.017; Mon, 22 Jul 2019
 14:04:50 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH v2] can: dev: call netif_carrier_off() in register_candev()
Thread-Topic: [PATCH v2] can: dev: call netif_carrier_off() in
 register_candev()
Thread-Index: AQHVQJZtC69p4g+Gi0ut/NKwJq5HBA==
Date:   Mon, 22 Jul 2019 14:04:50 +0000
Message-ID: <20190722140429.19782-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0051.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::28) To AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:15e::19)
x-mailer: git-send-email 2.20.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b78c812-ebcb-4073-ca5a-08d70ead8f77
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR10MB3091;
x-ms-traffictypediagnostic: AM0PR10MB3091:
x-microsoft-antispam-prvs: <AM0PR10MB3091BDE89252AE3224CD097D8AC40@AM0PR10MB3091.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(2616005)(8676002)(66066001)(476003)(5660300002)(36756003)(53936002)(305945005)(42882007)(508600001)(26005)(186003)(6512007)(7736002)(25786009)(52116002)(6436002)(14454004)(386003)(102836004)(6486002)(6506007)(68736007)(4326008)(316002)(486006)(71190400001)(66446008)(66556008)(66476007)(66946007)(256004)(99286004)(1076003)(44832011)(64756008)(71200400001)(2906002)(81156014)(81166006)(50226002)(4744005)(110136005)(54906003)(8936002)(3846002)(6116002)(8976002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR10MB3091;H:AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RFkUEqEMaqRrhLMeaGCMo3Ncu2H89pGuoUmEUjfN1E3FwxnUY68XZ4tqelgpqLfzj7LDhO3ASnTj7slOMOqCpQRwdS12f0bv/5nhPaGMECKCktDjOqQRsjfUJHUejJVVUphf1BX324E1tHZFUfUw7sBsFUcATRkVXhk1k7brGeyIW1FqJa32DhiXYM4JAhtbCeveDQr/GwjMj5Vi9oMLQ/1FPVcOB/dhT/wLCEKnQU0UEeQZujfMVT6QQa7gtbA9TTfn9ccR+4P7HNN7rDmSMGozJ+zXTATyccJxwHOODGoeOBDwAzcHyvwHsyp041bBDaDvYOPGTYByOz7PmLppM4MBLyiHUb7d7kfsHizMkfK1V2LXkoqnsFJvBG4D0pCpCJH4yIU50qvQB2aLhk3xnDJP8TRcIqJhTUXs4nu/I4M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b78c812-ebcb-4073-ca5a-08d70ead8f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 14:04:50.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rasmus.Villemoes@prevas.dk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3091
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

CONFIG_CAN_LEDS is deprecated. When trying to use the generic netdev
trigger as suggested, there's a small inconsistency with the link
property: The LED is on initially, stays on when the device is brought
up, and then turns off (as expected) when the device is brought down.

Make sure the LED always reflects the state of the CAN device.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Acked-by: Willem de Bruijn <willemb@google.com>
---
v2: resending with proper subject (no net-next) and Willem's ack.

 drivers/net/can/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c05e4d50d43d..fad27ace6248 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -1260,6 +1260,7 @@ int register_candev(struct net_device *dev)
 		return -EINVAL;
=20
 	dev->rtnl_link_ops =3D &can_link_ops;
+	netif_carrier_off(dev);
 	return register_netdev(dev);
 }
 EXPORT_SYMBOL_GPL(register_candev);
--=20
2.20.1

