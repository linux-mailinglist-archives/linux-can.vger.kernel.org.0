Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3E485386
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 14:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbiAENYk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 08:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbiAENYe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 08:24:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71298C061761
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 05:24:34 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n56HI-00056c-VH
        for linux-can@vger.kernel.org; Wed, 05 Jan 2022 14:24:33 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1870D6D19E8
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 13:24:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9EF116D19E4;
        Wed,  5 Jan 2022 13:24:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 93403e67;
        Wed, 5 Jan 2022 13:24:31 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        syzbot+4c63f36709a642f801c5@syzkaller.appspotmail.com
Subject: [PATCH RFC] can: isotp: convert struct tpcon::{idx,len} to unsigned int
Date:   Wed,  5 Jan 2022 14:24:29 +0100
Message-Id: <20220105132429.1170627-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In isotp_rcv_ff() 32 bit of data received over the network is assigned
to struct tpcon::len. Later in that function the length is checked for
the maximal supported length against MAX_MSG_LENGTH.

As struct tpcon::len is an "int" this check does not work, if the
provided length overflows the "int".

Later on struct tpcon::idx is compared against struct tpcon::len.

To fix this problem this patch converts both struct tpcon::{idx,len}
to unsigned int.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
\# Cc: stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Reported-by: syzbot+4c63f36709a642f801c5@syzkaller.appspotmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index df6968b28bf4..02cbcb2ecf0d 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -119,8 +119,8 @@ enum {
 };
 
 struct tpcon {
-	int idx;
-	int len;
+	unsigned int idx;
+	unsigned int len;
 	u32 state;
 	u8 bs;
 	u8 sn;
-- 
2.34.1


