Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096DE4F9EF6
	for <lists+linux-can@lfdr.de>; Fri,  8 Apr 2022 23:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiDHVMn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Apr 2022 17:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbiDHVMf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2022 17:12:35 -0400
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6032B181796
        for <linux-can@vger.kernel.org>; Fri,  8 Apr 2022 14:10:27 -0700 (PDT)
Received: from localhost.localdomain ([93.35.164.10])
        by Aruba Outgoing Smtp  with ESMTPSA
        id cvr9nij0B79nYcvrAnFy53; Fri, 08 Apr 2022 23:09:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1649452164; bh=YSzghGkQG9IKiyCgShp4fjbw3t+wnbGnbQfbUoit2jU=;
        h=From:To:Subject:Date:MIME-Version;
        b=aMz/5aUKALKOkx/jeMkyvvG6Ok+h2ZAFcMaNBMt5YTpPzLf604vS54VX4Q1aXeRk8
         TrVbTS3zCMay4v6gM4gGRP1ttXJ8zjoHxq9X09I6MAA+nUo+eoS0/nI7N1bbZGJOs8
         0F8KbCMO10ejdVsAzX1OOmNP2Sbqh7W9FLxPyZ8MD1L6Atz2z/oh9MIwGbe86utRD/
         tuqqOdlFK4gk8nPeYSS3pHcEtzr3YmxvZCPOLSlVP9qvxuiVjCXoSo1S+QHHQ82QXa
         JitWCGZSvHAshaZBq9MMydhgHLsbFgjcdpb+B4wrKP1Wr7H0ldAwR94bb5tWuh+p5G
         X/1AZ3Xtx91oA==
From:   Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
To:     Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
Subject: [PATCH 1/2] can: j1939: make sure that sent DAT frames are marked as TX
Date:   Fri,  8 Apr 2022 23:09:09 +0200
Message-Id: <20220408210910.16137-2-devid.filoni@egluetechnologies.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408210910.16137-1-devid.filoni@egluetechnologies.com>
References: <20220408210910.16137-1-devid.filoni@egluetechnologies.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDs1cPSwuRdiCSLtLZyqg37B4TVJbz+ZxjWCtbMZPzJozG1yKobeZbVpzXO0x9SmaEyQtcDImFttjQcqnnnv1TM3NjUCsPZE7tkOZi/JsM1kNMO6IfCb
 IFFxc4/vAv66/aVNKIOmayo1RBwRlGJOm1JViFkm7PxJH55q5fT5V6Ujg2wvrXOsRGzjXmDUm4Xrt+IOEvkqCny711VJk4svtjAC08PGbq0o4urnbh2i0o7Z
 pgmC719EQuQsFhZMjb/PLNR7t+kqtueK7+5ghMe5nICdd292A41SY2BprEDK7jVSDb79YwTHkGceCVccT7yGBR2SocN4zQ+K52CLS72/IXvXq8sSFFxI7rTJ
 8qAlmjUPegJgTcWd2Ky6Sdmpooc/pA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fixes: 9d71dd0 ("can: add support of SAE J1939 protocol")
Signed-off-by: Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
---
 net/can/j1939/transport.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 307ee1174a6e..030f5fe901e1 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -621,18 +621,30 @@ static int j1939_tp_tx_dat(struct j1939_session *session,
 			   const u8 *dat, int len)
 {
 	struct j1939_priv *priv = session->priv;
+	struct sk_buff *se_skb;
 	struct sk_buff *skb;
+	int ret;
 
 	skb = j1939_tp_tx_dat_new(priv, &session->skcb,
 				  false, false);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
+	se_skb = j1939_session_skb_get(session);
+	if (se_skb)
+		can_skb_set_owner(skb, se_skb->sk);
+
 	skb_put_data(skb, dat, len);
 	if (j1939_tp_padding && len < 8)
 		memset(skb_put(skb, 8 - len), 0xff, 8 - len);
 
-	return j1939_send_one(priv, skb);
+	ret = j1939_send_one(priv, skb);
+
+	if (ret)
+		kfree_skb(se_skb);
+	else
+		consume_skb(se_skb);
+	return ret;
 }
 
 static int j1939_xtp_do_tx_ctl(struct j1939_priv *priv,
-- 
2.25.1

