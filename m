Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EC343DD7
	for <lists+linux-can@lfdr.de>; Mon, 22 Mar 2021 11:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhCVK2u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Mar 2021 06:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCVK2U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Mar 2021 06:28:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2760C061574
        for <linux-can@vger.kernel.org>; Mon, 22 Mar 2021 03:28:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lOHnG-00068B-JW
        for linux-can@vger.kernel.org; Mon, 22 Mar 2021 11:28:18 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A9CEE5FCF6B
        for <linux-can@vger.kernel.org>; Mon, 22 Mar 2021 10:28:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2CA445FCF66;
        Mon, 22 Mar 2021 10:28:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7411256f;
        Mon, 22 Mar 2021 10:28:16 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] can: uapi: can.h: mark union inside struct can_frame packed
Date:   Mon, 22 Mar 2021 11:28:14 +0100
Message-Id: <20210322102814.402850-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In commit ea7800565a12 ("can: add optional DLC element to Classical
CAN frame structure") the struct can_frame::can_dlc was put into an
anonymous union with another u8 variable.

For various reasons some members in struct can_frame and canfd_frame
including the first 8 byes of data are expected to have the same
memory layout. This is enforced by a BUILD_BUG_ON check in af_can.c.

Since the above mentioned commit this check fails on at least one compiler
(arm-linux-gnueabi-gcc (GCC) 9.3.0). Rong Chen analyzed the problem
and found that the union in struct can_frame takes 4 bytes instead of
the expected 1:

| struct can_frame {
|          canid_t                    can_id;               /* 0     4 */
|          union {
|                  __u8               len;                  /* 4     1 */
|                  __u8               can_dlc;              /* 4     1 */
|          };                                               /* 4     4 */
|          __u8                       __pad;                /* 8     1 */
|          __u8                       __res0;               /* 9     1 */
|          __u8                       len8_dlc;             /* 10     1 */
|
|          /* XXX 5 bytes hole, try to pack */
|
|          __u8                       data[8]
| __attribute__((__aligned__(8))); /*    16     8 */
|
|          /* size: 24, cachelines: 1, members: 6 */
|          /* sum members: 19, holes: 1, sum holes: 5 */
|          /* forced alignments: 1, forced holes: 1, sum forced holes: 5 */
|          /* last cacheline: 24 bytes */
| } __attribute__((__aligned__(8)));

Marking the union as packed fixes the problem.

Fixes: ea7800565a12 ("can: add optional DLC element to Classical CAN frame structure")
Suggested-by: Rong Chen <rong.a.chen@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/uapi/linux/can.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index f75238ac6dce..9842bb55ffd9 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -113,7 +113,7 @@ struct can_frame {
 		 */
 		__u8 len;
 		__u8 can_dlc; /* deprecated */
-	};
+	} __attribute__((packed));
 	__u8 __pad; /* padding */
 	__u8 __res0; /* reserved / padding */
 	__u8 len8_dlc; /* optional DLC for 8 byte payload length (9 .. 15) */
-- 
2.30.2


