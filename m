Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C32F025D
	for <lists+linux-can@lfdr.de>; Sat,  9 Jan 2021 18:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbhAIRlE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 9 Jan 2021 12:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAIRlD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Jan 2021 12:41:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ACAC06179F
        for <linux-can@vger.kernel.org>; Sat,  9 Jan 2021 09:40:23 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kyIDr-0004kL-8s
        for linux-can@vger.kernel.org; Sat, 09 Jan 2021 18:40:19 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7A72E5BE8AA
        for <linux-can@vger.kernel.org>; Sat,  9 Jan 2021 17:40:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 44B395BE897;
        Sat,  9 Jan 2021 17:40:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 45f3caf9;
        Sat, 9 Jan 2021 17:40:14 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 01/13] MAINTAINERS: CAN network layer: add missing header file can-ml.h
Date:   Sat,  9 Jan 2021 18:40:01 +0100
Message-Id: <20210109174013.534145-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109174013.534145-1-mkl@pengutronix.de>
References: <20210109174013.534145-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch add the can-ml.h to the list of maintained files of the CAN network
layer.

Fixes: ffd956eef69b ("can: introduce CAN midlayer private and allocate it automatically")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 54fcd5fe572d..c3091a91ebbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3960,6 +3960,7 @@ W:	https://github.com/linux-can
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
 F:	Documentation/networking/can.rst
+F:	include/linux/can/can-ml.h
 F:	include/linux/can/core.h
 F:	include/linux/can/skb.h
 F:	include/net/netns/can.h
-- 
2.29.2


