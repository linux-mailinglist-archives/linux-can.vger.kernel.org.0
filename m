Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C710C4CED78
	for <lists+linux-can@lfdr.de>; Sun,  6 Mar 2022 20:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiCFTgJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Mar 2022 14:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiCFTgJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 6 Mar 2022 14:36:09 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945035D645
        for <linux-can@vger.kernel.org>; Sun,  6 Mar 2022 11:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646595314;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nL7vrlbAorwn1K86mApnbEHl1wysYh/mz7WnNsP2714=;
    b=T0NC606Go4noZv4vkvoe2qHEYTVZIJYLsMsT0CwJ7BSh0/zpY1K9RUxuW6KdjizCfb
    wL3l96Kp0thiVoTUCqCfn8T9A9oCPYWLocv8Qj2NDs7lVBSIML6A1lyjoBoaSJoaEusl
    6V2F2Pz15zHUIJyiqeD/m7rieUUvxIPmChWEy9s5DxLhol5LpWjnZWJibbYxEKeoQmuR
    ORpd363112ndLtC6hPxCvsyw1Jz5T50b4+YWsw02D+xytdRmPxhp39IPYwtTuIj2S6Yr
    zEaEBclUPLAm53uowvDpL8DWcQACwB1XMdCfhGxnWS7jT1JJW5VUXrl/baAVvRoe8r4T
    yb9A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUvprl4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.40.1 AUTH)
    with ESMTPSA id 6c57e6y26JZE5LC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 6 Mar 2022 20:35:14 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next 3/3] can: isotp: set max PDU size to 64 kByte
Date:   Sun,  6 Mar 2022 20:34:54 +0100
Message-Id: <20220306193454.33158-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220306193454.33158-1-socketcan@hartkopp.net>
References: <20220306193454.33158-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The reason to extend the max PDU size from 4095 Byte (12 bit length value)
to a 32 bit value (up to 4 GByte) was to be able to flash 64 kByte
bootloaders with a single ISO-TP PDU. The max PDU size in the Linux kernel
implementation was set to 8200 Bytes to be able to test the length
information escape sequence.

It turns out that the demand for 64 kByte PDUs is real so the value for
MAX_MSG_LENGTH is set to 66000 to be able to potentially add some checksums
to the 65.536 Byte block.

Link: https://github.com/linux-can/can-utils/issues/347#issuecomment-1056142301
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index d59f1758ac9c..423cb99e85d5 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -84,13 +84,13 @@ MODULE_ALIAS("can-proto-6");
 			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
 
 /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
  * take full 32 bit values (4 Gbyte). We would need some good concept to handle
  * this between user space and kernel space. For now increase the static buffer
- * to something about 8 kbyte to be able to test this new functionality.
+ * to something about 64 kbyte to be able to test this new functionality.
  */
-#define MAX_MSG_LENGTH 8200
+#define MAX_MSG_LENGTH 66000
 
 /* N_PCI type values in bits 7-4 of N_PCI bytes */
 #define N_PCI_SF 0x00	/* single frame */
 #define N_PCI_FF 0x10	/* first frame */
 #define N_PCI_CF 0x20	/* consecutive frame */
-- 
2.30.2

