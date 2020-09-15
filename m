Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8B26B1F6
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 00:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgIOWix (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 18:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbgIOWfc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983CAC06178C
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:31 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJXt-0002Tb-MS; Wed, 16 Sep 2020 00:35:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 04/37] can: net: fix spelling mistakes
Date:   Wed, 16 Sep 2020 00:34:54 +0200
Message-Id: <20200915223527.1417033-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915223527.1417033-1-mkl@pengutronix.de>
References: <20200915223527.1417033-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes spelling erros found by "codespell" in the net/can
subtree.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 5c06404bdf3e..ea29a6d97ef5 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -358,7 +358,7 @@ static unsigned int effhash(canid_t can_id)
  *
  * Return:
  *  Pointer to optimal filterlist for the given can_id/mask pair.
- *  Constistency checked mask.
+ *  Consistency checked mask.
  *  Reduced can_id to have a preprocessed filter compare value.
  */
 static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
@@ -411,7 +411,7 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
 /**
  * can_rx_register - subscribe CAN frames from a specific interface
  * @net: the applicable net namespace
- * @dev: pointer to netdevice (NULL => subcribe from 'all' CAN devices list)
+ * @dev: pointer to netdevice (NULL => subscribe from 'all' CAN devices list)
  * @can_id: CAN identifier (see description)
  * @mask: CAN mask (see description)
  * @func: callback function on filter match
-- 
2.28.0

