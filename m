Return-Path: <linux-can+bounces-7269-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDkbKW/SxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7269-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:54:39 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B142349657
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F3FB30F3217
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC35337E302;
	Fri, 27 Mar 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e6nhl/AK"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA5314A8D;
	Fri, 27 Mar 2026 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637330; cv=fail; b=bllbpJYTZnx70qNJYDzDObT+/Gc6AsQ5leZpoyWYemBZcFdedS5Wc6qR3QQqDuz9z17g/xDFXJTS8d+3deDD3axzH0axffCX8LBWT5KjkLVWw2dWNF+upp0hHX+4RNO7FrwaWkHPBievPp8tcYNqZN+fh7d84tiWF8GudDNacXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637330; c=relaxed/simple;
	bh=v4i/u8B9nOKIaYO/idRPT1p+oM24ITlBYbGfalWcANo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hwqsTTtNUZVfymneSpQu+e5JsWP7/gvPp60IQthgc/HwUUarXHJ6gnEiV6AXGIDO7SChhSMtpMXxi7u0ERM9YTXlicuulA5ll03INPJwzfSuegLLoISjVfihLM35HaIysqzy7gLV078t40eAxk/TSREphebwcPCPKzW+bGZTpTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e6nhl/AK; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFI1mmG+Q70p2GrC/2+eRrx0HjeWCXptIP1oNqLfKzwcqDcBvpr6JV/CV4X9eUpSW2E9Ihjq59DjKTRTgRa+HpLxKwZDbAw3ErTyEMzV3klJM3Wy4WJObsOpqEFXdmIaj24azKvpl++9Gc//qbkkWuQjs1eZ3avLb+b23wHK1krRLb/jAmDBSf645pItdw/96xlBfowb5dYEjXnjL/3fjYBqksEXyt7CKXPLVrVSu9NK9dnQtslZhaC1MrOFvsIvVN0G0So/8vSQVtVwpWkAoLko71pTb9ZNrRa2RkeL+056fnolGDYkbJvyxVlmXRAGwpw78JSrxw6RjAD5zyUDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVeviPvHMq0LaCxSlyLaskF0DfAAFJIx0zC5WZVO2MY=;
 b=UxrpAewTIO9e7dDvam1/+C6i9wi822K/iONfJgR2Wv6iaNLHdr77sjSqvwA9QseiOgn7qgSyg3aD41G6EcqwycDvJxrN6QUi2o9RdPwB9zngfRX6FxLQIAIZLr5d702f6/PsklFLAM68BC6gkZ5fubIMSTFabRPncSwoUgxD8tKTp3kYaixMM94lWLyYTfjrg8BRgusSTt7UFSciZYx+AbxFGHWdzJSEKhghH7ubRYrgcnfrP9rrzBy0MLt2hPcT1aYboekZ3GKe7mEdzvSAtzF4W4uVEADxvoA90qlbqkoLuknsmBqOUKWEbwescObMVV8Cy7+/HXb6gOcuV3SnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVeviPvHMq0LaCxSlyLaskF0DfAAFJIx0zC5WZVO2MY=;
 b=e6nhl/AKphohFmlmdxifV73rjSDcQ2UOT53zc2F1ByslZ6WMLMRS8Lme2nxu/qYFKadXA0Hn9mr32zSa1Zsc4G2j7Cr/Wf9J4fACjNBC5yf5ZVGggs+11A4bMJpzMgA5UYjFm79suWkDsSPisImONMHta/J9fuLMOwKmI/lvliJX5CTppUYH/sc9riJ4g4bGtr6k/+q8DLgI63qCZVvs2jrgyc3so9i2aQjA6NVRkCnQmaYkcEOFCesHe+tMlneiuVTM1rFoTaR/FwjeHdInJ1lA1AY/m9uLOwpXON6+KFo8QA31ydow0t6Glu73+ldseO+jR7jfTOtb+6UF+C7xoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:40 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:40 +0000
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
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: [PATCH v6 phy-next 04/28] drm: add <linux/pm_runtime.h> where missing
Date: Fri, 27 Mar 2026 20:46:42 +0200
Message-ID: <20260327184706.1600329-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0303.eurprd07.prod.outlook.com
 (2603:10a6:800:130::31) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: 862befa0-e8ba-4883-f16a-08de8c3176b1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 ksHMILi2KEXCqIgYHih/INMWwZHJ2DLRsj4r9Q7KIkiyX3cMyWKUuJ/k2D4/N1GH5tC19MeAHI435eAma6BHmjAybNWZKkJ6yLfsrwot5E6FhMk3pf1mFk7xDUGYL3O8sEG3brmYPAENITjyFVNVB8GRc85UpIiQdkJSIL49JaW1SrbaWaeoz7stvQrCfOuDFeyDO8QtVBBkyp7xiX65FZAto3D+TpgNaL7O2tWyOuwkY8wfZAh/CfCQoyFl+yaGMEefMjNagIE+/Hh6UQ8wdUvPdJ86IfzjzlyT8R6Dnn8g/PW8mroorEv6OW8OFFspENKXvS21p1DyDZQbKWr/3wyMjgaNTZdA7XhJZCZClm6a2bgTkeELXdRmF4TmK0VwFMMcIuE4ba+wRBs3PgUbt43PCYd7J9TAu47RqMvYzt6KJlnD1zfE4CQ9ftBsw7mAVNAVjydJQCEfWy+Ao/Ht0aXSwkVwg5DGBUu2ytzYwylpxMjEKkR3+4uh01g2m3EqVarbxzCsNIy9dlaBIQqPKG5YZq+Tk4RRAH+wj5xLWeT0HvJ885t/lEpoeuRB4tNf78Gu5GX9ZoVjXACp+yuxXwfjc8eADd5wHPY1KsnudUNwTjouvMDTFFrGhoa4RfjLMR4uirFqJ4A0wUlsFqeaWtpHUERBpxLUIQdPn+l6GT5OpAeOaiT+iLGkEyf7WDeO62eCPGzyMmYtoyq7/ESASprmStM9RSuopRaqrRfL1Vs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?jcJZr8K24dQD73IAGaZuBOPR4/64LbZe6cUnMQ4c8kxoa6KuRfBO6J3kuLkm?=
 =?us-ascii?Q?Hatlclh/P8ZWcnQS8Jw+1EBQqmnflzHrqE37Ps2sBwkOlxEACKIL3rUEHXSw?=
 =?us-ascii?Q?TzKRuwCT0J/htMh2FXNNlaMX1A58yZcbwLQSY3cgpE1uKG4W4+pjx1yGUnGr?=
 =?us-ascii?Q?IRPdT8UU97fTLA8Sc+tHls7Lxm0PbWE3BYZ+JYzYLtGtsdGt/p0LPyIH7dbj?=
 =?us-ascii?Q?np2Q71q+i1kZ72/qxRny3JEMksuo9G9xpTQ5nMxKGLgf0xGYylYbTH5IsICa?=
 =?us-ascii?Q?bjzl/oXkeebOk6kVBC8XS5qnyCBightcQ/P3hFqRWOQh5WhBPYDKzG6EPntE?=
 =?us-ascii?Q?kijV1PWDS3NBMqKnVzts3Hh/XyGBzmApAM2l5FBmSNPxAqEe9IISJ1tNHDoB?=
 =?us-ascii?Q?ov/NJbQAFOP+ACkileeebRYBK3wDskjpxm3UPtBdqILxLJhAyOVn6wUG09uj?=
 =?us-ascii?Q?MUi9AWfRxmiBuL3lkGoEHrcnZKO8R86U7tpb90hbexve8LhMcGCremFFUrnl?=
 =?us-ascii?Q?4KyUFMRL/aEwXgbN3GRgxwdoRuXo5uwB4yT3uF56Et5wB3wJ9F/UEHvjco8q?=
 =?us-ascii?Q?mk6VT/ujMT+3nmWfz1o6JEHDljIMr+gVgmRgsvXZu5vsKnO6B0/+uf3FtiGC?=
 =?us-ascii?Q?8fvh9T+xCx+7JR9dPlqea0M+eskgCUXqIZIWnu+vkK1U9Tdp/aRjssVlAf2i?=
 =?us-ascii?Q?d6hkYaaqQa7m3VbNYdVC8cwgogpsuqv7dyi2W0ULrTj6qCN9Z7q+jkTMnlVe?=
 =?us-ascii?Q?HQ2cImPx7uvGerNEVzeLxpf1ZS9KBPDLT3pvmpfSpL/KVkNXN4i9D1Fxjxff?=
 =?us-ascii?Q?R0sn5ZC/agMMpDSAkIFJz7vSuOrB1V/KSRGjHAUkNoIZzx6IF9yzHw/OeOQW?=
 =?us-ascii?Q?uWnENVcsrX/+sMmlMa/cLGJSdgS8plmORigGkwtaQ1vAigLT2oM0vf+5xGvO?=
 =?us-ascii?Q?QskiIEUEIixcGwMb5pPgx7DwdHV22T5E6PpcOG543BfgpFDs2ioBDYt0kUSZ?=
 =?us-ascii?Q?Qhl4DkUXSRVU+ByybhikdXrufJSkrxP86tuPvN/rlZJ4UV/7dvQdA2oke635?=
 =?us-ascii?Q?vLQKH4utX/vWSr/hLpG2+M0jqKRNBYts72AxqtkVBMLxa5zISPFfhbmsdlUX?=
 =?us-ascii?Q?qrq6XfVb9nMLMr8dIvJ4gF7dgGKQsfsP020Vw0QzDwMEXEzZrTkcZQhb/Kbg?=
 =?us-ascii?Q?TJKMkWegmrmFwLX5IgzGaHvp19WBjh1J5oK6/OMFy6KoC92qD4Ee7gLrO8BC?=
 =?us-ascii?Q?7WEwK1ZQ73ABjFN6hqFzmQin+D8cd6oC+AewaZUvAE93C9sWepbexO5P1RYI?=
 =?us-ascii?Q?boFzsGEBPUiOzZtHWng8jRTeCoJdeVtESG97aw2NLSR0uwqGVymQ0WFSeQQO?=
 =?us-ascii?Q?PFFzEmFyl9ZCTukaVG4BmjdWfA9Ha0LqMyB+U17E/orQMcoyATL9G2XEPoES?=
 =?us-ascii?Q?ZxnytnwhVYvMZZVhYr6esSjEFIx7C3LJi/d5+Qy/ILxUeXkXBVj9f8hPcqdB?=
 =?us-ascii?Q?OQyy24XE9rjoAGJAERs7Y1BwWMwaX7he80Gz3zFJAk1qQRGfai9w4CsG9SV6?=
 =?us-ascii?Q?DL27rf5a7ORkkBTIn1OXHzVrVnSVybxB8/rM1JD8kZa7gARwYx8NdOdyrsUi?=
 =?us-ascii?Q?Oj6BKvCxpjuChAw/0bx9GLnqEa9xAIs6r9qAdlAiMudmAJNf6qeJiuweJIFe?=
 =?us-ascii?Q?WwIo88Y/vnDn75aLoXSauBLAcwlCC+Xzt/CHcYwpECSJErUeFkmP/oKR/gcb?=
 =?us-ascii?Q?p3ua3nr2fdIfNE1M+RzNUuGbKEXgbb6kH+LbgEteE12rDagsFk11JPH9bB6S?=
X-MS-Exchange-AntiSpam-MessageData-1: S9AbpDrxnAVZNazwEzGprAfDzuL1BJl6eSw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862befa0-e8ba-4883-f16a-08de8c3176b1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:40.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEuVZDyYWVrMQgbSlPCVbRdunUcpNhOmcz+GOLBg8d2kirvhJOG47Xr9czJxyAoTWg5ZlZZQqNwK6FYQyKdlFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
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
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,samsung.com,amarulasolutions.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7269-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B142349657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multiple DRM bridge drivers use runtime PM operations without
including the proper header, instead relying on transitive inclusion
by <linux/phy/phy.h>.

The PHY subsystem wants to get rid of headers it provides for no reason,
so modify these drivers to include what they need directly.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>

v1->v6: none
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c  | 1 +
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 1 +
 drivers/gpu/drm/bridge/nwl-dsi.c                    | 1 +
 drivers/gpu/drm/bridge/samsung-dsim.c               | 1 +
 drivers/gpu/drm/msm/dp/dp_aux.c                     | 1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c              | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index efe534977d12..9dfe790e6c14 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/bridge/analogix_dp.h>
 #include <drm/drm_atomic.h>
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 9392c226ff5b..a8b6ae58cb0a 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -32,6 +32,7 @@
 #include <linux/phy/phy.h>
 #include <linux/phy/phy-dp.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 
diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 2f7429b24fc2..9ac8796ae91e 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/sys_soc.h>
diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 930aaa659c97..54bc148fc29d 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/units.h>
 
 #include <video/mipi_display.h>
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 3825a2fb48e2..5ee22f88bd28 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include <drm/drm_print.h>
 
 #include "dp_reg.h"
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 177e30445ee8..68556daa54ae 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -10,6 +10,7 @@
 #include <linux/firmware.h>
 #include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
-- 
2.43.0


