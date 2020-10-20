Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F5293522
	for <lists+linux-can@lfdr.de>; Tue, 20 Oct 2020 08:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404518AbgJTGpE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Oct 2020 02:45:04 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:26828 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404517AbgJTGpE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Oct 2020 02:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603176303;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=EKCHEAbofdUhiWN9RFuIyPmrXG9Qtimxuxj2MpwnSaQ=;
        b=M0NtlOPEZ2EDXH2VdC9K8/w329xk3IUHVM+Jm3b3cjMdtweKL6M4vcqq5dbaGx/aJ4
        F2IuNTvK6IUI1BlELtTX6TmaD1Q5596Wi5WXGks/vVkuFCG7P6jbJ9/OmNw1sL/V0483
        HyFznlNrfV9Pg58cOnQLjpkxL992BVABlTZ6xtlXv3f7W0L/hY07CzyN6m5O/BhfEI5N
        NsRrh/U+jzWc3sQ/VzBIpqJMn8uHImN7B4SWDD/7WXkLx6Sd0TFdXfvrmq4KH1x7/165
        hFJIrh8yWu1lYzwtiBZwyf/SbfhaNzw4m04iH5F3yIP6pCerq8mYX9wH9UShs9A5QE3N
        Ia2g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0lO8DsfULo/u7TWrJQP0="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9K6j2lhm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 20 Oct 2020 08:45:02 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH RFC] can-dev: fix real payload length return value for RTR frames
Date:   Tue, 20 Oct 2020 08:44:43 +0200
Message-Id: <20201020064443.80164-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The can_get_echo_skb() function returns the number of received bytes to
be used for netdev statistics. In the case of RTR frames we get a valid
(potential non-zero) data length value which has to be passed for further
operations. But on the wire RTR frames have no payload length. Therefore
the value to be used in the statistics has to be zero for RTR frames.

Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/r/20201002154219.4887-4-mailhol.vincent@wanadoo.fr
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index b70ded3760f2..64c8cb27154b 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -510,13 +510,17 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
 		/* Using "struct canfd_frame::len" for the frame
 		 * length is supported on both CAN and CANFD frames.
 		 */
 		struct sk_buff *skb = priv->echo_skb[idx];
 		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
-		u8 len = cf->len;
 
-		*len_ptr = len;
+		/* get the real payload length for netdev statistics */
+		if (cf->can_id & CAN_RTR_FLAG)
+			*len_ptr = 0;
+		else
+			*len_ptr = cf->len;
+
 		priv->echo_skb[idx] = NULL;
 
 		return skb;
 	}
 
-- 
2.28.0

