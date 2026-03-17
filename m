Return-Path: <linux-can+bounces-7115-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJF/NrrfuWk7PAIAu9opvQ
	(envelope-from <linux-can+bounces-7115-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:11:54 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9379B2B3DCC
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48D3930DC9BE
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A87E3FE65D;
	Tue, 17 Mar 2026 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BiTEsiVx"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505EA3A5E69;
	Tue, 17 Mar 2026 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788760; cv=fail; b=HoSSkVjJ7QT5o6McSvWrRNGqmrxTU4LGXjvQgEnp+DyopuvkluNQ1fQ9VS47JKGBRkb1JoLGjgLPS2H8ifVRQ6+PunomGO42Y5MwPfamEEqy0FzzbQEmqhXJ6N4roQ3b7DGBzYToivyuf/ybRo9YdVUrZAlya1twzl+Q66YNUvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788760; c=relaxed/simple;
	bh=kZaaXa5BlcY7rVL9wk+l32ygqDA+tcEWXi9B+6cEYSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JY1Y7GC2jTjCvaNtmXU+1CV7LJFVE4MEmwwXNlGlmTI3RIgSdFT8f2Qaqi2hB/H9OArTbaSP8sOT5hdtBYdtwJBfJU3PKGKEfaeqVx9Y3413U/nMy4Qdaw7JNlxypXR+sl2OGXQ92xxFUwt24hluy70ZeT+9u7HWRO9pOM1Zjdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BiTEsiVx; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqnV/bc2C3qcaFw8ZgBGo+DVXJJXUWenF/opp0KC7S3dXVtuhjxiMgLwACa9BwTg5V1cky6d7fjLRgKP8IGEey802QVYzPC0ly2SjZ5aE2L0UqfqF3+t79/JAXDRBbGTUyfGsHL3KO9TN5//FY/jv4CNtWbNEQXWPlAiFfKRt9FOa7WGc7v9wbI8FrLBLbC0yr/Iazwhs9yb/K5QSDuYoZFmONLF7cAR/IVJur4xkkcXS31ora1ZKstcr7Ru4XK7OtwvOcu3y9fsJzv1K8lcNMoCWZZjfo4LL0dkiWlPoh0OwFekPWw9lEwzRz4OX4dO4YAQmnRf5i7zc/3+WDa4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZwHgbUeIMTz7V4ZL6rC+cTux/hD/zkka2eK0eHiEac=;
 b=K8FUPAfCoCiGKlYDvzmBMCc2WzljCunOBxkGDBGZFYdUXvzGN7USjb8KtBsrqcchnOHZh1ycvT9XekNDFzAZZDZW+T17h682ykPYnum9czp3xOWBoGXWPoBUXpxi+MClCM7UTSgHeP37oZ/XyTlKpyPr2HY5aA3YdVTHsJ7pzJ/Lp/yEBCXCSoCoITs9LTcrq9UNL3pFQr8CZDa1e8qctr4qh1Bu+hKV83eSSl3Fu4suw10b0ephvvGs21Bh4CuJGDMKIkp/Yx6vBzFTAn80hiCL1GUdkI7Axdx7Vt1xAbXhjd+1umxSqHRp1XNWalvvk1k0+dDu3wgLfEsc67rR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZwHgbUeIMTz7V4ZL6rC+cTux/hD/zkka2eK0eHiEac=;
 b=BiTEsiVxCVtGotcw6MSFYhB85o6ycrQgxaHRDh28aosCbna2X+F7h70SpW8eG0+tKfeWYqiubNnZlhIJa8xAnzyS8jAgYhIXomgsWTOOpp0mgATogpe3m1xLxnjKmMk5NHevz6d85wOlVNt8JtnIoMkeNsSyOEgHsYk/LGNF8vFASM69uIeMDQpKG1jV+mpamRzt2IlKRc9IJsf3NdIDJyZmqJwHxYHCx93kNJ5vPUAJdXqmIE4x9WIrBbzYQSDCc8mRYtA3aSbXeVWg2uxyJT0A/CjZVbiFcJAfjUUPq8u2Ip6pNSlTpmrhI6b6P0HYwjc+zKRMgI+OIP0VPILDwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7022.eurprd04.prod.outlook.com (2603:10a6:800:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 23:05:33 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:33 +0000
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 phy-next 11/24] drm/msm/dp: remove debugging prints with internal struct phy state
Date: Wed, 18 Mar 2026 01:04:47 +0200
Message-ID: <20260317230500.2056077-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::36) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6a6ff6-5ebc-4eaa-7b74-08de8479b100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|10070799003|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pbOam4fd/zrUIhPyiFJDcO/IbSAG2/xCuaAJqsAwYNiiekfSu6iX265TKG1tUVKbkcETL1Gp35NyzOJpAhJ0cf6+QPjpa6SK/5uv6VEE/LWOdi0yDu+WO8hG/eqs3lghQoJlKo+Xlx1/pxpKGGZlrJnnYFAracqFMCSZA1r8Y3UZdzeRigHfYfGL+aQn2SuwzbBSLoPMp2b9tlqkTd+iN1W3N/SgsAtxfgIbIhqhQKRrEAFFKjQE8Vq3cpIwTXEBZRfL7MPYKCQj3BIHbJUC5vp+r9NvGSFDE5A7Ht3lU4Dj51DYkHiM7N86NjIvOzGV2cX/hTJYKY7FHNZWhNpyougTE5UM/Xz6vWbeljPdPj7N7sxodVwsnu04y2eISh42w+GOvERh40rVcnNqw/oM6aDz15NSLfkxTLy+BoKgjv64v+dK94T2oOy9Bkz2tweoA58rJZprOZd3suM29AXaZxJRjNfFPd8ks1vXYsgKpdyDq9XzqkZdjIEpC4E6FFiyyrf7/8wMY8sfdXE9td+yv0G3/yGW/+FzsKOMgksCIZak13GcBUnqffeae/7D0s92aQdS1swACEVNrcEEoP8O71nfGvxIx7LnbaP3V2LjOyoOU6ZQntsYPFfU6Ih7IK1HLq8CL04PoQV7r828qfkn0NNF98FranXW+ultLWvQaIUMK8+akvxDIqcgE30i4IYiLuUnZ7DuDilAMENQMNcLk9fMPrtrqqLKEuz6xwn+oF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(10070799003)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NnNxBXMPgGTyeFSVPUetqgJ0a3yZpwykmGPZPreQciLoy/efmmOYm1ghjzHY?=
 =?us-ascii?Q?UJa6xuwZMGW/Sn0tuW9M4hqzsThpNyHu5BZghK+nQqZmnlvMyT4XFfaLNXNr?=
 =?us-ascii?Q?bg75LoK/nAAMH+HUXqzG0E1BDWQ0r/XZcdqmWbbpiv490/lbyRgwxD7T/iWd?=
 =?us-ascii?Q?8SMeFTjyjlhWYWVWhoLTUIIcSJz9yb0tn5ZQCAQRLnuwFa0gmRhhvV8R1Wsj?=
 =?us-ascii?Q?lmpQNLqD903FDfkV66rNnNzv6xQhRWLI+GqnBbvBrdTWWStsf8mktGHHwpi5?=
 =?us-ascii?Q?rsZ2G+dz6TXG/yq1ByUlv5lgpWtuvG5Ub0w3MGH/4IQlsmDWyvsqcvqyX/uE?=
 =?us-ascii?Q?Ol9H9BqWt9iAHSFSEyVkoE38Tkzp8JFXjbVdmkWEaQcx8l3doyNloeXJs4Rq?=
 =?us-ascii?Q?Vda8KTCBe/xsg4sSf43B7Cnz88+7DsZ3eXCyZDC3J2BG/opcZsRWYc3lmvkC?=
 =?us-ascii?Q?uaHFAIfnONzWfTxOBFYoI7kYx2jE+gNB0pXGpiHDcLPMyamfoWSgPm72HgnE?=
 =?us-ascii?Q?di5Vzer1Ha/ItoEB2xSGEQbaLAZ0keJWyGoCyLW21g/jK64aCrKHL0tDPV07?=
 =?us-ascii?Q?KOqlJ0YI0AJo2lMG94VWtReuk4vzg7oqYgSGSZByO7hjSDn4vlJ4jCPKfeoe?=
 =?us-ascii?Q?3P/TJ6NzYorFzNj/GI6gVTMW5FiMi45uYKQImxzqy6J2NGXZcIt3SVss1kIP?=
 =?us-ascii?Q?KoKARYGMxTqk9HjvhHOXNiyXevmuY2doalOdQ3s/PV5HBm+SP+T88caZbS27?=
 =?us-ascii?Q?IInltvaH638JqX9MXYF65OqQRZMOKSyTdAqZajr8E6yk7TJImth/Lb/XusUM?=
 =?us-ascii?Q?v6HJFxoVb2KmAL3WIxxod1k/g8EPTaK6u6EwWzKMGVTWr0os288qXoVN2qYk?=
 =?us-ascii?Q?bx7gxGjAt38ZOrXjq3gCcU0+Lh2CH9FvVETST6y2+HYCkqjuOX36kKAwwVe8?=
 =?us-ascii?Q?H3qeT3CI3RhNqccurPXOKjUIYum/wywMvpFnUxKqlRWVyk6DDTsjptQ93gV8?=
 =?us-ascii?Q?kt28qbTa1aiPRufgsdYcQ5MKNdaKlxsaf2XYYmfBwHhuon1KdpXzyvGf5qxp?=
 =?us-ascii?Q?iHVAej5PbhRDLzY08NUm8rziuavyYyk05IQ9GBu3F1iJdLG+jkO12QHGwXPE?=
 =?us-ascii?Q?Y8RmO0AdHneLHu8o4w7r3HHh8nITxW7uiOgA1IVpqiuhJZ/XUZ3koXbX3iDz?=
 =?us-ascii?Q?t/kn7z3w/tf2+lBQXKNl2HhJ4X7zC3i994WfRdT886QbY5mfXvHknyl0RZW8?=
 =?us-ascii?Q?xFuwqhvYYiPmAfaeLW4JK6MbYqfyO9B8j6Wu0Ek0Avr+SCdduOHOqItmEEN1?=
 =?us-ascii?Q?qbRPlINpswrI+w7jmTO2RPbNmBbUQDqkuIx296kXnbBLfycHHM4mZuXCBpnv?=
 =?us-ascii?Q?h1oc1XwYORsoKeYYUcWLLtuvzz5i3G1WOdNlATW5wHLT/0SJfCLkxC1ZTmJE?=
 =?us-ascii?Q?Yr9UUSYEIkNSq7pXMvUQtQmJDgyipTqbzM3+azurzPw7IyNbpfjCNrUf8aO+?=
 =?us-ascii?Q?lxavR6513H4HyDSmEIEbDBeqRLSXwzZukz37uTyuvmipERZ7y8UdnmtMrssD?=
 =?us-ascii?Q?ntbXrnpCi+362jZ4/AkLnQywTB/UEhZ6WVepsa96q7L/dy12EugqjyeKMcwR?=
 =?us-ascii?Q?LxTDrC0o5xO0OjhqQgR9k4DP1f7A7C+vQAhF+jSUYNEDROtr+uF2bQmcnZpv?=
 =?us-ascii?Q?Jw4Wqr5bJF6WzhZIjezGSKz1uxGMFjIdo8APV4IxGs3iYAJd+etICA2BV3ka?=
 =?us-ascii?Q?uuvqsAtJpsbx2NdJjMOIYbk3MTwUjVXM3ER81NiazYaFWLnZT1FL5JURk2g6?=
X-MS-Exchange-AntiSpam-MessageData-1: g0QS5ar392I6om00hf7KTBiISXxawUGdFbc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6a6ff6-5ebc-4eaa-7b74-08de8479b100
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:33.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /a37Hyw20fHo3qB3N+c7JP536AB98bTPCvtRwtFtsZ+T8Op66Zi9CN7KgwyPp4/N4GdD5h7UoS5e7cxDFivsMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,oss.qualcomm.com,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7115-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,linux.dev:email,poorly.run:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ffwll.ch:email,qualcomm.com:email,somainline.org:email]
X-Rspamd-Queue-Id: 9379B2B3DCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v3->v4: none
v1->v3: collect tag
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


