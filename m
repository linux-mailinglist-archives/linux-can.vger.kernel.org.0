Return-Path: <linux-can+bounces-7105-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAwDFFbfuWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7105-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:10:14 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E58ED2B3C34
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3DBF31B8CB8
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7943F87F0;
	Tue, 17 Mar 2026 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F4Mbd7AD"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423113E51C4;
	Tue, 17 Mar 2026 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788745; cv=fail; b=TU0Z1u+esArsw7uJ+GQuUmvVcZTOFICepr+rRmqOa5p0Mqs3YRJmghc2HiQ+Q4v/vYjGhGxFwJYwkGU+nkTCCuZ3gripnhGNq5ajynTxPFctgSSdasBuyP+zFbHgBxC0nG0noDjVBopCTnekiITrguZzpUWUXtFMb9g6KSODTCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788745; c=relaxed/simple;
	bh=Gx06K42lFiJ09Wogt9QVYKcYLjAlo7A5Unm6oFZCo+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IbAAMSMoPpMbtGUO+OyJwtPOPKIv3u7GI7TYtFeKZpOi1oYTO9QUBKc/Ydea77wrIH+joYEbM5+MUHm5DGNo6RU6+OpN2YqKWIlQVWD4fyZhbviNg5UJ6fINHADaKAM5rOk8OCKXhFFSs4BvUAejZZqap7b/zw6dSri/G3CzMt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F4Mbd7AD; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ve5V4xBIkHxKDlcqEX2E/SF8NRmX4H3HMp65kawepz1VcRhHY3tVBGfdQAqjBci+IGagYMj//1CTDlxjgajlxQIlL6buptwJD/NFirkcKFfrapFkI9Eq9btdDSik2wTfDBAIGf6AybwsI+ASi6tgH1ckoYYwehqrY7TyyMENwanOd+Iof1TuBsXsf/nQdUhWNSGxbEK9beWT9bfFx9LUQTH5mjDb+hFY1+e1KYciregDPnk7jsG9EouI1hHDqDiyQDhmCSTC+89YW9W/+luuyJV5tX2TuG2d8sSoGMeaxOvz5Dv8Sml6lF3UfooRmwjjKJCDRcTs8I1Ucvk5z+oFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3ASyPZo3LOPhIMbb/Mt7zFBAAWs1PimI3cDTINQKMY=;
 b=jV9Nx2LmsmovIRPmGckjpUU2kO2jlaAn9pLcIT6DEOe0X3xl1bBXESeIp5CcdurizZmlQ2R73APCLbDhzMZEUpAXysXItteMt4agbYHKDIfoWWIVIjeX9g19/BIRETA8HCwljHRpyUh26FYhHPTKPifxvOoRhq7hgMfk7JPPxS8IMumm5edoKya0CpaAiWZwSu997Q+ubb0+ewzSnfMG0QMwxoo1tKtitvD3J76wXnBV3NWKClVNToZFssjPf5iaaiC8CoS7FlK+zHUDHxJ69n07j7FQfXISThEKg4my2km99GjhghfShiNRIbWX2Orjp9yhtbTlU0cOnYIEelX9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3ASyPZo3LOPhIMbb/Mt7zFBAAWs1PimI3cDTINQKMY=;
 b=F4Mbd7ADGy5m+JNu6Bk/ksDQGAT6+9EZoFiPg1orrYmrWKz0fWB3FAd2iCAuQkX7pU8D94lUKB+IxnHvtIsPr6DS4PcmRYabVGE+HYPgq8LDNPBxe0tp4/ebfQ+aSZBFzOnaxCawzarz5PRNF5NLKeWm+cd9frVmKdnM/DVfEUOz55uOhT3JtPQHnmcPmWcBLeWkMBZJUp82tTq3axSoS198tRWG6q5d0Qx5Cr30ye2qIktxSSUiHWknC+Mv8uvI140w2I9GhHPQ3Tzn6mxlIVmkAuABeMHmw0zh7Am/JweXek3XiarBADM6MkFOf4LEyw6bj2Gs2yWSqaaEQvs2Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB12032.eurprd04.prod.outlook.com (2603:10a6:800:311::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:21 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:18 +0000
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
Subject: [PATCH v4 phy-next 04/24] drm: add <linux/pm_runtime.h> where missing
Date: Wed, 18 Mar 2026 01:04:40 +0200
Message-ID: <20260317230500.2056077-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0142.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::35) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB12032:EE_
X-MS-Office365-Filtering-Correlation-Id: 191b3b5d-b5cc-447b-241e-08de8479a80c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|19092799006|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 PmG7y2osV6GE95c35LvvAyK/xK3duBv7xivafwis7xavUXB66nFG4P0lHsFCPQR+5eEfpezNWhHQtKdt5MHvpw2YqArAKyxiLa/7Cv89ApzQkAfGtY8VQsv6A2gFS4X+uRuZe/3rBt1hhPlQYNINlVayLivM9RKHEm7s692P7/z0z/ShrZZtR6LYondpAsEwVzSq294gx2ZxhOqdTyYPHUE0k+aQVFSeMX21qQgqtdYj7CARponUawDZNAzdhTPOE2d0VfWLHHUNx26iIdcNvWvyz/NL47SALUxxVD2D7sXrDzd2sQ6AYEz/oM2/O2VPsNf6pllOhhKN+z8vTFhE8Jr6xSYK6S3jEHt6MQtoMHB2HlaDNOaFNO5eYApsMvlGp1DL9DcRTXqnV0ijs1wdRYzPi+Jgy55sg/spMaXHD0zaozoZDwa96n0W2LmQMG/Zx8SvDajzI67PAPMuIyevhx8n9GlRv+7PW2wDOvZXNQUReq4zJ7kofjmhEaJv3b7F4ld5J87GqSQLqiRiMUAeCtifXSKXbuXpA2qoUcMow6qOz66i5o+2Da5NOH2SdMtsu/9t1P5GTxEnNIQBuPLQm3jUTxkv4et5qwGFKYCyThbjgFOJ1PfC7VHc5VLTElxrMTfjkZVsjnIEZ7lAMQ6q1p3uCZpOSxQt4AyJuElmmOvkfuUvzXZXEN2HFZhxg4pNDOlmOjIgeK0enI6GJK4Y+ZNqoR0U/SU14ASCLzQ6Cj8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(19092799006)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?sJizefRqiODtYAEKMIxKOERmVlDMi9yfC9sJPAha6YQchJWxgHW15AByL8oq?=
 =?us-ascii?Q?7cpphubp+3dBe+AcvuV1/N7AMtXETD4hei5OcQH9yuiFk6aVglXvESLYnMUY?=
 =?us-ascii?Q?lFQu68MXQ9lIcvIpaEf7Q6EFQvqLrLg04OwoYUwEEGNGtGoKCI6/DvUNNb0T?=
 =?us-ascii?Q?cEwaslqW/KfQbE5MHURZ2211yt94IWYlvHpVGBeNRQBl7xU3V7K0jTiouDbc?=
 =?us-ascii?Q?zSTBd7ZO+XzbMm/0HJs0fzg2POyV67Gar3TvAuD5wYq16w4bweGlYurBdgs5?=
 =?us-ascii?Q?bWHrw6Gqtc0mfUHOSPaC+NRm32dMS3inN0Zu/tq3eDOaZhUmu7BzOo9Wqp1H?=
 =?us-ascii?Q?P/jxqe/e4kfwGywXHL0vVam7DdNCGpm983yrym53ShxsiTFwJoJEQTFgWqf3?=
 =?us-ascii?Q?WP3r5Iz9hlfsrKCQKwGV4D4R62uIpJUgkN3ZGYjsu6cR0VsYUFiuvaBh+2hS?=
 =?us-ascii?Q?gLqyph/i/Bz5R9rJdoP+k336gSjx7xKH363udLVyC9GacocRn+qXMNfA8YIi?=
 =?us-ascii?Q?iofCez9LxFBmZ/Cj9EaectEpRzOYnh84taD/4I0A6Wojihxo9Z2pYdeKFiNE?=
 =?us-ascii?Q?R1pvesJC0dPXDgSnZNnz/ZkRByI4lZkj0Q3Vb1oPuz8zYPEDNDM1vfJLar0J?=
 =?us-ascii?Q?rMiy/wuGPguzIku6xQs5WWOndSywSn5N3XgHfqbqas3BbAj3TCS/fW0cxfTO?=
 =?us-ascii?Q?XmiIzLM0Eu0O/5/yYKddRWpMp4n6hpDbJ+FAc81IuH+42Wvl+RQN7cSmNNJl?=
 =?us-ascii?Q?1XIFmICsXgWDzRgg99cOVj1ezNsRhqzIK6YVQutWiL1FeRhJzQb7ASUxmEO+?=
 =?us-ascii?Q?bw1XAJ3M6qk+cfRJDJf/T0ZywzYBEAuE628e+A0urK1eM27AFDihQY/hkfJc?=
 =?us-ascii?Q?NyLM8SrBBG7jfkRk55BlqhRaTpLQK16XfDuEpPWH9og+3TNsNbXr7sairJXf?=
 =?us-ascii?Q?mzfDRX/MIOR9bWlL6jP3NThLGKyRIrSY23w0Zh8Fy/8C8DgIulAnpy/C9GcJ?=
 =?us-ascii?Q?WLoW6hYlENZaUjkyoyI2zALBVNWEYD0OG3znCY7aUwtgOTjTK+G1JsuxKkAs?=
 =?us-ascii?Q?qpw78veftO/jOx3bN8jzYUIgMvJ3ifstJLztW4O1wuYPjTGgB8w0jgfzyyCb?=
 =?us-ascii?Q?CvNohH/KLkXLeJCfHFrFmNYUQplbB1+0UjOZ+1xyqN7ldYgSlqh9an3u8VW6?=
 =?us-ascii?Q?ufW9iEOELQ9Xs8Sqkb3JMhDqzzN7ncbKrfDR7JZM7J+ZCHScN804S3+i1LYb?=
 =?us-ascii?Q?RIB81x2DHx9O5AekV2bAyMlBQ8t0hN7nXFsiDFjKR0BCDn/0QzDcDdG1jVFg?=
 =?us-ascii?Q?OZUDsjKqDkJGYoF6imsmYIJ1lWB3T169+8EZCPdCLMkv3apcjFJW7M1IY8uh?=
 =?us-ascii?Q?dC1pbNOOR78PSs75bEACsoIn+7S/yjt5AQ0EA8sz01dhluGtMamK25t7d+rv?=
 =?us-ascii?Q?Tc7y/OXhoJ2e39yiuxuXrkpYZPYUTEpBa4js8BYCWRbDj91KluJz2XkJU8IH?=
 =?us-ascii?Q?006MsdeCl0Q5aYDhVkGoYXY9NNYHRTMYEEfoFwh70f06qK+MmTyw2nmjA7yg?=
 =?us-ascii?Q?LfQh+GWr2S3FsvvXcj133gWfFUxNZfZH0VHKWxxlFLee8V+QNtxOTuChsP/6?=
 =?us-ascii?Q?VWo7Vnyqv/+u9CUEI7Y3ItNb/7K76/jbnlEVyzZjKBU6cVGkUDb+frVBjxUh?=
 =?us-ascii?Q?ZXHHwrsCGHTFpkhjCOp7peli7ps8TC0oyYEjpmaalsAxVtJZyna6TmmczTY4?=
 =?us-ascii?Q?WvsWsJIq8cdsORwnMx6GARhT6oi76Pd8wwqfZAlpv/1CtKSNaLMFSCH7OiX3?=
X-MS-Exchange-AntiSpam-MessageData-1: hcChp4woQ8FpHwur4TkwKIEqgUSGGY0yYq8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191b3b5d-b5cc-447b-241e-08de8479a80c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:18.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dql6sOOFwjgjc/rMf4RVR4BzTThjppflKS7fzFm/I0mGReM/eakV0BRxA36udE4ERit7ZfF9d2Ux7oznbrejVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12032
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,samsung.com,amarulasolutions.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7105-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E58ED2B3C34
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

v1->v4: none
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


