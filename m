Return-Path: <linux-can+bounces-7283-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM7NGFvVxmmtPAUAu9opvQ
	(envelope-from <linux-can+bounces-7283-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:07:07 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E12CD349CBC
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3494B30F8309
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24BC3ACA6C;
	Fri, 27 Mar 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VctTM9Ar"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7D3A6B93;
	Fri, 27 Mar 2026 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637359; cv=fail; b=mdLfMAYypsgW+Ay7YwtXhIPjXNeFx6jTc893+CNVFuiDaOtc5U1CnPG5WHeh7SfUdaNgQkHn9nus2+dx4Zi6z+3kCMmQgRVnUl3sRuA3hv/VKkGAd4Rl9O2omMv+REWOiaWwk+x2kZO9NoTL+VfAeHBezAXaSyvCz1Jd+Pu8+dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637359; c=relaxed/simple;
	bh=hMDLRXdF1NigX4KqsQUQ4uKayzoPd9xA2A5p872A84I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aBvJR4xPulv5m0TibsQ+2QWKwD26mVR8QxRwwVbZmuIKWqzhR+QOWHsIIN+Ywm+NcBYOvSbh1HsKUoHkv4fGG+vbJrGWpowjoQnXdG6iI1hP2pvDqvUfhWd3i2NbdpGST1Mve/URu10yBM8zs3fBjSRlZ3H49xUKF6OpK8zarR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VctTM9Ar; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFnyvFx+lFrnqIRV6qk//0oEH4vsyvOATlhm92XaU3ANxRmrDXXATBkCM6/hfuJdpQAyiX4Tj1SFg7KcljxC9sda++MiI+gMwCQe1jxMvIVMK3XO/t7q34s2B98nWkyLdPdyGQM7qaHfZxhC6mLCgYjZ1hqTUE7y7OMoTXgtGFPvxfXS4uoSd0y1b1ZOVOQQs2Sfmu0RKbRpNAu/gIka4TbaMSNjwnpJF7d/dWVx20VSNv/OpWiw//gFhtbsMHiau/I+3l/+QtM0nF/JvD2ogEFcOf7TIQHpLZ3xZzaWggc6uNg3eZ1NOOGAjuNxGupGnY607uTtBRyfuRLhVaIgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puL+Fop37MU0VjAvQTbetvUe0xe0cRUTa/Skh3MyxsY=;
 b=ypgWtCuY7FM3Am01jKrqIT9ECWfz5BmQf6z2fsozmBJQkkuHIEOjRPKeWpxbl92c8n5VgKcKNYEmi6oj8EoZDpmhgalIcwu74kjW9oXkJ+RHrdmHLffWXVZ9GJd0o9zVRCQM36furPiZhEct6nlS0rnAv6phi3BAXehf4aDAeyoNZ6NBjuK5coVHkplsEWrr/95ZGel6KaXxZwOew6xo6FalveVOg1b3vsluyTyLu1OHgjcggmysrZWBGgvaEgOAhDEgXlsyswdjIQdU6Rrn+TX6y1EuHYCArXAIg+zbPFJsJ+dEXK5cX1oc16ZoC8lAcLWlCiNNV2QBE/wAnokpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puL+Fop37MU0VjAvQTbetvUe0xe0cRUTa/Skh3MyxsY=;
 b=VctTM9Ar/aUsMO2Lv0GpqyC+lBhpQIE9xkyCFX83L/leNZROJ8fzzAk3/ISPl2yYITSAbZ3s/zZ27PeMZSCsmDIdLIxBIWxIHe3m4D+e6dVZnxWuHu6y5KPfjNkCUbNKfAeiY7WUR7PHom1TEkBO5oeuz8KP5kLliKI+bbmJfUjDsPE6dejik7njyG6OKGTGkn9fAeS8JJHtkTe3Scmgrj8nWXxeBIRqCot2ypVIFLVbal6xfJMGZIQQLLG/bLkRkdt2Gexfersa2gaHu8gTQTt4hliK5/pDWV9ITZ5TKEeNu/y8qmXb89vvKrxhK/D+zXd4FDUeZOi8acHkyoCXRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:49:12 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:49:12 +0000
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
	Markus Schneider-Pargmann <msp@baylibre.com>,
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
	Andy Yan <andy.yan@rock-chips.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v6 phy-next 18/28] phy: introduce phy_get_max_link_rate() helper for consumers
Date: Fri, 27 Mar 2026 20:46:56 +0200
Message-ID: <20260327184706.1600329-19-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0286.eurprd07.prod.outlook.com
 (2603:10a6:800:130::14) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6f0e54-0445-402a-7457-08de8c318966
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 RO+IMo6yWlwWMmICiq70CjKljgGqjGpQiqPfcY5cXZ1VvD1t6vpjIHtQpa2zNhimynz4zwoRm07mL7Y4UPL2kex3t/TRBnJlVcEksN/ADG48pha4tKaNXiTrDvT66MUHC8Xga2OQvR8xtkYCxYWAvcrLmbQHe9hnA2VNJFgdTG6E7mb2rlSYEuk+ffl7mZkDF5BcV2em3fWB+W0KiQS7w7z+gibrSru38VhAvfQNQeOO4f1tvJHLkVAZ5Wz57ig27GTWfGVwmew72wtyPII3irhO0zFI82CGgzF2mkesFyexzE6ApoTiKRcm/6sfEoCxiXp9QLlgpP59dm+Wb8FPjZ3vP0sqan6T/w7SdG5EXPnhGq+8PYIxo+yr91JgEOQiFeKjf01gIedqrB8FLSSPQWCYi5V5Fy/2Zpp+tRN6zUnSr0+vFl7oiuHeR8Uxl9osgORFkkRgnyXwzXVbW0/oCbRBvWbj5p+Vdss+WvzLKSK7EF8GkTByp45ugViMefBP3h3jWeyYPyHRm8JuiWCyyTDLwlobvGTG9R4ZkJu65gjoTaEE7DO3pEe3glKKj917ksOSO+ob8ZVDKOpW2WR5ZXd4e3UXathrzVZwQ4SfxG3vzHUg8EufEfP7bS7kr43AozUjVCmiOwnReKoPxg0JSM62jhsOBRAV3fnln+jsSaGMhF9sfAIkaEqvzFtwJt/KP11fJJw30GtFYXBjgxSntMmZPVglYTkTTCoZL1WjAQg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?CW9lIrpc00Eh9U6Ay0KUaT53Q04MMclqI+z563JMf3yoi41CbS5G240j0VO/?=
 =?us-ascii?Q?A21pchnKEL56odeLL3nnbY5G+AB7R+BHIz87BO0FrwNuNZb9FYUWmQWnGU3q?=
 =?us-ascii?Q?mqwF4AJC9OKB8HSykzl84JjvQ8bl5qgijfecXzv2XCwpq5jK080C7fHnalER?=
 =?us-ascii?Q?t1WEWyBpAXvh+mjzbcFpH5+IsmKEkChJkD1kM6VNVDZ7Qhts70MveIVgzRbM?=
 =?us-ascii?Q?fztzQy6NxC6fqQpDznEBTGZ1P3seoTWwNgPdtjOmxl8miXIc3UtczktkMQuH?=
 =?us-ascii?Q?1IcAIFrQT0Ep85z0+mgk3Gw1Y2gG67mMzQBh94fmGqiPDMq+rmvQphydjRHF?=
 =?us-ascii?Q?7MAajeRtqdz/fIjtxztpUse+y5JHZbCIn6fes3nOawfD1ZkHDvwxmoqgN19K?=
 =?us-ascii?Q?GtwK/sexjevRicLo51eb4DZs6mYygrLzhCtQIQ1YWGf/Jd5HFTvVvlT7nX0D?=
 =?us-ascii?Q?N4538B0V7sJQZIH7ln+HNYdpycYYQwdlGJxvGC/6YNX9LstJh1RqMX+YF1ED?=
 =?us-ascii?Q?4cxe5j+DsHATd2+VJ+U7XxbgR1QfZ37vcMegi2QRPMWDg93TWniqimK3Zjcn?=
 =?us-ascii?Q?s5hiACLaYe+OB/ohr3F9ApndW57+5VtQgSKnHZAPGMO8fFpFdtJ/htpyJbIV?=
 =?us-ascii?Q?TK0PpPl5nAYAP9qmNjcbaeUxYH6dGGoN6yEFXL9JOxBFPQOY5mnOeYfC3qpK?=
 =?us-ascii?Q?xnkDCbYP1ZUm9WAUU4d7bGVpq9Jb31tRjByaJJbCLJqjpP8YuHmYJhJnlgfw?=
 =?us-ascii?Q?+FvTUowWFgtdROcvqjA7KbEb15KfuYgFq6a7NAtm5QisiUcp3ZTsZG2KARL5?=
 =?us-ascii?Q?vOFC1J9Rj6KdPXdeyDeamvflo7RoiKrzo8m5LvmF4zf7tlp1+wU4er5OLirl?=
 =?us-ascii?Q?+fuOyo1i/BOWEQELVhxJsqcpYyNddqGKbJHTXjLQBLlmtnS+Wec5uUfw5wK8?=
 =?us-ascii?Q?3ubhHBgVYcESBTdJE+PdrtaCBKldIZ6rPMFPxA/OJEihDGAoIwy7k3G1Zwye?=
 =?us-ascii?Q?UjHtoy4PqtydktDbVtLfF2o6jmLbLNIgyUhtO+t3FkQQfF1nNwhC2iciGa+I?=
 =?us-ascii?Q?xGNmzpfEreK6sH1EF4Zgk4FDrAcXUBVF1NOpb///tN7FZPMOW3BxZCQuwxjo?=
 =?us-ascii?Q?itXPdozpWhJpb5jEz2WVBNfGcErCw76ZPIDF9BEd95IUEOCMj1bJ1stcqRtL?=
 =?us-ascii?Q?K/aYvvi8rYe7Cl5CLMUGPRm7UTt9ekb8/x0UcZHhZzXJWy3IRU74CaXHa1cC?=
 =?us-ascii?Q?cSZJ9mG8tOr+wzeG8AutJQ+yWkn8jNHx/UXlj9FUSKi5OUEBnkRLT7rj9Xp0?=
 =?us-ascii?Q?6pxZFb3haSz/FTSfJFr2EEXQipyAuEK28FsqF5aEuY0/w2a7OkXhC51OxGxM?=
 =?us-ascii?Q?aSMYqw6VFxpCoYy3/X6Lq2hS7931+MLVWg5A10aDXftN8ClNR89ihJk1lKh/?=
 =?us-ascii?Q?qGpVd3SewEo4/6lWbAMUi/lDwvN3re3jwhUNPSfBSpB17MEflEEVzdqadAob?=
 =?us-ascii?Q?DK27vQnK1sTthf6lt63aC5JvJRtaKYpOXtwqfdD5J9KqNQImrQGY5BoAhc0P?=
 =?us-ascii?Q?h6MsvQRYOpL2xB2DymDRKJW+zhziMh5gVzDrt6K24NMzUHW+AePbR06HAzz4?=
 =?us-ascii?Q?A2vDs8FYXWvn921TyPQRv1J0b9lUidpr1VKMirTLJtGT64knjqmLv+zhoG5l?=
 =?us-ascii?Q?QGJwEJOmgf11w/9AZY87/kdgDK6hsUoS3gD0vFI5BnfbB8G1vn7wA48kCX2C?=
 =?us-ascii?Q?VnZ2qVJA8rLWpsGtZfGbOG/pQPHA6b4cyLeOt/Molh+GvP6FHUnHJeXg2i9G?=
X-MS-Exchange-AntiSpam-MessageData-1: k45uxCojwIYPittlq48uUaPcF6qFXnCmSz4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6f0e54-0445-402a-7457-08de8c318966
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:49:12.2153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQP9/NfU79yOuEeUXQKw241nAlB8H124DWdWl+cugMtZsiEhUxmIZq39DaSSVQZSATuwbNqOuNYZYUORqw3lUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,baylibre.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,rock-chips.com,pengutronix.de,bootlin.com,tuxon.dev,glider.be];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7283-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E12CD349CBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Consumer drivers shouldn't dereference struct phy, not even to get to
its attributes.

We have phy_get_bus_width() as a precedent for getting the bus_width
attribute, so let's add phy_get_max_link_rate() and use it in DRM and
CAN drivers.

In CAN drivers, the transceiver is acquired through devm_phy_optional_get()
and NULL is given by the API as a non-error case, so the PHY API should
also tolerate NULL coming back to it. This means we can further simplify
the call sites that test for the NULL quality of the transceiver.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Markus Schneider-Pargmann <msp@baylibre.com> # m_can
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
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>

v3->v6: none
v2->v3: collect tag
v1->v2: make phy_get_bus_width() NULL-tolerant to simplify CAN callers
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 4 ++--
 drivers/gpu/drm/bridge/synopsys/dw-dp.c             | 2 +-
 drivers/net/can/at91_can.c                          | 3 +--
 drivers/net/can/flexcan/flexcan-core.c              | 3 +--
 drivers/net/can/m_can/m_can_platform.c              | 3 +--
 drivers/net/can/rcar/rcar_canfd.c                   | 3 +--
 drivers/phy/phy-core.c                              | 9 +++++++++
 include/linux/phy/phy.h                             | 6 ++++++
 8 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index a8b6ae58cb0a..ed7ed82ddb64 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1300,7 +1300,7 @@ static u32 cdns_mhdp_get_training_interval_us(struct cdns_mhdp_device *mhdp,
 
 static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 {
-	unsigned int link_rate;
+	u32 link_rate;
 
 	/* Get source capabilities based on PHY attributes */
 
@@ -1308,7 +1308,7 @@ static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 	if (!mhdp->host.lanes_cnt)
 		mhdp->host.lanes_cnt = 4;
 
-	link_rate = mhdp->phy->attrs.max_link_rate;
+	link_rate = phy_get_max_link_rate(mhdp->phy);
 	if (!link_rate)
 		link_rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_8_1);
 	else
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 4ab6922dd79c..79c72ee8e263 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -536,7 +536,7 @@ static int dw_dp_link_parse(struct dw_dp *dp, struct drm_connector *connector)
 
 	link->revision = link->dpcd[DP_DPCD_REV];
 	link->rate = min_t(u32, min(dp->plat_data.max_link_rate,
-				    dp->phy->attrs.max_link_rate * 100),
+				    phy_get_max_link_rate(dp->phy) * 100),
 			   drm_dp_max_link_rate(link->dpcd));
 	link->lanes = min_t(u8, phy_get_bus_width(dp->phy),
 			    drm_dp_max_lane_count(link->dpcd));
diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 58da323f14d7..7749da0a58f6 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1125,8 +1125,7 @@ static int at91_can_probe(struct platform_device *pdev)
 
 	can_rx_offload_add_timestamp(dev, &priv->offload);
 
-	if (transceiver)
-		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
+	priv->can.bitrate_max = phy_get_max_link_rate(transceiver);
 
 	if (at91_is_sam9263(priv))
 		dev->sysfs_groups[0] = &at91_sysfs_attr_group;
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..093e48b8da58 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2210,8 +2210,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->reg_xceiver = reg_xceiver;
 	priv->transceiver = transceiver;
 
-	if (transceiver)
-		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
+	priv->can.bitrate_max = phy_get_max_link_rate(transceiver);
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 56da411878af..2a0f163a683a 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -131,8 +131,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 		goto probe_fail;
 	}
 
-	if (transceiver)
-		mcan_class->can.bitrate_max = transceiver->attrs.max_link_rate;
+	mcan_class->can.bitrate_max = phy_get_max_link_rate(transceiver);
 
 	priv->base = addr;
 	priv->mram_base = mram_addr;
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index eaf8cac78038..9062db48d477 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1884,8 +1884,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	priv->transceiver = transceiver;
 	priv->channel = ch;
 	priv->gpriv = gpriv;
-	if (transceiver)
-		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
+	priv->can.bitrate_max = phy_get_max_link_rate(transceiver);
 	priv->can.clock.freq = fcan_freq;
 	dev_info(dev, "can_clk rate is %u\n", priv->can.clock.freq);
 
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 0d0be494cfd7..737a760d97d1 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -647,6 +647,15 @@ void phy_set_bus_width(struct phy *phy, int bus_width)
 }
 EXPORT_SYMBOL_GPL(phy_set_bus_width);
 
+u32 phy_get_max_link_rate(struct phy *phy)
+{
+	if (!phy)
+		return 0;
+
+	return phy->attrs.max_link_rate;
+}
+EXPORT_SYMBOL_GPL(phy_get_max_link_rate);
+
 /**
  * _of_phy_get() - lookup and obtain a reference to a phy by phandle
  * @np: device_node for which to get the phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index a7e2432ca1ae..34b656084caf 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -57,6 +57,7 @@ int phy_notify_disconnect(struct phy *phy, int port);
 int phy_notify_state(struct phy *phy, union phy_notify state);
 int phy_get_bus_width(struct phy *phy);
 void phy_set_bus_width(struct phy *phy, int bus_width);
+u32 phy_get_max_link_rate(struct phy *phy);
 #else
 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
@@ -256,6 +257,11 @@ static inline int phy_get_bus_width(struct phy *phy)
 static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
 }
+
+static inline u32 phy_get_max_link_rate(struct phy *phy)
+{
+	return 0;
+}
 #endif /* IS_ENABLED(CONFIG_GENERIC_PHY) */
 
 #endif /* __PHY_CONSUMER_H */
-- 
2.43.0


