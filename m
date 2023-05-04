Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AAB6F77B3
	for <lists+linux-can@lfdr.de>; Thu,  4 May 2023 23:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjEDVCv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 May 2023 17:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjEDVCU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 May 2023 17:02:20 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307EE1BDC
        for <linux-can@vger.kernel.org>; Thu,  4 May 2023 14:01:46 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7FEDA857D1;
        Thu,  4 May 2023 21:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683229872;
        bh=39q+3mKLqbdOiR49RDTryunT33wypaGaC2ptWrAA6WM=;
        h=From:To:Cc:Subject:Date:From;
        b=IenDkw5V+E3faRBMOxdA8afGLCczCkygqVVIAW0lNZoz0XFyqQ1U+8y/eDnXRNvET
         k1+2BsAGORubxzdBBPF824nBYCIYuZigDAHR3lx4a95xPgPj+8/KUNr6Z03xKEwgz5
         OGlM09pS9g5+boHkZOE+1OY4cm8kC0tt4PVOeEjTSqHuKLTJSmJm3a+t7DGjAKSOb3
         4XOr6GWrxrR2hiuVYOEXkRMhiopRPMDZ54JeyZ7ZMP8yXqPp3Lwpt4PuISILO+L7NY
         8fCrp4edNsFxUfO5NQf7MPLnJsVidBAl7JiklCBfbSd+V3XWc510bd61x2Ns0BesCl
         kDXEWFni8bd+A==
From:   Marek Vasut <marex@denx.de>
To:     linux-can@vger.kernel.org
Cc:     Fedor Ross <fedor.ross@ifm.com>, Marek Vasut <marex@denx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH] can: mcp251xfd: Increase poll timeout
Date:   Thu,  4 May 2023 21:50:59 +0200
Message-Id: <20230504195059.4706-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Fedor Ross <fedor.ross@ifm.com>

Make `MCP251XFD_POLL_TIMEOUT_US` timeout calculation dynamic. Use
maximum of 1ms and bit time of one full 72 bytes CANFD frame at the
current bitrate. This seems to be necessary when configuring low
bit rates like 10 Kbit/s for example. Otherwise during polling for
the CAN controller to enter 'Normal CAN 2.0 mode' the timeout limit
is exceeded and the configuration fails with:

$ ip link set dev can1 up type can bitrate 10000
[  731.911072] mcp251xfd spi2.1 can1: Controller failed to enter mode CAN 2.0 Mode (6) and stays in Configuration Mode (4) (con=0x068b0760, osc=0x00000468).
[  731.927192] mcp251xfd spi2.1 can1: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
[  731.938101] A link change request failed with some changes committed already. Interface can1 may have been left with an inconsistent configuration, please check.
RTNETLINK answers: Connection timed out

Fixes: 55e5b97f003e8 ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 68df6d4641b5c..9908843798cef 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -227,6 +227,7 @@ static int
 __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 			  const u8 mode_req, bool nowait)
 {
+	const struct can_bittiming *bt = &priv->can.bittiming;
 	u32 con = 0, con_reqop, osc = 0;
 	u8 mode;
 	int err;
@@ -251,7 +252,8 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 				       FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
 						 con) == mode_req,
 				       MCP251XFD_POLL_SLEEP_US,
-				       MCP251XFD_POLL_TIMEOUT_US);
+				       max(MCP251XFD_POLL_TIMEOUT_US,
+					   576 * USEC_PER_SEC / bt->bitrate));
 	if (err != -ETIMEDOUT && err != -EBADMSG)
 		return err;
 
-- 
2.39.2

