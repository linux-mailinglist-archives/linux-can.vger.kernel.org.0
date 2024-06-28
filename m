Return-Path: <linux-can+bounces-871-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F09491C6ED
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9330E1F24B94
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39752770F5;
	Fri, 28 Jun 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Y/f1fqcg"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2111.outbound.protection.outlook.com [40.107.104.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48263770FE
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604555; cv=fail; b=QaiuInETgdKd5ASPnedaxvT9oVcbQRFZ/saauBLuxxzfT9gu7S9SLRsp3Cb8b1sOhtrADo+TqMhCXUjy1vrVHyRP60gIsI3UgBzr6PjgTBmEri//tB1+uTRi3G7RBQ03ulZE4FS1SdLNFmgSywGr1ns6BDrzqzhmk5Pmg6ecp0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604555; c=relaxed/simple;
	bh=YtA2MTGxDkY2UPVuKKNoz1Bv2/a8MRYVbAi+mqJsUrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gym2dHgfsifiHuxUyxv2mb+DZUQ2F0P6FdSRbYPJGs84NCGbOseDpZ9UAbV/tFfP2gl4m5JtK4n3rqssy1DJJupR4Hr9MVflpNCK8iMTpXZJPo+FSPh1sqoWQCmVw/nKpQMVbeegyKKWx0n1my283GI/46twvg6h7T4UvtdBqGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Y/f1fqcg; arc=fail smtp.client-ip=40.107.104.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Swe+/f/RAz0n9SHwVXp1tVeJWPRdsBCrPOOz2xlMHzhQVsrAMPnCJP5wT8YK0OzPIrWa9J5Rxx9vZXfy/wZK6i6q3pYQirQYzceuWdiInmARfO8o0N5pEJ1xXg3+WB2+FwkionOSbIH3IRG3wKzB2QkZ/bzSyhmvpge8iAPctqkNAVjc7ZrmCFIAOSUlvXbHSp+479tfq8hjEBFCxWKkwCx/fJhNmr/bdoFX77S3Wl5wjMt+3xohqnTWwjY9/MLz47fwqkVNY5T1xXsv7vTZaHbp8pv+vWLkM/aZzvW5uE8FYNR+d3pu0r4h2edAY3drSHSpKpcLO99ghsAYSaIn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEdBNXTYf9L2CwXsoIP3h8XhM6CmLRUNyP7RGerbysE=;
 b=l4nm+H25+HUoJObKcEQEFCHFybDP37cXZX4qgwelvePzL4f4dR7EGWt2fyOCCdrP/cxa1jXghMcjcmfflypKwLY9/TewgxNh9AyCvn/ED4aAaNj6vnrtVYufI77Ia2StNK2v2fH0RiCJWOdNJb3hasCFIA76WjPLxv5ENgnXKRFJMarGvcktTDeMne9ReiWLkNbmIQd99f9NPVnPIaxCNByNpDMgskL6QoZcjvWodLA8LfxSO28aFBKg54JJy0KJW720j0a2PG6ifSHpVQObaTBby0gbIykLe9Ghx1HUald8bw0scdWl0EAp2oJ+ZchcYYLz6weanwWBibQjEFyHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEdBNXTYf9L2CwXsoIP3h8XhM6CmLRUNyP7RGerbysE=;
 b=Y/f1fqcgCVqAjBTRyUIWuF1Ag3/Ep6aAHCYmLGsxBMQhOBEX/yl66J4vBXN0fKAyzWwBbgfqH6y/W+49qsvLxdtnQei45UoDhpeCALP3c/Ja8ytfiw/juFt5y0L26p6ZnnNvP2Jo+00zvyxMHk9rTNvJsYm//4Y/zltQ1OyCVoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:43 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:43 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 04/15] can: kvaser_usb: Add function kvaser_usb_ticks_to_ktime()
Date: Fri, 28 Jun 2024 21:55:03 +0200
Message-ID: <20240628195514.316895-5-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628195514.316895-1-extja@kvaser.com>
References: <20240628195514.316895-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM9P193MB1142:EE_
X-MS-Office365-Filtering-Correlation-Id: 4098dbf2-d1cf-4f9e-382d-08dc97ac4b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Js6EUOQ9GvYQ/MVB7He7eJ8xazIE5Hh4k2y63xBrf+7h1D/TVaYTPNVmisEQ?=
 =?us-ascii?Q?VybW5/eTuKjb4DnTcIv73mzkGfKcV7mpCGk7rDVqPFANDvkrmwdFRSl33PuZ?=
 =?us-ascii?Q?JJyjXmJDDyGM1Oz28kR3dKDsGctu/Gc+RzVXM/9TlZutibzxrywY4oTSb5h2?=
 =?us-ascii?Q?hck60og6KvhVsx4nPGod+0e7723e8Q7dsxQfaEGRe+k6vtDoUS0cHqUFfRuY?=
 =?us-ascii?Q?sp4iOFdE4pvRBbdou106fJ0DT4UAdY9/gnQO8agvJiibGrDLIAWNdCycCapr?=
 =?us-ascii?Q?eRFhZnvXGxXJUx76uTR4JAgw0ZGVIgO6IMtYYPk0sKbil5R/AcFigIcOfYjb?=
 =?us-ascii?Q?S5LEBB70hzy8c3Cn6RwU5xfeq4I4W+7QxUIT3jrFG6t2kyYKSwByoz7M7Ec0?=
 =?us-ascii?Q?Un1haUWJ0Z8FqcvYAefLYQ9w1GGsiNEweIqmneLS07SmLjed/5w6YjJvv7Nt?=
 =?us-ascii?Q?6qqeWNW+1oVCwHMnDtRYKdsGBR/1g42Y2zb9ENXYXDek6dKzykvnEGafqfJD?=
 =?us-ascii?Q?/aW9xxShAaO+EKvU1gRmApJp/37ddsyymuAw5tXqsx42yIQh0FeAUBkagWez?=
 =?us-ascii?Q?1SdmXxt+ttIPrELp0/tHzpCdl1HcjKpHSgyBmBUh+6RKRKEMd4pWJnQZvjW0?=
 =?us-ascii?Q?EwFW5ndwQ4c6TPERRV/Y6Hk9z1l9lnfcjVLDqPDHTQRtCvyCauccHdIn17ra?=
 =?us-ascii?Q?tii7lGlZSMsX69YkaX+SO/Yzv2zDAxZhtQstREozJ07EokGReyCIvrDtfFtl?=
 =?us-ascii?Q?9VEDk23UPpsJST0ZEjV5R+weXviHGHq5RFFW7po47FcbmIvsR4L2zYJapBRn?=
 =?us-ascii?Q?iFVQ2C1pj7Y7Ta8aHQVKJOymeZuXchkvgDkLMeW8SmbUePhoqeso2ktH3rZW?=
 =?us-ascii?Q?fhwVORek+ud/YyHxZ4lruiWX/2flBNKZVJKRHD2UY5ohGYnY2AxJiR9IFHeP?=
 =?us-ascii?Q?sB4fMXhf0u68FzE/JG80Zm57Duy4+Hf4e1rEar/5h4VdN+n9/3fUtMQJf7fw?=
 =?us-ascii?Q?20gKK7oAk2S7QjfMxTFn4GhLSnv4st/+lq/LNKqjif8707kJR8DI1iytNh2v?=
 =?us-ascii?Q?Li05qsEm6Ndw3AsbuViri6/fDKi/EtJMWs9vdQ1XYyuTXtDGeacTyo5RD72H?=
 =?us-ascii?Q?ddXPKLPKtI2sWTWv7ywhZIde6W3NDJS7HNabSsAqCULuaZFcYnodH+b9a+9j?=
 =?us-ascii?Q?lzBKwwNVtBVODB1XeM+mBRefuQVSVmLSyuVc2aysREd4f1CRKs3q2Z4bhWIG?=
 =?us-ascii?Q?oQDq+QrCOwJ1IfMKxEVfxSMjm71EQs1XT6rPKME94xVCRwcV4Ekp64sYT6E2?=
 =?us-ascii?Q?AzQY/NSCveaH3Qkij6a0maoMZPDBsd67+kBJ9DPvlh1CdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7D+6Etq2ogwWpA9HAdZ9CA9K4wc28gWBQiEe8nBdN0GBK1StJ5zJ3GRSMatH?=
 =?us-ascii?Q?aha1xXqEmxydaYOHnktu+3Rm0xeQeRcvsoGMIXis1007O07Mgnom97iSfvNA?=
 =?us-ascii?Q?S39C/nO5JC/3GgD51bdkDQei9yEoXO+Te8RQ0WBY1lrW4BPB4D74DUp9b6FF?=
 =?us-ascii?Q?1dq5Cpz5v6FozW31YvilnPV4izWF9q14agnIHpjcgalzUqASW+4LtLDbYgqh?=
 =?us-ascii?Q?Q63ZWsIwAVZI59yVrTiAPcLN+3QFFQT9pOgoETfkfCVsjw1MgJc9xlIlAe3Q?=
 =?us-ascii?Q?uNoty7FOlXQsy2BZK82UrtuJ6C3T4vADGyUD87DfX6HyNKYMwO3qT6q7jffa?=
 =?us-ascii?Q?f8nUPE72DWmCj0/YjIv/2CRhXjesJHJOWACuopQcWk6hhm6fkFTaZvxLrExz?=
 =?us-ascii?Q?Ssxs/N4CyO2s6/YHnwIeCfq13woknAp9Quml8h6pPcAp6eaEcF7H20x79AKg?=
 =?us-ascii?Q?mWF/BNyGhUbyK6+v7JTlIYJA2ML6sKfOHkA3xGxJWMlpvCTiL7NErgmbI2WQ?=
 =?us-ascii?Q?mwe6b9e5D1gthUD5ms0h7lex2Oz5Ljz97JAlFJpzYpNptWQXDaSZOGqMI/wV?=
 =?us-ascii?Q?aO53nfmpALIwVma66Y7cO+q3hnHQKB7uuyBPeuvP1+iFdXrQ9UqDJ6+T4dXy?=
 =?us-ascii?Q?8ddStBfBPPJcjDMVBKkDx32ie+WFLVbdWckjuviO/kP9vTAPK0aLISscti5i?=
 =?us-ascii?Q?5m21/Gkw2Rj83TJ/8VUtKI2+jfJGTE1CFTo/lUWOUzX9haSjaWVcy9OInZii?=
 =?us-ascii?Q?GKOGTOEbvu5TjUXZ7XhLZGNCsGpJGlnV80TWl8739hrGl+bCoJY6GyaQdx3c?=
 =?us-ascii?Q?8MlnHkyuYgelhh4h2kVh8JyXlqcvg1/Ndwd/pTtOvMtWBPtMZfuo75uXqUQR?=
 =?us-ascii?Q?TqYN7eCWT5GSeNXVP+er8nbGBsV2x/gGhTuDZ5wuse1i3Qg6tGbOqLTdo6Zt?=
 =?us-ascii?Q?i3wGVPwB0ixa7VhEmeJfzpvWWa9A66ZwjFb3Dm2sYi0Al7ujZp0nTvP0wEgt?=
 =?us-ascii?Q?6BDVi+r9WsDduyvWIWKCNc8LKa6k0jg4JEE9r4PbCAhhtaPBF1qePQBtajIB?=
 =?us-ascii?Q?XV85Be6ojLxbYzE7YeQGPs/R92ZEcRVa9y3BeQd96zXgjX37cNP4BAPFv3i0?=
 =?us-ascii?Q?JUzi0Wpjc927hE+o0y16hJ/vNzF3UkOA1uan+hFWRsCN5ZsE+aOtznB2wkYp?=
 =?us-ascii?Q?W/xsFlY1C+McpqCZZoD5XC20O0vJWg3E9ddZEm8+ACMQstthKQMoQoLg95Jn?=
 =?us-ascii?Q?i35cP7dPepm8PH6ag3rxwLtD5c4HFB3gHAQAA0OzMy+2hDRcYsCI/AcFoz/Z?=
 =?us-ascii?Q?O6wmTcZW80BBWKXHdW/bfnj5ihTQkmUFi3SKWFuvVhvu2zjD7SGVdKNhsCu+?=
 =?us-ascii?Q?e1oJJmbSqvqAR3auLAD2iN3jnOhgC8HF8D5Kja1QVHhVTU6746w2/uDqy5p+?=
 =?us-ascii?Q?CVwM/x9CDsB9sdmG1O5iCFiyUEykNNJVtivM0nBXyB98p/0x8ExBHw0jaXxF?=
 =?us-ascii?Q?peaCXxWKozatSeT9nW5do32M2rz/uXyeOQRGHSHf9TZC7eY1hCQAkCnAXVo7?=
 =?us-ascii?Q?xyd/5fJd44R8RLK+JYbA2JbumZX7AXruEDTn8Gt7?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4098dbf2-d1cf-4f9e-382d-08dc97ac4b4a
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:43.3997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gZ1EWanuMMZHYE76hs11uYV9OmVZHlyTNIMUu5+Oawgxf/RP8B24D31wenDZZ8MLo343QXRhc6HW75J0wYSyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Add function, kvaser_usb_ticks_to_ktime(), that converts from device ticks
to ktime.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h       | 8 ++++++++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index ff10b3790d84..f5868e0b3b23 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -22,6 +22,8 @@
  */
 
 #include <linux/completion.h>
+#include <linux/ktime.h>
+#include <linux/math64.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/usb.h>
@@ -216,4 +218,10 @@ int kvaser_usb_can_rx_over_error(struct net_device *netdev);
 
 extern const struct can_bittiming_const kvaser_usb_flexc_bittiming_const;
 
+static inline ktime_t kvaser_usb_ticks_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
+						u64 ticks)
+{
+	return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
+}
+
 #endif /* KVASER_USB_H */
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 28a99d78ba8d..08688514d142 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -553,7 +553,7 @@ static ktime_t kvaser_usb_hydra_ktime_from_cmd(const struct kvaser_usb_dev_cfg *
 		ticks += (u64)(le16_to_cpu(cmd->tx_ack.timestamp[2])) << 32;
 	}
 
-	return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
+	return kvaser_usb_ticks_to_ktime(cfg, ticks);
 }
 
 static int kvaser_usb_hydra_send_simple_cmd(struct kvaser_usb *dev,
-- 
2.45.2


