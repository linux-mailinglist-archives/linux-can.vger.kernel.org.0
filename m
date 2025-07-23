Return-Path: <linux-can+bounces-4049-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2997CB0ED5B
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA4C3BB2D4
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1242192EE;
	Wed, 23 Jul 2025 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="c0sDfT1u"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2132.outbound.protection.outlook.com [40.107.22.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582627F756
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259743; cv=fail; b=mWOXnQGfxcmWamN+L4v+rHD92/hFFcrs/010EVZgpcbGhTiC/ElohQ0LOcjcB82evinoKbxAjZDuqi17tSYy8qGlYEtjeEM7om5w8eRt7NoBL0i+CqBONGDAifT9BptgboxILeQHve0SpUC8jIl/1TRSDNwgFHuNUbusge6DKwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259743; c=relaxed/simple;
	bh=oGUvAvBG74SUpFYLTdRs9ZEtBm/l4Ac4j9u1jq5b5P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G3btAo69P50zRU/joaBhIqfeltW3jB5FYCJjqqU2Ht3c+rAKhMq77LCnHc5w8i5lDtAGWrqHnfVcxI8PKOfe3aGsIimbMR3E+J8WOEBBsYS8eY5ZSBrj7dwYuzvq3QE5LDg4ulfEvMg7Hu0DwRkFcI2stW0qNRsOT/nkHyiQTMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=c0sDfT1u; arc=fail smtp.client-ip=40.107.22.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tH4T9eOyTvjer0GbVRWTZtPAf5b4br/fMUDKq0uum6zt+po7teY7l39lZ4Bkju2gbf+bomYcclST80QyTDaJ3yPBKUg8FbfKE6XEdkV1e6ezeWIpsCM0ngB+ZR4IUD7oVA8RwyEyOMCtilRP1BvyGkXNnf0/WdPZf1JPuG3BbccvCc5ZGRtfrHWejAXUEHfHovXSYCYPTiRZ79rYVf9zxIaoFK65kqcGIqmorNu52uacglJYMAlMf04+5qVxxt0oJmx+OJB2srRLIarbxRV7WuqUq2W74hk6+aFALYreGFvjQMVQX1FqvJO6tZYYZQXgIFMiuOr0L7hHHzOc0gpyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L02Oy05p7z7DAqiP6WKNYFrzrq/2G5LGVsGPPLOyC9M=;
 b=QTuXbFFEZPqVtHA1fs7f+G+MhsmDHjYZ0NPZIiZOl1wtYYiTctPhDnVm9kjLzQheqTeKUteDNmAGnBxSepxaGfHiwsjCYgXC9/4ofTM2r2iuSCSmBmkcscvZseCgG7zYh/FYMMKa5y87LYaGIXF/oSHXYjoKYBlGLK1Z1+ZVCzIWxQQRVx01NLadQZCeIBAj4jbkTo8Heu76lJ99KkmPKRZZqC6MxP0rjakqBF3yPe9YtxicjFf1ivNR+89oTGsH6JwNUo8NB0+n5Pzg5Wz6xaH/BfAcjP2tmkLonnu+CwBgQPDN+qBsKSz0bKAYgrrLgrG7QzAnkB307N6SSbv6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L02Oy05p7z7DAqiP6WKNYFrzrq/2G5LGVsGPPLOyC9M=;
 b=c0sDfT1ui/9v4qmaBPKUhmvZYUHKhas3ddrDGar37zafnP+G1HGPhAnO3fiydgRoQeixXqW574MVzDkwi3cbxZISb7pCS7XgdJmwy7PKT+6pyS8E+tXSTjkLH+ykjUAHU0siIgvhyYAHH8xdRrPzwqT2DCb1efRoziNrKKWAoNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU2P193MB2018.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:35:33 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:35:33 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 4/9] can: kvaser_usb: Move comment regarding max_tx_urbs
Date: Wed, 23 Jul 2025 10:35:03 +0200
Message-ID: <20250723083508.40-5-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083508.40-1-extja@kvaser.com>
References: <20250723083508.40-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DU2P193MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 19176732-3543-4cde-cb86-08ddc9c3e32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tFwSToBQzGG61aFd2QfA8pR2WD3pwQlwHk2mR+wbur0X6Tx3OwNGo1Qbo60f?=
 =?us-ascii?Q?Ly+bUb5UufZH9azNokXoKNDk7R56misEvLkCgfke5BfOm8H/MXJNq0enil1z?=
 =?us-ascii?Q?taQbvHYssQAqaUVfhwQyNP79/lK5DjGIZOEObqcuFjNkC2bGA6PYfnezrswJ?=
 =?us-ascii?Q?wPvESp+h0KnmSfDr0++cFRlzbBavDuvjIQ4qb/oYWnitxyT1RHbz9l87lb+b?=
 =?us-ascii?Q?E5bCoFIiQthyDHPT3Y3d/avsRptLDmgPxVvUMbQ5Y+2z9M/CrlH4R2AFVNYF?=
 =?us-ascii?Q?xMGX3+zC9UV4he+XacU+4K2lC3vydDT+tDjkxmvOREyPYpIYmCy8oSJL43KG?=
 =?us-ascii?Q?eq7AECt8gI0EFeQu6jcbw+cC6SfzrtjVu8tGqrP2KRgl3KpZbcGVQJHLTx8k?=
 =?us-ascii?Q?F7z9ZwknQyeKGRSKMfY/kBs3Ua+58YWOtNMvrvKifn7+mJ26+5UfmeXw3mG9?=
 =?us-ascii?Q?nOFSN7Y7AKRtxmv5fDPCCkYXntURU3jDYxa6GTep9HHZygaa8BxpxwGlNZVY?=
 =?us-ascii?Q?awaDM3UDWb1WYV/sBgSIgOpWxyLYRtZcdu5yMiJtHwdXkAXNypXRvyk7sn41?=
 =?us-ascii?Q?pQwh8oeq1NgpBM+PvFuw3jqr3fOW+lQre0fzVJmY6MGiU0mu5x/1AoyLyNLj?=
 =?us-ascii?Q?1W0f4tm6+L7+z6T6PAQl6W8mtcsRMJLHDPzZ0RhoV7Z3ZbKKd7m/cH4JRpOg?=
 =?us-ascii?Q?njbLB+HZgKENuF5KbMxZB83j6l0BxGxZaKuNuUso+6GD/wrFBoBtbWIqbCTq?=
 =?us-ascii?Q?hc1/DpjVYSnBix27kC6pN1SxakhC025TRV1AYYBhksAUYknlaaOCfYpWFNHH?=
 =?us-ascii?Q?nuXVJmddL0gCO6Nffpnb6oyyoGDdWM9D936cjzXYYVu9fEeduQgz4WUDXcn6?=
 =?us-ascii?Q?wJRPD2n5FReOuByERsIiRzncWL7elQN++aBwuTWrwT9/YWBkeHY8moeHBK9P?=
 =?us-ascii?Q?p7SkHSpd6hxV2UxmzCpVoUAZLsNvbJjOYEx9BVAhqbsNGg+3JZOvSckjWH0U?=
 =?us-ascii?Q?MW8IEpRmJNY7jMOUJ/it4ZCoOTVvjS8qowNp5GD7tuNg9NTe0ion2cUsEYse?=
 =?us-ascii?Q?3xwRL/g3SjN/z+uSHD6+qRiHsarUxL8lqyTnzJV7faDSZyFI0k3HlCYXFybW?=
 =?us-ascii?Q?w9/3PGF8LX+q8qaCSAQjM5kqBhtcf/lu4hex9gQe9Z5afN+VPVAMPUcWh7S5?=
 =?us-ascii?Q?LOUBOU4vJbAfHRDL3uG/He9h5cOwjIBWMric5sDxa8OfvqUueHurZh6jaj3m?=
 =?us-ascii?Q?4IHqa62joLDQE83CUewhrXXcG6G69pMcoxwgy0DgvWQlsyQ3+7GkI5iwwoEt?=
 =?us-ascii?Q?uJUea0W4Q5G6qP30lwgTLgV5HNzM1CylRT9/HeV9OyLF8RIVJx+pS+dZkTH7?=
 =?us-ascii?Q?sYdoB39NRBNUT9V0GQL21qtEJho809kce4+TK7ChBo9Om2N3xM7qsiFQG2L/?=
 =?us-ascii?Q?YafqxAtApyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j4ly0LfH0BXxKHY0RkVOk5ZxERyIdv3LQJyi5K5DRuOOEyzzvF+dccp2kVAZ?=
 =?us-ascii?Q?Gs4Q85nfeqIpJ0sJGTgqutSeIFSO3s5a1EIYQPgFdhLVigDMfGgyVLG7PrcG?=
 =?us-ascii?Q?L297yWKni6h9ubIku81kp6HsLtYtuau7bPffQJ4HTrZgUrrI4gxPEBAxtgVu?=
 =?us-ascii?Q?ms9Yq6InRhW2Up26xCGp4CbN0P/roLRba7hZch4VffqmIWdqDX697FraK+I+?=
 =?us-ascii?Q?OT69j7C9dpqGDQIzl4n+6y2bvU5wu621KtNq71+GY9p9SwBfHL8yrmEHPg6S?=
 =?us-ascii?Q?1f7rfCwsNofU1RfjnPkhryPTN1/ZzouY34l/ZYF+6kUs6v0KbI6W4zPB+JDC?=
 =?us-ascii?Q?pQRNrukhyQrlChFFb0KjqVDBNDemReD6oPk9eZLHeulfj0bAgqXxC3xOVoLj?=
 =?us-ascii?Q?jGVI8+nVQfaw/EyDi1VYvfNmBKZTQ++9A2LbqVfC91Q8T7bKYND4sLxGkjvB?=
 =?us-ascii?Q?QRdtt1OMYHxnt9CQkhFDRJUQabsbQ9Fk1om//fQweZglv9mj1CGPUYz2XNif?=
 =?us-ascii?Q?5VkOp6FvUiRJv2Uziu5SjUkUKPMkxDz7Dmk3N6ShMd0RvwEH+MLvjI60DzZD?=
 =?us-ascii?Q?QgxvG8L4nAW5NZS3AhRRmupfEGZgEOVVvQCtMifeh10A6FsdAiOENU9NmfEW?=
 =?us-ascii?Q?GfeXczLCLY255K6vM/bUb+KbxgJbJ3RuKZeiBoEe16PlVYGjw2BcmcNIBkT3?=
 =?us-ascii?Q?f7RjnG+2YX5tLTHbzNAMBxTX+Q/fgCVnoKkL++PvOGzVLadVoex3jR0rXACL?=
 =?us-ascii?Q?9hint1tvqVNzR030tF8cx2PJKVN+NPNdfvGkpH5NSJ1l7mTIvgw/tP8l9ESz?=
 =?us-ascii?Q?+Qu8F9l2z0mm6cXZpDEq+szpqFlvpFAWUzh5U2v3CNu48qcB4ChvKObSagOK?=
 =?us-ascii?Q?8OMNhna+hItzWw+qu8BhFCjjd91VN6sZIdToEATCuck5+37/AYrJII/PlFik?=
 =?us-ascii?Q?rso7qzRKK5j52fc3ZjvAtdZGGFuXKBmO176sbza/zK1soaPFziwd28f9Bw5R?=
 =?us-ascii?Q?AiPPjahBZaVR0fyftwP86Z+MoJ8dhTwke9ZyVEMvup913MYOWgzvBvVjfODY?=
 =?us-ascii?Q?HuoZPJ1vSsRzvol1rtEb4RLhARA7o4GuX6koLZbnKblTI09HVe3cLa3tmlCX?=
 =?us-ascii?Q?GHKTqJeO6eHPbJNW9V2WThQOcZNB7OMOvWhioWebhva5IyUiE+h4/WUWz64f?=
 =?us-ascii?Q?m91HfF9j7MN5K4xl/m07IY5aEnfpPYtW0WAIW4DUYMI698Xc7hSa2XlzO3hz?=
 =?us-ascii?Q?GUbDJfrtOS+gYNMu+y+aoVsN4DI/ic27ErDuol/iQ9hoxrH7NvV8I9xymqDn?=
 =?us-ascii?Q?Hv38o5FacjKOee+f/A81lb5px0xsXHaQPFR2FVV93At906z1BoZNX4A5loDI?=
 =?us-ascii?Q?aPh3DrbWcGqoTlkD4n+mHMKy5SsX7jqnPdzEioFGi7M4WAL4yPYlhhXC1RRQ?=
 =?us-ascii?Q?A8o8hJdd2o7OHBnFeGW2NSrhfYHhj/5p+Y34YmPDHA6pVyPUFCcazodBLEsU?=
 =?us-ascii?Q?mgfZ+mQH/inz9/QtCt8JDloYk7D3jngOU1aU1UFbOy0qm48M00uxvRwJKVBR?=
 =?us-ascii?Q?/L+DNrDWrJFq5h8SvaB7eTLXu6pw1mpYfNpOqkK03YHDqVClFmnvXCfDF6+d?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19176732-3543-4cde-cb86-08ddc9c3e32b
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:35:32.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBdyg2w7K5smNri6nhHoU+hx4dyvAdXxQW6p0R+i2mt5ihXCtUckFGppyARW8z8XmlX++nQnBzempHa0ZSkyd75iTswhMwsl8t8vQ1Kjho4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2018

Move comment regarding max_tx_urbs, to where the struct member is declared.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 032dc1821f04..fba972e7220d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -101,12 +101,12 @@ struct kvaser_usb {
 	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
 	struct usb_anchor rx_submitted;
 
+	u32 fw_version;
+	unsigned int nchannels;
 	/* @max_tx_urbs: Firmware-reported maximum number of outstanding,
 	 * not yet ACKed, transmissions on this device. This value is
 	 * also used as a sentinel for marking free tx contexts.
 	 */
-	u32 fw_version;
-	unsigned int nchannels;
 	unsigned int max_tx_urbs;
 	struct kvaser_usb_dev_card_data card_data;
 
-- 
2.49.0


