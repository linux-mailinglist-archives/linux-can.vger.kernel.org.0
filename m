Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9090F73E1
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 13:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfKKMaY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Nov 2019 07:30:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:4071 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfKKMaX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 11 Nov 2019 07:30:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 04:30:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="206729801"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Nov 2019 04:30:22 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iU8pp-0003j6-DO; Mon, 11 Nov 2019 20:30:21 +0800
Date:   Mon, 11 Nov 2019 20:29:30 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andreas Werner <andreas.werner@men.de>
Cc:     kbuild-all@lists.01.org, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC PATCH mkl-can-next] net: can: men_z192_set_can_state() can be
 static
Message-ID: <20191111122930.xnibjgoh74klwlzl@4978f4969bb8>
References: <201911112029.HTDjx7at%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911112029.HTDjx7at%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


Fixes: ee2172710a15 ("net: can: Introduce MEN 16Z192-00 CAN controller driver")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 men_z192_can.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/men_z192_can.c b/drivers/net/can/men_z192_can.c
index d3acc2e8ba090..e89b5e7641756 100644
--- a/drivers/net/can/men_z192_can.c
+++ b/drivers/net/can/men_z192_can.c
@@ -643,7 +643,7 @@ static void men_z192_init_idac(struct net_device *ndev)
 	writel(0xffffffff, &regs->idmr_4_to_7);
 }
 
-void men_z192_set_can_state(struct net_device *ndev)
+static void men_z192_set_can_state(struct net_device *ndev)
 {
 	struct men_z192 *priv = netdev_priv(ndev);
 	struct men_z192_regs __iomem *regs = priv->regs;
