Return-Path: <linux-can+bounces-7032-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGL6KZ8br2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7032-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:12:31 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 917B023F587
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F68E30F7FA8
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521933EF0A2;
	Mon,  9 Mar 2026 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iMmhu3PG"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9323EDAB8;
	Mon,  9 Mar 2026 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083361; cv=fail; b=aS4dhO4y8KB/dZK5M/7cSMXxRuPegPEuX4R/LAc75eiMdxBo7L2u1Cta5vFcZsOlxV2or7FsdwTtONb6TN1jq+wRkecIFQMWlmJgdHlDjINVEmTteeByae45HMUivD8EXKDsr+7IEGmPw0YrfeLnMjKVCBxF4lMxHUL5xTZ0T4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083361; c=relaxed/simple;
	bh=d0h6faqHJnzRtBQDzOEdEGYQcboxKTQ+nAILWXbJsw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPzdvmk+zpIC9dOD8V2fBvjkPgz0uRHm+v0T4algCfaOGNeJcvmYI8IR/GniscVj5FIw3jwDHZu7VXg7Vjw3hYomrOymXA+I7m0pSEgcw3Jtgb8oUB5ITvyW9+HgN/PeM35rGtTZ7AFFpKKhsAIT5zUlSkaxGYd7dU6rBZ6x/NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iMmhu3PG; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIjXAxkWUSS0elGRGCjA9CRgS8hloBkSw2jRLSHfeu6YIZMPm6xJQ03jUBG0m5+n7WyJ8lzmCgmc0MaqsdyzdKrpBroTlMrdPeCkq5uA4iAbNS0O8QpcJYIk/yZgF7ccb9oohAG2PoRalrdpeaXEc/3wqR75lgKlSrwWDtoD3npAnfxanla0FePiCGdHFfcGrgRN1q4ZSHEFCDBfPzYbyxoJh8iyUgU2oHKDkeaIlww+2DruphEauSh/XxT5nWZXSurLzgkdx8GUpYTI2C7bLqFPgsIqiEURpog9tgybvyl1BqXR+Sa0oN99EAYC1nN3ICVPRAdD0CGZM4bQFRQZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uFhWeR7lCpQrbld9SF+kqTYR7ZN4F8mmRE0hud9w8E=;
 b=llaVrfE9jLIxq60dHidn1IzJusD6fk8EtAQL3bitJF1d8lZrPv41TaUlSExy5iXzI7n+DpaWbFG4K9b/3H5JCkBAuE540TkkE27jN24V4v5eQWrrpBz2LZFU+lcLACocFbO24gXnq8g2BQ3WX8QK77eLvB4nsnWH/euLXIG4IZOinf6xvddf27ENPQR1W/w76T7mNOPPGq6tWfOdBZ9I+Y/kpGgJ7+MSlXMQpa8EmX8zQKWI8AfUYTsWNScqSKlrR7dVpnlJ5uBB6gd4DgjDKBHFeNsniZNNyHY9xrTV5VvqyOOH62KNfRP5TrhbObxc1+RkdZDx1N6XO/3kJAeiMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uFhWeR7lCpQrbld9SF+kqTYR7ZN4F8mmRE0hud9w8E=;
 b=iMmhu3PGWVugjvOWauAj9JltxLko8E7o9CgZW+ts+TejM1MCF2L1ptp391pOD5IEfJ+q8/BAPNUBHnOcDJR0SQT1Im8REdbUP0eNInLLL9ofGWHo60IzN+negvJdvVqFazB3ugT6RVrohGFjSr67EQ9g2aCOJcXirnYi4xKiGn2jqhu3FOBmqJj43VxGYxRWz1oKyMTJH6KOy1M6C8pXmHScg7Fk0J924qXy64J6AF0bhpqZmdMXXsLvDgscDpIZyiqZHqYv/Hp1eJT2l7e6Bk/+S1po3RIXPTZpTFBPUd6H/w8KYS4Y8pZaltb1f2ZaxlQ2DrrYOmGG3FQLX+othw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:12 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:12 +0000
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
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 phy-next 03/24] usb: add missing headers transitively included by <linux/phy/phy.h>
Date: Mon,  9 Mar 2026 21:08:21 +0200
Message-ID: <20260309190842.927634-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0180.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::37) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f452e2-9113-4f42-b970-08de7e0f597a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	Qiqr1pvBcVi5RmI4GylUWRZg7Il0uomYm3SzlMGNP6sJYMJami5pAVO/eGF92VTyryBgrnywRIuCNUXKzUqdFwvqcaQ2pyhNfkoJ17JiOQadDFyqQU6iyDPyhChsW+SxFogyApabS93Lwx59JlMMekY1pmTIa6W+AMsib4ozW85+3FHjRyNtDC3hB4z/O+ucjXfSYXs99r8Y/400wUcACLMDxQnX7g9BloCTxzir8WwFhcL5ga3snPC4aG8Jib+vJ+iJvw1laJYp/Ba2WNTK5NTrLhDy14XV9rRixfuOcadzq4FWj0dkmO3MqIcul9VuhSdaO7vBxX5ILNj7nJizC8jWlmoa1orQyNVBkKx2m+VyzMZxK6TPdJ7KLWbJNliCK/iPdjtIPTUWGEUCWYW/WQpblVMpAbZgyF02QprUvrIJRRO95iJkHfP46x9kzBk9g4m2kggjDSDkVXtoTQoo239E/QvLMsvBal41i+RHtMQYT1KJ8fiCLFVzOee26sfY/pKHOzekRIF3UUHZxY+q8ScGWT2OXINQFQV5mUedY+ZU1LLfvknqJdE79DpI4ioxuFVjMkGQYTBXC6lWZsh1xe+Pi+n4yXajULfoYSwKPnh+fALssTNdX3ltzRN4xUgumRpIPFXwm1IgPwaHhrhF95nxaSScmDiCqxq1/33JcAa2hKx9LN1CJShA5Lbj4U7/PcTmhSPweVjXVJdChYNMKXRCQG97QIBQTiaQYvBXicc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wlvR40iC4IpJ5iLQ+/oevHQ2hzXL3dNFjXXcEhYEdF6akR22HhfDlGMCzruY?=
 =?us-ascii?Q?wi55lRQOPWb/g/A2fBjPP+mar84olL/+Fa5yGjM0rnd5TImapW6YJsLSQe4L?=
 =?us-ascii?Q?TcmNAqX+1+EriCPF8BT3KocUWlfz1qWN0NF10aos62MJPZoQTi2WXAT2VniM?=
 =?us-ascii?Q?6+ZFCR2BVvmXLz1Qu0bXhQEYDFMwPFdPgsKeUAKtONyR14lTfxJhFCdHZiBs?=
 =?us-ascii?Q?nddrE4GvTXFlcU9pNnzaeoHt2BZ3ntKvi51CY7/gn9uXtSzhqksif8BHVF2M?=
 =?us-ascii?Q?CFxzG1r4gYOyDiywjQy2QH5LkG5TbSIIXwdbdNud5hM/5hcEiGXuYhu4Ga65?=
 =?us-ascii?Q?KDw5oFjKUu+Itm0bAwK9J4xhh3G7ytgh2hO89bCZvsL+81geidAm2wLRA5sm?=
 =?us-ascii?Q?FER6j7XPvgt486+jQBcVfSABIUXl5ke/EBl39FiNIxm0GF3QRnjSE41X0w1f?=
 =?us-ascii?Q?N/cYe7oZo2ViP9Y1KRmBZeUiCYrFOK9yIIsDK9PO2h4EpPlj0WFxq7eAL9r0?=
 =?us-ascii?Q?WSMhVDIHav1LfYHid3KpUfMWKqIeccNzREdot/AlmUuYcfIn7Iuj+FA6cDkQ?=
 =?us-ascii?Q?cMpswp93RAUJ2aPAOzde7vbBU50dnnM//VSNEFF/YGY6DmwWFJEfPus4QmW+?=
 =?us-ascii?Q?2IujF0WTa4arFWxUlBU30wwL0YpCGqSO1VYStBam+f1jFzHZYs6dGOyVJPiF?=
 =?us-ascii?Q?Ke9SuV67jIh9PsWQSAzXoXcVpIoIIcDx79CwBdzFAF5qUdQnU4hLyJkU3Xq7?=
 =?us-ascii?Q?uCGYaNQ7zo0/Rftwjf5F5+BOfGkn9yv5Dy0rOK8+kdVEliJvnCQZ9p1WL2ih?=
 =?us-ascii?Q?c4zBws8khbAfiz2F8j0jaFXwpCwkzDzj9MDQAs3tViquBletzDKlmf7dbhb4?=
 =?us-ascii?Q?ixoMSqF25G94nV0YJnSMXgf2HjdrNttXbzEWV9Qv2OP+MwL1NczQTxnWLy8C?=
 =?us-ascii?Q?oAT+5aMgw7mnal8iMGM1nJzqi88DLpEfusesETbQhzVw5sPySNkVbzsdtYCx?=
 =?us-ascii?Q?Dvwa+GE6UEIMVwldwLMQY9PSPVS7mvDlpIE8uw3X+G6a+x2+hIdRvN0IRv8y?=
 =?us-ascii?Q?qPykDbA/jPTTtLORJ7dsL45+aGv4EddwkLKLpQwyj9d+7YaI78ranjOGjEkr?=
 =?us-ascii?Q?ZbTpgy2eFVpl5wUhbVneYjVPEIhP0ThBs9ikmsR6SNI1qrAwGPtR+fSqPV6V?=
 =?us-ascii?Q?714luKrTgOxbqxjrscL3JbzvJShWr5SXOeJiExOQB+OrLlRf/lfIkqO0XU60?=
 =?us-ascii?Q?EzGWJC6C8P5p1l7KGj+R1UBJUBhJVbQpTHjFKJJg7te6/KTl87DiF8PoZUDQ?=
 =?us-ascii?Q?uV/4ygG24aPTXL0TUMH2+n+32EAay9kXuuQlMqbxQEfZcma+bIJy7SKjU3S+?=
 =?us-ascii?Q?42ul4f7Giz5zUJ3rVHOdnwoi5/1yo5Bg8h/MucIQf8r4QtrLIlN69+PNldYc?=
 =?us-ascii?Q?5R/C8vWrsYVhb8HEUCcu+TFPvWwtkkePPypEhXCWmSHXC9Z38OPe4dTIwIFb?=
 =?us-ascii?Q?uvgoY8e/bR0h3r+GPjj6Ij8XPiWcLlBdHypqEOvwf+jhxLY01IQqck79hvMv?=
 =?us-ascii?Q?6eyLowaFfsuWkc/ynXKqHAhs3Ie3BcoMVpmlDwhXNm9YV/qVXB9K1PdtfNVl?=
 =?us-ascii?Q?aPp+v9W7B1jvdvYQpmW8WfuGJ1eHRWhX/gYw5C0FoVa3PN2F5jJ1KgDuF0XP?=
 =?us-ascii?Q?nFm8ct4KbMXXiw+tEMFoSnLKIrmzKKY9koyZxlPEUC6iNP0XTDxRjesmRo+U?=
 =?us-ascii?Q?WJ12/6WVhxdpLOwC14A6CL0BJObewfKYVv85Iq2ZOyg2gZ7KwKoi3HVJULOW?=
X-MS-Exchange-AntiSpam-MessageData-1: yPkXy6cnPhC20w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f452e2-9113-4f42-b970-08de7e0f597a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:12.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPbGv2UT6YG9/4O3IeAoCvMko1uJFE6C/7iB7cgTZPsS8hO8Ogm5BhZCDRDBLAhvYY5+iytTTR2DXb67fuw2VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: 917B023F587
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,synopsys.com,linuxfoundation.org,nxp.com,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7032-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,synopsys.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,pengutronix.de:email]
X-Rspamd-Action: no action

The chipidea ci_hdrc_imx driver uses regulator consumer API like
regulator_enable() but does not include <linux/regulator/consumer.h>.

The core USB HCD driver calls invalidate_kernel_vmap_range() and
flush_kernel_vmap_range(), but does not include <linux/highmem.h>.

The DWC3 gadget driver calls:
- device_property_present()
- device_property_count_u8()
- device_property_read_u8_array()
but does not include <linux/property.h>

The dwc3-generic-plat driver uses of_device_get_match_data() but does
not include <linux/of.h>.

In all these cases, the necessary includes were still provided somehow,
directly or indirectly, through <linux/phy/phy.h>. The latter header
wants to drop those includes, so fill in the required headers to avoid
any breakage.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com> # dwc3
---
Cc: Peter Chen <peter.chen@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

v2->v3: none
v1->v2: collect tag
---
 drivers/usb/chipidea/ci_hdrc_imx.c   | 1 +
 drivers/usb/core/hcd.c               | 1 +
 drivers/usb/dwc3/dwc3-generic-plat.c | 1 +
 drivers/usb/dwc3/gadget.c            | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 56d2ba824a0b..0a21d7cc5f5a 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_qos.h>
+#include <linux/regulator/consumer.h>
 
 #include "ci.h"
 #include "ci_hdrc_imx.h"
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index dee842ea6931..7a3261f72463 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>
diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index e846844e0023..2ee1bb9d7199 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/regmap.h>
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0a688904ce8c..d06171af6870 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
-- 
2.43.0


