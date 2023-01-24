Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CDF679D70
	for <lists+linux-can@lfdr.de>; Tue, 24 Jan 2023 16:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjAXP1i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 24 Jan 2023 10:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjAXP1h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 24 Jan 2023 10:27:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5F047090
        for <linux-can@vger.kernel.org>; Tue, 24 Jan 2023 07:27:34 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pKLCu-0006uL-OH
        for linux-can@vger.kernel.org; Tue, 24 Jan 2023 16:27:32 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3995D162AE1
        for <linux-can@vger.kernel.org>; Tue, 24 Jan 2023 15:27:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0A1B7162AD2;
        Tue, 24 Jan 2023 15:27:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id cf8c56cb;
        Tue, 24 Jan 2023 15:27:30 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
        kernel@pengutronix.de
Subject: [PATCH v1 0/2] can: mcp251xfd: better workaround broken TX FIFO STA register read
Date:   Tue, 24 Jan 2023 16:27:27 +0100
Message-Id: <20230124152729.814840-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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

this is an attempt to better workaround broken TX FIFO STA register
reads. This series implements a workaround similar to the "workaround
broken RX FIFO STA register read" [1] and should be applied to a
kernel tree containing that series.

This gets rid of the "Transmit Event FIFO buffer not empty/full", for
debugging purposes you can enable an error message by adding a
"#define DEBUG" in "drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c".

For every detected error the tx_fifo_error is increased.

[1] https://lore.kernel.org/all/20230119112842.500709-1-mkl@pengutronix.de

regards,
Marc



