Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600D86736C9
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 12:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjASL2y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 06:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjASL2w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 06:28:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C395084B
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 03:28:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIT67-0003sZ-6L
        for linux-can@vger.kernel.org; Thu, 19 Jan 2023 12:28:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5BF2815D1A2
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 11:28:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 45FDD15D18A;
        Thu, 19 Jan 2023 11:28:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 04bdb290;
        Thu, 19 Jan 2023 11:28:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
        kernel@pengutronix.de
Subject: [PATCH v2 0/5] can: mcp251xfd: workaround broken RX FIFO STA register read
Date:   Thu, 19 Jan 2023 12:28:37 +0100
Message-Id: <20230119112842.500709-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

this is a to workaround for the broken RX FIFO STA register read
erratum found by Stefan Althöfer.

With the help of Thomas we found out that the chip has a time window
after receiving a CAN frame where the RX FIFO STA register content is
not read correctly.

From the driver's point of view, everything looks consistent at first,
but the head index of the chip is too large. This causes the driver to
rehandle old CAN frames that have already been processed.

The workaround uses the RX timestamp to distinguish between new and
old data. As soon as old data is found, processing is stopped.

The series applies against current net/main.

Happy testing,
Marc

Link: https://lore.kernel.org/all/FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM

Changes since v1: https://lore.kernel.org/all/20230111222042.1139027-1-mkl@pengutronix.de
all:
  - add proper patch description
  - added Tested-by
2/5 can: mcp251xfd: clarify the meaning of timestamp:
  - revisited new naming of variables and functions
    now we use ts_raw instead of tbc
4/5 can: mcp251xfd: rx: prepare to workaround broken RX:
  - precalculate shift width needed for full u8 instead of calculating
    it every time
5/5 can: mcp251xfd: rx: workaround broken RX FIFO head:
  - remove dumping of old CAN frame in error case
  - add erratum comments



