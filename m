Return-Path: <linux-can+bounces-7003-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JUKHf9jrWkG2QEAu9opvQ
	(envelope-from <linux-can+bounces-7003-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 12:56:47 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7399522FED3
	for <lists+linux-can@lfdr.de>; Sun, 08 Mar 2026 12:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCE563068F79
	for <lists+linux-can@lfdr.de>; Sun,  8 Mar 2026 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E743876CD;
	Sun,  8 Mar 2026 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gOIm4Hij"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99C387378;
	Sun,  8 Mar 2026 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772970202; cv=fail; b=oQpwm9sYERm8ebofUXdNY7YFK3UDFiiYophdGy8VAHNSM+xEKkmUMEOomjU8zqcvodcdZIT99HoQIrvRhokK0WeEEASpEKX97B+7Smg5AzhRKCNQ1aLKM+izuT8QEaUaDQ7fIR3cdNMG+T+qgWrUX41Rkh3ofatLkjURe4ur7CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772970202; c=relaxed/simple;
	bh=Mfw15RveRlxU4MpET4yFJJWsBjXX2Wpnzp4EUvxP4AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gdIBUPmW92jsVOPjRffiuldfwGZsT3WTdtS5lTbJOvD1L91Mm/zqt4YlhELCADxyHrdMsjxGuth6zfAs0gdPeAzqEbyI1MswHMyhX3AuOgwkNNDA+HPfdeowt3svUplwtDOaurSE0kzxUXeScCjwVaTS16+8DhPGY7zEJJLb230=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gOIm4Hij; arc=fail smtp.client-ip=52.101.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+GSOdjL5BiBqtLNbW4bxPvi66xhRYZBdKo/y5wyF0/4BH/KJGrVzLjzWXNSjSl1KpBxNxDsaHAx4j/ss8SFssQj6nFl+sWF1RMIlA3tMx2n+QfF5zM5DgPj2nwcr5fMlIojJcPHuZZte3WqE/UVOlqOpx7m48tF4D4EyGLdC0opBN8IrFUoxXedcpvZQ+uAsMLAbtxlzbUTCyoijdMObn8mgTf8wwqVherXBPCX7lqdnOCmMIe+Ouutnxmbc1/5A2BWB7SdqBh+L5BRhwVF6Hki2KgrEr8csZy6HGZML8J3WChKblyVvdaw0FVH96BBY/YOj/cbnCsw5Dr3+QQ4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64aIAGje3LUiG5pg0iWDkrBrXi8NsxyID1badDybOUE=;
 b=AHnCanjp2MjqGshTg2r4/u/qG1z1huDPL26tFliI8AKYFJ1vf36TVssUNNLv6aYcf9YzJLwnQqZyQkmaftHzOfvxTewtg53WHGNKs1kNmGgCnTuV1ZkIZbauAHn/b/eIORah+7BW5fw8ai0p0B5cBrBUOxR5UyRuhYcDvBiGs4hVaL4DBEKUvDzhUNIHcM9YWcJpgkfx4gI/EP90gcgM/lcS/gI72PUREWjkL2QD17LtwVTy26YIIEDLF/32ezxSFKw0pc5i8Vpa2Rne6fSkCq/BNaeUJm08M6xeLrW5oMy0RbQXyEFSWRy7+psMe/HCmQHj0mwU4nTF9D1FxozjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64aIAGje3LUiG5pg0iWDkrBrXi8NsxyID1badDybOUE=;
 b=gOIm4HijPinA2geFLw2rrdxxPSN9khf2scaFMVzR38L/kiggE8h8Za1/+VlO2/bvmBIT1SE45yLzahBVlbfgSBMNLY+PcarJiiX2ltwTqDyoi6vV58j4L/4rqEmS1f8as2qqwGQqIFYRuWbUvj66e/05rQTG8UVbHRS9Os02KoTwNrtqu1kumuw8ZibjVCWCg5pUbb6co3lZth+9PC4DNKa82mtFBSEPMx+Dttgu/SpRQ+Z3WGH0cPxcIz1a2WvQc8wP+Z0x10vGkwDTXKj+fzYaODNcd5yZUXWds4Jh320UXzXRHGCa5/aKH4o7Tvl0pTVW+P4GQt9M4mCLfAxXtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB12426.eurprd04.prod.outlook.com (2603:10a6:10:614::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.23; Sun, 8 Mar
 2026 11:43:17 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Sun, 8 Mar 2026
 11:43:17 +0000
From: vladimir.oltean@nxp.com
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
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 phy-next 11/24] drm/msm/dp: remove debugging prints with internal struct phy state
Date: Sun,  8 Mar 2026 13:39:56 +0200
Message-ID: <20260308114009.2546587-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
References: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0161.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB12426:EE_
X-MS-Office365-Filtering-Correlation-Id: 0920e5c0-fdd4-4034-ed8c-08de7d07e402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	ufAXEt46dhPv/XXStCWs6F98Qo6s4/OthUfHi6nxeFCiKzs8/U++qJcv/n9RSCafi9qijxsPQKWGt6+jyOll4IV9MDc8v6aSi3g1uUnVO2uXdaS1saqEMgoRNIdwegDT5HvGxOC/SbKCzHGj61wEpdACPJoM4Y+xS0/6RA7a2Jj15Hr41tMEUvx9CicIT/+AazNW0B9KnvqATN+uoAxAalaADU3Lxxna2h0Y8RuGp71hUJJIdu04prQbD4RHCJu7DV6HQiTOBB4uz50fPk2zW95ELPoLEBpjJBB8OM7vSzIScvIFWJNBpqFMt0B3+ucdqZEMKNmU/9qFm6LV+Q/WbAK62wBXlViYZN8wlUOx4gquvewKlk8Yaf6F3RBkinVCHqno0LSQmmNdCRXrE2IaXIefjsUsjHuQEBRN9qteyc8X2AUNpAM0sF7pv8eWFEN28a7fJidz8CGm5LrmADYh1VQHmth1XPzHHZX0EXJzgZKGgD5CASFzfZsnU2P89bi1l+hjRfQ77GGl3IN7YezapCK9orB0ytmyPrj8GdOOiO8ql64yFFZ3dFMfpAN2Zxkf4PYKc245h+RxYoZ/8GvpMBmzH2uTadLZ4JQCUQOTDhKXIYGFsZLRj6JG98xMrgxnPRR/6TS7PVeuay8YtvPHqg0s5Ss4zJFQ50x0mjiV0JIEWeP16JNDw/WRhOscaUSyrYu2r/aEgLGnKeooXULKKrkfijb4mo7flrLYqivtjkU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FNNIDjZgmE6gAjv5RoaMeLvBHGmQMzbxuB3/ckeoB5OwuBuLRHtQdQSn/SnP?=
 =?us-ascii?Q?1rA4GvpCTLtPXRGJj+wcLJNI7T+DGBfjDFUf3gZk7YQQZJWiJr16LrWukiXX?=
 =?us-ascii?Q?NNv6oM/7VzNYWRPxJY5n5k+P3O3KWoDM55Cy/oLHAiQ6vRSFoQ/N7TxQKVxQ?=
 =?us-ascii?Q?kBTp69Akdp5W9zLZqaujsr3VSJxsxreY4rQh8QHCm7bjR13P1tzLc95cvJB+?=
 =?us-ascii?Q?cBvJUHDru3krYOnYY6t4kxYBOMIpruORxgmslj5xjidLNgXW3ZZAWaUTvv+/?=
 =?us-ascii?Q?xY0DWpqjynV0FNdsUgyICFkt7gtmGXXbfFdiK/5b9AkqfhzZrBvYmfico5gs?=
 =?us-ascii?Q?akezA+7pRA2r9/RqHn1ct6Kl2JsPvvOKAqgtUBLm7nRaSdPyY6s1p5su88N1?=
 =?us-ascii?Q?nepBOAWln4ASYjxU4k8PuT7ln94NR2XTq17zFS1eoN1/5ozBCJE7/Algsa+w?=
 =?us-ascii?Q?OixLLQLjPi1KQOa2ZbG4YOvnaGhjakyFj8++ItHIsuAH4hDTHRiu1wieh3/y?=
 =?us-ascii?Q?zerI06/j10FYV0QYupAFSEw+HREpAxNFrjn4KiUcnhV/eFDqTRaxW+O4mqtx?=
 =?us-ascii?Q?8GbJlTJeKC78Hcz4qE/L1uyUh0+jeMA5MCjgK4Vlc/WPY/kWhllhzgrWmr/q?=
 =?us-ascii?Q?akAoRSon4Q9J6Gzuv55/bWmRFk4lpsPOMVeZ7QaKvP/9RUJMY/YV+gLOrKKn?=
 =?us-ascii?Q?V80TnEJRz+xHV5t0zHX8hgegw0Yqfo6DKSdsDtvnd+7kfkzTJZKko/w43tBR?=
 =?us-ascii?Q?xiIEUpaJL2DUGherU1/hf/CrtlzFl/fykcnwNuYyRp5ehVH5Px1Je5C80sv7?=
 =?us-ascii?Q?I+JmMGjhTmw1lei/wNxdIBgljYsTAGPqaUVXhLLG+eUevFBfnRwFgGx1vqIQ?=
 =?us-ascii?Q?e+uMN+jQ0Cel661zMAv7NqjTN2kQybKdwlkvx3/7U2liRaJ+Rno+X24xZpqy?=
 =?us-ascii?Q?sIr3rF6I76cWm7GIyoiZZEiRniasW84Pr85n50Zp++OszCRmlZ3MmeaEMI8r?=
 =?us-ascii?Q?sau9/X0WYqh+uJ0xltB8O3OHfG04q3nniUZ02wrlHNoVaFLrEbkxboLUi+IM?=
 =?us-ascii?Q?BJZHPDjfCdDKfWRSAyTDL1ABmEYXZg+67/7W7h1yFdL66MXEkadX/w8PVlBF?=
 =?us-ascii?Q?IFs/p1kV32HsmHuXFgXeXPB4OBWO4BCazucqPJRhCqCukGFtKeCi62e3/2xk?=
 =?us-ascii?Q?pNAJwVaGcVmlG5yaiXVydcZuR1gXIMfvOJcbbQRlfZluZOm6FKHUB/8w01Iv?=
 =?us-ascii?Q?KQp+vvUpxPof1SfIgjzXHAZQK6a20NTR9h15lXTB6DrkSIEDhhPJxRRdn3Wo?=
 =?us-ascii?Q?2/lEKUPofOuiJUolQ9NVE0tr+0OtK6HgDUjonu6zoSEoWfSEig4NgNBVeU30?=
 =?us-ascii?Q?j2El0PbZjMdDarPMjt9Ns1ldY4YyTvrMSZ9hz/tk4UTzqHF1XCkgJJco3OJR?=
 =?us-ascii?Q?s8nniXHlwsWV+5s/GCEtBEGZym9SPNEJxChD0qoPW00KXLoowpGwXAsesKQE?=
 =?us-ascii?Q?9ND5LcJ2Cua3sqL16OV91xbpSg5eh5DukM9sEnzMx6FhP48DOMWulq0xGJXf?=
 =?us-ascii?Q?wJBFbfUKvNqgJnwNVGE6FYXhWQBQ8A9Ie4MUcrhAXjpoIFzpNs1EklJ/TCSA?=
 =?us-ascii?Q?r7LMHxoKvfUbuJtDHdbrgx4FH+1xK7HNa6BG3OJNJhPCknuD5ASin47g4VWT?=
 =?us-ascii?Q?zcPBqpDzvKjqg7Bi0V61Z3xRuIMHpnB1IZHp1chPcMDRzHDTsSgc8e460Z0c?=
 =?us-ascii?Q?ERM8SkWgXa7K5gz1tmzqPsA3nBjtSOlRcpX5XPfxfXjUyPh2rCwHhv+qR8yg?=
X-MS-Exchange-AntiSpam-MessageData-1: S6sdC/ihtgZ9NSBK9SISdrWYR0u3bZkipJ8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0920e5c0-fdd4-4034-ed8c-08de7d07e402
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 11:43:17.8274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA7FUrsuhsqqU/uPgcgwZjkT24hlH/AloKIeUEZJ5O6Zm6NmUVVcU+7/Wy9nWB4By6km8A3viYU8u1y4Eal9ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB12426
X-Rspamd-Queue-Id: 7399522FED3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,oss.qualcomm.com,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7003-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ffwll.ch:email,poorly.run:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,qualcomm.com:email,somainline.org:email]
X-Rspamd-Action: no action

These do not provide much value, and will become hard to maintain once
the Generic PHY framework starts hiding the contents of struct phy from
consumers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v1->v2: collect tag
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index ef298c7d3e5e..cba8a71a2561 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1928,9 +1928,6 @@ void msm_dp_ctrl_phy_init(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_phy_reset(ctrl);
 	phy_init(phy);
-
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -1943,8 +1940,6 @@ void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_phy_reset(ctrl);
 	phy_exit(phy);
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 static int msm_dp_ctrl_reinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
@@ -1996,8 +1991,6 @@ static int msm_dp_ctrl_deinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
 	phy_exit(phy);
 	phy_init(phy);
 
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 	return 0;
 }
 
@@ -2588,9 +2581,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	/* aux channel down, reinit phy */
 	phy_exit(phy);
 	phy_init(phy);
-
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -2606,13 +2596,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
-	DRM_DEBUG_DP("Before, phy=%p init_count=%d power_on=%d\n",
-		phy, phy->init_count, phy->power_count);
-
 	phy_power_off(phy);
-
-	DRM_DEBUG_DP("After, phy=%p init_count=%d power_on=%d\n",
-		phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -2638,8 +2622,6 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
 	phy_power_off(phy);
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
-- 
2.43.0


