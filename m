Return-Path: <linux-can+bounces-2666-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC51A17013
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 17:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2ED7A1AAD
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2025 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7419BA6;
	Mon, 20 Jan 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="o8Z71EJO"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704311E9B14
	for <linux-can@vger.kernel.org>; Mon, 20 Jan 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390238; cv=fail; b=QLf2azijFNy5yL2mVayi2FS312H9+3ysmgRX1qmjDHSd+GYMpoQK4j1DaMsgZF5ASYcWCTtQwWHMlPgqUfOurKDitw27f7DOrcQL9a+gBVrdIHyZ/0zB/OAzZJg5b7dfQ3JOuKE52iPmij7EDhrX4Hx0y+5o7aHZ3ZmVpNxOcY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390238; c=relaxed/simple;
	bh=v0KHkSop+AgpRV1ZMx4DPx0xI+5kVKrSm7EKXhW4CLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpGCNvAiZkpqfr7j+4nmjurZJHWMUTWXedxCmDRWuE4Ji1IeZV3YHP/RtMCHkE+7H7tFlWJaqzCRPF/KHO0Y3tcVW4k2ZgVMnfabc43S7RQXo4hik3N3dT2c68qw80VCFBYNsURwZovGFGTojkKUV4oRGVqW4VKbNHUo7oAK1AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=o8Z71EJO; arc=fail smtp.client-ip=40.107.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2PNqt9fYlVKfjoVDi3UXbX7v0mS15PZXkB8fSvIlJtYtDzW9tT4EQRjPgbkEkLPynEp3UleqO7fi8Lyoeo6aDjBMYEevOcRFVVkWjOeL8D88pjtWsYFmwE05ZsKIUaTvqJryHPrUqDvbvXiG5r8CM7vGcV5iDBotT0UFo/OVY2pwToxsHXRqzOJqpAUzb/CXWhNnKjmEE72aq0KdD+z2O3mad+M5/cmCGHs4fD/lhcLMDK9uB3SyQT5id1vtyuvinWr/PuXACZbt0Lh03F480dp+ROsrFF1amP437BnWzkHwMxTimVNTfk6ZNjYtYOjEgylKsqkGE2joilQl712gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AA69U8lZDxfn9jecAPK+ohzaZMMx8nDRdTdNlzfNXI=;
 b=O47XjLpSpnC8kz19FrkcGBIBHlSD8EqzuB+a75597tedSXiv3osAbQnehWOTv09omQJQ89tX9GGB8mT0rCIvI+DLRbn9wwMdt5LBmaj78SgmMnRqPoMuxqbIK6anf8fOEJctdwXxBcyi5NAePrrYtjF4VjvN4UNsCLcSMUN/JlsktIphJOTD3cP8WptQsrjp54ey2JFt5Pbg7opG91f/8W5Uj49HMWYPFF/HIX2spQuf8kUt8U3mXaLO0Wuyz1xm2hz33Fkx1tf7SK+lUHlxtV5q+QWHrRnvOPNqxJz4bKSgUTSzHYGNxpFm2LIqwuW2GGdQEGmf0m5zWtSemyI4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AA69U8lZDxfn9jecAPK+ohzaZMMx8nDRdTdNlzfNXI=;
 b=o8Z71EJOGUyZSsT9AiAb2uxD0Oe9uy7ydiqpuoCJhml8oOo+Zq7wXdqoFGdb10zhWuvnkH7wb/IQITGBVQID6mNvAbG/tbtDWS0NO0zANm5Zx18vsVvP9g/wri0iHlnNvkck8QycpHAVlOWwacDIge80cwA+FHh6GQWZAnYRHx2flRdinhqRskOcHHKgC2j43ysSAYQk4+UqXhJnVIxs+97sybLbZhL9bgSiVvSDX4/HUfvUaNWrlzPXOEVv8qpC2TQbY8uCxzGyqUiZneFPn0wwCZkb3B9PwyoDEMpemVzGFSAos/rV2xlVmP5BPC9/LH7FTX8xqQEUthW+LrPTUw==
Received: from AS9PR06CA0164.eurprd06.prod.outlook.com (2603:10a6:20b:45c::15)
 by DB8PR10MB3273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.13; Mon, 20 Jan
 2025 16:23:50 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:20b:45c:cafe::bc) by AS9PR06CA0164.outlook.office365.com
 (2603:10a6:20b:45c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Mon,
 20 Jan 2025 16:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Mon, 20 Jan 2025 16:23:50 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [can-utils][PATCH 3/3] canbusload: support busload visualization
Date: Mon, 20 Jan 2025 17:23:32 +0100
Message-ID: <20250120162332.19157-3-mark.jonas@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|DB8PR10MB3273:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7392d3-c85c-4107-de17-08dd396ed2e7
X-LD-Processed: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?176CTfXCRFk5r+ATUPeJHHrEIyChHoTdv63giYy8yX5JWpaCuMT4ETEUIGhz?=
 =?us-ascii?Q?NiDzkKkwt7gK+gz2BCCF4oki3Dn3FfK0s+zD9jq5Wyu9pfQezQq0QAtzbNz7?=
 =?us-ascii?Q?OlFEzGf0+Owp/XpUc5G7xVrsBiZC4Qx1k/EydNfdgWh9ketDnED+B0Zz8GRR?=
 =?us-ascii?Q?bcfCBSWsONxBJ28A4nt9BpnUEiVxWwff4M/TItSRIgu52/YZB/Nn6o44hiHQ?=
 =?us-ascii?Q?G19RFH4UiLsCn2nkqAwI8znIwiTVXC2DMKzYSH3WOgn+hdfzLuHHzbjSYZPZ?=
 =?us-ascii?Q?+7fPKjFsf/aUO9rQcLlPw3+877k6yvEANEbnu+Ph+81EQrpzarTnNfbW/wmR?=
 =?us-ascii?Q?cCFgZo96rFaq01N3kIl17zbysUiv869VtcFAKLQjepVBnPFjIyLQzWCg7p0d?=
 =?us-ascii?Q?7kdIdY+o2cGotkkEiIAqAmHarN8ISUKeXVz2GzBXlOIGn8EUztB0EVIiPfqG?=
 =?us-ascii?Q?LKe/6/e8sJJwptYjOmqTiNvF8qkSnVYs9lmJC2fbqSAbR4wZYQo3lPPX5dic?=
 =?us-ascii?Q?khqOY+x1UN7uQq+JgF1K2HluIXmMLoHtQQU3FH0/RVTK8dbiHZIAtDJCzMLB?=
 =?us-ascii?Q?OMX9y9sAXy9eGDt+FAiOJsamsXynOGwuQ2YMKYaMzHAxVpJq4MMsoAjHJAXh?=
 =?us-ascii?Q?+BgNLdch1KUiJqMQuZWntJzpyEIDqpVWtQYeraRzxfVCI+xLIQX680esNGZ5?=
 =?us-ascii?Q?1Z7MYVkr5hJ3dYpyNoHBKG4fqopZow8G7Von/Q+ITCtMewh+f5ONctneMkgH?=
 =?us-ascii?Q?YXbWly8kBNtMqNGoKCd30n3O+uZo3suAzdJmRUpAeEtAvJVhX8jXTeULR6/2?=
 =?us-ascii?Q?652q74KFU2/vXYLEMnxXT14RN6YkFOdvi9wbHCaulhpGj4ObL++cA7xlfK7u?=
 =?us-ascii?Q?e+B7XxTqIZUjwoP5w6x9MP6WbGIeAvT4VOkFaaXYuA1DjUeK//8aErxUw2d6?=
 =?us-ascii?Q?qlJtDPSjhJG2UzcJx0EsEyiEwUh5ve3SUhin9KO0mRenn6XtZtqLr0myLy1X?=
 =?us-ascii?Q?B2T5CT6ApCzLnkkf4b0/Po5mIIPQGlf1U5XZaqJQ7xbeO/7OVS/zs9uoDeZ7?=
 =?us-ascii?Q?AHaAyHnA7gH6a3YMyBUAXfysjZj+wUmDnjKc+QAdN7pSNAYt1Nu3FB66gmX9?=
 =?us-ascii?Q?XSYBBQuXrQ2G0UxKRM04ttZYAZ6pTi6irtiTIs1KlgQwT7rJzGV5c5/E761c?=
 =?us-ascii?Q?2A9NrtBlp4eJH+4/CNnS5Fb2V1CsoH/MAPJQQ/XucnLM0cWP3jyRXbHL9Vnj?=
 =?us-ascii?Q?NT+Zn2KGGYJ7Kti+ZnSEaZPDoeZt8/BPY3nT0OcvqmkB9ZjY2S4qJd2090jb?=
 =?us-ascii?Q?yLmuOG3dYGPAxdHzvXCiGQdRmVaqy6uaRFXxGVf0OofrYuAnUH8rsN/GVGLt?=
 =?us-ascii?Q?aFLRgbTe8gKzI93JYSe74E48TROpjUnjlV1iOr7N+3zyH+LdGY/ZoBZ+KiP4?=
 =?us-ascii?Q?Gs9fIPPz0Od4UW72N8aCv2fd6b6sxrROw9LwwlhanfRuKa1zAOdevYK7d9Mg?=
 =?us-ascii?Q?Ll9Mb7R3qCyR+7c=3D?=
X-Forefront-Antispam-Report:
 CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:23:50.3451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7392d3-c85c-4107-de17-08dd396ed2e7
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3273

From: Zhu Yi <yi.zhu5@cn.bosch.com>

Add '-v' option for visualize busload, the output shows a moving
histogram of the past 90 seconds.

canbusload 2024-09-23 17:19:33 (exact bitstuffing)
 can0@500k   487   55558   31048       0  99% |XXXXXXXXXXXXXXXXXXX.|
100%|..........................................................................................
 95%|..............................................................................XXXXXXXXXXXX
 90%|.............................................................................XXXXXXXXXXXXX
 85%|.............................................................................XXXXXXXXXXXXX
 80%|.............................................................................XXXXXXXXXXXXX
 75%|.............................................................................XXXXXXXXXXXXX
 70%|.............................................................................XXXXXXXXXXXXX
 65%|.............................................................................XXXXXXXXXXXXX
 60%|............................................................................XXXXXXXXXXXXXX
 55%|............................................................................XXXXXXXXXXXXXX
 50%|............................................................................XXXXXXXXXXXXXX
 45%|............................................................................XXXXXXXXXXXXXX
 40%|............................................................................XXXXXXXXXXXXXX
 35%|.........................................XXX................................XXXXXXXXXXXXXX
 30%|.........................................XXXX...............................XXXXXXXXXXXXXX
 25%|........................................XXXXXX.............................XXXXXXXXXXXXXXX
 20%|XXXXXXXX...............................XXXXXXXXXXXXXXXXX....XXXXXXXXXXX...XXXXXXXXXXXXXXXX
 15%|XXXXXXXXX.............................XXXXXXXXXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 10%|XXXXXXXXX.XXXXXXXXXXXXXXXXXXX..XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  5%|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Hubert Streidl <hubert.streidl@de.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 canbusload.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/canbusload.c b/canbusload.c
index 577d99c..139d3d7 100644
--- a/canbusload.c
+++ b/canbusload.c
@@ -73,6 +73,7 @@
 #define PERCENTRES 5 /* resolution in percent for bargraph */
 #define NUMBAR (100 / PERCENTRES) /* number of bargraph elements */
 #define BRSTRLEN 20
+#define VISUAL_WINDOW 90 /* window width for visualization */
 
 /*
  * Inspired from
@@ -120,6 +121,8 @@ static struct {
 	unsigned int load_1m;
 	unsigned int load_5m;
 	unsigned int load_15m;
+	unsigned int loads[VISUAL_WINDOW];
+	unsigned int index;
 } stat[MAXDEVS + 1];
 
 static volatile int running = 1;
@@ -133,6 +136,7 @@ static unsigned char color;
 static unsigned char bargraph;
 static unsigned char statistic;
 static unsigned char reset;
+static unsigned char visualize;
 static enum cfl_mode mode = CFL_WORSTCASE;
 static char *prg;
 static struct termios old;
@@ -150,6 +154,7 @@ static void print_usage(char *prg)
 	fprintf(stderr, "         -i  (ignore bitstuffing in bandwidth calculation)\n");
 	fprintf(stderr, "         -e  (exact calculation of stuffed bits)\n");
 	fprintf(stderr, "         -s  (show statistics, press 'r' to reset)\n");
+	fprintf(stderr, "         -v  (show busload visualization)\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "Up to %d CAN interfaces with mandatory bitrate can be specified on the \n", MAXDEVS);
 	fprintf(stderr, "commandline in the form: <ifname>@<bitrate>[,<dbitrate>]\n");
@@ -202,7 +207,7 @@ static void create_bitrate_string(int stat_idx, int *max_bitratestr_len)
 
 static void printstats(int signo)
 {
-	int i, j, percent;
+	int i, j, k, percent, index;
 
 	if (redraw)
 		printf("%s", CSR_HOME);
@@ -314,6 +319,28 @@ static void printstats(int signo)
 			printf("|");
 		}
 
+		if (visualize) {
+			stat[i].loads[stat[i].index] = percent;
+			stat[i].index = (stat[i].index + 1) % VISUAL_WINDOW;
+
+			printf("\n");
+			for (j = 0; j < NUMBAR; j++) {
+				printf("%3d%%|", (NUMBAR - j) * PERCENTRES);
+				index = stat[i].index;
+				for (k = 0; k < VISUAL_WINDOW; k++) {
+					percent = stat[i].loads[index];
+
+					if ((percent / PERCENTRES) >= (NUMBAR - j))
+						printf("X");
+					else
+						printf(".");
+
+					index = (index + 1) % VISUAL_WINDOW;
+				}
+				printf("\n");
+			}
+		}
+
 		if (color)
 			printf("%s", ATTRESET);
 
@@ -375,7 +402,7 @@ int main(int argc, char **argv)
 
 	prg = basename(argv[0]);
 
-	while ((opt = getopt(argc, argv, "rtbciesh?")) != -1) {
+	while ((opt = getopt(argc, argv, "rtbciesvh?")) != -1) {
 		switch (opt) {
 		case 'r':
 			redraw = 1;
@@ -406,6 +433,10 @@ int main(int argc, char **argv)
 			reset = 1;
 			break;
 
+		case 'v':
+			visualize = 1;
+			break;
+
 		default:
 			print_usage(prg);
 			exit(1);
-- 
2.34.1


