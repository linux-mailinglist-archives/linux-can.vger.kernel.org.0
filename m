Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8292F585A
	for <lists+linux-can@lfdr.de>; Thu, 14 Jan 2021 04:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbhANCR6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Jan 2021 21:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbhAMVNl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jan 2021 16:13:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC6C061795
        for <linux-can@vger.kernel.org>; Wed, 13 Jan 2021 13:14:20 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kznT8-0001Ux-Qv
        for linux-can@vger.kernel.org; Wed, 13 Jan 2021 22:14:18 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 684C95C301C
        for <linux-can@vger.kernel.org>; Wed, 13 Jan 2021 21:14:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id DE97A5C2FFA;
        Wed, 13 Jan 2021 21:14:11 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7d4fed6a;
        Wed, 13 Jan 2021 21:14:11 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 01/17] MAINTAINERS: adjust entry to tcan4x5x file split
Date:   Wed, 13 Jan 2021 22:13:54 +0100
Message-Id: <20210113211410.917108-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113211410.917108-1-mkl@pengutronix.de>
References: <20210113211410.917108-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Commit 7813887ea972 ("can: tcan4x5x: rename tcan4x5x.c -> tcan4x5x-core.c") and
commit 67def4ef8bb9 ("can: tcan4x5x: move regmap code into seperate file")
split the file tcan4x5x.c into two files, but missed to adjust the TI TCAN4X5X
DEVICE DRIVER section in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/net/can/m_can/tcan4x5x.c

Adjust the file entry in MAINTAINERS to the tcan4x5x file splitting.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Fixes: 67def4ef8bb9 ("can: tcan4x5x: move regmap code into seperate file")
Fixes: 7813887ea972 ("can: tcan4x5x: rename tcan4x5x.c -> tcan4x5x-core.c")
Link: https://lore.kernel.org/r/20210108073932.20804-1-lukas.bulwahn@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2cb79198288..54fcd5fe572d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17839,7 +17839,7 @@ M:	Dan Murphy <dmurphy@ti.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/tcan4x5x.txt
-F:	drivers/net/can/m_can/tcan4x5x.c
+F:	drivers/net/can/m_can/tcan4x5x*
 
 TI TRF7970A NFC DRIVER
 M:	Mark Greer <mgreer@animalcreek.com>

base-commit: f50e2f9f791647aa4e5b19d0064f5cabf630bf6e
-- 
2.29.2


