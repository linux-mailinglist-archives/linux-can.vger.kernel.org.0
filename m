Return-Path: <linux-can+bounces-2527-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67DFA000C0
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 22:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9533A33E4
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 21:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F81B4120;
	Thu,  2 Jan 2025 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="FVtmLetG"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020100.outbound.protection.outlook.com [52.101.69.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCEE13AA2A
	for <linux-can@vger.kernel.org>; Thu,  2 Jan 2025 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853803; cv=fail; b=jg6blA/SxzD2N6b+SE9hkmNNm4HQvC9dH2+KJOJpf4BQ1ElJAgAAZPKKTqZRe5pP6mhIQ1jD7q361RhXZcjcm//3Jh/bF/5JQETO6H1u/siLg3g89zQlS0r9WM1IzOBZqJI0KRyMH+alzmzdNPHArcUJgE7WDMLdOvi10j4uxp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853803; c=relaxed/simple;
	bh=EDDyn4ENlAGfTZ721ItnxTYFp0NS2PT+NgU9kTbs/9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H91hBQYis3bs3vhP7YxhF8KUb9bPeCpetW3R0wVqvgeDEoUIe628ggZ3TUVYfTGTNJy9O48UgT0IrpU/s3sHk2fjiK6O+a8co9m4h4kLH1YGffouu7ICF/GLugGj3BECMBi84jAQ3NAhfDTLdAGJRpkEN80OA7iSjUpGHnQRsgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=FVtmLetG; arc=fail smtp.client-ip=52.101.69.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB/sh9fXyRvTyfRGPOZvRSq2GUMJidHq31QHhaE3ZJ7nca7udoAczeKTtAGymu8LygVXNCgLoAT9TW70JTEDnKnm3+04RUZvc5rZC3SMtzAzRrMKAbcJ/T2S8vU/3ceYHLDmJXWtL/3sOpxk+yQJgxbK89O+fRUF2xM2ONnac4xPz9TdWI26qZZd12POVx9ECTYbYS7ZqvGdFD8VC4Upu1ZAaFm9TbtsfcJSeUqkiXE7OqCrQfFigwRKISXzcOGeeuTRNBBM7+Ga1PJPtIRzKGWxrK5E2qFt74kKkt8qlEmZJhfNy/AhFx4XtB0fOu8O0Ftwxpw1lLK6a4eiTlUnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVpe8aPhddaX0CcyCdn4Gysn5N33/gFZGv0OjaMFgTg=;
 b=UdbkcrI9QBzksZUJzxD/7YSokFnVN9FUNtp/64dq1d+42miNJmWIgJwez3S/Sv77KFmkXVIZgG3zohL/euvvZOz59StAg9egeclLQy5rFtgqQDDJ/GyPkKK4S2LlvrtwejSHta+cjzgQcju3VczL3C6zKiXoLUL/7mH0wVsHIoeeqTLet3BgoSO0L1hn/Dub3Y1Bwd12Tkr+FDpxJBpyvKTkKz8fJRxB6k2NMeF/O6vrEkIVX3FeZncjdGRHi2gfUs3h53P7hWPJyjiKBUSEfmL2shkcaRa6FkF+OF3/S8wrKXcBS2WL7ImEO0pc6fgswOtggh3byhvXnVVgTT4qSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVpe8aPhddaX0CcyCdn4Gysn5N33/gFZGv0OjaMFgTg=;
 b=FVtmLetGFBFCGZUbRMG8RVjWflPR4J9mjCcw8F3hwCMptRHMdqSifko34CGcS9lQgwtd1Mi4V2bGrYEgZCr6PBomWlK9CYfvIYENP/tsNNqcYrLHr/fz69cf6nc4RN9mfZQ8fS2cJbX0X1+r/zu58cT2ELYIy3ff+qm18/a7sFo=
Received: from AM5PR0301CA0004.eurprd03.prod.outlook.com
 (2603:10a6:206:14::17) by AM9PR03MB6916.eurprd03.prod.outlook.com
 (2603:10a6:20b:2d7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 21:36:32 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:206:14:cafe::34) by AM5PR0301CA0004.outlook.office365.com
 (2603:10a6:206:14::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.12 via Frontend Transport; Thu,
 2 Jan 2025 21:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server id 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 21:36:32
 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 152397C16C8;
	Thu,  2 Jan 2025 22:36:32 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 090B22E803F; Thu,  2 Jan 2025 22:36:32 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Robert Nawrath <mbro1689@gmail.com>
Subject: [RFC PATCH 1/1] iplink_can: add CAN FD support for FD-COMMON-BRP
Date: Thu,  2 Jan 2025 22:36:31 +0100
Message-Id: <20250102213631.765503-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250102213631.765503-1-stefan.maetje@esd.eu>
References: <20250102213631.765503-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AM9PR03MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 984565a7-dec2-4f62-fddf-08dd2b758674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2YwN1Z2MUJDNU9DRmRNWC9TK1hvc0VYMFdTdFhTelE2bUZJTXhqR1I4NXox?=
 =?utf-8?B?U0tVMW9uaXhCc1E2L2hhem5IakN3L2xvcllocGQ0bHlrYnVvZHE1Yk12VVBh?=
 =?utf-8?B?a28vSVdrQlhGUFJPYXlmZWQzZGtzRzNBcVZhaFBWNGtNUWNoUWVVUDRmcEJP?=
 =?utf-8?B?dVR6dXpiYlpIQkxjSU93Y1owUEIxbEdjbXBYd3dGVlpYS3NGck5jd1k0b2t5?=
 =?utf-8?B?VlV2VFJvbVNObTdOQ2ErK0FwMk1IVWhSUjNDYmE4b2lzTTVHeHNrRUxPWFdV?=
 =?utf-8?B?R2dwSGduc1NIdHZzLzN1SmpHeVU1Zy9nUEE2SjQzZ2l1bVBIYnNYK3VDU2Jz?=
 =?utf-8?B?eVphTEF3aitJdVVMMU9KQUpsVjNhZHl6Z0hvWTVuRHZ2cmJtU2VqN3VlL3NP?=
 =?utf-8?B?N3RLcUh0S1hVS3JPNVFKRGpPUVNmaFlTV3lFeUdyWGtEeE41Zlp3Ri8xTmFB?=
 =?utf-8?B?SE5MamhMZXNvN1ZOcWF5K2E4cDRtajI1QTZZYTRjVUs0YWQ5SWtXekhGcUdC?=
 =?utf-8?B?OVZlS3dmK3pTMW80T1dpSVZlTWdJZ0hiQjUzUTNWY01XQis0UXh2MHdqeFI5?=
 =?utf-8?B?aitiK09YSnFuVHkwejZGZjdteFZCcUg1d1Erc3hGb1ZvU2xESXZ6ellnd3lL?=
 =?utf-8?B?b1BMeU96VCtjdUdYSHFTdmh4dmVXVlZwOFNyaEZvNlRYR083OXcxN1ZhWkZI?=
 =?utf-8?B?SzNZeEd2NXJTWm4rU0w0bzd5dzFSbWtOT1RVSUcwbGdqZTcramNDeDNVYk9p?=
 =?utf-8?B?NFJnVEErcW1od2xDOEZPRnVLSUk1eGYrUVI1dGtYaTBrczA1d0RxMExaTk9v?=
 =?utf-8?B?YlZ2Ymg0bm41YVlNaUROY01ZSUI0UUhMYWdJaDdmTU96RTZnWEFvc2h0WWc2?=
 =?utf-8?B?WHNuQkZtYkNOWHZYdGxIS0dIVC9NUzFFZmlWWUJuTHJsNFpPck1JZTdrRVdK?=
 =?utf-8?B?OTRucUo4cEJFcDlxWWttbmQyajBldS8rNlNVdVFMNDE5eVRIVUVjM253TjR0?=
 =?utf-8?B?WWVnVURvdW5jcjVuZGk5L2ZJUkZtSkYrNllDL0Y0K0gzYmdldjMrZWk3NDZN?=
 =?utf-8?B?cFAyb1lZVXRoRDN2bVBCdjJhcS9FY052bFNtby9RejFjRjZ0V0Ywc202V2Nr?=
 =?utf-8?B?NnZZMjZVWFQ5SE96QmI1Y3ZEYUlqT001K1N0Vm1oYmY5dU5WRk5UTnJLYzZs?=
 =?utf-8?B?bWZCY3FGWElVeUEwZ0wwOUNGY3ZRS21xa0FWVTJkbUtYeVI3dld3T2FyZEdq?=
 =?utf-8?B?MURBejFoalRUdEJBZ0x2TCtha0txQm1UODJEcFZrdkp2RklhblJNL25NSENY?=
 =?utf-8?B?ZWFSNnU3elpqakxyUnBsU2xHbUNOa2ZUc2M4RzNQanp1S3lnb1g1WHpURTdW?=
 =?utf-8?B?d240NmJ1VTVlYUp3c1I0VzF0MC9xVlQzYmRmSUNtejlmUytoMFlJZHRQYk5n?=
 =?utf-8?B?TFR1OXhPNkFlWlF3SG9OcWo1UE5qUFNHNzhxVHV5R0VwQ282NTEvUlhuWTZo?=
 =?utf-8?B?aVVBaE5ZY0l5Z3dBdkxpY25ERjFnOHU3VDhsczM1L3crNlVxZ2szeE8xT2tl?=
 =?utf-8?B?YmJzc0wxK0xOby9RQXFSdFJVTkFrVm96MG9LM2xhS01MUTZlY3RZdTJmZDh0?=
 =?utf-8?B?WWNxZG8rUFdjenJqd01majhDZEtmSTd3LzVUbWZhUnVxdnd2REZ2TDJGdE14?=
 =?utf-8?B?SjdpdXlQQjdjS3VJYzB5V2xhakJ3dWF3dmN0Yk9HS2FjQ0tKR2F0emVySjdi?=
 =?utf-8?B?SkwzbkNHYVNmOFZrNWVvN253RklvQWN4TFAzMkIrc0lIdmh3alNQWUp0ZWMv?=
 =?utf-8?B?OXBzRlc4Tk9xQnBnM1ZiZnY2K1AxMGtiUC9SVklPRFdXR1dicHlqNkkzaG1h?=
 =?utf-8?B?NUUwZjVud2I0Z2h3Vlo3S214d1I3OVErekxjczFORXBZUmRpdklkVFR3NEhy?=
 =?utf-8?B?RWNUc2JGeldQY3BmbCtIUnZYZC9JYUZTZWMrQndYZFRKVVU5N3FwZkcxUFBF?=
 =?utf-8?Q?MfMVqTHeSes4+/htHzgSlNZ8dMsAxY=3D?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 21:36:32.2835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 984565a7-dec2-4f62-fddf-08dd2b758674
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6916

Request with CAN_CTRLMODE_FD_COMMON_BRP for CAN FD the usage of a common
BRP for both nominal and the data bit rate. This is on the one hand a
request to the kernel bit rate calculation algorithm. On the other hand
drivers for CAN controllers with only a single BRP register can enforce
the usage of a common BRP for both bit rates by setting this control
mode statically.

Using a common BRP for both (nominal and data) bit rates reduces the
phase tolerance and thus increases the resistance to interference,
thereby reducing the probability of errors (need for a retransmission)
on the CAN bus.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 include/uapi/linux/can/netlink.h | 7 ++++---
 ip/iplink_can.c                  | 6 ++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 8ec98c21..cfcb4205 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -16,8 +16,8 @@
  * GNU General Public License for more details.
  */
 
-#ifndef _CAN_NETLINK_H
-#define _CAN_NETLINK_H
+#ifndef _UAPI_CAN_NETLINK_H
+#define _UAPI_CAN_NETLINK_H
 
 #include <linux/types.h>
 
@@ -101,8 +101,9 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
-#define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
+#define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN controller automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
+#define CAN_CTRLMODE_FD_COMMON_BRP	0x800	/* CAN FD common BRP for nom and data bitrates */
 
 /*
  * CAN device statistics
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index fcffa852..186e145a 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -42,6 +42,7 @@ static void print_usage(FILE *f)
 		"\t[ presume-ack { on | off } ]\n"
 		"\t[ cc-len8-dlc { on | off } ]\n"
 		"\t[ tdc-mode { auto | manual | off } ]\n"
+		"\t[ fd-common-brp { on | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
@@ -122,6 +123,7 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
 	print_flag(t, &flags, CAN_CTRLMODE_CC_LEN8_DLC, "CC-LEN8-DLC");
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_AUTO, "TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_MANUAL, "TDC-MANUAL");
+	print_flag(t, &flags, CAN_CTRLMODE_FD_COMMON_BRP, "FD-COMMON-BRP");
 
 	if (flags)
 		print_hex(t, NULL, "%x", flags);
@@ -263,6 +265,10 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("\"tdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
 					*argv);
 			}
+		} else if (matches(*argv, "fd-common-brp") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("fd-common-brp", *argv, &cm,
+				     CAN_CTRLMODE_FD_COMMON_BRP);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
-- 
2.34.1


