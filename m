Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F626333C
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 11:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfGIJBU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 05:01:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54423 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfGIJBU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 05:01:20 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085T-H9; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000eL-Bf; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 12/34] j1939: main: add netdev_dbg on priv create and release
Date:   Tue,  9 Jul 2019 10:58:47 +0200
Message-Id: <20190709085909.1413-12-o.rempel@pengutronix.de>
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

so we can make sure priv is always freed

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 8481c46c6b08..bdb6de2a25da 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -116,6 +116,7 @@ static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 	priv->ndev = ndev;
 	kref_init(&priv->kref);
 	dev_hold(ndev);
+	netdev_dbg(priv->ndev, "j1939_priv_create: 0x%p\n", priv);
 
 	return priv;
 }
@@ -141,6 +142,7 @@ static void __j1939_priv_release(struct kref *kref)
 
 	/* unlink from netdev */
 	j1939_priv_set(ndev, NULL);
+	netdev_dbg(priv->ndev, "__j1939_priv_release: 0x%p\n", priv);
 
 	dev_put(ndev);
 	kfree(priv);
-- 
2.20.1

