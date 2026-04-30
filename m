Return-Path: <linux-can+bounces-7450-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IIPAs4782nlygEAu9opvQ
	(envelope-from <linux-can+bounces-7450-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:23:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9C4A1FAD
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8D8330D0C6E
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D8C43D4E9;
	Thu, 30 Apr 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gBNMsNVL"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676243C066;
	Thu, 30 Apr 2026 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547268; cv=fail; b=Wydh3Iv7zm1dLum5F16UJSSVU85gERScshPvZZ6T9Cc6JbIZq6m5EokueXL+Z7N/dtal3XcyEwCQFQpLawXMVFI5hE7DK9XhqbsLALjsrpIKP7tfcNG3mj1p0Pc3qXQR286n+ewrls6FZ01l7QCHvbOKb8OfDMKrQZv/vCzvWrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547268; c=relaxed/simple;
	bh=A/ruuqnKNCgyM82OkFBYliO/pB22W0DOSbXWia0D3VE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5Nho8hbi9kMXwy+0HIsnZiixUkQNu1Cbizg7Y8FDkmxeaqI+KXAOhynnyrqAVbvpFoVfCZDy8TPI11XVT2UzLmS2whpQP04MESESLnzwmiMgfC25zw5o3UCF6jNHumdDO3ISLbhBW0sq6VMPpc5/zyfWUNrngZvdtSBadMg38o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gBNMsNVL; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVztxkQof2fPsmaBHdS9mkwsNHN3BlM+dioQw4xIP18r+nfdHXAAK+ZyRFTMwhH8UZx0D/voKVxlpjj5qdgJeQFRm5SKIn3VK0OLagQO+auqXzKxchnyq05QjQL1hNNpziDy8ubXv6uqCPjY/jTFb4UpG3srojiizjKy3raLvDn5polS4mVz6u2E0n0NtqAeXN+eX/XvXu6lr6jDPy+KZbeRCCZaatlRGUYau8Lkdm/zXAwbfWxqtHfNysDqRQ4kjEE4Kea+rq3osDIZEEDiQVNuqWoTINlclUVQ/dbr8ylhRR3dz3EFmhJ+9aFhO8zMDGNZfVKDpi0EbwQwAxaFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ambD5fD8tiKNKqGjkvX2XY7P90Hrsgm9T5hGL0GrqtE=;
 b=Mf8ABylK/L/q92LVslOsqph5JrVYjVmZLnea0NYdzJbvBzlP2K25inBgM4CsrSssBd9iljl638dnR5ieg7ksydj3x+SQMIL960t/ipsDGFFoEB6E81BF4ZkRNHWiq7P9ZwIXeR9oJ8pX0KpPnHnw8tfOqBmwiR4SxDINtJRLUAU2v6W1tXUBR1Nd+5h9rmUOmjkzU/paA2Dr/5u+tuaRZmwuu7k6hJH2FjTjYLDQyzgenzyAW1mYOARkZ9ly7np6+Pe5T4GQ0NUsEok2PAaG37frVw9tuLndQIKz97NoP20LDp1UN2QqbWaBHgKearpjPT0NthMABD/OLiqViXSu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ambD5fD8tiKNKqGjkvX2XY7P90Hrsgm9T5hGL0GrqtE=;
 b=gBNMsNVLxY4nU6JXP6PTd3Y7GgzCN1PhS6zuOzji9QHD9VPR1BVVx134KzX/eWfYYQaeSb7tzPPhXZbvB7DEGoSWUObg1b832Cj+Q7/B8vG4MXIfU3YzCycXmrwcSU01XZvR+FL+HgDIsT4ebABSa0HFCR0+BPuSjBKRN3oDt6LOgp8NzAOkm/sukNpHZ0t55vKb1zq/q6an2Gl7qw4IYRSGW821CLN4NesrQdCpNJBkq8rYvyj5gJIp1l6nN19oXA9527MfQ7g72ZKtX0gpnNz/bWLiy202Jf12z1dJXBS3wRZoZkFDRXHCCk4bdxNOPCrH4LxpBkX5A51O2zLzwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:33 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:32 +0000
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
	Chen-Yu Tsai <wens@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH v7 phy-next 20/27] media: sunxi: a83-mips-csi2: include PHY provider header
Date: Thu, 30 Apr 2026 14:06:45 +0300
Message-Id: <20260430110652.558622-21-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7437c1-9af1-461d-f6b9-08dea6a8ad16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KxZGAVtM4nYl7CJ+gG5E0Z9hD7iFQikgHitkyMHw2dzXEL5KrizPmlmM2atzrFonWugAfdl3YdPX5htGesnO39KBCJZDB7rMxSlKTLsx0Xiefk5pRVSXgjIjWqZbIJWpKpm2i/fcu6B0pkbvy+wTCuFDY9DjVvDCsGdwe4pIZUiG8i6++CFpqa2LleaIrxq93JwgvK8KWh8lzLsBo5johjGlH7nTzTeMm6d3zWHfEs+N8grGKyo3mrrx2rnrdAksONmvrIZhkCasA9Zqq0K0YUYzPFmy8G032aw+DnmDKeYkbjxf5nW1xWQCZrUpxWfhLHN8nMpsb6WRNEihnBRECDfoeOXic+xVsLOC1JAi/9P21yMgiFZug6DlVicds7piASYpgLIPXQEJ/9n0thTGjsrdtLxwuqUbjSw4ZYP+2qPnCuWnHuceMWPbe1eMC4lKhLfYVXYijR31+lnpDQHe5+YUWPyeDZAT+eopkZE3iM+u47laXANyCAp+UI1K+be/LUmQvmstHsnwHYbMEOOR6NjymPfcPvFmKwHy//vwYaIhBWksGiVvFlVfOHRUuvqONUascxjShAz5RDEZiNldxpdLER8b40pCluO7zGkwDoIs4sWyw7YLnZfMzuHEttkCQvRdk14pEYr7mmQGJLdhDfguJCw22f/zpnTV26m1u8WHKmhbx3xeoEGh/W1T2EcIg0XoAot+4D+LwIPZ1UxfmRG7VLi9rPZ5huxdP/k6zSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ENZBH6koJ9ZOyBMxt5H53HeMSc2ic3G6W7fh96A5X8rpSKpOBIBFp7TtyD1r?=
 =?us-ascii?Q?8wdVLPfZRarqJ4gYLSX8U58iOMDgZfx1SHU5oRZGoNorKNr4B6ohNCsN/pde?=
 =?us-ascii?Q?nNx19e/BhvLfRoEBreEYNeORRz2jy5y6r/pIjdqPmOuF78lE/NHjZ32473td?=
 =?us-ascii?Q?wQsIpQ5M9otEX0DCd2nLRDX6P+JegPs0LKkZJ8p2W3R266mkjT0kyijzzy78?=
 =?us-ascii?Q?49Zs+CTaul/Rp7gCbtyhdC0DMmCC2Vv5XcvEuYCFsBvl6d8yO+kGMVm4ATRv?=
 =?us-ascii?Q?8xVMqaGkKiI3od2L8czthNrJQFYSnaN9kVoHpsdUs6YBmdTgoPZkyr+hmOCN?=
 =?us-ascii?Q?g+BZJ8oc5T8xb2XDdhwBqR9CWK1sc8PAV+SZu6M2YzNdhzLLhUhc/TjxLd9s?=
 =?us-ascii?Q?WnOAOrPe4DTrycEpR6ktbPA1J93V5CWeq9MUjKpY+30R139vZKeqJUIwy9Ie?=
 =?us-ascii?Q?2p1UxToYUZEL0cuIQDs8gYnheHyphdVxJfvdey5DRP58DdmzQqgGTQU8Ib9I?=
 =?us-ascii?Q?llCEE0ELF6NiovfXu6O5i6OocCVTfTHnktpoF++j/qQ/p5peexd7ACrDCyx0?=
 =?us-ascii?Q?kFU2K36BtDNDrTtQ4OXbfPNObvADCD8rAT0HOm0Ctb3Ch9ntK6fTClh0uNL2?=
 =?us-ascii?Q?5ey8AerPg7nlf90rnm0jpAAE/9kVsrObHY+NiQtNlUsLACShvJVDspn3Eyh/?=
 =?us-ascii?Q?RgLW7wielPSR21IPM8x/bNtv/mOiM2eZn9mJy4LwPBIzcxBlwQ19NMF8AEBw?=
 =?us-ascii?Q?ZXwKKoeJJN2SePVctfHJyAu3OOyKu0rG3M2+eMYMd0x4YmHYXxu2COfA9NeE?=
 =?us-ascii?Q?/Ku/7aZ10/9hG221HOyGcojuEXyMfz098WWEc9vUJE1IO4s2N4U21VSONjEm?=
 =?us-ascii?Q?UuwK00NIl9lEC/KbogEWpqqXMc+5cu2oF+mheRl9KdOy3ajXYDbsRJVAGb3c?=
 =?us-ascii?Q?B5cJhRYK9RBPP72VLKBPCeDpgMnOHgDNnhMOd5ZXXC1PzyXPIA6Ql6qwIPe0?=
 =?us-ascii?Q?9IAB2M7Vw7d6GeSCrY5Cc4ke58YgKdAbQeOulfK/M9CjdjkQ4Qyi3SEyg8Zx?=
 =?us-ascii?Q?FUzsSPp7A8lBMAO6/jdjTZEhT3Te8gMxxWzCgVyPFASA4qDR71H8sI1f5ohJ?=
 =?us-ascii?Q?iNN0m+bO7p8hPDOwxVUtAOXij1C9WGik72AMwnvcSmxGSIk5KqZgVwmRL4Ob?=
 =?us-ascii?Q?Q0XA9zfNCQ3Wl8sfw1AiXIhvl5j3gwYomqHSr4LgdGRzXM8AAcq5Q9qFZ2NU?=
 =?us-ascii?Q?PmcJBtwLwa3d11/ghXN04HElskVdfQgscoO3c2pmgs16k3xj83s3GbBGD0kS?=
 =?us-ascii?Q?4TcDTA6RrPjH1B2rdU+BY/Fq5KSByt42hQaoTRvXScuiNPCGJcuFF0iGfsJz?=
 =?us-ascii?Q?2B22znpvQLcOMFd2rG/nCAnkolWxEudQyIFnGBTHZOoL4jM4IaXLGqtvlfSH?=
 =?us-ascii?Q?o8pLhBo1dN2DPd3xsxK/kHIpCoeeEwIPto6CsVACkduYL3beHbqtkRTlcVgz?=
 =?us-ascii?Q?WutuQl2ZdNftA7d2gkkiFJRS7sBWl4OoVJ3OGlp0WwNJMb5HUBCwB2ef67gW?=
 =?us-ascii?Q?vzTk8Z3mDUjqR8TD/K/hW/zsNqmGXe9ybfNJdchjVI60CFwi411J+m307FLn?=
 =?us-ascii?Q?n1gBl6aCkqMRZHd5pDaUFZ5IrTbxtHHIOLBYSuN0i4KuUZ8pPQm6WIQgPm5m?=
 =?us-ascii?Q?XViLebBKuL7lJvDg/GbCQ/VsO40XDJtCWq+Rw+rWoyAmSMootJSJpV9O0Zpp?=
 =?us-ascii?Q?WorfNKTlAPQkheokjO36srOfvCLeL81UvSQA29eBW7xbms4F6CHG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7437c1-9af1-461d-f6b9-08dea6a8ad16
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:32.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZalflKqZCD+7frljcmeajRnUQVxC49q/JxGF7AGataSrat+T6A6AsrK2m0nJh1LdJFgJm253H8tEgEjZemdh+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: 8ED9C4A1FAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,sholland.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7450-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid,bootlin.com:email,sholland.org:email]

The introduction commit 576d196c522b ("media: sunxi: Add support for the
A83T MIPI CSI-2 controller") says:

    This implementation splits the protocol and D-PHY registers and
    uses the PHY framework internally. The D-PHY is not registered as a
    standalone PHY driver since it cannot be used with any other
    controller.

However, this does not matter, and is not the only instance of tight PHY
provider <-> consumer pairing. According to Vinod Koul, having PHY
provider drivers outside of drivers/phy/ is discouraged, although it
would be difficult for me to address a proper movement here.

So just include the private provider API header from drivers/phy/ and
leave a FIXME in place.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Chen-Yu Tsai <wens@kernel.org>
---
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>

v4->v7: none
v3->v4: collect tag
v1->v3: none
---
 .../media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
index 24bbcc85013d..1143feeb4fcb 100644
--- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
@@ -4,9 +4,9 @@
  * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
  */
 
-#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 
+#include "../../../../phy/phy-provider.h" /* FIXME */
 #include "sun8i_a83t_dphy.h"
 #include "sun8i_a83t_mipi_csi2.h"
 
-- 
2.34.1


