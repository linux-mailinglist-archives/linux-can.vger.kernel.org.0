Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21863EE60A
	for <lists+linux-can@lfdr.de>; Tue, 17 Aug 2021 07:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhHQFJc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Aug 2021 01:09:32 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:54562 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhHQFJc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Aug 2021 01:09:32 -0400
Received: from MTA-13-3.privateemail.com (mta-13-1.privateemail.com [198.54.122.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id C91EB80981
        for <linux-can@vger.kernel.org>; Tue, 17 Aug 2021 01:08:58 -0400 (EDT)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 906CD18000AF;
        Tue, 17 Aug 2021 01:08:57 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.223])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 2DD3118000AD;
        Tue, 17 Aug 2021 01:08:57 -0400 (EDT)
From:   Matt Kline <matt@bitbashing.io>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Matt Kline <matt@bitbashing.io>, linux-can@vger.kernel.org
Subject: [PATCH v3 0/3] can: m_can: Merge FIFO ops to increase throughput
Date:   Mon, 16 Aug 2021 22:08:50 -0700
Message-Id: <20210817050853.14875-1-matt@bitbashing.io>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

As requested, I've propagated FIFO errors up to the m_can driver - on
failure we now log the error and disable interrupts, similar to
https://elixir.bootlin.com/linux/v5.13/source/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c#L2298

I've also folded the ID and DLC fields into a struct (as suggested) so
that we don't need to copy them to and from arrays for the FIFO transfers.

Following-up on
https://lore.kernel.org/linux-can/20210811063520.aw6hkll2kax22ytr@pengutronix.de/T/#u
Sorry for the slight delay - last week was busy!

Matt Kline (3):
  can: m_can: Disable IRQs on FIFO bus errors
  can: m_can: Batch FIFO reads during CAN receive
  can: m_can: Batch FIFO writes during CAN transmit

 drivers/net/can/m_can/m_can.c          | 221 ++++++++++++++++---------
 drivers/net/can/m_can/m_can.h          |   6 +-
 drivers/net/can/m_can/m_can_pci.c      |  11 +-
 drivers/net/can/m_can/m_can_platform.c |  15 +-
 drivers/net/can/m_can/tcan4x5x-core.c  |  16 +-
 5 files changed, 172 insertions(+), 97 deletions(-)

-- 
2.32.0

