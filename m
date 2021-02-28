Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB43271C5
	for <lists+linux-can@lfdr.de>; Sun, 28 Feb 2021 10:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhB1JnJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 28 Feb 2021 04:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhB1JnH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 28 Feb 2021 04:43:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C76C06174A
        for <linux-can@vger.kernel.org>; Sun, 28 Feb 2021 01:42:26 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lGIan-0003bt-5u
        for linux-can@vger.kernel.org; Sun, 28 Feb 2021 10:42:25 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 464205EA850
        for <linux-can@vger.kernel.org>; Sun, 28 Feb 2021 09:42:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CAD345EA84C;
        Sun, 28 Feb 2021 09:42:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a5975d87;
        Sun, 28 Feb 2021 09:42:22 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <murpdj72@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH RFC] MAINTAINERS: remove Dan Murphy from m_can and tcan4x5x
Date:   Sun, 28 Feb 2021 10:42:18 +0100
Message-Id: <20210228094218.40015-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dan Murphy's email address at ti.com doesn't work anymore, mails
bounce with:

| 550 Invalid recipient <dmurphy@ti.com> (#5.1.1)

For now remove all CAN related entries of Dan from the Maintainers
file.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Dan Murphy and *,

there is a Dan Murphy on the internet that worked for ti.com,
contributed to the Linux kernel and got maintainership for some parts.
Turns out that Dan's e-mail at ti.com doesn't work anymore.

I've found a Dan Murphy in github, who has some repos matching Dan's
profile. This is why I've added Dan's e-mail from github on Cc.

If you are that Dan I'm looking for and want to keep maintainership of
the CAN chip, please give me your new e-mail address, if not I'll
upstream this patch in a few days.

regards,
Marc

 MAINTAINERS | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a50a543e3c81..bd3b60c639f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10819,7 +10819,6 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/radio/radio-maxiradio*
 
 MCAN MMIO DEVICE DRIVER
-M:	Dan Murphy <dmurphy@ti.com>
 M:	Pankaj Sharma <pankj.sharma@samsung.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
@@ -17813,13 +17812,6 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Odd Fixes
 F:	sound/soc/codecs/tas571x*
 
-TI TCAN4X5X DEVICE DRIVER
-M:	Dan Murphy <dmurphy@ti.com>
-L:	linux-can@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/net/can/tcan4x5x.txt
-F:	drivers/net/can/m_can/tcan4x5x*
-
 TI TRF7970A NFC DRIVER
 M:	Mark Greer <mgreer@animalcreek.com>
 L:	linux-wireless@vger.kernel.org
-- 
2.30.1


