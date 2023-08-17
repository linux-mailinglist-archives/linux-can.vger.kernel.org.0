Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F343477F4BB
	for <lists+linux-can@lfdr.de>; Thu, 17 Aug 2023 13:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbjHQLGV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Aug 2023 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350177AbjHQLFt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2023 07:05:49 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F67B2D78
        for <linux-can@vger.kernel.org>; Thu, 17 Aug 2023 04:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=SbEBVByXgp8d3JT748tX+b4Sb0g3MXMurhjtahUd7lQ=; b=wV5CeWQ7z7fQfavbpxK11as5P+
        3o64llzkYQDIGQF0vWimS7UVZFoQzcGFjNJ2k57MH04ywOFzUUJr3T5mK1EjyGN3LMkUQHSptDDyZ
        uumHCqSld3s8ZF6jLn9rI6A4fXqckAT1BffPM2maGFPhVA1woyKJNlm0gEBsCpRDgOSmlI1Xw5pyc
        iSbnurWt6yuPS+g754KYQwPD90A8e8QoiULNnyGQoLytrKV0dlR0/kdJHgdy2iQudh+U6tG1kzU84
        JIMU6LzbhMNyKQZsBNcAbiD8DivSgT0j1LGxbPZ+WnVE/kkNPMe5ajD3YXEWPHudij/oInDRrbRMv
        59FrcIng==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qWap0-000JGJ-Qo; Thu, 17 Aug 2023 13:05:46 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qWap0-0000oc-Hx; Thu, 17 Aug 2023 13:05:46 +0200
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH] can: ip: support hw-filter setting
Date:   Thu, 17 Aug 2023 13:05:43 +0200
Message-ID: <20230817110543.3497080-1-martin@geanix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817101014.3484715-1-martin@geanix.com>
References: <20230817101014.3484715-1-martin@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/27003/Thu Aug 17 09:42:42 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

Just for refernce, this patch can be used on latest iproute2 when
testing the hardware filtering support. It is based on
https://marc.info/?l=linux-can&m=151949929522529 but rebased to latest
master, where other new flags have been introduced.

 include/uapi/linux/can/netlink.h |  1 +
 ip/iplink_can.c                  | 82 +++++++++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 8ec98c21..0f6d0bf6 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -138,6 +138,7 @@ enum {
 	IFLA_CAN_BITRATE_MAX,
 	IFLA_CAN_TDC,
 	IFLA_CAN_CTRLMODE_EXT,
+	IFLA_CAN_HW_FILTER,
 
 	/* add new constants above here */
 	__IFLA_CAN_MAX,
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index f2967db5..e0b5c8fc 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -8,13 +8,20 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <errno.h>
 
+#include <linux/can.h>
 #include <linux/can/netlink.h>
 
 #include "rt_names.h"
 #include "utils.h"
 #include "ip_common.h"
 
+#define CAN_HW_FILTER_MAX 200
+#define CAN_NLMAXLEN (2*sizeof(struct can_bittiming) + \
+		      sizeof(struct can_ctrlmode) + \
+		      CAN_HW_FILTER_MAX*sizeof(struct can_filter))
+
 static void print_usage(FILE *f)
 {
 	fprintf(f,
@@ -42,6 +49,8 @@ static void print_usage(FILE *f)
 		"\n"
 		"\t[ termination { 0..65535 } ]\n"
 		"\n"
+		"\t[ hw-filter can_id:can_mask[,can_id:can_mask]+ ]\n"
+		"\n"
 		"\tWhere: BITRATE	:= { NUMBER in bps }\n"
 		"\t	  SAMPLE-POINT	:= { 0.000..0.999 }\n"
 		"\t	  TQ		:= { NUMBER in ns }\n"
@@ -263,14 +272,14 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
-			addattr32(n, 1024, IFLA_CAN_RESTART, val);
+			addattr32(n, CAN_NLMAXLEN, IFLA_CAN_RESTART, val);
 		} else if (matches(*argv, "restart-ms") == 0) {
 			__u32 val;
 
 			NEXT_ARG();
 			if (get_u32(&val, *argv, 0))
 				invarg("invalid \"restart-ms\" value\n", *argv);
-			addattr32(n, 1024, IFLA_CAN_RESTART_MS, val);
+			addattr32(n, CAN_NLMAXLEN, IFLA_CAN_RESTART_MS, val);
 		} else if (matches(*argv, "termination") == 0) {
 			__u16 val;
 
@@ -278,7 +287,68 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (get_u16(&val, *argv, 0))
 				invarg("invalid \"termination\" value\n",
 				       *argv);
-			addattr16(n, 1024, IFLA_CAN_TERMINATION, val);
+			addattr16(n, CAN_NLMAXLEN, IFLA_CAN_TERMINATION, val);
+		} else if (matches(*argv, "hw-filter") == 0) {
+			struct can_filter cfi;
+			struct can_filter *cfi_msg;
+			char *ptr, *nptr;
+			unsigned int num_cfi = 0;
+			unsigned int i = 0;
+
+			NEXT_ARG();
+
+			/* dry run to get the number of valid filters */
+			ptr = *argv;
+			if (sscanf(ptr, "%x:%x", &cfi.can_id, &cfi.can_mask) == 2)
+				num_cfi++;
+			else
+				invarg("invalid \"hw-filter\" value\n", *argv);
+
+			nptr = strchr(ptr, ','); /* check for next filter */
+			while (nptr && num_cfi < CAN_HW_FILTER_MAX) {
+
+				ptr = nptr+1; /* hop behind the ',' */
+				nptr = strchr(ptr, ','); /* update exit condition */
+
+				if (sscanf(ptr, "%x:%x", &cfi.can_id, &cfi.can_mask) == 2)
+					num_cfi++;
+				else
+					invarg("invalid \"hw-filter\" value\n", *argv);
+			}
+
+			cfi_msg = malloc(num_cfi * sizeof(cfi));
+			if (!cfi_msg) {
+				perror("CAN hw-filter malloc");
+				return -ENOMEM;
+			}
+
+			/* second run to really fill the filter message */
+			ptr = *argv;
+			if (sscanf(ptr, "%x:%x", &cfi_msg[i].can_id, &cfi_msg[i].can_mask) == 2)
+				i++;
+			else
+				invarg("invalid \"hw-filter\" value\n", *argv);
+
+			nptr = strchr(ptr, ','); /* check for next filter */
+			while (nptr && i < CAN_HW_FILTER_MAX) {
+
+				ptr = nptr+1; /* hop behind the ',' */
+				nptr = strchr(ptr, ','); /* update exit condition */
+
+				if (sscanf(ptr, "%x:%x", &cfi_msg[i].can_id, &cfi_msg[i].can_mask) == 2)
+					i++;
+				else
+					invarg("invalid \"hw-filter\" value\n", *argv);
+			}
+
+			/* double check the second scan result */
+			if (num_cfi != i) {
+				printf("CAN hw-filter: second filter scan failed.\n");
+				return -EINVAL;
+			}
+
+			addattr_l(n, CAN_NLMAXLEN, IFLA_CAN_HW_FILTER, cfi_msg, num_cfi * sizeof(cfi));
+			free(cfi_msg);
 		} else if (matches(*argv, "help") == 0) {
 			usage();
 			return -1;
@@ -291,11 +361,11 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 	}
 
 	if (bt.bitrate || bt.tq)
-		addattr_l(n, 1024, IFLA_CAN_BITTIMING, &bt, sizeof(bt));
+		addattr_l(n, CAN_NLMAXLEN, IFLA_CAN_BITTIMING, &bt, sizeof(bt));
 	if (dbt.bitrate || dbt.tq)
-		addattr_l(n, 1024, IFLA_CAN_DATA_BITTIMING, &dbt, sizeof(dbt));
+		addattr_l(n, CAN_NLMAXLEN, IFLA_CAN_DATA_BITTIMING, &dbt, sizeof(dbt));
 	if (cm.mask)
-		addattr_l(n, 1024, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
+		addattr_l(n, CAN_NLMAXLEN, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
 
 	if (tdcv != -1 || tdco != -1 || tdcf != -1) {
 		tdc = addattr_nest(n, 1024, IFLA_CAN_TDC | NLA_F_NESTED);
-- 
2.41.0

