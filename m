Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441581C9995
	for <lists+linux-can@lfdr.de>; Thu,  7 May 2020 20:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgEGSqn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 7 May 2020 14:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgEGSqn (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 7 May 2020 14:46:43 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926952145D;
        Thu,  7 May 2020 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877203;
        bh=/TMN0lGZvihKadpmMuNf26UHOuRy1VAvFM+rEIbmEWw=;
        h=Date:From:To:Cc:Subject:From;
        b=mlWwbPq2jZykelvTIJ9s6B5u8cek58y3jhaZyweFDN9pJri2yF42B5jVsOe9pzupO
         qNPWAhrdQoLXs0GTAbLIPHgEOko5vNGqxGuQlaBCK17SjCRy40htWKzNCReWlDvJjE
         sLM6eAoaY0sRuPdr2CjPDv2a+aoULpdQXKRY/f/w=
Date:   Thu, 7 May 2020 13:51:09 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] can: peak_canfd: Replace zero-length array with
 flexible-array
Message-ID: <20200507185109.GA14002@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/can/peak_canfd/peak_pciefd_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index d08a3d559114..6ad83a881039 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -146,7 +146,7 @@ struct pciefd_rx_dma {
 	__le32 irq_status;
 	__le32 sys_time_low;
 	__le32 sys_time_high;
-	struct pucan_rx_msg msg[0];
+	struct pucan_rx_msg msg[];
 } __packed __aligned(4);
 
 /* Tx Link record */
@@ -194,7 +194,7 @@ struct pciefd_board {
 	struct pci_dev *pci_dev;
 	int can_count;
 	spinlock_t cmd_lock;		/* 64-bits cmds must be atomic */
-	struct pciefd_can *can[0];	/* array of network devices */
+	struct pciefd_can *can[];	/* array of network devices */
 };
 
 /* supported device ids. */

