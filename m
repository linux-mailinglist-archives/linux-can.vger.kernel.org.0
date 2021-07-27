Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411CF3D6BA8
	for <lists+linux-can@lfdr.de>; Tue, 27 Jul 2021 03:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhG0BTU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 21:19:20 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:55794 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233249AbhG0BTT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 21:19:19 -0400
Received: from MTA-08-3.privateemail.com (mta-08-1.privateemail.com [68.65.122.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 9EE1380090
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 21:59:46 -0400 (EDT)
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
        by mta-08.privateemail.com (Postfix) with ESMTP id 60EB218000A2;
        Mon, 26 Jul 2021 21:59:45 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.244])
        by mta-08.privateemail.com (Postfix) with ESMTPA id F403B1800183;
        Mon, 26 Jul 2021 21:59:44 -0400 (EDT)
From:   Matt Kline <matt@bitbashing.io>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Matt Kline <matt@bitbashing.io>, linux-can@vger.kernel.org
Subject: [PATCH v2 0/2] can: m_can: Merge FIFO ops to increase throughput
Date:   Mon, 26 Jul 2021 18:58:53 -0700
Message-Id: <20210727015855.17482-1-matt@bitbashing.io>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

While debugging low throughput on a tcan4x5x chip using a logic
analyzer, I found that the SPI bus is silent for the *vast* majority of
time spent sending or receiving a CAN frame.
Each SPI transfer takes ~5 microseconds, but there's an order of
magnitude more time (50-60 microseconds) between them. This doesn't seem
to be caused by any sort of contention - it happens on a SPI bus with a
single chip select and no other drivers accessing it. Presumably there's
a (relatively) large fixed cost to request a transfer from the SPI
controller on the hardware I'm using (an NVIDIA Jetson platform).

Let's improve throughput by combining FIFO reads and writes into larger
transfers - one for ID & DLC, one for the frame data - instead of
handling single words at a time. We could reduce the number of transfers
further by batching certain control register reads, but this is an easy
place to start, since FIFO registers are contiguous.

Since TX and RX time is dominated by the fixed, per-transfer delays
mentioned above, this nets substantial performance improvements - about
20% faster for small CAN frames and nearly 5x faster for max size
(64 byte) CAN FD frames.

This is a resend of a previous patch set, updated to use FIELD_PREP()
and friends - I fear the first one got eaten by a spam filter due to
some SMTP flub on my end.

Matt Kline (2):
  can: m_can: Batch FIFO reads during CAN receive
  can: m_can: Batch FIFO writes during CAN transmit

 drivers/net/can/m_can/m_can.c          | 80 +++++++++++++-------------
 drivers/net/can/m_can/m_can.h          |  4 +-
 drivers/net/can/m_can/m_can_pci.c      | 11 ++--
 drivers/net/can/m_can/m_can_platform.c | 11 ++--
 drivers/net/can/m_can/tcan4x5x-core.c  | 12 ++--
 5 files changed, 61 insertions(+), 57 deletions(-)

-- 
2.32.0

