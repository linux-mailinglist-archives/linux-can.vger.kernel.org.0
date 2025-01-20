Return-Path: <linux-can+bounces-2667-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D453EA17014
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 17:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A04E167560
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 16:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED9D1E411D;
	Mon, 20 Jan 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="N6FrOof3"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013024.outbound.protection.outlook.com [52.101.67.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7421E9B0E
	for <linux-can@vger.kernel.org>; Mon, 20 Jan 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390243; cv=fail; b=hFMMCag0KQtuU21KrjGqFv2Ej76HITlywCLSMlbNdwcPzHMEuhqWn6WphEGA0kiwIie6F3dU+07iZfPqsiFHEk1kaAb4zPGIeWlSa0bzZNz3B+oaBXVyj0G20G+8yDoDmFklxouf68sJcO3ZVLtoSsDnZISvF5lIWbEiPLsQe30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390243; c=relaxed/simple;
	bh=rHiv2MbGu/D6SuuCRCe33g4yc6FT+b87LZh2RUPHyRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCFxBSdZebdAOjViinc8DZ3GzRNmWkWsFOWMZUUah60n4zIsjO4rOR7WMLUcQsFpxdmsKWDEPlb0FoB54kwIK1Awotma0S9MLHP6Y9MfQKUogW4gzWSuhncY4lQLJqazZzJjPrybAhN8c7bgbjLllcvudZZ//5srQ0rF2u+4sU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=N6FrOof3; arc=fail smtp.client-ip=52.101.67.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE2CCriOKvkYULpT7Z1Lt5fa7m/yxUkVy3Tej0xcV2MpwtdQkQE7L+Fik4dOJpav6bm0k700l4oJIto/jfrAYPBh/2iVMJFC2eOlcCy9XvbbQ5m9DJL+4NibJTFr5EYfFouKiOTkbDYoUoWjlMBpfQL91NtMTxNRgCLdvstqCbwKh4jmDozlyoco86paUgKqWA0hwYWtXiuvDaxA0ecZ+7Q3bt2tGB2k0PftHU93lofXWC7eoiUG47IOk9f6+C33Ed1OngYv4KLoZefKMNL29iASbhjO/5Fx4z6wImvOyrcA9rZdVPEk+XbjHbst9AwTGvOkDqYBKB4v22ATvA+nAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2O57WqkjQkI8fC9hgGMVnyZK5xXJrS3kflC8DcaG44=;
 b=xSnoC3dLjwlSU51W5RYtaEpJX7SqG2cXYM03tRWaj+92Q0akLlnM73sjOgXOavLS0sImZma9Bx9vH73UC8ytsQJv4In/qSyWGJ7WXbaR5ixFruK8bjHrqkPI9N8VhsrxW5J2l0YtjyAfv/ub73AdQf6oWfy1X7UvFT21sAxVoSVf/s6jtj6SZasA26CjkAc/wFj0tCnFu0k/TrRw1USxFWWGUJZO/3OCM8+FxYtXrrB03Za79bEkQV9Nt94iWcFN1EXt7Eu0c26IIiyIFPX8coK4WxPlsd+9KfzHMVp4QZ5CGeSIKCl+t3N07z3vT3Bl549WfVbpH8v0gkRxts334Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2O57WqkjQkI8fC9hgGMVnyZK5xXJrS3kflC8DcaG44=;
 b=N6FrOof3wVH2jXXdou7Amhiec0vadAPMoEzwDbC01rEnqr9HZlsuxeTDLZWjiCjXms25MNrIznAomVtr5/ynPBkl13xFiJxnGl6EYfBMJ/VJxlG0/GA8CveFGR+oV4UvjZfdsM5TJIM3085QrPpWgRHlFF5ooFBnE9YmCr1aJLJ2KVffhYAKdYbu5fKhfVqkCK/48aB+HxH8BrD1cJ/6hor/t5YAeRn3ebk6hyZTOIAR7VJxZ1+gtDZKDa0fZwd2y6heSMOSCYupt6dg7Lay4Q7DhZQRNHhPxgu4UgVLCEJnTHW2JMZFHs+qWspi9Wzao3yT6jP42XBMi1q1tYjuYQ==
Received: from DB8PR06CA0033.eurprd06.prod.outlook.com (2603:10a6:10:100::46)
 by GV2PR10MB6042.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.14; Mon, 20 Jan
 2025 16:23:56 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:100:cafe::12) by DB8PR06CA0033.outlook.office365.com
 (2603:10a6:10:100::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Mon,
 20 Jan 2025 16:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 16:23:55 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Mon, 20 Jan
 2025 17:23:50 +0100
Received: from GRB-C-0009M.ot.de.bosch.com (10.139.217.196) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Mon, 20 Jan 2025 17:23:49 +0100
From: <mark.jonas@de.bosch.com>
To: <linux-can@vger.kernel.org>
CC: <mkl@pengutronix.de>, Zhu Yi <yi.zhu5@cn.bosch.com>, Hubert Streidl
	<hubert.streidl@de.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>
Subject: [can-utils][PATCH 2/3] canbusload: support busload statistic
Date: Mon, 20 Jan 2025 17:23:31 +0100
Message-ID: <20250120162332.19157-2-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120162332.19157-1-mark.jonas@de.bosch.com>
References: <20250120162332.19157-1-mark.jonas@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|GV2PR10MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 1784cd6f-4c76-400b-f767-08dd396ed638
X-LD-Processed: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?nog6pI1idVRe54gsHRom5nFNDvMcS0E68E9bEVK2DBFpqLfpguw6UJzFnGK0?=
 =?us-ascii?Q?Voa80d7RDIt3Vw6W/VYM8i1b2XnUYmAkveiwSppfyQdES0TUPFcPlPl5eEUo?=
 =?us-ascii?Q?CPz1G9M/uNWjXHK22ZDRsNy+9qjC+QfwAjxxnte7fgXV/QkuZVis5APwYOT8?=
 =?us-ascii?Q?z525uT1JahgDqXZYA+DOn+zdGznmNq+3q/BL2D9x6eEJa2DQTgEYEmme61Yi?=
 =?us-ascii?Q?q65+SO3BbRWHR1K6OUBo2oiki6Fni00W2pkqbMMUdYfRABMHyr4ByWov/Dx/?=
 =?us-ascii?Q?qmceeM4rpMJsQblv0uaE4KtVSHBo/BYQImhf6VfCnjtcQjhea1jp8kaBWvgM?=
 =?us-ascii?Q?PkMQlSz04t3EN51HIwu95KEnzcu4QBcDKyOKQkgeRrTcQU6WicyVugc4PQr7?=
 =?us-ascii?Q?MXBdeWrDLyRE9tR1L9LzrYguR8aRoT5QnM41tSaeI3RfG6CGGeTJslfy3L6l?=
 =?us-ascii?Q?ovmsPz6c9ESVZVnlhDwDy5aQ1xprBsspc5JvtDC+OMJLVcbkpuZeWcwxZsdS?=
 =?us-ascii?Q?hXyXA/kCn1A2q7z5wCPE2vOYLf+m4QRsLKQGUCanEo17UnMtFqUAo20A882V?=
 =?us-ascii?Q?gAegQCfIGOuNzdfZI4kVWge4jXse1TbtbRdSKAjWl0OOWNX9v2vKZbxAZnZM?=
 =?us-ascii?Q?ywhON6lkPD2FFS/az4ZkdpDDFuzXw1ZPkK089W4vzwA5uZ9+wpPtZtZql/ua?=
 =?us-ascii?Q?sVYPUEN64T5ma24c9Sc9MWuBfiDqmiGOw5SQq23HfL+tOOBuea+8uQQSrjxU?=
 =?us-ascii?Q?Fxx3VJG18KZEtfuyGChUhhlNQW83O3KYgwmx/dFW2qvAEqSLRE0YlXbrEY92?=
 =?us-ascii?Q?i/cwpd5Mcjpq5lLIC71bQYCiRgntbZzBqqBhnArjLdOXfMM0yPs5C20Mgxh1?=
 =?us-ascii?Q?U2bB73ipX6yBwKRWXCd36xnBFVjbb39qykkStFGz8zGSSv4QjgtCTE1nZZ/U?=
 =?us-ascii?Q?TQ9x7wZladzrjcZh860ygwqb9GUt8uDiD0Mxq2GeI3eDc3KxQ3xTs1gekN13?=
 =?us-ascii?Q?Koe0gjhQfoe7b/gEIV9/CR6YvMTxtvnuOKx+yoRNrhiai3SV41HNoWGyRc8i?=
 =?us-ascii?Q?PK0DepWSQxPEla5gjhkIOrDdkGxLYRNJGkjbZyKiy7P/c8gSvoy4FdqdH3X7?=
 =?us-ascii?Q?GvWZOpzHTDMI+omU6vRUsuAEnKCju4/TAU0QgIKpR0b5irf7/g2ZDnDnomyY?=
 =?us-ascii?Q?6qC3z1VJM8UP1tI1qMzyRuTjVP9W+cRHrmXIXlDkYnG+Y0eFFn7I8gFg7CF1?=
 =?us-ascii?Q?rkzqboANL+9hD1heWFs1SGhp6MCYyrqJwCIGKG0AvlVN3CREeBZzicaiCTeT?=
 =?us-ascii?Q?j1/Nh/o/V5bjXMUH8l2b5oqazWkDg/JkX1b04UDHZVFs7htqRC5rkGS9E/5D?=
 =?us-ascii?Q?AvBvkb2gV+Bwo6SpmYp4ePtJ6UzfpvYVMDrSaiNYgAV19f2O2T7Aw9GCy9n/?=
 =?us-ascii?Q?BZfSluETpvfVnKwfcvpDJf1xnvrPVD71?=
X-Forefront-Antispam-Report:
 CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:23:55.8784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1784cd6f-4c76-400b-f767-08dd396ed638
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6042

From: Zhu Yi <yi.zhu5@cn.bosch.com>

Add '-s' option for display busload statistic, the output contains
minimal, maximum and exponentially-damped moving sums of one second
average (borrowed from Linux load average algorithm) since start or
reset (press 'r' while running).

canbusload 2024-09-23 17:15:18 (exact bitstuffing)
 can0@500k   942  107535   60168       0  18% min:  0%, max: 21%, load: 16%   6%   2% |XXX.................|

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Hubert Streidl <hubert.streidl@de.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 canbusload.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/canbusload.c b/canbusload.c
index 753d658..577d99c 100644
--- a/canbusload.c
+++ b/canbusload.c
@@ -48,11 +48,13 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <termios.h>
 #include <time.h>
 #include <unistd.h>
 
 #include <net/if.h>
 #include <sys/ioctl.h>
+#include <sys/param.h>
 #include <sys/socket.h>
 #include <sys/time.h>
 #include <sys/types.h>
@@ -72,6 +74,34 @@
 #define NUMBAR (100 / PERCENTRES) /* number of bargraph elements */
 #define BRSTRLEN 20
 
+/*
+ * Inspired from
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
+ * include/linux/sched/loadavg.h
+ *
+ * Following are the fixed-point math constants and the exponential-damping
+ * factors for:
+ *  - 1 samples/s in 1 minute
+ *  - 1 samples/s in 5 minutes
+ *  - 1 samples/s in 15 minutes
+ * in fixed-point representation.
+ */
+#define FP_SHIFT 12              /* bits of precision */
+#define FP_ONE   (1 << FP_SHIFT) /* 1.0 fixed-point representation */
+#define EXP_1    4028            /* (1 / e ^ (1 /  60)) * FP_ONE */
+#define EXP_5    4082            /* (1 / e ^ (1 / 300)) * FP_ONE */
+#define EXP_15   4091            /* (1 / e ^ (1 / 900)) * FP_ONE */
+
+inline unsigned int calc_load(unsigned int load_fp,
+                              unsigned int exp_fp,
+                              unsigned int sample)
+{
+	unsigned int sample_fp  = sample << FP_SHIFT;
+	unsigned int damped_sum = (load_fp * exp_fp) +
+	                          (sample_fp * (FP_ONE - exp_fp));
+	return damped_sum >> FP_SHIFT;
+}
+
 extern int optind, opterr, optopt;
 
 static struct {
@@ -85,6 +115,11 @@ static struct {
 	unsigned int recv_bits_total;
 	unsigned int recv_bits_payload;
 	unsigned int recv_bits_dbitrate;
+	unsigned int load_min;
+	unsigned int load_max;
+	unsigned int load_1m;
+	unsigned int load_5m;
+	unsigned int load_15m;
 } stat[MAXDEVS + 1];
 
 static volatile int running = 1;
@@ -96,8 +131,11 @@ static unsigned char redraw;
 static unsigned char timestamp;
 static unsigned char color;
 static unsigned char bargraph;
+static unsigned char statistic;
+static unsigned char reset;
 static enum cfl_mode mode = CFL_WORSTCASE;
 static char *prg;
+static struct termios old;
 
 static void print_usage(char *prg)
 {
@@ -111,6 +149,7 @@ static void print_usage(char *prg)
 	fprintf(stderr, "         -r  (redraw the terminal - similar to top)\n");
 	fprintf(stderr, "         -i  (ignore bitstuffing in bandwidth calculation)\n");
 	fprintf(stderr, "         -e  (exact calculation of stuffed bits)\n");
+	fprintf(stderr, "         -s  (show statistics, press 'r' to reset)\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "Up to %d CAN interfaces with mandatory bitrate can be specified on the \n", MAXDEVS);
 	fprintf(stderr, "commandline in the form: <ifname>@<bitrate>[,<dbitrate>]\n");
@@ -234,6 +273,30 @@ static void printstats(int signo)
 		       stat[i].recv_bits_dbitrate,
 		       percent);
 
+		if (statistic) {
+			if (reset) {
+				stat[i].load_min = UINT_MAX;
+				stat[i].load_max = 0;
+				stat[i].load_1m = 0;
+				stat[i].load_5m = 0;
+				stat[i].load_15m = 0;
+			}
+
+			stat[i].load_min = MIN(stat[i].load_min, percent);
+			stat[i].load_max = MAX(stat[i].load_max, percent);
+
+			stat[i].load_1m = calc_load(stat[i].load_1m, EXP_1, percent);
+			stat[i].load_5m = calc_load(stat[i].load_5m, EXP_5, percent);
+			stat[i].load_15m = calc_load(stat[i].load_15m, EXP_15, percent);
+
+			printf(" min:%3d%%, max:%3d%%, load:%3d%% %3d%% %3d%%",
+			       stat[i].load_min,
+			       stat[i].load_max,
+			       (stat[i].load_1m + (FP_ONE >> 1)) >> FP_SHIFT,
+			       (stat[i].load_5m + (FP_ONE >> 1)) >> FP_SHIFT,
+			       (stat[i].load_15m + (FP_ONE >> 1)) >> FP_SHIFT);
+		}
+
 		if (bargraph) {
 
 			printf(" |");
@@ -264,6 +327,8 @@ static void printstats(int signo)
 		stat[i].recv_direction = '.';
 	}
 
+	reset = 0;
+
 	if (!redraw)
 		printf("\n");
 
@@ -272,6 +337,11 @@ static void printstats(int signo)
 	alarm(1);
 }
 
+void cleanup()
+{
+	tcsetattr(STDIN_FILENO, TCSANOW, &old);
+}
+
 int main(int argc, char **argv)
 {
 	fd_set rdfs;
@@ -289,6 +359,14 @@ int main(int argc, char **argv)
 	unsigned int anydev_dbitrate = 0;
 	char anydev_bitratestr[BRSTRLEN]; /* 100000/2000000 => 100k/2M */
 
+	struct termios temp;
+
+	tcgetattr(STDIN_FILENO, &old);
+	atexit(cleanup);
+	temp = old;
+	temp.c_lflag &= ~(ICANON | ECHO);
+	tcsetattr(STDIN_FILENO, TCSANOW, &temp);
+
 	signal(SIGTERM, sigterm);
 	signal(SIGHUP, sigterm);
 	signal(SIGINT, sigterm);
@@ -297,7 +375,7 @@ int main(int argc, char **argv)
 
 	prg = basename(argv[0]);
 
-	while ((opt = getopt(argc, argv, "rtbcieh?")) != -1) {
+	while ((opt = getopt(argc, argv, "rtbciesh?")) != -1) {
 		switch (opt) {
 		case 'r':
 			redraw = 1;
@@ -323,6 +401,11 @@ int main(int argc, char **argv)
 			mode = CFL_EXACT;
 			break;
 
+		case 's':
+			statistic = 1;
+			reset = 1;
+			break;
+
 		default:
 			print_usage(prg);
 			exit(1);
@@ -449,12 +532,19 @@ int main(int argc, char **argv)
 	while (running) {
 		FD_ZERO(&rdfs);
 		FD_SET(s, &rdfs);
+		FD_SET(STDIN_FILENO, &rdfs);
 
 		if (select(s + 1, &rdfs, NULL, NULL, NULL) < 0) {
 			//perror("pselect");
 			continue;
 		}
 
+		if (FD_ISSET(STDIN_FILENO, &rdfs)) {
+			if (getchar() == 'r') {
+				reset = 1;
+			}
+		}
+
 		/* these settings may be modified by recvmsg() */
 		iov.iov_len = sizeof(frame);
 		msg.msg_namelen = sizeof(addr);
-- 
2.34.1


