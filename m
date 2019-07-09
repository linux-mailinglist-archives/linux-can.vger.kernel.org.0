Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4A63322
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfGII7W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54211 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfGII7V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085P-HI; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000bx-7I; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 08/34] j1939: bus: add sanity check in j1939_name_to_addr()
Date:   Tue,  9 Jul 2019 10:58:43 +0200
Message-Id: <20190709085909.1413-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709085909.1413-1-o.rempel@pengutronix.de>
References: <20190709085909.1413-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index d106e2d333a2..9a290c906869 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -255,7 +255,7 @@ u8 j1939_name_to_addr(struct j1939_priv *priv, name_t name)
 
 	read_lock_bh(&priv->lock);
 	ecu = j1939_ecu_find_by_name_locked(priv, name);
-	if (j1939_ecu_is_mapped_locked(ecu))
+	if (ecu && j1939_ecu_is_mapped_locked(ecu))
 		/* ecu's SA is registered */
 		addr = ecu->addr;
 
-- 
2.20.1

