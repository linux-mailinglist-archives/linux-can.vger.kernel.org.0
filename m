Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF8A4D73B5
	for <lists+linux-can@lfdr.de>; Sun, 13 Mar 2022 09:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiCMIhz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Mar 2022 04:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiCMIhy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Mar 2022 04:37:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6891AC289
        for <linux-can@vger.kernel.org>; Sun, 13 Mar 2022 00:36:46 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nTJiV-00072s-TH
        for linux-can@vger.kernel.org; Sun, 13 Mar 2022 09:36:43 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4680049A98
        for <linux-can@vger.kernel.org>; Sun, 13 Mar 2022 08:36:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EE90949A7D;
        Sun, 13 Mar 2022 08:36:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4ce932a0;
        Sun, 13 Mar 2022 08:36:40 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: can-next 2022-03-13: mcp251xfd: add 
Date:   Sun, 13 Mar 2022 09:36:28 +0100
Message-Id: <20220313083640.501791-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

this series for the mcp251xfd adds IRQ coalescing support.

It turned out, that I cannot reproduce the no-RX with activated
coalescing support on busy busses problem anymore. I added proper
patch descriptions and fixed some checkpatch long lines problems. I've
also removed the #define debug, which was only for testing. The rest
of the series in unchanged.

- What is IRQ coalescing and how does the mcp251xfd driver implement it?

The idea behind IRQ coalescing is to not serve every interrupt (CAN
frame RX'ed and CAN frame TX complete) as soon as possible, but to
delay it and handle several RX/TX complete frames at once. This
reduces the number of IRQs and SPI transfers.

With activated RX IRQ coalescing, the RX IRQ handler deactivated the
"RX FIFO not empty interrupt" and activated the "FIFO half full" (or
"FIFO full IRQ" - depending on configuration) instead.

To ensure that a single RX'ed CAN frame (which doesn't trigger the
FIFO half full IRQ) doesn't starve in the FIFO, a hrtimer is started
that activates the "FIFO not empty" IRQ after a configurable delay.

TX IRQ coalescing does the same thing, but for TX complete IRQs

- How to configure this?

Configuration is a bit tricky, it consists of several parameters,
which are all influencing each other and the number of buffers is
limited to power-of-two, to up to 32 per FIFO.

1) Configure the CAN mode (classical CAN-2.0 or CAN-FD) mode. Do not
   bring the interface up.

2) Configure RX and TX FIFOs. In ethtool's speak this is called "ring"
   configuration. The current ring configuration is shown with the
   "-g" parameter:

| $ ethtool -g mcp251xfd1
|
| Ring parameters for mcp251xfd1:
| Pre-set maximums:
| RX:             96
| RX Mini:        n/a
| RX Jumbo:       n/a
| TX:             16
| Current hardware settings:
| RX:             80
| RX Mini:        n/a
| RX Jumbo:       n/a
| TX:             8

   For TX, 1 FIFO is used with the default depth 8 (CAN-2.0 mode) and
   4 (CAN-FD mode). In default configuration the driver uses the
   remaining space for RX. In CAN-2.0 mode, this leads to 80 RX
   buffers and 8 TX buffers. A more detailed overview is printed when
   the interface is brought up:

| FIFO setup: TEF:         0x400:  8*12 bytes =   96 bytes
| FIFO setup: RX-0: FIFO 1/0x460: 32*20 bytes =  640 bytes
| FIFO setup: RX-1: FIFO 2/0x6e0: 32*20 bytes =  640 bytes
| FIFO setup: RX-2: FIFO 3/0x960: 16*20 bytes =  320 bytes
| FIFO setup: TX:   FIFO 4/0xaa0:  8*16 bytes =  128 bytes
| FIFO setup: free:                              224 bytes

   Note:
   - The number of RX buffers takes more priority than the number of
     TX buffers.
   - Ring configuration is reset by CAN mode configuration.
   - Ring configuration resets coalescing configuration.
   - Configuration is only possible if the interface is down.

   Let's increase the number of RX buffers to the max of 96.

| $ ethtool -G mcp251xfd1 rx 96 tx 4

   Check config with "-g":

| $ sudo ethtool -g mcp251xfd1
| Ring parameters for mcp251xfd1:
| Pre-set maximums:
| RX:             96
| RX Mini:        n/a
| RX Jumbo:       n/a
| TX:             16
| Current hardware settings:
| RX:             96
| RX Mini:        n/a
| RX Jumbo:       n/a
| TX:             4

   The detailed output during ifup:

| FIFO setup: TEF:         0x400:  4*12 bytes =   48 bytes
| FIFO setup: RX-0: FIFO 1/0x430: 32*20 bytes =  640 bytes
| FIFO setup: RX-1: FIFO 2/0x6b0: 32*20 bytes =  640 bytes
| FIFO setup: RX-2: FIFO 3/0x930: 32*20 bytes =  640 bytes
| FIFO setup: TX:   FIFO 4/0xbb0:  4*16 bytes =   64 bytes
| FIFO setup: free:                               16 bytes

3) Configure the RX/TX IRQ coalescing.
   The driver supports both RX and TX coalescing. The configuration is
   done again with ethtool, the interface must be down for this.

   There are 2 parameters to configure:
   1) FIFO fill level that triggers IRQ
   2) Delay after IRQ processing to enable FIFO not empty IRQ

   In this example we configure RX coalescing for 32 buffers with a
   delay of 10ms:

| $ ethtool -C mcp251xfd1 rx-usecs-irq 10000 rx-frames-irq 32

   Check with "-c":

| $ ethtool -c mcp251xfd1
|
| Coalesce parameters for mcp251xfd1:
| Adaptive RX: n/a  TX: n/a
| stats-block-usecs: n/a
| sample-interval: n/a
| pkt-rate-low: n/a
| pkt-rate-high: n/a
|
| rx-usecs: n/a
| rx-frames: n/a
| rx-usecs-irq: 10000
| rx-frames-irq: 32
|
| tx-usecs: n/a
| tx-frames: n/a
| tx-usecs-irq: 0
| tx-frames-irq: 1
|
| rx-usecs-low: n/a
| rx-frame-low: n/a
| tx-usecs-low: n/a
| tx-frame-low: n/a
|
| rx-usecs-high: n/a
| rx-frame-high: n/a
| tx-usecs-high: n/a
| tx-frame-high: n/a

   The TX IRQ coalescing parameters we see in this example output are
   "tx-usecs-irq=0" and "tx-frames-irq=1". This means no coalescing,
   i.e. every TX complete event triggers an IRQ and is directly served
   in the driver.

   Note:
   - Use "rx-usecs-irq=0" and "rx-frames-irq=1" to switch off RX
     coalescing, accordingly for TX.
   - Coalescing configuration is reset by ring configuration.
   - Configuration is only possible if the interface is down.

regards,
Marc



