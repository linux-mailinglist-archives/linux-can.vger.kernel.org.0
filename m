Return-Path: <linux-can+bounces-7171-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLPfDLp5vGkFzQIAu9opvQ
	(envelope-from <linux-can+bounces-7171-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:33:30 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E19532D3167
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3ED4302C281
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8B1407588;
	Thu, 19 Mar 2026 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WDE5qDsN"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87C407567;
	Thu, 19 Mar 2026 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959588; cv=fail; b=NldhHAG/ooPzAjCGwvnrdhd4DCWUciDEdvo8auzRpZ1X/H2600rKmHpmWg6aRKijFhZhP1bAKboE4uqySOakikd8yqxkqhcXfjNAgqZJvNeHKguB9iHVK8xkesguRY7JzmFmSvel2yFbbKUrl0HJ83trQv+jePlRMP56oshkBvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959588; c=relaxed/simple;
	bh=4DOmG32R3SGPIfsRsHDw6qDUZWvc2lump+awYwPpAWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCRZ+BL/3Ur8Ed8J77nqO8Dl9SJmQju5x/ZFWRhIg2gSIG2xXLVGMsjEpnWvluY05G0o9e4uCR4czYm2ksNjdJSHsnekVFpXXe/sJeaObUTX/S+aif1CI+9qBqyuaF2YnrmrYzcx/5xcYiancON9yIMJyOF3wjEIrrvmJwqnJZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WDE5qDsN; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uec+v4g29ja6kbH6j6+Nv9DD10Nly+WeQdklogJncYPAluPfy8eoWPmwafgo2Kr6RRgaoCu4GiGf2T/M5Ws8VheYpyIqZ4PPYmBid0vyehGw+0AXJp7UnHX4cezhGXQSsj8aOLqwoIhDrNfeQxHt549U/gv/rL8wQVblD+LeM9euRylDd+RdkEOXpJwxQU2ZXszdEX8h/v6XqFwhSnWA2g2akJKxUoo/2RZAt9naBNiGe8W0gezjjeRkwczd+CDq9U2TG8kTmD/glOGgx6PeUNAzfvUW8cKrgZv//I10ehbegTTjsgB+b20/HIq2nP72K6VPBN2ryjwK3jhDu/fFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L40Puna/ceJutoKohahciphIwcdOqo9C8TF6ixTMH7U=;
 b=RQmXM+gjllpgXNv/pAni1b6avZjLT2OP8H0q6lUv8KXr5cDn8SeLFEaorFJsKtjHAD5YoYdrIXoXqzm3NOuqpbReIHPirTe4C8elSApTuk2wU1W9jYcawY7NIZs7SzxedlI8icdjumf1TecPhb4gq+7CArQhVK3VPgtEpKCWilvgbYKu0ptXxGF11Qn9PhXlYsBYy9YbXDq9b11N8s2NABmDv29CUUe3MBiNJtc67ZLJ3Yg4GkJLvvP986tKNZKeephKAFiKjeB0HDC/3PbZpVhKQp+/6ONRTD0/evXtt9elHYj8iG++kyYN7/hQbE9qizbj23/C1wFlJd+OaSyvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L40Puna/ceJutoKohahciphIwcdOqo9C8TF6ixTMH7U=;
 b=WDE5qDsNGKnzJhDvZYHNQoKv56qh1HvD5ljZgGb3YhxPt8tr/bvbNlm+YylDK7B2mtQTqZEql/OANhj+pRA3Jylov+g7XKqagdEGT5BW9Ou5KSKIhlosXdXd0jsthR8peh+FX+bTriwNwSPbenmo5vX1AlYkddFi4srqDdX7CTP3Z3mr6+Kuh5vJEKeMEYxDEY9eYfgDc+ctZkQbseo7syzuLkEKXd4RedEvP9Hq7F1uSOlPuSQbe1g9YoS7n6DyhLSzqsf8xf/FpFadYYzfnedP3d9ot6Vx8IISpek7mHyIwoc7FyjCurMBDZK8CO+rB51zBcMpyigCC77FiyGCaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:32:46 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:32:44 +0000
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
Subject: [PATCH v5 phy-next 03/27] usb: add missing headers transitively included by <linux/phy/phy.h>
Date: Fri, 20 Mar 2026 00:32:17 +0200
Message-ID: <20260319223241.1351137-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c942184-51af-4b92-3d97-08de86077080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qqaX0YBQDfnXceMnn4qX/sok8BMOkhBBIdjVbuN9HCIJtuKUDbBswZsXWma08vmmEkv2ePRm8gfqlZ/R7OipgWyPeURPdqirVTEkweUcqRbqykAOTc12jCJSBFh+OW6wUyeP5BIhn+lSt4iCFUHcy5Hl+6NOmM7OhtBCRsxgw2X5abotR+LwzHiTo40hiQ8BKsPCo8OgFzRiQ8YbpqYH+rRWubTqM2PSza9UHQ9Sk3JYj/b180/UYURouswB3sETjGcUxr5kXpN1is7dyJmbD9HX9RtnIdm0Q/xbtJiW4Hthwr0/S5COtAUafRVQUZPjgj0H46M+YoZ158Ld920yCA77ZsGOw6T6yldA3xWe9KlWF9YWi94pvpd8waGSGc0kr/aFp99D967GUoejwIbeDK1WGdo08ozlMUlFb498/mel/3wxN73y3f22hzFIVdoaCoa/rU+o5ahrfcFulrTZ30Dfyx0Hc6tGFIDNkwMhND4d3Ro7oAKaYwYscgpUB/b2g/vKBko05FSWIhOEcl1izmK7mpbC0Ez3j258J1bSqPSKQA+/jiTph8D33G2uRst1hhIaHQyT5GGBUe4cgCLBKCjEGIcv/9E2sb1jdmHTDOazmjekCDfoA6n7C43U8KlE97wELoHmhJvztJF/fkPM2FCnlgfsUFWPx90e7OUFal2Hnd5gX22IM7CP0g8SLjNfXEUbNexkdzYWvLfXgU91DVdDJiSSQucWtPhTI+V89f8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H6wRN3nXdWY9RLX/xvaoNibMBOmq68uLP5KK5kPHWQq6nWJqweBj4Ix8VOO4?=
 =?us-ascii?Q?4AhsxylhtfvHH593sG2rXF9HDGqbznL1iBLDDAnPfuiE/5BpyARwSVSeb9JF?=
 =?us-ascii?Q?PVsYBLVzDjiKzsb9e+VwgOtOcviOEmLXjkxNOMIy2pUnw7FyBkoLB2gXEBeW?=
 =?us-ascii?Q?PC0jlmp/CZJda/Z5pyzsnl/eWi2z+qfpcUCCFrJpwRII5cGu3DHg5ohXiqtD?=
 =?us-ascii?Q?ah9loK2DX6SvhxlbfPHaRJCCjIKqZ1/MvlASXkAZt7IOltrCsOjJZRP9TF+N?=
 =?us-ascii?Q?Zjd0QgvIFyN3nxDein+chloVkh+Dy+GEG8QCwveSbwKjb+9i4IcqLu+9XoeB?=
 =?us-ascii?Q?keUqy8pyXBRYsy9bfISfTSi88jV/IMmju3t0v8XpvDomejFh3Yawk6HnitPz?=
 =?us-ascii?Q?o7cLApaEQFiqGGaXVvx947Dj+x3QVgIOl+B7pXeYujhyYK3TB6BOjb5f/BLz?=
 =?us-ascii?Q?qb5cvI18E/z4UdLg6SMiGeBSebrKUWxBp4bVGBJ0Surr+833c78utD2qua09?=
 =?us-ascii?Q?DZuXoipIe4mEjVvis+lwemIlni5cdBYmabjE1vefjySkYUmmsJr2EPbVMKOq?=
 =?us-ascii?Q?/8wOAnyTN8Mae6IfGFso1BUUuU2joUKAba1RNd/xH99kfNa7DAWEEpW7/MK3?=
 =?us-ascii?Q?OX9K9Rmxn8+1NOX7+PgavmHlzEeUjAfBwhUUv2i3FIZ4vJ+RkwIqE/XAePzN?=
 =?us-ascii?Q?VJpDIh0Z6fkyr3l/gsZUmQ272i+PlBQVIFZLw+2Xp0M9TOMZ/W9q/17o+lFK?=
 =?us-ascii?Q?BW20E5SjNpaoxY+nPOYa7k1DzVMwRjMV/0+1TI0fB3HX4DmOkeUT0AvyEE30?=
 =?us-ascii?Q?CjhzfOSCTDr4zYG0s3MBb2FbHksHj7eERGiPdyssJj22HtU4LtOvZxSKbUTb?=
 =?us-ascii?Q?zzXzKNMDQj1gFAfppaKvCP5BtInbYR+M8uQMtfHRJVN7bFYTKYPtIc4RFb2R?=
 =?us-ascii?Q?zE+IK5h9GKs19Ig/7yyQmgjYcER0GmbQL8Y0aq7nYA7z9xI0dYqFLUBct8OL?=
 =?us-ascii?Q?ESeellYoSsYCfCxFqc8UV85EwLg69YPuJbOzp9HMRMD5nl5uYi4ItNCC2WSg?=
 =?us-ascii?Q?Jub7gRvi75qSeYA1MOQtWZho5AeE4wQqNgCloe8FphqKhxxWEl10UPff2Y02?=
 =?us-ascii?Q?6zMqf78Q3pkN5ufszRQdPncHF0dlnTHJISoeljaNBtshxuuczTkg2sfcAia4?=
 =?us-ascii?Q?SrTHseH1Wxo0t2lOh0K2GktXHueT6By+ofy9sYInTKIUEq7D+koS8kR8BsUm?=
 =?us-ascii?Q?m4iej4qkuo3CfCuyDNKK5B/lKM49SOinEwy8u+WsI3+4cZg42p7I8pAvj1A4?=
 =?us-ascii?Q?U9MiXTFgi5gK9XsA2qJD4OZXuGfLT1uYOGWVgIi5jlCNGX1+NvioZkd4yQWv?=
 =?us-ascii?Q?HPT0rm7EwbVuLfMpl2i86y28beOynsd/9EzBuVRiCViiAEIrSKey06OaexjG?=
 =?us-ascii?Q?r8ADefCMwOmuLCaaz48ctXTu9AkK4i3IWrlZKrbkXtti52NXrZttn81uJB45?=
 =?us-ascii?Q?tf46ROEG+suQbqAuej/iorvk2iJqDhzVVGrbul1ohszzOphwLrv0vf7UbZxS?=
 =?us-ascii?Q?7RDE5mPOX6SdmEUxDlHge3ZxCwar3unZyFqKICNEOYMzVlFNVjGnEkU88o+5?=
 =?us-ascii?Q?tjYVFhxvov8Az41+lglGaNEx0d3Qs6y5ir78s9rA40wS3nQ3oH2t8MxGQYAz?=
 =?us-ascii?Q?cgD0Onxb/TI+xKbnYrsvphQugKPQWMReT/BmsZ4ptLjVBPRifdJvfZUYNoaz?=
 =?us-ascii?Q?rxCQsGXqhx5mgXoH9jPXSLyNawDHLbjdbmuhu8jvlOz6yOMgWQbQjXQ3R+tT?=
X-MS-Exchange-AntiSpam-MessageData-1: 2zZtkRHdWp32IDpIXapVJLpi6jkQCiL34Wk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c942184-51af-4b92-3d97-08de86077080
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:32:44.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4lRCFw1V/f01LMDQ5ICN1OE4KbTbsxC1VmfiYo0j0LqTNcz6b2Dh3u3hFBHCocRspabMAqAf7kyFAZ3AS/DhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,synopsys.com,linuxfoundation.org,nxp.com,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7171-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.985];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,synopsys.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: E19532D3167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v2->v5: none
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


