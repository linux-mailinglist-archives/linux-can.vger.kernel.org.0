Return-Path: <linux-can+bounces-7448-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHRNElc682mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7448-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:17:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E26414A1BFB
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 360913038DA7
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCF742EEC4;
	Thu, 30 Apr 2026 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gp16WAgz"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34C42B74B;
	Thu, 30 Apr 2026 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547263; cv=fail; b=BF1RYz1oQv44+UcxnInfW80FfKNIrFl00eaFBkf8nOgTxi0/Psn3pPkD0a3AfXFRAwOcx7EQDii7lTA7ze6BdRJD4gVcYnFafyH783AsTcBy4DiSLmFHs1tKFFujIVRvKMl15IABSvuLdZ/tWqiZzaBBS2b9LoP2kRdjWpZwGrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547263; c=relaxed/simple;
	bh=KlY3DPNdMe6AfWvaAZINX/908e4uIBhefvHPmSaKlDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eSu63/hHRbL4wL4Mn6aNyMMKMoUjOcSj0McXjLgiWKU3fWTKI5TWH+alJ2PdlLLvodM2JvWeg9Fu02yefsavoUVUJWNParf2iEu5B/js+ZjJIm/rdUlPol4jUuBajl+JgKbsQzs6HtwLd8QYPkJK9/APg3lUd2U9IxlvS86FiWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gp16WAgz; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEyR/k6RuPgg+2E/UsfkyV1TCgIKRcGN/cLX7YrUrMX36PqrrWl7f7LIKk0OmQ02RPoDOCaKHdv1UNFrPRUFeZVn9N5q5pxi4stqV+fPxZF5MfwEmboQtCLpj96RPu//tzJNqMSLlBGl7EyMFzR0QAz9ttFwJF6+MCxMbYMxNv5QNu77kxBBzW7pV7uybz3SnSeRSPy6zItMQ8vLXt+tlv0Q6+2+T2wsefnMv1Cjwbp/ur3iTuAvQLZi+x+Yk/tB9NaYHfi9VBE4pCTeB0YslHgNOFJloWT8PwRiyhPNVib+XYxWnp0yhL8TExrdePi+rnIzLtFIRasBHNhlsGY91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFGBZMKWDaEQT+rrLi1jOkRWHu55g/5Colrht8tYcEI=;
 b=UlQZ1JbBmo2bSPPII9aMLb9wp2kPeFt2hXhLvStcZ2P65wOf0XYjaDgIsg3YMqdrwuaGJG3y7dA955Z1GnY8ubcY7TmLNqXCNcyYhfzzKWrl9pXWj8MkhKID2JfkkPy/OpOk547a80L2P8xfcEtNbrwmxpptuW/VuLiP6WIpPvuIxcXK3Fg9rVj8p72vnBVyqE/7/ipm99y9b+MT+17PBQ4ieCD009ks3BSyCQrECy4yI9lgzoUN84+Pfycz8xtn4eJxOvJ+9eUHaKTfFSguXMXljPexSfUOGcNxh0zr1sppcA7JhY2j7ufqLmg3ntbaeFjGq3NucP3nL1jIR3b+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFGBZMKWDaEQT+rrLi1jOkRWHu55g/5Colrht8tYcEI=;
 b=gp16WAgzxQx1c6L8XU17gs34lT1V9Fq3lmpCV1qjM/F39yn3cm77zI/fd4Sy8Gf96tXpC1G0PdYAmEdLUy/OH4F0ehUhOUveRHZOGIHMNaeOfdkRiOojWXv/psWshVdSa2iHa6hw5VuGu3WbrMtY9e4O3kGYzTpQufQnJUS4gDI8Houo6l9zr5HziLJIDmdIkBPKxL1+3vThcRlg8zxReS18ti2rakSJGnTpUEmSZBZaPwLd6QZmYuAiw+Nl8J3VN0OwrGOQIXT2O+K1SFzvg/eAyfWNwyKEZ4dMaho1NcASmyG5sBseIYor9fSDrneCjJJaPg3SWsv5rQNzQtHi5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:30 +0000
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
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v7 phy-next 19/27] drm: bridge: cdns-mhdp8546: use consumer API for getting PHY bus width
Date: Thu, 30 Apr 2026 14:06:44 +0300
Message-Id: <20260430110652.558622-20-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0017.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::22) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e034de-3fd0-44c6-63e7-08dea6a8abd2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 ldkiVwSwWU7OdGHvHf0e+NTdFOCEPuQ4jnOkz+Ib42odJw6cYXWUjpYevSuYN+8IXkxhnY6NqkJqO2D70JrhOY5GRSkLWtqL5sd8lyUjKthYhSl59dzJaxrCO4fWItGhrsnamzL8wNU1u7loZbP8xWt6/cq7ZQcxHos/9t9Os57+5pAuQvSWAiZ+uMBQpS5S7qOQGWmnbNdwSEe2s2z9n4Vlhj9A7AU2qFXtTWwbSrVPw4aVfqIky05SJ5zW/B/gsIqmUThwfi00orHxGq+XfY5VZUWAaUKwwIIp035QSplTv5G817ws1p50i7j3FOPe5vtXxePx2+p8pNLFbU7zdgj8tO8BCNVIRcksbmFcmz63SDm5X3rL6IrqqgOyClhGAzhaqmb6G/S55Kyn6xDVErc9MCUrW44U/OK0OK9hbeaKoY/WuYT78hZ0t66rH64PWj9L716e/WWryp3e2eRvV+KC57jjBOp1CA0EWJatI8AJsyZbTvjVMmjofYl6HlSTq+z7qhkceaXKEr9vZESoIjNhzHQytMWiTkyHMrXHygltbsFhD6MxIlliYc/PaWldutbv6utcKj3pgxDCbuWRHyWY/OGQ2CxcwGa4058be3Os271BBaNE7SNnOPJp69HqjdQbmJ+Km6JRKDL4HzLQJW8snxFGzkvATOGUs14cO9ZKAHV1BRw/GwvQ+eSgeM8RVSK52WjMuQWpWQtYmNuMp6q42Y6SLdpztLo9k/ZG0d4=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?JanNzRLLpVIPDVT9ueDjaEyeVcnVSUxCJd12hufnqTL1D4BHj76MGbhul883?=
 =?us-ascii?Q?wHmzhPvhsntzEKYT3JW0rkl/9MX2Es4Vc3bbJ+xeKiePovDee5UZxfxcIsjA?=
 =?us-ascii?Q?s4jWoKqETevXwkqSrI/3XiWE2q3UDuiiMhdnKKar2JCT5HlEf+WHNaxHn3ne?=
 =?us-ascii?Q?HBg6J8j680g5m+9zLEHNG8oh/+2zYQNMrFe2S/Vaump5rd7pJd1a5GdYb1I3?=
 =?us-ascii?Q?9lDXI4w7fUpIEta4zeuo2YANsiaeoYo6Vqm7KtPZNc0Km+Db+2v75wzbMaNc?=
 =?us-ascii?Q?hd0GuKMZPJJ4kEdgkvXJCczC5hXmFw74Tds2FhGlsVYo39F92OT5CFdzN3/K?=
 =?us-ascii?Q?cR0ITqXan7HTnfVh6AJbixIpLVuDEXdWQmGgfU59eB9Vo6bCMcSF2XA9o6Hc?=
 =?us-ascii?Q?IIEkFQY8lI889Zz8P1JABQQb4IqHeXPcaA+eWjEVHvLCW0COyqBPAxsmFmdl?=
 =?us-ascii?Q?TK42H9pPWxmqyr8sDu7FoCm4D7XegpJvwgDLw6DGTKx64o3TxW07Xeep/fyE?=
 =?us-ascii?Q?BVyfvShz5p4dfxM+XqkaLUdWksztLyVgDw0k13twTy+bjSi0N+H4P1oNB9lT?=
 =?us-ascii?Q?I54G4wRupyVF/jLvaWBgYDcOJnZdEj+fWUOOZaYzFrHTml8Yu+txz+5uVN+3?=
 =?us-ascii?Q?Ck2c7CFCA+MGNimbsXwcHSNYyhGrPLQb8OhqByjVdO8fMQfsy9UVXGa3Sfai?=
 =?us-ascii?Q?Cz/qSrPQHtDYqaCIWeGaLkkAgx6sthWxhkH+h6FiSqT1wqMpvaoMDcIH69Xv?=
 =?us-ascii?Q?nztn0Qq3MGbJR4j690skhErJ9RLgHyvRx82+5Vacy0dFncelBkfTgjcWo7XF?=
 =?us-ascii?Q?l341LKgM5M2kVMQkbmBgajHXrBxCmOrg+SVhOiMZHz2xXNT9bhw3O+yfQP46?=
 =?us-ascii?Q?psw08LY2Xkq2V13VY+RQ+X6QTjAr8vXIfXwYW/vtuqLac/PCSKUBRPAdDOzQ?=
 =?us-ascii?Q?/0f0MlJryZwiSm5mW6qf5r0BJKRSX+/yojlymaUY4MGlKsEfzkhlDbirCGcA?=
 =?us-ascii?Q?9NVthGOYCC/4zS+YD7Mpwm9XOlraNzYQo0M1wD23oe14FjIdYMTHhy1bzEiu?=
 =?us-ascii?Q?tQocqehlcN4kWXzHRjnNftihLbqlXT+TSdfqqS45T1C8dhEdGerkJiv4rx4X?=
 =?us-ascii?Q?DnRTXAmclUzkKOCpQFnqwBaWwnb9bzYwNkGRDhVCiixh4wdrQ6/1G8W1BPpC?=
 =?us-ascii?Q?IJN4xOEWbGRzlk1vea779lWIQ+7wZAvL2ijvqr7l9rxKXMuhrNzwRKghQLt5?=
 =?us-ascii?Q?Txc/vuwri7AYoGOkMl7duklGpW+xzmaT2Nu3mmdXsInHhWjuG8IN9V8vMubY?=
 =?us-ascii?Q?P6uD+tkVTe+4ejBmhXWR3/0kX3Twsbpb4MThQgREp1kOZlYfVhrw5obQJmpW?=
 =?us-ascii?Q?7GvJI8046n7ZaBa94qvShzcUzxu+a83CkU986b5SMHd39P0SZf64KRE3k9sz?=
 =?us-ascii?Q?Ss23G+H1YlmEY9XLOrmSvJ7MLve1lYkh5+ihkLQ3flrSPWK1JO9irfXkXvEL?=
 =?us-ascii?Q?ynp7SEaEg6/EjqqljB3zKG7Im0iKgs5jOlRjmMNglU67KtNfjsMLqpeg4E6j?=
 =?us-ascii?Q?LIdP0IBXkvKFfNjjBGhgNOYwDwTMyokDRrbx6Rs08Vnjsz3ghmGDiP8UpyJp?=
 =?us-ascii?Q?HrqJrX8Jyng1zciuvAZkAnDIrSUuv0eynpocRGiHLYHCMGykQyA2dlVl8gAt?=
 =?us-ascii?Q?ur+PVs0itVj16d93oPCndcSgtV9BTkUER8Yb0JWMO6mzrzpS4aDE/YqaTqAE?=
 =?us-ascii?Q?r3HeACaDdONg4wkJ5H+0hfLprXWA2HH862X9pORyqKuKdNGZg5yr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e034de-3fd0-44c6-63e7-08dea6a8abd2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:30.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNH+SDHrCDiRJNxQYh8DOltMMpOYTKRtFOkdiMHVVdmUL3+/ys8JEk4iJeLvVS7/Li6dWICjNAZPbtX1jvWuLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: E26414A1BFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7448-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

The Cadence MHDP8546 DP bridge driver gets the PHY bus_width attribute
(holding number of lanes) directly, but doing this will no longer be
possible after the definition of struct phy is hidden from consumers.

Use the phy_get_bus_width() API function designed specifically for
consumers.

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

v1->v7: none
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 87847978c1fb..76a684d4be26 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1300,7 +1300,7 @@ static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 
 	/* Get source capabilities based on PHY attributes */
 
-	mhdp->host.lanes_cnt = mhdp->phy->attrs.bus_width;
+	mhdp->host.lanes_cnt = phy_get_bus_width(mhdp->phy);
 	if (!mhdp->host.lanes_cnt)
 		mhdp->host.lanes_cnt = 4;
 
-- 
2.34.1


