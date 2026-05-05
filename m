Return-Path: <linux-can+bounces-7497-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE8WBK7D+WmxDQMAu9opvQ
	(envelope-from <linux-can+bounces-7497-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:17:18 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 851314CAD17
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92D83310BBD0
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851A3E6DD3;
	Tue,  5 May 2026 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nnPhXjT9"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B7339705;
	Tue,  5 May 2026 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975561; cv=fail; b=DFN6nQJcbb5jZ8pJUQ7aDW8PRfbya6h7oWeNVx/fpwrUErYsFUU8w1Z3NreZ7P2n7Fs0+aWR5Pdx9lsd4LSmsit3SkkgUCq5KweIgfPyucfSCZVqAx6bKxN/ATNEK9Bod+aJ0fp2qrWUCKFpFHzji8hfkyOd1h7wPb93GVao5bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975561; c=relaxed/simple;
	bh=BIMVZ4JQPa0Xvq7L9O6wZp5w+CFhsWvJogBGJ/W85cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AidEHS0OGvjidrCYOtlo0eyieYkaF41YTdf9pjJQnvZ1MtVJ6q02mPIMWsGw7Kr8QGfTz9AzEZMtpUxmQhZNNMrRFd5V1DRC/iJqv5tWk4CBMObMumROLVFyfrs2gLf7JJZ2nj1A8G15G2Ba7eSuZRzjFUfzSxx/kE+FQV1h6mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nnPhXjT9; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B56n/yXioimBdgrS1thj4tzUYRq6iIfbDdt72j//MNYCZOaEeVXrFCaenBnFpuYIi8oDw4V/FQ3mchcdraDHT++rPuGRU9Zg55LS+tWoplqXNO9uRmGjYqqj+HXOcErBK6TA75a1WXY1OHiYmeGTLoR8WJUZ6kwFdYUt9Boiu5HwVr46NONrslK2hrN/h7palM6TIaxDPNwdruTv9rQ7DCvNlTDOIxbf9bpsQcktpzrUIcd4aqbZ2JQN/+BFhLEOaQCsXD38cxX2mQAUxB6CAKoiSvlS4ekcJuZN8buPxLb6L/ktObBAbqJbu6sQ6IWwRFkWkR0+rQQccD0bJyfa0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6od11NVAaZ1aoZ0ZEny4Zx8sWwxwk8KGPAXF+Ikegcc=;
 b=kYOmEVi2BjpvdRS//csR7D3+o7W3YWgLnanGQn/lAnV3DrK0LRqNDTIok/dqAzH9whPWQP873eIgDYDCvJBr3tQBSWRLVQ7zSk4M7BHNaZkO0pDIfGOuqDkakBYE4K/2+wPNzyOxFiDDc+rFcq1JTle97maf9fBM1rQtL2NrLz2a9FH5DylPDcOFr4ctrFrZHugRsdNyoSpw5k/ETdgfdSiERv3rw3iq4wyQqq8CgJi1GHTaEkA0agHezkDxYb4HAgEeb1Tu3etenGWiwXbQNlYB2brS6m5Io0jgHTYAHTP2+eDwu+LZ5WWLr5QxOiYwjVtpzKy2gi/kuO6eoK3/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6od11NVAaZ1aoZ0ZEny4Zx8sWwxwk8KGPAXF+Ikegcc=;
 b=nnPhXjT9ksRlv8S97XW/jMLjbBrZFUiNKdue+E61y6H1vPduymAIdDVZ5GKFfiqh2Vbip4M4PkXoH0akBuAhhfLp9kYphekNJwRj/pqnEWJdlrxs5X/NVwwpSzGdDWKd3yCmwyyDN2hAjmJ5aszgrS/A+r08FvaAj0/u2nEN1PwWY45clBmcXvEl0/rAPEM6Uav+f9K3bGNWHUM6C5KIxfhoB5nS0CL7M1GO818PyXJw/y7qN8RkZIDWrV6r8OzPuXKu5BY443vIOCiGU2KNAxWEXgH8EXgRg8aWh5/S2LHLP78I3yunOGAGFjFP1ELTKx+ELH1XaZWGI38tJy/X1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:05:51 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:51 +0000
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
	Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>
Subject: [PATCH v8 phy-next 08/31] net: lan969x: include missing <linux/of.h>
Date: Tue,  5 May 2026 13:05:00 +0300
Message-Id: <20260505100523.1922388-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0306.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: a90243b3-e5ae-4fdb-8799-08deaa8de33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qZztwzZT9D9r1hiKKLuDT/77XOIijRfNXbgmgLw576Zpaoaa+YO+D7poEe+CcsVqW1663SgOkI74g1ltIDUkLf1EPOAY2MD1O+QYrwF4BYzvR4p9j34hpIJ/UCPr/Ed1afOia5JIFx3a6S6FkaLEVzNdyt9hD9WX0wBs26CzlU3wuFdrtC0+dMbew201ubU9vHVO6CzGxXXFwDEiF6IugVfvamHqkSBu9PfFCISf3d30ibWnZZ3jaCLumfMZSvQG4VBb6Xaol0v9ARHmHqFUaGWpXOYJMFlhkr73gCgwSt8SLk+RiLxfSoGx237QmxckPQznhTuwq57RqTSs+gCpWXeioqVbiHnd8J5MW+s5oP3D/cPli16ELHZ7kUyqXxcumOYK3pei0convPnqPkKazzZHPavq5HiJdz/M8d1/y9fGvtxtfCpl8pz5488+LcWTVbJn3WM6s4+Spb5cM0fgnUFvtyzEoAUpTbseh5iy2qnY7OaJO4MW6NIRV2JXsKiMX+kmdpiyty9NhjEGzcPYwJ1XyEzmSN0Abu1kjwrizluR/F2K9p0XM+UXReMiiJcAgPxX/c7Aeo/iNAkW73wlW6Hbp9AeKOTB5Ox/qGsFZ4gD9ygdIJDbr33QXKIGcNnJr3+NMCwoaJZ9DViv4LcN3hRa9cRcoLrACmoMXKVJjEDZBWMiLmwlsQg33AnwTNHD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7BpF8nKHNuBOUQveEs1kn3qRF6RJhTuqnqacw1W6ymslmPPFFmJ7eLnMb7HF?=
 =?us-ascii?Q?RI+M+O3vjwy1sZ/A81c0/2GMN9EL/BDL/ElbdKPGs66XLArjyFcTDiLRrDzb?=
 =?us-ascii?Q?V+TSOh6oDb8sTiAFekUrysPrcOqdLvrhjevUt1cNQMUGvA8XfMb13K/Oj1qq?=
 =?us-ascii?Q?A+uz6f9lBGI82nyhBAL+7Vq2yj+kt8IYSR3QQ2zyi1u9M+7EVP+HbL/Na9YW?=
 =?us-ascii?Q?73jp1AKYF1ewwtuv5Tk4d0GNrAGzu3bfpo0BUcmtgZKOiF//vD4Tb45GXGsa?=
 =?us-ascii?Q?REuaNgJpfvye9e28m1J6sGNnMuU5SVWd2KMsv+ztJKnPoJO8YAF3A/6+OHHE?=
 =?us-ascii?Q?wD9NSzBzsy+asSsUq5+MBwF2hO+WPK+0Hssm6A+uWSSdI6js8tF+Lavqtw9C?=
 =?us-ascii?Q?yiCuYrgCORoV9GO964w42jevB0RXJrpGOwgUYFy3lXHZfhctNdNp2k1D2vCP?=
 =?us-ascii?Q?qj9giKLCfIY8LMYGgq4hPxdjcShqRyY8HF3G81FCHnN3ddQflga5sOnzeDyX?=
 =?us-ascii?Q?RKSvEebTvrJZd/Nebafx6ahUrdh/KjKcwF/6ITL/hy6vsqzZMPoG4qgp6MyV?=
 =?us-ascii?Q?SwIJ9wqgO7Dyo2AgfIklbq6/nCZCdEKiNJDsGCPJykk/C8klIA/bF3bfzv1Y?=
 =?us-ascii?Q?3TLtXkj+iEFzgGhCvjz7jorWO+VOx4IgVlKyd2P2SuTiaLYFqOOGQYLKr66O?=
 =?us-ascii?Q?KC7CnQtVG1QSi58eVKmbuBja+hnBhlh2HC671dR/n+ssBiX3+uETNT4A4qEn?=
 =?us-ascii?Q?Z1kkbqaedWJf/sL3IruqohmUwpNKT/F9PA3Y7Y1GZs6rzB6aUw+dKVVhyiCY?=
 =?us-ascii?Q?kkP/Phh0I9Trwl7uM0J8hplQG05o08BBZuJsAJxJdBGZp4JafJ+rxLXUG5A5?=
 =?us-ascii?Q?CYtAtsSXsh4Z8zSBvnbGW872zgr9AJMpCSTAghcYHcrNH5DWVpbFZY1MthiX?=
 =?us-ascii?Q?Uw//ymAMrRE8MWlnoI1IudFowfTTXo01eYsVcL9ahtL15gXltRloHnlVVZXb?=
 =?us-ascii?Q?QhcP7ZCfcEpKcBZYJ1+R9nIwIH0IoHN61fUe7GkFdyHEQJ5PdwCnhFeUbkvl?=
 =?us-ascii?Q?Jb2rBH1U/DCE9Eu/MJ0XBp7OOiQGk5oir8UyPulGAwTgXN4Wx5uGpLRh66Ij?=
 =?us-ascii?Q?bYNA3wpBcazXKMFN4ZkuEwEg5YedhJS0GifxDDw6f3suPvVDju7FqlOCp8M+?=
 =?us-ascii?Q?NVDv4j/FCCf3LmHJaCwwCTmkFP/RrWXrtf0om1vH1UxLqqBBsfrHCnnHYheS?=
 =?us-ascii?Q?D+604JH0ga5dTt+6LbQImrSfA4eXR+tXXgkZsVrVrvc27Xqx8lRVYlgTAhOT?=
 =?us-ascii?Q?sNtn3uR2UMPu2O4TLCzcHl4mlIN0zD9Ps5EhqUPvDShkCllLWbI/8hkrmgd1?=
 =?us-ascii?Q?TScQw8L0Q43TVHS/NzUvafO+h7lsEY3RZTNtJHp0vjnCWd9TetWgcMAOSRAz?=
 =?us-ascii?Q?22w6i6/UebhuIjkoNkvv15REsD3W7feh9cKFZBKldu1SIZLlI2WTJk+VARLO?=
 =?us-ascii?Q?NPPDvrW4RoCRpFUr0pu7ZXLTKC6Q4IviSfDYVItou+AI0JUYsz3s7wXa8wUK?=
 =?us-ascii?Q?713C0D3rkVRiTi50LWwdvCBbE7SMEK0p1zk7XgBGT+J1+lix2ZkajBjkv9K3?=
 =?us-ascii?Q?CGRHM6o/Bmt4xwKSBtnDsUXI0aeynwHZ8VbKl7Vr2X8N/IZ3Nce3Z2wG9j4k?=
 =?us-ascii?Q?Ld7K2/rtG0ptLJK2wK/eOES5ESsWr6t5a0wIUFxvwfIbyRhhIK8mmByLnQey?=
 =?us-ascii?Q?lWmttZ/yhQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90243b3-e5ae-4fdb-8799-08deaa8de33c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:51.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ls/3jtzzFVQq6j/sSf4PfKOdKWGfiPuQpRvsKDmJDW9TYB9qEWUZnUstC69gqvMGPHmMtsjrqMS0F45vyPFEZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: 851314CAD17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7497-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,nxp.com:email,nxp.com:dkim,nxp.com:mid,davemloft.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This file is calling of_property_read_u32() without including the proper
header for it. It is provided by <linux/phy/phy.h>, which wants to get
rid of it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Daniel Machon <daniel.machon@microchip.com>
---
Cc: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>

v2->v8: none
v1->v2: collect tag
---
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
index 4e422ca50828..249114b40c42 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
  */
 
+#include <linux/of.h>
 #include "lan969x.h"
 
 /* Tx clock selectors */
-- 
2.34.1


