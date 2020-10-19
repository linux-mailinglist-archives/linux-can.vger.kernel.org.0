Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488372926E5
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 14:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgJSMDA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 08:03:00 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:33016 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgJSMDA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 08:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603108975;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=wwheiqu+Kv1v+1Fjle3mVlNRfqkrKNMbWPuB+egzk4c=;
        b=n4Ge6okD3e8ereIMV1yxH5pEr5F5ZnHOd73HQgisg0KtRJslh40q9U/bwJfrJaDv++
        ickcf5/c3P4A5AdOA35o0lwRug8NaMe0MzYxRK+BBI5WOyo6j8/x0IhnpcZ7WPCzMXXx
        Yv1A45f5MOvD0Diq/zOv4FFunwsSANFZKIq5FeiLoQDzAV9R309eDOlnjPFvezmNOHQZ
        m5K7YRsTz77vUc+FoUhE329QczRgXcFLa6b5CYZ9gSA3zKgNNh95O3Ff7lhuxtUyfCaE
        crCTxC6WtGq3Dbf49g2DvOgQYVCS4fGqzw1GaaGQZfU7acCPXnD+w3jOu8tjaChcMqG7
        0kzg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM/uUA="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9JC2sjSE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 19 Oct 2020 14:02:54 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Thomas Wagner <thwa1@web.de>
Subject: [PATCH] can-isotp: enable RX timeout handling in listen-only mode
Date:   Mon, 19 Oct 2020 14:02:29 +0200
Message-Id: <20201019120229.89326-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

As reported by Thomas Wagner here
https://github.com/hartkopp/can-isotp/issues/34
the timeout handling for data frames is not enabled when the isotp socket
is used in listen-only mode (sockopt CAN_ISOTP_LISTEN_MODE).
This mode is enabled by the isotpsniffer application which therefore
became inconsistend with the strict rx timeout rules when running the
isotp protocol in the operational mode.

This patch fixes this inconsistency by moving the return condition for the
listen-only mode behind the timeout handling code.

Reported-by: Thomas Wagner <thwa1@web.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 4c2062875893..a79287ef86da 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -567,22 +567,22 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 		nskb->dev = skb->dev;
 		isotp_rcv_skb(nskb, sk);
 		return 0;
 	}
 
-	/* no creation of flow control frames */
-	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
-		return 0;
-
 	/* perform blocksize handling, if enabled */
 	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
 		/* start rx timeout watchdog */
 		hrtimer_start(&so->rxtimer, ktime_set(1, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		return 0;
 	}
 
+	/* no creation of flow control frames */
+	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
+		return 0;
+
 	/* we reached the specified blocksize so->rxfc.bs */
 	isotp_send_fc(sk, ae, ISOTP_FC_CTS);
 	return 0;
 }
 
-- 
2.28.0

