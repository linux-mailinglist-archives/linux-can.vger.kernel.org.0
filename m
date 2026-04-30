Return-Path: <linux-can+bounces-7453-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O8yMhU882mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7453-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:25:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9074A2073
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1BFE30E1C47
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D5244CAE2;
	Thu, 30 Apr 2026 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LfDHtlSF"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730943C06C;
	Thu, 30 Apr 2026 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547271; cv=fail; b=DYI41uRuGawVo0lFIpKOBFA+zD0QdT529OofAz62mcNYF8pmSNG2aLtW1sUE8qN6bYM1nQIwA5b0GLolurnFSFGZQsQaOssRn/fZ3oCRg19TWU5q4UHZ9lj/Rkkty/edQKncbwlpIPvqElNnkWhkDd3GtF0aHulhywsZ1D8Bp6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547271; c=relaxed/simple;
	bh=2Ob6yNuseDNuezHoK2pEvawniPC2dSqM6rTBP7VlLkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cukdpiMHvy01ZBWTX1o97ig09bIwONBQ2HWb0FoVaj+bSUM4jsobcPUbXdhxcjhXkWjBiUZN6/Z4Ef3Lmso91EhIXURRwjlZXLKTqs3+n/eXeCbB3k5hxA58bKYH1sIE6VKii0GLut5XpCRjhJAE3YWO116xZ7p95QGWm/u77cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LfDHtlSF; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL7sgri5sej050Zt/jhRijtqhFYoeR4aA6z+C2EG6wW8pVo4mJAsISdSMq1tvkhvv2WjnKWpDUor9Pn2v0UtjOAKu8SFOl0dk4DbrIqDPH5NJAjOlDPL6voqcPIJe1bzzljdN/z1MbzH0zsuv9vLH4VgkmwFi73TSb51UXOeg8F1AH61QAgL07Hb1dG50CBerpXWsfIg5QbUqPwFhqe7v17d8RfChW94YMUvW5eJd6zEZe0hQymzdAeJ4N8nfkrKTmQhtklyTtbhOEKirsM7O0ZPPXfhqZO/s1gdHeOfL8EhozKoftAU0hN6ThOqgu0D5qmD1kISZaLe/PMeWvmbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrDAXQcL78HCnkbPyDnb7v2L03MfOAQh2ZffjilAc0U=;
 b=MuCijDL2daI6iWNitI/sVjnzejPWZx/GynjMx9daCdvkb2UNq6hNDDkeMBKyJXi275Wt6bjwh948IRL4RgPxmmBhxSG3PhaySIzkelsf0t8sIZydBF90IaJ514glXn68jNU4o0H1mnf8jWmqhE6gNzvABSknDkW1oNBeNuX+WhVEiE00/NzMNJ0V9iGUaTJpNPF3y86hXuYI4nV+gY7jD+5p7dQdvRadskMlshw03aQiy9h2/rLOw5abMu9uPS16sh2zWTNZQ+itTuqnKKT0enmEuqsRvVD1dfrDeTQCJIzT/D+Zl4x3NOpaMvtgeVIYkpIw55NnDXV4+PQyzTdNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrDAXQcL78HCnkbPyDnb7v2L03MfOAQh2ZffjilAc0U=;
 b=LfDHtlSFg5+ada+CLCOzEfWxEJd5vtWAaBuxGsCUuChUbtQ9jLS6y149afXbQCLV1pqb2hQO+1vDAznbMb/afj03qg1elzXitXsztf4/KffPIQUnSLg/VRvAM5zC1m/I7bxp+jITtvzMSOou2JFRCMvBCbrd1TaBEX+1VUXI6JRyag9r+kch5U0mgnciJpbhNJDaWgbP/70Gcie7ra4BLi1HmNR8cVdOCRxZ9c6xYDnUZDooh63r2y/2iZQ9fQOVm7B+p+g/bO9zpJw0Vn7aC7B1s4qVSlnpbI7JirsQ7DElK9PAdZuL3OSGIVKOZgnNr0+OVY5Vs2mtMC6+hyBiIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB10583.eurprd04.prod.outlook.com (2603:10a6:150:203::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:07:39 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:39 +0000
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
	Chen-Yu Tsai <wens@kernel.org>
Subject: [PATCH v7 phy-next 24/27] phy: include PHY provider header (1/2)
Date: Thu, 30 Apr 2026 14:06:49 +0300
Message-Id: <20260430110652.558622-25-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB10583:EE_
X-MS-Office365-Filtering-Correlation-Id: b4575058-a205-490e-26ee-08dea6a8b10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QZRkG9ttxHZwZPy0nxwFSURjhjC8LCaIaA8kInOHM9stmFqdJGA/KHkwaX4oX0YSNwLD+632E4/VBhajMWBVBq+s0Wd6zCAomhECNcOZyVXmiK+Gzv53fW/Iac2MH6BinBh7rES6nwrtoWMn0f+Uinn/iVvPAj+5NmHNyevVb1W6KEes/mnbwQm7d7Y2G5tfUj5SmLnilk0r3zWL4AUTyz91NaGbge10TNWAMnqi24diDj+2Ym3HtLnGnvoUckwQfflz65iXTrJUjDJcELgBZCxgDBNa92TPX0cccQx4nV7YMJ3ZHY77e6nTWaghsrY3XcEyWtBptM5YSqBHtlYU4maZzDDe8eLke0013VClXeyFvvLAnXMjer+YhhtPgWV6OfBs4C9w6YtTqvkWhdi2HJ10P9hwXh5uP28z49ITjpNLB2MboKAAiH25PsMatU27fF/iS/ZYSgv0i4FXtkMN7ebc8YWeVbzz4ZfjBM/1s479OswWMmae7ZtfRJ2esfDDFKGWykpzM4zkfvMAsBJZVbqAvX1PQHfZbDvxq9fD5chX6zdJYyj6xGlXMRwkKl46z8aLKbqC6hT/nhLoyzaGupxvlFFQC6Yu5O0NrNTeOuiAyEJZ6xfm31xTweTe0QLV4pGzrm5uyZuL08N11Evg9wDf/dVn1t47jJNGqpQ8lh5cVAKQb73usMXe0iAoE1eb4yKEosPvgQmXOJj4UDHr04+ZrbUkjRdWhPDgW3FaDDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aXrXrxmWSh7Jn2nYaV69uBsTaEu0wtOhrOAQnkP03jkOqfRaETwYgMpq6KbX?=
 =?us-ascii?Q?nA3SO7HH4zwR4gszSa3ZNyEQD2HgpMuJl5bw30dCdIHmUa/G9CDJuqRmQASh?=
 =?us-ascii?Q?z/pguFmXVhK/0T09aiKMv8Ze25xJjNFjkDyFBSNGNXw6HDM/uZbh47h3HfOe?=
 =?us-ascii?Q?JQO+CMzFeBAu+CYvjstx8wILspjHKsH8FPe2WoreSq7KxIzcAPPgQU2VJHZA?=
 =?us-ascii?Q?r2Cqy+3hK2XciKgQ+Yvg2kw0QzhRqnHNKkXkfoP4Pys4NkUmBvzLKR1OmsBS?=
 =?us-ascii?Q?wmHb6/nS2gMCY5yRpkgq3OThrlieWy6eexmmhg0jBsChMGNysEgAbsqCVtm3?=
 =?us-ascii?Q?VHNyEsMIpzZ/Lv0tpy6QNl2jQ2To2qD07l3E6YgfSbZSCHdEAF5GqhkHKMQd?=
 =?us-ascii?Q?Qj39Se75/iulHXHRGWK7TMaSVv3PMH0CfYjB7uQLydyHhxIGUWhJYBgvnLWR?=
 =?us-ascii?Q?2FtyJddH61BAtXbQG21vtv6irm1rwNLO+z4nyCvvyEyQygJDDtG4tBASPJKt?=
 =?us-ascii?Q?Hr/lI3cA78Rez1fDhyrbf/+EGdv6E1Z4ibgmPJcJ8njRo/L8D1xJsjROYXj4?=
 =?us-ascii?Q?NjNzF3zBSxtnLRVy5JHTTXt7JOXMAgjfX8dl01I47DPUt8QCYrnFr5MFQUhs?=
 =?us-ascii?Q?q0+cF5CbISofgMriUF74dhXwimYGJAETRYvpUMWMPSqdAI8Wkr2t5O7SL8f8?=
 =?us-ascii?Q?QLqQ3I45kyrbFtE4OOMyukBCU+eanXNIMsozEbUrYikmrS9xSxkGVxMhqoe+?=
 =?us-ascii?Q?pp18uoNe1tKJ6w4Fstm/YKeB0bk+tPbEw5lD2RarLaZyzzltiCUiM/FmULKz?=
 =?us-ascii?Q?Q7T7NCe89bF2oxlvMXPzwXxBVyTGbE5GloV0anFM5y61HgjxCY0dEzDHQ/LS?=
 =?us-ascii?Q?s1sX9ldSCuApVn6FI8kHgeL9QZT3N9xgU1U3X5FhpTQXlVhdd0/DHp40eDiS?=
 =?us-ascii?Q?kz7/BPZUumBBwugiwZc+OcUFSyogspsc8N657C4OU8Jn4BUL9ohx0K8thuUX?=
 =?us-ascii?Q?nqHGqqprEDBb2+3b6ln5CDVBRa517/QnSZJayf2wTZY1BbTFwQ69SquMp+/E?=
 =?us-ascii?Q?nrCwmB4WvblarhGjUa29GAte+4kzqvbGExtr3wo7FtmVnhhYYfYJmrTd9k1A?=
 =?us-ascii?Q?jEwfXi0aG0H8vTUFUW3Woks9yJL33+Mb5NOIoGKQJ3mzWAEMEnHNXie7sga5?=
 =?us-ascii?Q?k6l7/THm7HTBzNAELUsQ4B1xHjFKfen6tvpZA9IIh+iirtIF+bg6ENXTQwA8?=
 =?us-ascii?Q?f1pf3Wb2Fdj2mzwLgGajYSBEtH0S+YTMS2CIyqz8ZNdSi2etntJa0P7/m8us?=
 =?us-ascii?Q?uNy/MdaJrrOgNujk4hqqVyHb8u+rOgYEYUCXudDD8k67bjMie4abQEmq2uK9?=
 =?us-ascii?Q?jpybmCX5bcZ68mpxtUmeZwQWTRNKCaQCL2Mb9AUJuDMqiAuMkN8TUKKkEI4Q?=
 =?us-ascii?Q?ODaDvLRKB+NO/4EQfolKiL8Out13uYrIZjXvhXAnR67yjbG+AAxpGRSF7e+i?=
 =?us-ascii?Q?P3nXSKIAvR0w41JsgG+WqAcXTzile5dog8YSqbDZSZoG1xWXxt8laViZ/OMb?=
 =?us-ascii?Q?hchzPjMLO7xFDYLXcRgcFuqpnagCEOLMGZZduSbj0DcVCzdgUP126h4ss/47?=
 =?us-ascii?Q?3IYGJkZUbqYtbk1jUYtUTzGbiGBPLIqV50IhaZxkJL2fUFivl2ojWzw/gQQd?=
 =?us-ascii?Q?OlzIkzxwzdqDu/hmai6WSDhnkY+7xo7jDJK7oCI3Q17R9uRxJx0hR2buaspx?=
 =?us-ascii?Q?eMRLnbnXaZGi8uo/wycV2piqsm5Sr1ZUZOGPOrhCOKTWl9TBR/hq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4575058-a205-490e-26ee-08dea6a8b10f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:39.1563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATbZtz72Eftjw4xbjmRkkM1ha2yac5j06Bm9J+pk7ZCKfK9NOORJmc7uKA9p7HkdkYgBdpmJ3O6wlniqTX6DXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10583
X-Rspamd-Queue-Id: 6B9074A2073
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
	TAGGED_FROM(0.00)[bounces-7453-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The majority of PHY drivers are PHY providers (obviously).

Some are providers *and* consumers (phy-meson-axg-mipi-dphy,
phy-meson-axg-pcie). These are the Amlogic AXG SoCs, which split the
physical layer into two chained PHYs: the digital layer and the analog
layer. The DSI or PCIe controller interacts only with the digital PHY,
presumably for simplicity.

The rest of PHY drivers which include <linux/phy/phy.h> do so because
they call phy_set_bus_width(), a consumer function.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Chen-Yu Tsai <wens@kernel.org> # allwinner
---
v6->v7: removed conflict resolution details, conflicting patches are now
        in linux-phy/next
v3->v6: none
v2->v3: add conflict resolution details
v1->v2: split in two parts to pass through linux-phy mailing list
moderation
---
 drivers/phy/allwinner/phy-sun4i-usb.c                 | 3 ++-
 drivers/phy/allwinner/phy-sun50i-usb3.c               | 3 ++-
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c           | 4 ++--
 drivers/phy/allwinner/phy-sun9i-usb.c                 | 3 ++-
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c         | 2 ++
 drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c  | 3 ++-
 drivers/phy/amlogic/phy-meson-axg-pcie.c              | 2 ++
 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c | 3 ++-
 drivers/phy/amlogic/phy-meson-g12a-usb2.c             | 2 ++
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c        | 3 ++-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c              | 3 ++-
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c              | 3 ++-
 drivers/phy/amlogic/phy-meson8b-usb2.c                | 3 ++-
 drivers/phy/apple/atc.c                               | 3 ++-
 drivers/phy/broadcom/phy-bcm-cygnus-pcie.c            | 3 ++-
 drivers/phy/broadcom/phy-bcm-kona-usb2.c              | 4 +++-
 drivers/phy/broadcom/phy-bcm-ns-usb2.c                | 3 ++-
 drivers/phy/broadcom/phy-bcm-ns-usb3.c                | 3 ++-
 drivers/phy/broadcom/phy-bcm-ns2-pcie.c               | 3 ++-
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c             | 3 ++-
 drivers/phy/broadcom/phy-bcm-sr-pcie.c                | 3 ++-
 drivers/phy/broadcom/phy-bcm-sr-usb.c                 | 3 ++-
 drivers/phy/broadcom/phy-bcm63xx-usbh.c               | 3 ++-
 drivers/phy/broadcom/phy-brcm-sata.c                  | 3 ++-
 drivers/phy/broadcom/phy-brcm-usb.c                   | 2 +-
 drivers/phy/cadence/cdns-dphy-rx.c                    | 3 ++-
 drivers/phy/cadence/cdns-dphy.c                       | 4 ++--
 drivers/phy/cadence/phy-cadence-salvo.c               | 3 ++-
 drivers/phy/cadence/phy-cadence-sierra.c              | 3 ++-
 drivers/phy/cadence/phy-cadence-torrent.c             | 3 ++-
 drivers/phy/canaan/phy-k230-usb.c                     | 3 ++-
 drivers/phy/eswin/phy-eic7700-sata.c                  | 3 ++-
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c        | 3 ++-
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c            | 4 ++--
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c            | 3 ++-
 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c           | 6 +++---
 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c       | 3 ++-
 drivers/phy/freescale/phy-fsl-lynx-28g.c              | 3 ++-
 drivers/phy/hisilicon/phy-hi3660-usb3.c               | 3 ++-
 drivers/phy/hisilicon/phy-hi3670-pcie.c               | 3 ++-
 drivers/phy/hisilicon/phy-hi3670-usb3.c               | 3 ++-
 drivers/phy/hisilicon/phy-hi6220-usb.c                | 3 ++-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c            | 4 +++-
 drivers/phy/hisilicon/phy-histb-combphy.c             | 3 ++-
 drivers/phy/hisilicon/phy-hix5hd2-sata.c              | 3 ++-
 drivers/phy/ingenic/phy-ingenic-usb.c                 | 3 ++-
 drivers/phy/intel/phy-intel-keembay-emmc.c            | 3 ++-
 drivers/phy/intel/phy-intel-keembay-usb.c             | 3 ++-
 drivers/phy/intel/phy-intel-lgm-combo.c               | 4 ++--
 drivers/phy/intel/phy-intel-lgm-emmc.c                | 3 ++-
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c              | 3 ++-
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c           | 4 ++--
 drivers/phy/marvell/phy-armada375-usb2.c              | 3 ++-
 drivers/phy/marvell/phy-armada38x-comphy.c            | 3 ++-
 drivers/phy/marvell/phy-berlin-sata.c                 | 3 ++-
 drivers/phy/marvell/phy-berlin-usb.c                  | 3 ++-
 drivers/phy/marvell/phy-mmp3-hsic.c                   | 3 ++-
 drivers/phy/marvell/phy-mmp3-usb.c                    | 3 ++-
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c          | 3 ++-
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c            | 3 ++-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c          | 3 ++-
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c            | 3 ++-
 drivers/phy/marvell/phy-mvebu-sata.c                  | 3 ++-
 drivers/phy/marvell/phy-pxa-28nm-hsic.c               | 3 ++-
 drivers/phy/marvell/phy-pxa-28nm-usb2.c               | 3 ++-
 drivers/phy/marvell/phy-pxa-usb.c                     | 3 ++-
 drivers/phy/mediatek/phy-mtk-dp.c                     | 3 ++-
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c            | 1 -
 drivers/phy/mediatek/phy-mtk-hdmi.h                   | 3 ++-
 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c           | 2 +-
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h               | 3 ++-
 drivers/phy/mediatek/phy-mtk-pcie.c                   | 2 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                   | 2 +-
 drivers/phy/mediatek/phy-mtk-ufs.c                    | 2 +-
 drivers/phy/mediatek/phy-mtk-xfi-tphy.c               | 2 +-
 drivers/phy/mediatek/phy-mtk-xsphy.c                  | 2 +-
 drivers/phy/microchip/lan966x_serdes.c                | 4 ++--
 drivers/phy/microchip/sparx5_serdes.c                 | 2 +-
 drivers/phy/motorola/phy-cpcap-usb.c                  | 3 ++-
 drivers/phy/motorola/phy-mapphone-mdm6600.c           | 4 +++-
 drivers/phy/mscc/phy-ocelot-serdes.c                  | 3 ++-
 drivers/phy/nuvoton/phy-ma35d1-usb2.c                 | 3 ++-
 drivers/phy/phy-airoha-pcie.c                         | 2 +-
 drivers/phy/phy-can-transceiver.c                     | 3 ++-
 drivers/phy/phy-core-mipi-dphy.c                      | 4 ++--
 drivers/phy/phy-core.c                                | 2 ++
 drivers/phy/phy-google-usb.c                          | 3 ++-
 drivers/phy/phy-lpc18xx-usb-otg.c                     | 3 ++-
 drivers/phy/phy-nxp-ptn3222.c                         | 3 ++-
 drivers/phy/phy-pistachio-usb.c                       | 4 ++--
 drivers/phy/phy-snps-eusb2.c                          | 2 ++
 drivers/phy/phy-xgene.c                               | 3 ++-
 92 files changed, 177 insertions(+), 97 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index e2fbf8ccf99e..9a03b5944b98 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -23,7 +23,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/phy/phy-sun4i-usb.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -33,6 +32,8 @@
 #include <linux/usb/of.h>
 #include <linux/workqueue.h>
 
+#include "../phy-provider.h"
+
 #define REG_ISCR			0x00
 #define REG_PHYCTL_A10			0x04
 #define REG_PHYBIST			0x08
diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
index 363f9a0df503..d38b26e4bf95 100644
--- a/drivers/phy/allwinner/phy-sun50i-usb3.c
+++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
@@ -18,10 +18,11 @@
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
+#include "../phy-provider.h"
+
 /* Interface Status and Control Registers */
 #define SUNXI_ISCR			0x00
 #define SUNXI_PIPE_CLOCK_CONTROL	0x14
diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index 36eab95271b2..e96162d078eb 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -10,12 +10,12 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/phy/phy-mipi-dphy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
-#include <linux/phy/phy.h>
-#include <linux/phy/phy-mipi-dphy.h>
+#include "../phy-provider.h"
 
 #define SUN6I_DPHY_GCTL_REG		0x00
 #define SUN6I_DPHY_GCTL_LANE_NUM(n)		((((n) - 1) & 3) << 4)
diff --git a/drivers/phy/allwinner/phy-sun9i-usb.c b/drivers/phy/allwinner/phy-sun9i-usb.c
index 2f9e60c188b8..f667f3f4b307 100644
--- a/drivers/phy/allwinner/phy-sun9i-usb.c
+++ b/drivers/phy/allwinner/phy-sun9i-usb.c
@@ -15,11 +15,12 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/usb/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
+#include "../phy-provider.h"
+
 #define SUNXI_AHB_INCR16_BURST_EN	BIT(11)
 #define SUNXI_AHB_INCR8_BURST_EN	BIT(10)
 #define SUNXI_AHB_INCR4_BURST_EN	BIT(9)
diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
index c4a56b9d3289..60d17973a38f 100644
--- a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
+++ b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
@@ -20,6 +20,8 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 /* [31] soft reset for the phy.
  *		1: reset. 0: dessert the reset.
  * [30] clock lane soft reset.
diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
index c0ba2852dbb8..21e8e2a5563a 100644
--- a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
+++ b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
@@ -7,7 +7,6 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/mfd/syscon.h>
@@ -15,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <dt-bindings/phy/phy.h>
 
+#include "../phy-provider.h"
+
 #define HHI_MIPI_CNTL0 0x00
 #define		HHI_MIPI_CNTL0_COMMON_BLOCK	GENMASK(31, 28)
 #define		HHI_MIPI_CNTL0_ENABLE		BIT(29)
diff --git a/drivers/phy/amlogic/phy-meson-axg-pcie.c b/drivers/phy/amlogic/phy-meson-axg-pcie.c
index 14dee73f9cb5..c4d9faf3a805 100644
--- a/drivers/phy/amlogic/phy-meson-axg-pcie.c
+++ b/drivers/phy/amlogic/phy-meson-axg-pcie.c
@@ -13,6 +13,8 @@
 #include <linux/bitfield.h>
 #include <dt-bindings/phy/phy.h>
 
+#include "../phy-provider.h"
+
 #define MESON_PCIE_REG0 0x00
 #define		MESON_PCIE_COMMON_CLK	BIT(4)
 #define		MESON_PCIE_PORT_SEL	GENMASK(3, 2)
diff --git a/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
index 46e5f7e7eb6c..11626f4528dd 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
@@ -9,7 +9,6 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/mfd/syscon.h>
@@ -17,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <dt-bindings/phy/phy.h>
 
+#include "../phy-provider.h"
+
 #define HHI_MIPI_CNTL0 0x00
 #define		HHI_MIPI_CNTL0_DIF_REF_CTL1	GENMASK(31, 16)
 #define		HHI_MIPI_CNTL0_DIF_REF_CTL0	GENMASK(15, 0)
diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
index 66bf0b7ef8ed..6e599b933153 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
@@ -20,6 +20,8 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 #define PHY_CTRL_R0						0x0
 #define PHY_CTRL_R1						0x4
 #define PHY_CTRL_R2						0x8
diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
index 5468831d6ab9..60e9c3c1c449 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
@@ -12,12 +12,13 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/platform_device.h>
 #include <dt-bindings/phy/phy.h>
 
+#include "../phy-provider.h"
+
 #define PHY_R0							0x00
 	#define PHY_R0_PCIE_POWER_STATE				GENMASK(4, 0)
 	#define PHY_R0_PCIE_USB3_SWITCH				GENMASK(6, 5)
diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
index 6b390304f723..b8d5b12cffc8 100644
--- a/drivers/phy/amlogic/phy-meson-gxl-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
@@ -12,9 +12,10 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 /* bits [31:27] are read-only */
 #define U2P_R0							0x0
 	#define U2P_R0_BYPASS_SEL				BIT(0)
diff --git a/drivers/phy/amlogic/phy-meson8-hdmi-tx.c b/drivers/phy/amlogic/phy-meson8-hdmi-tx.c
index 2617f7f6c2ec..2a8c93dcda7e 100644
--- a/drivers/phy/amlogic/phy-meson8-hdmi-tx.c
+++ b/drivers/phy/amlogic/phy-meson8-hdmi-tx.c
@@ -11,11 +11,12 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 /*
  * Unfortunately there is no detailed documentation available for the
  * HHI_HDMI_PHY_CNTL0 register. CTL0 and CTL1 is all we know about.
diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index a553231a9f7c..b288868b2d9e 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -14,10 +14,11 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/usb/of.h>
 
+#include "../phy-provider.h"
+
 #define REG_CONFIG					0x00
 	#define REG_CONFIG_CLK_EN			BIT(0)
 	#define REG_CONFIG_CLK_SEL_MASK			GENMASK(3, 1)
diff --git a/drivers/phy/apple/atc.c b/drivers/phy/apple/atc.c
index e9d106f135c5..de9453d13c0e 100644
--- a/drivers/phy/apple/atc.c
+++ b/drivers/phy/apple/atc.c
@@ -32,7 +32,6 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/soc/apple/tunable.h>
@@ -44,6 +43,8 @@
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_tbt.h>
 
+#include "../phy-provider.h"
+
 #define AUSPLL_FSM_CTRL 0x1014
 
 #define AUSPLL_APB_CMD_OVERRIDE 0x2000
diff --git a/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c b/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
index 462c61a24ec5..e10274f53c10 100644
--- a/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
+++ b/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
@@ -5,9 +5,10 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 #define PCIE_CFG_OFFSET         0x00
 #define PCIE1_PHY_IDDQ_SHIFT    10
 #define PCIE0_PHY_IDDQ_SHIFT    2
diff --git a/drivers/phy/broadcom/phy-bcm-kona-usb2.c b/drivers/phy/broadcom/phy-bcm-kona-usb2.c
index e9cc5f2cb89a..356f42a08941 100644
--- a/drivers/phy/broadcom/phy-bcm-kona-usb2.c
+++ b/drivers/phy/broadcom/phy-bcm-kona-usb2.c
@@ -12,9 +12,11 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
+#include <linux/phy/phy.h> /* for phy_set_bus_width() */
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 #define OTGCTL			(0)
 #define OTGCTL_OTGSTAT2		BIT(31)
 #define OTGCTL_OTGSTAT1		BIT(30)
diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
index c5d35031b398..95331d08b367 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
@@ -13,11 +13,12 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+#include "../phy-provider.h"
+
 struct bcm_ns_usb2 {
 	struct device *dev;
 	struct clk *ref_clk;
diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb3.c b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
index 6e56498d0644..f2aa4014f197 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb3.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
@@ -19,10 +19,11 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/phy/phy.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
+#include "../phy-provider.h"
+
 #define BCM_NS_USB3_PHY_BASE_ADDR_REG	0x1f
 #define BCM_NS_USB3_PHY_PLL30_BLOCK	0x8000
 #define BCM_NS_USB3_PHY_TX_PMD_BLOCK	0x8040
diff --git a/drivers/phy/broadcom/phy-bcm-ns2-pcie.c b/drivers/phy/broadcom/phy-bcm-ns2-pcie.c
index 67a6ae5ecba0..9c2c603426ca 100644
--- a/drivers/phy/broadcom/phy-bcm-ns2-pcie.c
+++ b/drivers/phy/broadcom/phy-bcm-ns2-pcie.c
@@ -6,7 +6,8 @@
 #include <linux/of_mdio.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
-#include <linux/phy/phy.h>
+
+#include "../phy-provider.h"
 
 #define BLK_ADDR_REG_OFFSET	0x1f
 #define PLL_AFE1_100MHZ_BLK	0x2100
diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
index 8473fa574529..7543211fb998 100644
--- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
+++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
@@ -14,12 +14,13 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
+#include "../phy-provider.h"
+
 #define ICFG_DRD_AFE		0x0
 #define ICFG_MISC_STAT		0x18
 #define ICFG_DRD_P0CTL		0x1C
diff --git a/drivers/phy/broadcom/phy-bcm-sr-pcie.c b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
index 706e1d83b4ce..8f4e44d1dea6 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-pcie.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
@@ -9,10 +9,11 @@
 #include <linux/module.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 /* we have up to 8 PAXB based RC. The 9th one is always PAXC */
 #define SR_NR_PCIE_PHYS               9
 #define SR_PAXC_PHY_IDX               (SR_NR_PCIE_PHYS - 1)
diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
index 6bcfe83609c8..4c863738bdca 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
@@ -8,9 +8,10 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 enum bcm_usb_phy_version {
 	BCM_SR_USB_COMBO_PHY,
 	BCM_SR_USB_HS_PHY,
diff --git a/drivers/phy/broadcom/phy-bcm63xx-usbh.c b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
index 29fd6791bae6..63099da486c6 100644
--- a/drivers/phy/broadcom/phy-bcm63xx-usbh.c
+++ b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
@@ -18,10 +18,11 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
+#include "../phy-provider.h"
+
 /* USBH control register offsets */
 enum usbh_regs {
 	USBH_BRT_CONTROL1 = 0,
diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index fb69e21a0292..ab826f9c8678 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -13,9 +13,10 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 #define SATA_PCB_BANK_OFFSET				0x23c
 #define SATA_PCB_REG_OFFSET(ofs)			((ofs) * 4)
 
diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 59d756a10d6c..d660a0ed03ee 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -11,7 +11,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/soc/brcmstb/brcmstb.h>
@@ -19,6 +18,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/suspend.h>
 
+#include "../phy-provider.h"
 #include "phy-brcm-usb-init.h"
 
 static DEFINE_MUTEX(sysfs_lock);
diff --git a/drivers/phy/cadence/cdns-dphy-rx.c b/drivers/phy/cadence/cdns-dphy-rx.c
index 3ac80141189c..7097ac17443f 100644
--- a/drivers/phy/cadence/cdns-dphy-rx.c
+++ b/drivers/phy/cadence/cdns-dphy-rx.c
@@ -9,12 +9,13 @@
 #include <linux/iopoll.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/phy/phy-mipi-dphy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sys_soc.h>
 
+#include "../phy-provider.h"
+
 #define DPHY_PMA_CMN(reg)		(reg)
 #define DPHY_PCS(reg)			(0xb00 + (reg))
 #define DPHY_ISO(reg)			(0xc00 + (reg))
diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index d5b0e516b93c..40bc18405082 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -10,11 +10,11 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/phy/phy-mipi-dphy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
-#include <linux/phy/phy.h>
-#include <linux/phy/phy-mipi-dphy.h>
+#include "../phy-provider.h"
 
 #define REG_WAKEUP_TIME_NS		800
 #define DPHY_PLL_RATE_HZ		108000000
diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index f461585c84c6..8ed74db50dfa 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -10,12 +10,13 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
+#include "../phy-provider.h"
+
 #define USB3_PHY_OFFSET			0x0
 #define USB2_PHY_OFFSET			0x38000
 /* USB3 PHY register definition */
diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 92ab1a31646a..fb44b8fc5e3f 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -12,7 +12,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -23,6 +22,8 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/phy/phy-cadence.h>
 
+#include "../phy-provider.h"
+
 #define NUM_SSC_MODE		3
 #define NUM_PHY_TYPE		5
 
diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index d446a0f97688..974e12e34ae1 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -17,11 +17,12 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 #define REF_CLK_19_2MHZ		19200000
 #define REF_CLK_25MHZ		25000000
 #define REF_CLK_100MHZ		100000000
diff --git a/drivers/phy/canaan/phy-k230-usb.c b/drivers/phy/canaan/phy-k230-usb.c
index 52dad35fc6cf..4305763a5456 100644
--- a/drivers/phy/canaan/phy-k230-usb.c
+++ b/drivers/phy/canaan/phy-k230-usb.c
@@ -8,9 +8,10 @@
 #include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 #define MAX_PHYS		2
 
 /* Register offsets within the HiSysConfig system controller */
diff --git a/drivers/phy/eswin/phy-eic7700-sata.c b/drivers/phy/eswin/phy-eic7700-sata.c
index c33653d48daa..387d5c8c11d9 100644
--- a/drivers/phy/eswin/phy-eic7700-sata.c
+++ b/drivers/phy/eswin/phy-eic7700-sata.c
@@ -14,11 +14,12 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
+#include "../phy-provider.h"
+
 #define SATA_AXI_LP_CTRL			0x08
 #define SATA_MPLL_CTRL				0x20
 #define SATA_P0_PHY_STAT			0x24
diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
index 0928a526e2ab..314aa227f753 100644
--- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
@@ -16,11 +16,12 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
+#include "../phy-provider.h"
+
 /* Control and Status Registers(CSR) */
 #define PHY_CTRL			0x00
 #define  CCM_MASK			GENMASK(7, 5)
diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 7f5600103a00..6197cfc9b9a4 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -3,6 +3,7 @@
  * Copyright 2021 NXP
  */
 
+#include <dt-bindings/phy/phy-imx8-pcie.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -12,12 +13,11 @@
 #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
-#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include "../phy-provider.h"
 
 #define IMX8MM_PCIE_PHY_CMN_REG061	0x184
 #define  ANA_PLL_CLK_OUT_TO_EXT_IO_EN	BIT(0)
diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index b05d80e849a1..9b938b446996 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -7,11 +7,12 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/typec_mux.h>
 
+#include "../phy-provider.h"
+
 #define PHY_CTRL0			0x0
 #define PHY_CTRL0_REF_SSP_EN		BIT(2)
 #define PHY_CTRL0_FSEL_MASK		GENMASK(10, 5)
diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
index 279b8ac7822d..b274fd24b59a 100644
--- a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
+++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
@@ -3,6 +3,8 @@
  * Copyright 2024 NXP
  */
 
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -11,13 +13,11 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pci_regs.h>
-#include <linux/phy/phy.h>
 #include <linux/phy/pcie.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#include <dt-bindings/phy/phy.h>
-#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include "../phy-provider.h"
 
 #define MAX_NUM_LANE	3
 #define LANE_NUM_CLKS	5
diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c b/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
index ece357443521..55c23bef5121 100644
--- a/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
@@ -9,12 +9,13 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
 
+#include "../phy-provider.h"
+
 #define REG_SET		0x4
 #define REG_CLR		0x8
 
diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 63427fc34e26..38862c9c6c94 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -5,10 +5,11 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
 
+#include "../phy-provider.h"
+
 #define LYNX_28G_NUM_LANE			8
 #define LYNX_28G_NUM_PLL			2
 
diff --git a/drivers/phy/hisilicon/phy-hi3660-usb3.c b/drivers/phy/hisilicon/phy-hi3660-usb3.c
index e2a09d67faed..b66ff3be1aed 100644
--- a/drivers/phy/hisilicon/phy-hi3660-usb3.c
+++ b/drivers/phy/hisilicon/phy-hi3660-usb3.c
@@ -12,10 +12,11 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 #define PERI_CRG_CLK_EN4			0x40
 #define PERI_CRG_CLK_DIS4			0x44
 #define GT_CLK_USB3OTG_REF			BIT(0)
diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
index dbc7dcce682b..b7cf44078e0d 100644
--- a/drivers/phy/hisilicon/phy-hi3670-pcie.c
+++ b/drivers/phy/hisilicon/phy-hi3670-pcie.c
@@ -26,11 +26,12 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 
+#include "../phy-provider.h"
+
 #define AXI_CLK_FREQ				207500000
 #define REF_CLK_FREQ				100000000
 
diff --git a/drivers/phy/hisilicon/phy-hi3670-usb3.c b/drivers/phy/hisilicon/phy-hi3670-usb3.c
index 40d3cf128b44..004c51500597 100644
--- a/drivers/phy/hisilicon/phy-hi3670-usb3.c
+++ b/drivers/phy/hisilicon/phy-hi3670-usb3.c
@@ -14,10 +14,11 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 #define SCTRL_SCDEEPSLEEPED		(0x0)
 #define USB_CLK_SELECTED		BIT(20)
 
diff --git a/drivers/phy/hisilicon/phy-hi6220-usb.c b/drivers/phy/hisilicon/phy-hi6220-usb.c
index 22d8d8a8dabe..1b5a2d3e3e44 100644
--- a/drivers/phy/hisilicon/phy-hi6220-usb.c
+++ b/drivers/phy/hisilicon/phy-hi6220-usb.c
@@ -8,9 +8,10 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 #define SC_PERIPH_CTRL4			0x00c
 
 #define CTRL4_PICO_SIDDQ		BIT(6)
diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index c843923252aa..4a4701d0fc9c 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -10,10 +10,12 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
+#include <linux/phy/phy.h> /* for phy_set_bus_width() */
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
+#include "../phy-provider.h"
+
 #define INNO_PHY_PORT_NUM	2
 #define REF_CLK_STABLE_TIME	100	/* unit:us */
 #define UTMI_CLK_STABLE_TIME	200	/* unit:us */
diff --git a/drivers/phy/hisilicon/phy-histb-combphy.c b/drivers/phy/hisilicon/phy-histb-combphy.c
index 9dd0bd00b4e4..9b6ed1644d74 100644
--- a/drivers/phy/hisilicon/phy-histb-combphy.c
+++ b/drivers/phy/hisilicon/phy-histb-combphy.c
@@ -14,12 +14,13 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <dt-bindings/phy/phy.h>
 
+#include "../phy-provider.h"
+
 #define COMBPHY_MODE_PCIE		0
 #define COMBPHY_MODE_USB3		1
 #define COMBPHY_MODE_SATA		2
diff --git a/drivers/phy/hisilicon/phy-hix5hd2-sata.c b/drivers/phy/hisilicon/phy-hix5hd2-sata.c
index 1b26ddb4c8a7..57994f69417d 100644
--- a/drivers/phy/hisilicon/phy-hix5hd2-sata.c
+++ b/drivers/phy/hisilicon/phy-hix5hd2-sata.c
@@ -9,10 +9,11 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 #define SATA_PHY0_CTLL		0xa0
 #define MPLL_MULTIPLIER_SHIFT	1
 #define MPLL_MULTIPLIER_MASK	0xfe
diff --git a/drivers/phy/ingenic/phy-ingenic-usb.c b/drivers/phy/ingenic/phy-ingenic-usb.c
index 7e62d46850fd..d656f97729c4 100644
--- a/drivers/phy/ingenic/phy-ingenic-usb.c
+++ b/drivers/phy/ingenic/phy-ingenic-usb.c
@@ -12,10 +12,11 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
+#include "../phy-provider.h"
+
 /* OTGPHY register offsets */
 #define REG_USBPCR_OFFSET			0x00
 #define REG_USBRDT_OFFSET			0x04
diff --git a/drivers/phy/intel/phy-intel-keembay-emmc.c b/drivers/phy/intel/phy-intel-keembay-emmc.c
index 0eb11ac7c2e2..fdba1d050439 100644
--- a/drivers/phy/intel/phy-intel-keembay-emmc.c
+++ b/drivers/phy/intel/phy-intel-keembay-emmc.c
@@ -11,10 +11,11 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 /* eMMC/SD/SDIO core/phy configuration registers */
 #define PHY_CFG_0		0x24
 #define  SEL_DLY_TXCLK_MASK	BIT(29)
diff --git a/drivers/phy/intel/phy-intel-keembay-usb.c b/drivers/phy/intel/phy-intel-keembay-usb.c
index c8b05f7b2445..4e690f3eb560 100644
--- a/drivers/phy/intel/phy-intel-keembay-usb.c
+++ b/drivers/phy/intel/phy-intel-keembay-usb.c
@@ -10,10 +10,11 @@
 #include <linux/delay.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 /* USS (USB Subsystem) clock control registers */
 #define USS_CPR_CLK_EN		0x00
 #define USS_CPR_CLK_SET		0x04
diff --git a/drivers/phy/intel/phy-intel-lgm-combo.c b/drivers/phy/intel/phy-intel-lgm-combo.c
index 9ee3cf61cdd0..2a8b0caa0e59 100644
--- a/drivers/phy/intel/phy-intel-lgm-combo.c
+++ b/drivers/phy/intel/phy-intel-lgm-combo.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2019-2020 Intel Corporation.
  */
 
+#include <dt-bindings/phy/phy.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/iopoll.h>
@@ -12,12 +13,11 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
-#include <dt-bindings/phy/phy.h>
+#include "../phy-provider.h"
 
 #define PCIE_PHY_GEN_CTRL	0x00
 #define PCIE_PHY_CLK_PAD	BIT(17)
diff --git a/drivers/phy/intel/phy-intel-lgm-emmc.c b/drivers/phy/intel/phy-intel-lgm-emmc.c
index 703aeb122541..479a530dd630 100644
--- a/drivers/phy/intel/phy-intel-lgm-emmc.c
+++ b/drivers/phy/intel/phy-intel-lgm-emmc.c
@@ -11,10 +11,11 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 /* eMMC phy register definitions */
 #define EMMC_PHYCTRL0_REG	0xa8
 #define DR_TY_MASK		GENMASK(30, 28)
diff --git a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
index 82f1ffc0b0ad..eb6c201f7c87 100644
--- a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
+++ b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
@@ -12,12 +12,13 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
+#include "../phy-provider.h"
+
 /* Transmitter HS Pre-Emphasis Enable */
 #define RCU_CFG1_TX_PEE		BIT(0)
 /* Disconnect Threshold */
diff --git a/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c b/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
index 406a87c8b759..70da76399e30 100644
--- a/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
+++ b/drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c
@@ -11,6 +11,7 @@
  * TODO: PHY modes other than 36MHz (without "SSC")
  */
 
+#include <dt-bindings/phy/phy-lantiq-vrx200-pcie.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
@@ -18,13 +19,12 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
-#include <dt-bindings/phy/phy-lantiq-vrx200-pcie.h>
+#include "../phy-provider.h"
 
 #define PCIE_PHY_PLL_CTRL1				0x44
 
diff --git a/drivers/phy/marvell/phy-armada375-usb2.c b/drivers/phy/marvell/phy-armada375-usb2.c
index 3731f9b25655..d5c100096c3d 100644
--- a/drivers/phy/marvell/phy-armada375-usb2.c
+++ b/drivers/phy/marvell/phy-armada375-usb2.c
@@ -16,9 +16,10 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 #define USB2_PHY_CONFIG_DISABLE BIT(0)
 
 struct armada375_cluster_phy {
diff --git a/drivers/phy/marvell/phy-armada38x-comphy.c b/drivers/phy/marvell/phy-armada38x-comphy.c
index 5063361b0120..9653863f90bb 100644
--- a/drivers/phy/marvell/phy-armada38x-comphy.c
+++ b/drivers/phy/marvell/phy-armada38x-comphy.c
@@ -9,10 +9,11 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 #define MAX_A38X_COMPHY	6
 #define MAX_A38X_PORTS	3
 
diff --git a/drivers/phy/marvell/phy-berlin-sata.c b/drivers/phy/marvell/phy-berlin-sata.c
index c90e2867900c..4d4013d115ca 100644
--- a/drivers/phy/marvell/phy-berlin-sata.c
+++ b/drivers/phy/marvell/phy-berlin-sata.c
@@ -10,10 +10,11 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 #define HOST_VSA_ADDR		0x0
 #define HOST_VSA_DATA		0x4
 #define PORT_SCR_CTL		0x2c
diff --git a/drivers/phy/marvell/phy-berlin-usb.c b/drivers/phy/marvell/phy-berlin-usb.c
index f26bf630da2c..a3e58deaaa74 100644
--- a/drivers/phy/marvell/phy-berlin-usb.c
+++ b/drivers/phy/marvell/phy-berlin-usb.c
@@ -9,11 +9,12 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/reset.h>
 
+#include "../phy-provider.h"
+
 #define USB_PHY_PLL		0x04
 #define USB_PHY_PLL_CONTROL	0x08
 #define USB_PHY_TX_CTRL0	0x10
diff --git a/drivers/phy/marvell/phy-mmp3-hsic.c b/drivers/phy/marvell/phy-mmp3-hsic.c
index 72ab6da0ebc3..90498211431b 100644
--- a/drivers/phy/marvell/phy-mmp3-hsic.c
+++ b/drivers/phy/marvell/phy-mmp3-hsic.c
@@ -7,9 +7,10 @@
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 #define HSIC_CTRL	0x08
 #define HSIC_ENABLE	BIT(7)
 #define PLL_BYPASS	BIT(4)
diff --git a/drivers/phy/marvell/phy-mmp3-usb.c b/drivers/phy/marvell/phy-mmp3-usb.c
index 5b71deb08851..ba67bcc2c3f9 100644
--- a/drivers/phy/marvell/phy-mmp3-usb.c
+++ b/drivers/phy/marvell/phy-mmp3-usb.c
@@ -8,10 +8,11 @@
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/soc/mmp/cputype.h>
 
+#include "../phy-provider.h"
+
 #define USB2_PLL_REG0		0x4
 #define USB2_PLL_REG1		0x8
 #define USB2_TX_REG0		0x10
diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
index 1d1db1737422..3acfd74c3eca 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -21,10 +21,11 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 
+#include "../phy-provider.h"
+
 #define PLL_SET_DELAY_US		600
 #define COMPHY_PLL_SLEEP		1000
 #define COMPHY_PLL_TIMEOUT		150000
diff --git a/drivers/phy/marvell/phy-mvebu-a3700-utmi.c b/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
index 04f4fb4bed70..c17ce28ceb0b 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
@@ -14,10 +14,11 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 /* Armada 3700 UTMI PHY registers */
 #define USB2_PHY_PLL_CTRL_REG0			0x0
 #define   PLL_REF_DIV_OFF			0
diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index 71f9c14fb50d..18ad172135ea 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -13,10 +13,11 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 /* Relative to priv->base */
 #define MVEBU_COMPHY_SERDES_CFG0(n)		(0x0 + (n) * 0x1000)
 #define     MVEBU_COMPHY_SERDES_CFG0_PU_PLL	BIT(1)
diff --git a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
index dd3e515a8e86..f3e2ef54c37b 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
@@ -13,12 +13,13 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
 
+#include "../phy-provider.h"
+
 #define UTMI_PHY_PORTS				2
 
 /* CP110 UTMI register macro definetions */
diff --git a/drivers/phy/marvell/phy-mvebu-sata.c b/drivers/phy/marvell/phy-mvebu-sata.c
index 89a5a2b69d80..b9a9eca74789 100644
--- a/drivers/phy/marvell/phy-mvebu-sata.c
+++ b/drivers/phy/marvell/phy-mvebu-sata.c
@@ -8,11 +8,12 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/clk.h>
-#include <linux/phy/phy.h>
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 struct priv {
 	struct clk	*clk;
 	void __iomem	*base;
diff --git a/drivers/phy/marvell/phy-pxa-28nm-hsic.c b/drivers/phy/marvell/phy-pxa-28nm-hsic.c
index eff6dd6b2dd0..6feee8d1ca70 100644
--- a/drivers/phy/marvell/phy-pxa-28nm-hsic.c
+++ b/drivers/phy/marvell/phy-pxa-28nm-hsic.c
@@ -17,7 +17,8 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/phy/phy.h>
+
+#include "../phy-provider.h"
 
 #define PHY_28NM_HSIC_CTRL			0x08
 #define PHY_28NM_HSIC_IMPCAL_CAL		0x18
diff --git a/drivers/phy/marvell/phy-pxa-28nm-usb2.c b/drivers/phy/marvell/phy-pxa-28nm-usb2.c
index 64afb82cf70e..39b8344803cb 100644
--- a/drivers/phy/marvell/phy-pxa-28nm-usb2.c
+++ b/drivers/phy/marvell/phy-pxa-28nm-usb2.c
@@ -17,7 +17,8 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/phy/phy.h>
+
+#include "../phy-provider.h"
 
 /* USB PXA1928 PHY mapping */
 #define PHY_28NM_PLL_REG0			0x0
diff --git a/drivers/phy/marvell/phy-pxa-usb.c b/drivers/phy/marvell/phy-pxa-usb.c
index c0bb71f80c04..9a8ab813d001 100644
--- a/drivers/phy/marvell/phy-pxa-usb.c
+++ b/drivers/phy/marvell/phy-pxa-usb.c
@@ -10,9 +10,10 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
+
 /* phy regs */
 #define UTMI_REVISION		0x0
 #define UTMI_CTRL		0x4
diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index d7024a144335..ab3778447570 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -10,10 +10,11 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 #define PHY_OFFSET			0x1000
 
 #define MTK_DP_PHY_DIG_PLL_CTL_1	(PHY_OFFSET + 0x14)
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index 1426a2db984d..30015bac3f73 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -7,7 +7,6 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.h b/drivers/phy/mediatek/phy-mtk-hdmi.h
index 99d917e0036a..bfddd8dbe9dd 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.h
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.h
@@ -11,12 +11,13 @@
 #include <linux/delay.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/types.h>
 
+#include "../phy-provider.h"
+
 struct mtk_hdmi_phy;
 
 struct mtk_hdmi_phy_conf {
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c b/drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c
index 058e1d926630..5e008204ecca 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c
@@ -12,10 +12,10 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include "../phy-provider.h"
 #include "phy-mtk-io.h"
 #include "phy-mtk-mipi-csi-0-5-rx-reg.h"
 
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
index 5d4876f1dc95..676c8f78d9d6 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
@@ -13,9 +13,10 @@
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
-#include <linux/phy/phy.h>
 #include <linux/slab.h>
 
+#include "../phy-provider.h"
+
 struct mtk_mipitx_data {
 	const u32 mppll_preserve;
 	const struct clk_ops *mipi_tx_clk_ops;
diff --git a/drivers/phy/mediatek/phy-mtk-pcie.c b/drivers/phy/mediatek/phy-mtk-pcie.c
index a2f69d6c72f0..1ab7c1dc2753 100644
--- a/drivers/phy/mediatek/phy-mtk-pcie.c
+++ b/drivers/phy/mediatek/phy-mtk-pcie.c
@@ -8,10 +8,10 @@
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include "../phy-provider.h"
 #include "phy-mtk-io.h"
 
 #define PEXTP_ANA_GLB_00_REG		0x9000
diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index acf506529507..6f98de067327 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -15,10 +15,10 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
 #include "phy-mtk-io.h"
 
 /* version V1 sub-banks offset base address */
diff --git a/drivers/phy/mediatek/phy-mtk-ufs.c b/drivers/phy/mediatek/phy-mtk-ufs.c
index 0cb5a25b1b7a..de517fcc4f3e 100644
--- a/drivers/phy/mediatek/phy-mtk-ufs.c
+++ b/drivers/phy/mediatek/phy-mtk-ufs.c
@@ -9,9 +9,9 @@
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "../phy-provider.h"
 #include "phy-mtk-io.h"
 
 /* mphy register and offsets */
diff --git a/drivers/phy/mediatek/phy-mtk-xfi-tphy.c b/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
index 100a50d0e861..036a4bb58dcf 100644
--- a/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-xfi-tphy.c
@@ -17,8 +17,8 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/phy.h>
-#include <linux/phy/phy.h>
 
+#include "../phy-provider.h"
 #include "phy-mtk-io.h"
 
 #define MTK_XFI_TPHY_NUM_CLOCKS		2
diff --git a/drivers/phy/mediatek/phy-mtk-xsphy.c b/drivers/phy/mediatek/phy-mtk-xsphy.c
index c0ddb9273cc3..5e61abddaf54 100644
--- a/drivers/phy/mediatek/phy-mtk-xsphy.c
+++ b/drivers/phy/mediatek/phy-mtk-xsphy.c
@@ -14,10 +14,10 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
 #include "phy-mtk-io.h"
 
 /* u2 phy banks */
diff --git a/drivers/phy/microchip/lan966x_serdes.c b/drivers/phy/microchip/lan966x_serdes.c
index 835e369cdfc5..8769518f9708 100644
--- a/drivers/phy/microchip/lan966x_serdes.c
+++ b/drivers/phy/microchip/lan966x_serdes.c
@@ -1,15 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <dt-bindings/phy/phy-lan966x-serdes.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
-#include <dt-bindings/phy/phy-lan966x-serdes.h>
 #include "lan966x_serdes_regs.h"
+#include "../phy-provider.h"
 
 #define PLL_CONF_MASK		GENMASK(4, 3)
 #define PLL_CONF_25MHZ		0
diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index 320cf5b50a8c..09c22a6a2639 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -17,8 +17,8 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/phy.h>
-#include <linux/phy/phy.h>
 
+#include "../phy-provider.h"
 #include "sparx5_serdes.h"
 
 #define SPX5_SERDES_10G_START 13
diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 7cb020dd3423..66a834c208fc 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -24,10 +24,11 @@
 #include <linux/gpio/consumer.h>
 #include <linux/mfd/motorola-cpcap.h>
 #include <linux/phy/omap_usb.h>
-#include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/musb.h>
 
+#include "../phy-provider.h"
+
 /* CPCAP_REG_USBC1 register bits */
 #define CPCAP_BIT_IDPULSE		BIT(15)
 #define CPCAP_BIT_ID100KPU		BIT(14)
diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index ce1dad8c438d..92f63e52bd1d 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -15,10 +15,12 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/of_platform.h>
-#include <linux/phy/phy.h>
+#include <linux/phy/phy.h> /* for phy_pm_runtime_*() */
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 
+#include "../phy-provider.h"
+
 #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
 #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
 #define PHY_MDM6600_WAKE_KICK_MS	600	/* time on after GPIO toggle */
diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
index 1cd1b5db2ad7..13f83876d954 100644
--- a/drivers/phy/mscc/phy-ocelot-serdes.c
+++ b/drivers/phy/mscc/phy-ocelot-serdes.c
@@ -12,12 +12,13 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <soc/mscc/ocelot_hsio.h>
 #include <dt-bindings/phy/phy-ocelot-serdes.h>
 
+#include "../phy-provider.h"
+
 struct serdes_ctrl {
 	struct regmap		*regs;
 	struct device		*dev;
diff --git a/drivers/phy/nuvoton/phy-ma35d1-usb2.c b/drivers/phy/nuvoton/phy-ma35d1-usb2.c
index 9a459b700ed4..520c86188fe2 100644
--- a/drivers/phy/nuvoton/phy-ma35d1-usb2.c
+++ b/drivers/phy/nuvoton/phy-ma35d1-usb2.c
@@ -10,10 +10,11 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "../phy-provider.h"
+
 /* USB PHY Miscellaneous Control Register */
 #define MA35_SYS_REG_USBPMISCR	0x60
 #define PHY0POR			BIT(0)  /* PHY Power-On Reset Control Bit */
diff --git a/drivers/phy/phy-airoha-pcie.c b/drivers/phy/phy-airoha-pcie.c
index 56e9ade8a9fd..d9817eed2631 100644
--- a/drivers/phy/phy-airoha-pcie.c
+++ b/drivers/phy/phy-airoha-pcie.c
@@ -9,11 +9,11 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "phy-airoha-pcie-regs.h"
+#include "phy-provider.h"
 
 #define LEQ_LEN_CTRL_MAX_VAL	7
 #define FREQ_LOCK_MAX_ATTEMPT	10
diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 2b52e47f247a..68f771a7bad7 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -6,13 +6,14 @@
  *
  */
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mux/consumer.h>
 
+#include "phy-provider.h"
+
 struct can_transceiver_data {
 	u32 flags;
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
index f4956a417a47..770cfe2a2279 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -4,13 +4,13 @@
  * Copyright (C) 2018 Cadence Design Systems Inc.
  */
 
+#include <linux/phy/phy-mipi-dphy.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/time64.h>
 
-#include <linux/phy/phy.h>
-#include <linux/phy/phy-mipi-dphy.h>
+#include "phy-provider.h"
 
 /*
  * Minimum D-PHY timings based on MIPI D-PHY specification. Derived
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 737a760d97d1..02af89ee64a3 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -20,6 +20,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
+#include "phy-provider.h"
+
 #define	to_phy(a)	(container_of((a), struct phy, dev))
 
 /**
diff --git a/drivers/phy/phy-google-usb.c b/drivers/phy/phy-google-usb.c
index 48cfa2e28347..539732f4869e 100644
--- a/drivers/phy/phy-google-usb.c
+++ b/drivers/phy/phy-google-usb.c
@@ -14,13 +14,14 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/usb/typec_mux.h>
 
+#include "phy-provider.h"
+
 #define USBCS_USB2PHY_CFG19_OFFSET 0x0
 #define USBCS_USB2PHY_CFG19_PHY_CFG_PLL_FB_DIV GENMASK(19, 8)
 
diff --git a/drivers/phy/phy-lpc18xx-usb-otg.c b/drivers/phy/phy-lpc18xx-usb-otg.c
index f905d3c64584..554dfa55fe7e 100644
--- a/drivers/phy/phy-lpc18xx-usb-otg.c
+++ b/drivers/phy/phy-lpc18xx-usb-otg.c
@@ -10,10 +10,11 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "phy-provider.h"
+
 /* USB OTG PHY register offset and bit in CREG */
 #define LPC18XX_CREG_CREG0		0x004
 #define LPC18XX_CREG_CREG0_USB0PHY	BIT(5)
diff --git a/drivers/phy/phy-nxp-ptn3222.c b/drivers/phy/phy-nxp-ptn3222.c
index c6179d8701e6..ae75b760a30d 100644
--- a/drivers/phy/phy-nxp-ptn3222.c
+++ b/drivers/phy/phy-nxp-ptn3222.c
@@ -7,10 +7,11 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include "phy-provider.h"
+
 #define NUM_SUPPLIES 2
 
 struct ptn3222 {
diff --git a/drivers/phy/phy-pistachio-usb.c b/drivers/phy/phy-pistachio-usb.c
index 231792f48ced..8eed6f505a31 100644
--- a/drivers/phy/phy-pistachio-usb.c
+++ b/drivers/phy/phy-pistachio-usb.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2015 Google, Inc.
  */
 
+#include <dt-bindings/phy/phy-pistachio-usb.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -12,11 +13,10 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#include <dt-bindings/phy/phy-pistachio-usb.h>
+#include "phy-provider.h"
 
 #define USB_PHY_CONTROL1				0x04
 #define USB_PHY_CONTROL1_FSEL_SHIFT			2
diff --git a/drivers/phy/phy-snps-eusb2.c b/drivers/phy/phy-snps-eusb2.c
index f90bf7e95463..9062737bfad4 100644
--- a/drivers/phy/phy-snps-eusb2.c
+++ b/drivers/phy/phy-snps-eusb2.c
@@ -13,6 +13,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
+#include "phy-provider.h"
+
 #define EXYNOS_USB_PHY_HS_PHY_CTRL_RST	(0x0)
 #define USB_PHY_RST_MASK		GENMASK(1, 0)
 #define UTMI_PORT_RST_MASK		GENMASK(5, 4)
diff --git a/drivers/phy/phy-xgene.c b/drivers/phy/phy-xgene.c
index 5007dc7a357c..90a00498ec0a 100644
--- a/drivers/phy/phy-xgene.c
+++ b/drivers/phy/phy-xgene.c
@@ -43,9 +43,10 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <linux/phy/phy.h>
 #include <linux/clk.h>
 
+#include "phy-provider.h"
+
 /* Max 2 lanes per a PHY unit */
 #define MAX_LANE			2
 
-- 
2.34.1


