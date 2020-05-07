Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3244E1C9996
	for <lists+linux-can@lfdr.de>; Thu,  7 May 2020 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgEGSqx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 7 May 2020 14:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgEGSqx (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 7 May 2020 14:46:53 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F1A20870;
        Thu,  7 May 2020 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877212;
        bh=8y1X0s6ChezuHL2SQivauYuiwtYVtJLamswoo4d7aOU=;
        h=Date:From:To:Cc:Subject:From;
        b=PZnNClT+lg6ffcbI+UN0rLjs9ggoy1CMTteo1UmYrZyGaYYmxl/XJB9rJVLhNMTKe
         S+DhD7/Ma0tctRvxEfiVTYM4FlWArq4S2RFUWMLXtF///otoRsihdHvAMWESUhV255
         e3isMjfS4dZfDv+s5aWAGWMoPgTW+aVuKPqSGXLU=
Date:   Thu, 7 May 2020 13:51:18 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] can: Replace zero-length array with flexible-array
Message-ID: <20200507185118.GA14022@embeddedor>
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
 include/linux/can/skb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index a954def26c0d..900b9f4e0605 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -34,7 +34,7 @@
 struct can_skb_priv {
 	int ifindex;
 	int skbcnt;
-	struct can_frame cf[0];
+	struct can_frame cf[];
 };
 
 static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)

