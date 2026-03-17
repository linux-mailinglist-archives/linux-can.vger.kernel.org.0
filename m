Return-Path: <linux-can+bounces-7124-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LwZD2rhuWmnPAIAu9opvQ
	(envelope-from <linux-can+bounces-7124-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:19:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C30C52B4299
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93A6630D51E8
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F80410D30;
	Tue, 17 Mar 2026 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Psr1DsQt"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4940B6D2;
	Tue, 17 Mar 2026 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788789; cv=fail; b=B7TR0mSv0X4+WCSWMuRzLo9Qtk37StMHzVpclQ+Qrd4am1NyQvwI5vUMj5i9wGlLEDf7LjxtFEUqumSYbTmrYVaAnXmgGaPWFVFpxZ/c0PEvMFDI7M0zOn5gz6owqlRB9fIL44W75LQl2eV7zb0FoyD5jAvBMAG0iVKJzPCcNBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788789; c=relaxed/simple;
	bh=kFS1yOhxFdJHyXyHvzRb/Ly4jSeImrsuF8/AbvPj4vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S9tsKUPIwKb0mZyTQcC4qNGQlGOCdkzW1sN9BkQ2JwJZcOps3Ih9nj8dfntfhwMMO3JdsVqCP5Ip4irXE8xCj7a/rHbT/dGj74QuFmSGMHQC2SWogDAKS1iC1cUnGm0l2rvZ0xAsl+xa+KDVwYZ/I9kTPNPBm7HLjuwukzxshZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Psr1DsQt; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4nRER/cXiL1Gd20CNkryzNQlxwlBRmF2mLVe4rKVcQT7EH6lhdFwfDPA7Cj78003B3hydr5Jb2TXSeWIZ6ENMI1NBt4ncSWG6okmkxkvAiiOw0Vt/XHDARCnZ6wKVoanHS7hMthmXkbuMqAZKFKRgFluJnmEcdC8Ri5SE3lpr93NfbaxmX2jQxvk6JrvWxhjpPoKR+B4mqkwgeVkLQaTELYhiNQd+beUlw+lIdlZV/3GIxt7IOsZNPikKeeZViIgFnupj23giSi5z4yMTq9YFode12klcDoTmMlpLv62xBHOOZudI43M23nf6uzsdcltO+/SlB/jD00x8sMb+4UoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g49ZOZQFgyCwxZykIUlJnhPvtMZiDsOG0OMcpfe8YdE=;
 b=XpY4xefAnP6c4AlgmpBGLlyXujz1FMmfPh1TXAEJxxl5wqW/S5L3Htrn5+FmFLE52qBtPOpTwkmiCxWozpzy5+V6pWgHttixlmEvk3anJbgDOgRSlz68xbEXYXuaYHTyIlV4ype/n+CZ1m+1q8J1CYvHm33vglmsKeONi/oTriO1O1nBqDq+uBk6HktAOS1vKNJMXlIzr0Iy1JgDAIu4hVDro91+YcohUMvFQPrCgAgf8evm/YmL6MH+3KJ0jBwASVOKlNkwtIRqaea1cF3w6eqNH/FvRTunRit0piqNPqBND9DkS4fuaca5mB/fAWibtScqLEDiwxxADv4j0ocj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g49ZOZQFgyCwxZykIUlJnhPvtMZiDsOG0OMcpfe8YdE=;
 b=Psr1DsQtA+ce88Cgb2AKdoPW0r+JjVKM0+Dkl/XhBRrefq8PMAYnbu2oQROszT/HFZXPlc+CAwfkS8JEJt7t4SplnO29NXLeVL8zPc5I/0gwO3nQccou6MpurhpR3HxUw0AvMDXmU18eAxsIY9LaEtNHSHZExuCG5pBCOSl8uzbRxN0jiZsARJqHS1qo2RJ8PrRLraVXlX69fLucTU1r0cy6yw8Fy4XLLUGx6V2COLnteys1+D897OwYsplLa39YP+FTbgN8sFm+ou+MtwDU+MQfMTMgXuwZP/5TcLsp7qlbQ2rAHVLJ7HW5yvcwLNc4ISI7bzPb3OL3tkL6ar9CIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:57 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:57 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 phy-next 23/24] phy: remove temporary provider compatibility from consumer header
Date: Wed, 18 Mar 2026 01:04:59 +0200
Message-ID: <20260317230500.2056077-24-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0001.eurprd05.prod.outlook.com
 (2603:10a6:803:1::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee91901-6314-4a13-f055-08de8479bfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xXBTO2lwjiK4hQkdxhiwoyT1X4R4vuJzg/6OGI/nQAzPJArsRJv9t077Shcc0c2/xO/RNlp4h8z/O/51jiO+NCuJSGn1iVifIrSzqocYJ5EJ/T+iF7gc309h8Go0G/aUotQCN25NwID7SwhWx3wYoBfGSfvFPgjOnyGjZnO9IxCOddsY+wEiG+84yd44GaoStz0U0ujPwaRHhltjdBaEvIod6w7GzfYgWB3k2R25C30Ab0g0iZOh2qFQHfm7T7xriNPAFA4zgO5uzFTL51ThqBiCoaOzbwTOjuEjhiZ5yUkzz3RBzbraF5+kRnnBz+EqgVCTtH4XqXcl+U680Fz6+iRgT3BdjHqYkkO5i+J9eYZ5BDUG0dkFf3TGyxjQ0jK4aIsNFwT+aXRGoeKt19OSC8AuuoukBi6dE6w0ZNwHvp+GVC3MmhFjpAidJrdrH2kKq5ze6nT7Yhr9i4KCtTxMjss7om/3c0tejurSnpHdQMfiCUelLOKa0FjxJ3BPPVXTdUIwgGfu/kobJ7ZLUH919d6f6xXFHStBjBxgD3U4mHt3VlyBB8s3hg/+nFjbAKJWtyufCRQM5gzg/7buqc49G07TD8L12uSKX8aNvzXWCH/nGMU41dZXc5oGEnhIHSPwS5LixT7b/UlZrL/C5zNpHKK/itx16knuxdwoRFoQQfxSkkjcJ/e1cuOKwyO/wP1Bhh0Nr0d29DiMEUcjX//REbsJdp4Gpn7cWIYNu1PBB6A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ND7BlJwxMHTmLUf9VMu7THGTjVlzREAQFMEqMIG2NqGPB/RNLQDxS4nKpyI9?=
 =?us-ascii?Q?c77cqmqE26bqiQkbrhjAehQ8Bda4pbgUPk8pibxrwwvHY5Dm7Zf7lXS9E3fd?=
 =?us-ascii?Q?HymLZ5GHLOClvP/gpCcqSmWlkwq8KST83ilkh+8MgCjbhDKOeVwSDhxeYcNU?=
 =?us-ascii?Q?8kGAS+1wNpWJSrl2zsa2krapvYyk4IIlCIsbw7SOS83jVUmQ5mQickmsKQS1?=
 =?us-ascii?Q?PoDZk9iJPI0WSLuAJPOcy2fM9R70tg+VMINExZ74R48V0HJj1dodDEPTkrS2?=
 =?us-ascii?Q?x7x3GvJMzM06TkyljsJLYPjNQ3dXOW6OOwqHhnnMzoJ1mZSEJf3ZvI3uNv9E?=
 =?us-ascii?Q?oS4FaCnhMrnsHntYaCnoBWA++8SJUgCHKMKGNDsd2AaDLSzqRaDgrKoyVANu?=
 =?us-ascii?Q?zcF18OY+hv2+sbiNKhwoucPW/sCZYO1Jc3gLPQbcvpl+R3WukoZG9Jazodx+?=
 =?us-ascii?Q?UB5qUSf8Y//k2Juumr60AMlQcAU9sJrjytc8eYBUBOUlc+mA5zxeqxc0lqAW?=
 =?us-ascii?Q?6Y3Q0WFBWUslE5avVCpM6ZTUxuh7aINMiOMnfzYKAHichZlPMvtDYBrF7a9h?=
 =?us-ascii?Q?X+fWJyVe6xUv1cft+y0F4jgvL40fTXR5XlpB25PrNbsFWCuTjMuTLdyot/Y9?=
 =?us-ascii?Q?FTeucekROy1NHu7vW5remo4Q3rbBQr7dkaog/RZLdXoV4/ytaafQc3XfbW8S?=
 =?us-ascii?Q?d7WElb41x/jwbr69nAgSOkQVwwotS2kEMJ7Z58cUgds/FcQ7w0ZbseKg8AzT?=
 =?us-ascii?Q?/Rclgsfiv6kZtG4I0T13GFds+x+HGs9oFq6llrrY1SPsop33joqPl71Fu7yT?=
 =?us-ascii?Q?H0S7LnDW2z94rEEhzPD+gKRY+2ejghp9WqcKOPqsoMc0mbJNrNc+CMYcZtAP?=
 =?us-ascii?Q?NrGCsKU/G6BBv7rhw/wq0PmW5uXYzl6x5UdbnV/nc6aqMSgmUyQvhs1mgUEb?=
 =?us-ascii?Q?Unux7wxXWJ9JItx3fMSYii6QhpHp6rN8IqR+vQjlkB3+gHd1qIQupepPplag?=
 =?us-ascii?Q?Aev7NcDFGqtfPRH/AJtEd5zQ8+mCnd2EfPVuBW0nbRwFzRwf90KoMVm8osSN?=
 =?us-ascii?Q?d2+v1fyTPxOJQrTglhgzTGld4wt9TRRuUwGdy+kBj77CEvu9joNh0IAckhM5?=
 =?us-ascii?Q?pO1nVu96aLzpy5AnTgXHI1IItLncrlyUBPwSQp9VockMp9oYuxKHOYwnPmaj?=
 =?us-ascii?Q?JNNIyrFrqpIdPG7c/amii4q9N6QTqbWRpI+6ii40kubU/v2ROhDvo7Nd03X7?=
 =?us-ascii?Q?NEJRGT0cANLVfrZ++uOpWWVzqXTzAIHND1jkbJSqbZibn/qVktmtOqrDS0g6?=
 =?us-ascii?Q?25JsPx0Bqh0Zpe0kCxjO63ObrjUyfngDovk5Q1iv/h4tI52y6DfLs9Ncfo7Q?=
 =?us-ascii?Q?oRpxsDUSPf1IBa7HHMCDRSUIx9iaJhNQEo3w5B4kwTDb5L+ARC8lT4NSN9bl?=
 =?us-ascii?Q?npinlFqZOzZ/YfZWh6Ik26BIpUFN24KAabWEYd6OzDtdr9j6r6hF5dl8xCxH?=
 =?us-ascii?Q?NyxRZFIFk9Gg0XnRuExZ0/gyK82nGHa9Txyanpt24g6+WAnisTgIrdcIN/Q0?=
 =?us-ascii?Q?Ykkip/dGH3yBtRwEn8ceyayqOf4O1Wesr6fg2Gw0JcizrX9gSOiOnjhx5nGO?=
 =?us-ascii?Q?bNb7roGyRCJRLqcJAPutqDY3KmhXhqEDqZA/+vB/Y3nMpz1kotM3E+8oGH8K?=
 =?us-ascii?Q?iYnLpphE0Tf0sCTHEpgo5BhWzxYQVe10Im8VR7ercfqJDzEfoYq1IevkcEH1?=
 =?us-ascii?Q?bHRR4fDPPK9tzl58G8PlHIq7UD9+7Qqxw9dug2DRS2+joflHmiqT73HLjrwC?=
X-MS-Exchange-AntiSpam-MessageData-1: SbTIewzd69jXgkJ9XpY0ULimCFgDES3EDI4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee91901-6314-4a13-f055-08de8479bfc6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:57.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3KufM8hh/S4OOEbqNy4AZ0DlULIWQwxxWlgXso+yIs7B8U78EM0rwfZnmxkmxmZ9LfZMfZ/IsU9tddL72IYxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7124-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: C30C52B4299
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all consumers have been updated to no longer dereference fields
inside struct phy, we can hide its definition altogether from public view.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
v2->v4: none
v1->v2: collect tag
---
 include/linux/phy/phy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 34b656084caf..0fdcefaa3f55 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -12,8 +12,6 @@
 
 #include <linux/phy/phy-props.h>
 
-#include "../../../drivers/phy/phy-provider.h"
-
 struct device;
 struct device_node;
 struct phy;
-- 
2.43.0


