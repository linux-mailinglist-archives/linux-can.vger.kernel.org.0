Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8E82CEFA1
	for <lists+linux-can@lfdr.de>; Fri,  4 Dec 2020 15:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgLDORe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Dec 2020 09:17:34 -0500
Received: from mout.web.de ([212.227.17.12]:48031 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgLDORe (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 4 Dec 2020 09:17:34 -0500
X-Greylist: delayed 1168 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Dec 2020 09:17:33 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1607091342;
        bh=NE3Hh7UGu5j9Uf3U2IhfGfSQzsBZcglIXnyg/dtHqEI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=BFSLhiV6kGbDQyEWabRqSDZOTLwQnp7cj5PDdrWrw0cH8RHy92qyRinKxMnBulfrs
         1G/R3bOh/aMaLs1btgo3mNOw7uM5u2C30z9SToFrMX4jqKBwIaqADp7V+KeLK529fw
         vr/639OwpHiQBMHrCrLnTyq+JhDO5d8Dw3P8dupo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from DEV-VM-UBUNTU.fritz.box ([79.246.214.49]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MTPel-1kdEmw48l5-00SNjn; Fri, 04 Dec 2020 14:56:14 +0100
From:   Thomseeen <thwa1@web.de>
To:     socketcan@hartkopp.net, linux-can@vger.kernel.org
Cc:     Thomseeen <thwa1@web.de>
Subject: [PATCH] isotp: do not validate RX address when the broadcast flag is active
Date:   Fri,  4 Dec 2020 14:55:57 +0100
Message-Id: <20201204135557.55599-1-thwa1@web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M0IPn/eJYNa+VT6lziWP4YbOXhZ920RW3W35EwTVlN9UX8rpwn1
 /ELwp+NbMKYQfWXTM5ff04/yzCPR4o2Rate2w1P6V4AdVduIZ0tjy1OPOv2McMmXP9ZH+F1
 /lLK9c2UYGNk25Inv6cPCp2md2g7F4ZUP1ngUwWNkEBQH651tJDUKqREq2t9SmGa2zG2mzP
 ZV+ccX3FvHdU9mYG4YiIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QHf4CV43c4M=:E+nMkf8Om3bAu5+PT1jbKY
 DfKeBy+07ErTNCeeeoqEO77qO9p1mzbrnDmS3QGssHb0QlozbyiDWO3HBqv0ah1o1BFVrbhP2
 Gn9l4FBp8Ilz5JzZ0qoitr+nJ4WCLUwi3QptoPJ1M3oX35q/Rym56eh9ucTof8R7FbjWMMAwP
 LohIFM/v6DHxJIcruTARjL6mPErpuezgnHSV/SlJYe+jEawzxDMS7qzpEXo2qEoSfW+ENKIdr
 fFBkPsEDDsDvDzj/ddjBG3S1br49xwBA9aATmxcff2bZD1+Lb2uYc32n+IG4KNK6OHme3sG6j
 uHApptj2kMhrLnAYSq5FaMZ5brURhWeJGAxrvzRpvDwRVRcODuzE+3hACVkClumoE8h0MyQJ3
 SF0sjxxnmyKqslSTfOrY/uefreZV8cUw9TPH4a5SHAcKI2R/D+S1r3UFf3+CELRa0HDNVFfXq
 swPTsQZn1Dkh7Sj8npuoJIdDE/V9PvIxMMjZbTiiuz3hlKYmULRaG4exp28HA4omjG0OF6qy/
 78vVukvTPa1DOe9jzFnAKwlLCRsRq0nknV16jSwj8GOkxFa5xdn7Si/I5KjsTD/4wBzc4u61r
 SPw1kRjody51lM9EDyuV3H/2LRn3LDUyF87nvJ6nUMosXRii72u5PvBl12wakkkSWiDxRSOzj
 MH0k+8Fv5RwAnN6isKvjrQknJVF4E8fZNnp/y+dh3Gl2fL1c7YoRvb6xcwoqgE9/m5D2Wn1pT
 h5f5OYRRVnMM0xRpycWUJejTBgIaKMYCxTlubOPWg/W0CisLEJ19aR5KozEob4VpezkgPog1/
 DbxDiGtQAusmGD28DSp0q6BEHq743+LeI18Dt9wv5qemLfhdDKgKMOrDqMsX0ygeEmXT/Ql13
 C435xw4Lf3u/omf5m6xg==
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

EADDRNOTAVAIL shouldn't be thrown when an invalid RX address (e.g. NO_CAN_=
ID)
is set while the socket is used with the CAN_ISOTP_SF_BROADCAST flag.

Signed-off-by: Thomseeen <thwa1@web.de>
=2D--
 net/can/isotp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index fb6dba1..ae939bf 100644
=2D-- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1106,20 +1106,25 @@ static int isotp_bind(struct socket *sock, struct =
sockaddr *uaddr, int len)
 #endif
 		return -EINVAL;

-	if (addr->can_addr.tp.rx_id =3D=3D addr->can_addr.tp.tx_id)
-		return -EADDRNOTAVAIL;
+	/* do not register frame reception for functional addressing */
+	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
+		do_rx_reg =3D 0;
+
+	/* do not validate rx address for functional addressing */
+	if (do_rx_reg) {
+		if (addr->can_addr.tp.rx_id =3D=3D addr->can_addr.tp.tx_id)
+			return -EADDRNOTAVAIL;

-	if ((addr->can_addr.tp.rx_id | addr->can_addr.tp.tx_id) &
-	    (CAN_ERR_FLAG | CAN_RTR_FLAG))
+		if (addr->can_addr.tp.rx_id & (CAN_ERR_FLAG | CAN_RTR_FLAG))
+			return -EADDRNOTAVAIL;
+	}
+
+	if (addr->can_addr.tp.tx_id & (CAN_ERR_FLAG | CAN_RTR_FLAG))
 		return -EADDRNOTAVAIL;

 	if (!addr->can_ifindex)
 		return -ENODEV;

-	/* do not register frame reception for functional addressing */
-	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
-		do_rx_reg =3D 0;
-
 	lock_sock(sk);

 	if (so->bound && addr->can_ifindex =3D=3D so->ifindex &&
=2D-
2.25.1

