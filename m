Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3E489335
	for <lists+linux-can@lfdr.de>; Mon, 10 Jan 2022 09:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbiAJIYF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jan 2022 03:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiAJIYD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Jan 2022 03:24:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE90C06173F
        for <linux-can@vger.kernel.org>; Mon, 10 Jan 2022 00:24:03 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n6pyD-0003LC-W3
        for linux-can@vger.kernel.org; Mon, 10 Jan 2022 09:24:02 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 0DF356D4525
        for <linux-can@vger.kernel.org>; Mon, 10 Jan 2022 08:24:01 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D3FA86D4522;
        Mon, 10 Jan 2022 08:24:00 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2d610fbc;
        Mon, 10 Jan 2022 08:24:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Brian Silverman <bsilver16384@gmail.com>
Subject: [PATCH] mailmap: update email address of Brian Silverman
Date:   Mon, 10 Jan 2022 09:23:59 +0100
Message-Id: <20220110082359.2019735-1-mkl@pengutronix.de>
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

Brian Silverman's address at bluerivertech.com is not valid anymore,
use Brian's private email address instead.

Cc: Brian Silverman <bsilver16384@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Hey Brian,

please give me your Acked-by for this patch. This will map the old
bluerivertech.com address to your private email address.

regards,
Marc

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index b344067e0acb..b16995fd3397 100644
--- a/.mailmap
+++ b/.mailmap
@@ -65,6 +65,7 @@ Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Brian Avery <b.avery@hp.com>
 Brian King <brking@us.ibm.com>
+Brian Silverman <bsilver16384@gmail.com> <brian.silverman@bluerivertech.com>
 Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
 Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
 Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>
-- 
2.34.1


