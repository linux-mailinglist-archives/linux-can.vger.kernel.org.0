Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C75C524D3D
	for <lists+linux-can@lfdr.de>; Thu, 12 May 2022 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353806AbiELMl6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 May 2022 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353804AbiELMl5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 May 2022 08:41:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB55966FAC
        for <linux-can@vger.kernel.org>; Thu, 12 May 2022 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652359316; x=1683895316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9907oBsU5tPbYJtdpEPd9TZfcSBDHSCF21Wa5FHr5ok=;
  b=Wr8JlVgjShLFzROoVBxMSWWednPr/msHokK/P1tCvstfNy3xYhoLNsJH
   oe0PhrGmdrbdsLO32n2apzaXE88rV0nFTowFoET+Nh1JAHAHKOd1U9WWh
   PWyrpvoLID8FyDhBPe6q5uP3A1KqzjZIFA7JBIPLZCR45wuXf0JUERmUH
   7PnNUFP3tifqwA7eeyTYXAaqTSO6OqrHdpm4a9inl5yECtwqK2D42ba98
   AxC09Bf1YWvzbo2US2pVuqFlk4sxRuB+nVzh87FuGTHndidwllYRAmKo9
   MoXvuCc6zeFcAC9HIGLSBMZnYd1SNklsciWZYOieBTJWma3S6vMLmY1QO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="330590996"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="330590996"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 05:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="542754626"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.150])
  by orsmga006.jf.intel.com with ESMTP; 12 May 2022 05:41:53 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Chee Hou Ong <chee.houx.ong@intel.com>,
        Aman Kumar <aman.kumar@intel.com>,
        Pallavi Kumari <kumari.pallavi@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] can: m_can: remove support for custom bit timing, take #2
Date:   Thu, 12 May 2022 15:41:44 +0300
Message-Id: <20220512124144.536850-2-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512124144.536850-1-jarkko.nikula@linux.intel.com>
References: <20220512124144.536850-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Now when Intel Elkhart Lake uses again common bit timing and there are
no other users for custom bit timing, we can bring back the changes done
by the commit 0ddd83fbebbc ("can: m_can: remove support for custom bit
timing").

This effectively reverts commit ea768b2ffec6 ("Revert "can: m_can: remove
support for custom bit timing"") while taking into account
commit ea22ba40debe ("can: m_can: make custom bittiming fields const")
and
commit 7d4a101c0bd3 ("can: dev: add sanity check in
can_set_static_ctrlmode()").

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/net/can/m_can/m_can.c | 24 ++++++------------------
 drivers/net/can/m_can/m_can.h |  3 ---
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e6d2da4a9f41..7582908e1192 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1492,34 +1492,22 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
 		if (err)
 			return err;
-		cdev->can.bittiming_const = cdev->bit_timing ?
-			cdev->bit_timing : &m_can_bittiming_const_30X;
-
-		cdev->can.data_bittiming_const = cdev->data_timing ?
-			cdev->data_timing :
-			&m_can_data_bittiming_const_30X;
+		cdev->can.bittiming_const = &m_can_bittiming_const_30X;
+		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_30X;
 		break;
 	case 31:
 		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
 		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
 		if (err)
 			return err;
-		cdev->can.bittiming_const = cdev->bit_timing ?
-			cdev->bit_timing : &m_can_bittiming_const_31X;
-
-		cdev->can.data_bittiming_const = cdev->data_timing ?
-			cdev->data_timing :
-			&m_can_data_bittiming_const_31X;
+		cdev->can.bittiming_const = &m_can_bittiming_const_31X;
+		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
 		break;
 	case 32:
 	case 33:
 		/* Support both MCAN version v3.2.x and v3.3.0 */
-		cdev->can.bittiming_const = cdev->bit_timing ?
-			cdev->bit_timing : &m_can_bittiming_const_31X;
-
-		cdev->can.data_bittiming_const = cdev->data_timing ?
-			cdev->data_timing :
-			&m_can_data_bittiming_const_31X;
+		cdev->can.bittiming_const = &m_can_bittiming_const_31X;
+		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
 
 		cdev->can.ctrlmode_supported |=
 			(m_can_niso_supported(cdev) ?
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 2c5d40997168..d18b515e6ccc 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -85,9 +85,6 @@ struct m_can_classdev {
 	struct sk_buff *tx_skb;
 	struct phy *transceiver;
 
-	const struct can_bittiming_const *bit_timing;
-	const struct can_bittiming_const *data_timing;
-
 	struct m_can_ops *ops;
 
 	int version;
-- 
2.35.1

