Return-Path: <linux-can+bounces-7436-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOEVJUY582mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7436-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:13:10 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7434A18E0
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7BC33089D8E
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B227F40B6E2;
	Thu, 30 Apr 2026 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eu4VFiJQ"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929D406275;
	Thu, 30 Apr 2026 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547237; cv=fail; b=D0pJS0NDXiz5Q8xW+ja6AVw9T0gpXZn7SrpL6gFbiZGdyDWlO66vU97LpI42c66Z8hIfULjQlmnraI0s076aBucbiQD7zze/HdVRbqpDu29EeR8DW1SwnqsyxgvkuB/hBLQmeeodmPOOuXGbhusAK/Oi1+jPfeWK0ci3DXRyvjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547237; c=relaxed/simple;
	bh=id3ghYPSasdYg58VFK1vovrmwHgDz9xWgxEs496U/CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWVxCgzTV9jm84d5WFCwXNRjguSaiGZACqyxR935HgrOO3+X+4o8IiS3VQhuCG6qWLwLKVatXwq+xQWnSJemaFkyrUhfrqCSyLlSb+L7Kwu1rcxlENaB+zd77y9rgMBu8NbR4jyAnpX+QsejKW+WlV8dbNCt7KuCt5ajefsFuQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Eu4VFiJQ; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1wMtN1ogXEYBaVgZisMqtO6n/Q9NKsePb6a7vdrE8Jk7HUYB95s/bxVzjclnR3xQv3jqMbNE4Ft1ddzBl+5NTrAU2Mu70eVse2xn2fYiHrzfb5gu3qWNgDs/U1RNR41JghEpW7byyl88VZ+ZsLyQV4HMe+VorNhcUiNQhwj1Iyx3vLLnCLp6twaf2S4rrMPzD1wtnoc0yP2L6NDaFIt7/v17zxGbd8ukQ/T8awAtTD/4I9Fg6sBobf/cCaExTG2gNBdbhLksBRFRgXdzAiFJgpVgP5qGgBZcWJ1N/RzmTU0V2vfpxJgFBbcFb6GJiyeEUcfpK9O2DcdlRnq5l3Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx3MvUEfPC82AJPqktZmkTuzMQJjxAVoIFxtkjEpw3k=;
 b=Kdecl0OthygsbRTtOUvYcJtZ++NfwhASK2q1mBt8PBrpaa2ky4S8R2KOQPjhmoyPEMkmel0wf7N3hKMnro6eKHPRLUeFVRe6BN9jWLaEeEbn64uSPqIm3bvZoyPHBDiohm8avzqg04MFNFmVMf54vez9WHIEE4XOCEVdqmYh+GbbI+crH1/GSebLsPgQo/4o9NVsX3/IY5OGW20reCCd4Me8N528UHtG+l7ENGDpFBmkqPq6ha3+ajrO5outBHooK4RSa2jDl22GMB/eWc9gNnymbsO+pabUG9FKk6uZufhYBF0bG/aCTCDQrfotfUQLP6mQKEHxhyYkH2cxvh1/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx3MvUEfPC82AJPqktZmkTuzMQJjxAVoIFxtkjEpw3k=;
 b=Eu4VFiJQuj2lYw23TuzzYyxsoIg8XWgNkAW9eeeMEKAISP0S05j16Ygh0Us7CmOB6jmhRPuVmBArlUitA8EDvEZs/13DhkCQxzdWWABq4CiUSEinPI3hx+rM9nUXmrLi+TY3iMhpqfwI8e3db7hg+bIcNW6PZW8XNWFnZdyIpSpCAK5c95clBt2IyvpJqq1QyWj+3iVfZZhYusS+c7NEs7Re7eHpvyBZHvF7ibGfDFp9lITTxhWkmZDpoTctPadPALXGFjP4N1ebEJxyawGlbqqdNxaBUr+a1Jn5z4UDlVQbKZZ+dTNlYB3rfC1OypYlt4ZZqv9Yp2K7pxI6xMjeLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10609.eurprd04.prod.outlook.com (2603:10a6:150:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:07:06 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:06 +0000
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
	Yixun Lan <dlan@kernel.org>
Subject: [PATCH v7 phy-next 06/27] phy: spacemit: include missing <linux/phy/phy.h>
Date: Thu, 30 Apr 2026 14:06:31 +0300
Message-Id: <20260430110652.558622-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10609:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae07dd8-25fa-4ce8-5a74-08dea6a89db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xxRUkjzAuNgxGQ3ifitLMZWrthsJlUtaHosUMbODOIjRwPCOOSThoCdw/XTTdlHAWpdna9NiqFgtn6oW/U5xdq+Tj23RDdhXtHW9JcBZMowVymmX/TyU0ALnvDbvRQfRLYOlIZw6vtqJMLR6+tjIBwdM2jFISAldwi5JlIbMjppjDF7f7JS8e6+SbV1Olxw0ynDZeYDsDUkShJw6nHNgew8z/uw/L9N/n24d+yekvkoGm65g0GIT8HLon6gFH8XX1cmAUIuQBRCag3lE+DhC9FLjuIMed51hUALPc5UZgHBtDVCnvx6rYaETsmoosJrKNwfIUT2E5qIyCkBsigOXpAnY4UDFuMr2tf047fGWsemdwFb+BWpQ8iVCdvk5z8i9Frrt8pXZcsv6iNGRfb8CQ9FA7CkykYhV49XjMgB4fjQ36tRd4egHIzYrSQRNB6mhJpmtF5l4QZGxQiaQgzI9BGz8KQZx2TcDkK78ULD/v6tdT1ofZfSXKbHPR2YAG7Xd7jpQzxhIgEYnMWtX+sBDt/JJpTXoBio5sJvLJwbg84W2tzSqVwQUDuXZSP9A9QWTKj8pg3eTUYScEkP+5CJ2oUskmGO8isiv1iopDmLWtwTlbg4z6vbR1FMiz71p5BzAqc37EYn79/hg7G5KLE3JfUJ6o5+gCzz5hFKvjGiZigl06I5iZlT1DF6e6gJ2F6stVhsIDHwmgytjHetR6zL7pomZEjVVsbnUy8/ZN22KOkg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3hYOPlFpZzZTW8gs1zvTvDvu9rTZgrWnMF4cImu+CI6TochQfnvfmbO54I/+?=
 =?us-ascii?Q?b/swm7JIJtFmUiYEwgbI9r2+klhrR/xC7aRiEST1K54kM36PHPgwa60P8XBh?=
 =?us-ascii?Q?FX85yl7DLZaKkU5oPhrU8Zy7o3yijwFYj0hcFpe/GdvAZKehoLQk2nMhXVFl?=
 =?us-ascii?Q?gj9/55FwLry3uMLIQUk/9OkoaJiR+XiONBX3j4BLZlChxMatramYDq7hMM+1?=
 =?us-ascii?Q?Aj3k9ddT/C95esAnTvCHhOjLj3kINk2xT+KDz4xYQwU5F8w0Y0PPixGdi+H1?=
 =?us-ascii?Q?dVGvk+hVsG+aFwdtPYgiJfeZBAw15aBCSqYjm7yhBEGuCgSMely8VP5CNa9M?=
 =?us-ascii?Q?X3CcbshPl78f8oDu+QYYBoS0SuRapdELJAOGapxQLnH1FE1k8TRmVFGYw5oj?=
 =?us-ascii?Q?6oqlI3G4pHAucTgMbwKhY99fOH6vClkIi0s/wDRGgLV3+OUhHcca5oM0u1jg?=
 =?us-ascii?Q?UavhAMndgP5YyvcD+tHNWQNgdzjgFa2s1t9Y5SGe6aoS1pLqobm83WKSB8Tg?=
 =?us-ascii?Q?sm+uC9W583FkojvYXNCOZUj5EKbHxYckq3DnHmQEoL7oiZXbHhV+Eao17eJp?=
 =?us-ascii?Q?cg7rm1Gt7Di1awpxntLbHcpNOrAgTlhrr+itZAGbgNSzhlLFYYEbsK2FHUmP?=
 =?us-ascii?Q?DdNkd8APzEdIs/BeD1C5tYLj/biBVARAG28H5uGdf/T18QhcGEJaT2SIk2L3?=
 =?us-ascii?Q?xdAwkM71pCXNjb6b5r5HpiNZJCMXbP31+mLBzE5IBfyQx2VQBpm2bWrQEfJ/?=
 =?us-ascii?Q?0mMBFvQ4uS+1bzjFlbVQjz27+zzDNka4AuMgAye5kqcQRqMcZfjbatKpHl/7?=
 =?us-ascii?Q?+6o8SaAB9HAI1wE/QZSy6mwg00d9qFJtmxlz9058+u7fCt00TxASy8SX5sB3?=
 =?us-ascii?Q?FK+2Dm6Xy/7QXc/n3Qt5krBJy96chc20zmdtTStwSnaQ8yl1dKenvizputdo?=
 =?us-ascii?Q?0aS/y/uO7P2ORhuD1sfJHMLq/XBV1H6OntFSNm9K6pORE/3m6tG0QthvhW5t?=
 =?us-ascii?Q?coELd9HntkbjnCIhU7vbzXj1yo2dQlxsk3rSLLftSJdW9oUrWC5cyf5OnqI/?=
 =?us-ascii?Q?MJL05S5VW8fTgc/wMwnljfkslNsMaR/CDMsdmb3+r2jZkGmy02mDB1Y7gEWI?=
 =?us-ascii?Q?RTwI8Tna9/6HxpIE3bTcJGsKOeZkpEWEIw67NLVb8L+e2cDVFf4chSNUSvCo?=
 =?us-ascii?Q?ezzMCqQtQQWznF4V82I7WW9xVZxu6KmoFhCXU/IJK7yWGs+n8BMbXTQ3Rskp?=
 =?us-ascii?Q?oWzGRf9tz8o2gmdGpaLzMShtTQN7qw/hHr4f+3s2CmSQVNWb9naVEQ7iDq/c?=
 =?us-ascii?Q?OgViC/Foukr3uHLhH7B5pIUDksalE3cZM9GHF7Mx6YcQ/jCoAPMhnkeZ2aqu?=
 =?us-ascii?Q?5KRKYSAZJ4Y0/V8+mHBqLLq2UE7RUnSgp3X934kBdpux6s07nBN7Xjys1Kdl?=
 =?us-ascii?Q?gX0BWlcPSnZrnrh/Tx18BEg0A0tzoWrI+GKfTP6OzX9fDC3A0a7+jBrhLUYp?=
 =?us-ascii?Q?+JQ8rGk/pum6T5rf96nql7HQlpF2l84VpyCibyzlhcJCSpOrpm8K8HcaXgq2?=
 =?us-ascii?Q?wUGfpilksWON/FAtz2p9+HX8qcqU9xnBQ78TnQhTg66TRFtbthBKzF7q9b4E?=
 =?us-ascii?Q?hFu3RCYyqsbw+BQO7+lsjcDNm7/vfgzR8C5DXcKSKe7y4UCgrbc3AtDG9cQM?=
 =?us-ascii?Q?G1Hyt+I9F28RMDZkCVnWPC53VQK4/gZWmdmvsHKLfQkfL/Wg1UrNPcClCBqt?=
 =?us-ascii?Q?ENBNjeDawFgw7jDH7zGQ0J6/mK/Ummsnv/zy+L8dowNB9UPD+pDC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae07dd8-25fa-4ce8-5a74-08dea6a89db9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:06.5850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN7O7e6qb0hGZPIElvXnXPvrctiYoTEkE5XvLjtYmF3+IePTe/ZsD9/McF34rbHaRCiBsFZfXWgdvwEyOn/meQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10609
X-Rspamd-Queue-Id: 4C7434A18E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7436-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

This driver relies on a transitive inclusion of the PHY API header
through the USB headers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Yixun Lan <dlan@kernel.org>
---
Cc: Yixun Lan <dlan@kernel.org>

v5->v7: none
v4->v5: collect tag
v1->v4: none
---
 drivers/phy/spacemit/phy-k1-usb2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/spacemit/phy-k1-usb2.c b/drivers/phy/spacemit/phy-k1-usb2.c
index 9215d0b223b2..01af310d6683 100644
--- a/drivers/phy/spacemit/phy-k1-usb2.c
+++ b/drivers/phy/spacemit/phy-k1-usb2.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/iopoll.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/usb/of.h>
-- 
2.34.1


