Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1512DB76B
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 01:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgLPABY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 19:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgLOXZd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 18:25:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407F3C061794
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 15:17:58 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kpJZs-0002SZ-SA
        for linux-can@vger.kernel.org; Wed, 16 Dec 2020 00:17:56 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D5FBA5AE3C0
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 23:17:51 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id DA1205AE39D;
        Tue, 15 Dec 2020 23:17:49 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id dd2029f8;
        Tue, 15 Dec 2020 23:17:48 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>
Subject: [RFC]: tcan4x5x: rework regmap support
Date:   Wed, 16 Dec 2020 00:17:30 +0100
Message-Id: <20201215231746.1132907-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

this series first cleans up the the SPI regmap and then fixes several problem:
- tcan4x5x_regmap_gather_write(), tcan4x5x_regmap_read():
  Do not place variable "addr" on stack and use it as buffer for SPI
  transfer. Buffers for SPI transfers must be allocated from DMA save
  memory.
- tcan4x5x_regmap_gather_write(), tcan4x5x_regmap_read():
  Halfe number of SPI transfers by using a single buffer + memcpy().
  This improves the performance, especially on SPI controllers, which
  use interrupt based transfers.
- Use "8" bits per word, not "32". This makes it possible to use this
  driver on SoCs like the Raspberry Pi, which SPI host controller
  drivers only support 8 bits per word.

With this series, the driver is able to detect a tcan4x5x on a Raspberry Pi.

regards,
Marc



