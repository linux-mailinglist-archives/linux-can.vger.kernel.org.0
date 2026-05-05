Return-Path: <linux-can+bounces-7496-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLOIGLHE+Wk0DgMAu9opvQ
	(envelope-from <linux-can+bounces-7496-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:21:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0864CAFEF
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B0A2317E44C
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C33DD520;
	Tue,  5 May 2026 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mMgKLDWz"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FAB3AD51F;
	Tue,  5 May 2026 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975559; cv=fail; b=ed1nLuToTiy4zquX0qsCv42Puy2ag1SbBfDK5BinjXyFJUFunliAxlsMlDEZr0DBYL6ETAF7CRzPE3bR4thXE+dt//q0eI++V7Aaa0dFtjWnNW5rh7AbjuP10IdqSr59pYM0b42qa/2MdL5Xl/dnH9gyP9uQciIG4cV4TlXjPE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975559; c=relaxed/simple;
	bh=DgppikFdyCFKydiGpdOZhH27z4jvUAg5nQc7w1LCdOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FD4qJLaeyAaECertEZRi06Kgjn5kHs0i8c+IdToo1JuXoBFKSdBXYOZCU0FTTcAegbZYfx4xObWiFNJ2ajFHJAtdBPeMhN2afN8k9vfh1/WCI9h5xw5ec1hxbiOkRmgd2zBMpj2kz7d3W1Magw8PaPBSeLfizXXeeajTwKET8OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mMgKLDWz; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7S25zatMGCEgh/gWmhexvPX3iKNDGsi+0V6VMHhHU9S0fJtlxjn15acCm3XjQs+lOFKU04UY8dliS4R/O9JjKUyOKCLldkC8NmFeEYdJXrlFp/9icTVgTwIXPK03ubgGyfd22KTjp8JkyITVjMUIAF3Dmg+HXNZkU6G2qDYIAldZo5S9UPusxYWnD/VgcV/S5nSag7+2ztHFvaoPzzifllnJg67/szLjCMKo+ZsQDFN4YNz8vzdPfOXUMMuDToUSy1E1VQKk8WKoPNbMEAZMKpc54z2B0SZjTYqe+nhY0BGwy1oyKRI63/ZLMmtZrp54nnYySV1onmoCP3F1Fnr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCFHOnX/ZGDdXXvAOElb1G1nILlamVmVubz0RaCKpcE=;
 b=vrfj8CcKo+YaBGcNwzzt3Y5baP0WEQm7+Xfa4Yltz/vCJvlktaTWPZjN9L8KhUR+8RuhqaiRVfb79ejN5erS9H06i+qqiPJmUeWpluCzzApOkqUvVL0Yh2o61wvR6jOA10ASR2f6NrcXbjZeTQ5DIojyZW/VkdbDmuh+xpZhxO7gBs8QJW5OebaRxXe/Vd4UzzcOTcxdJKn9LJ4KazKqC8ON6emZOVAFL2V6lOdSUT1aQLgpyHSQmGQ4rZSpzAng5baK4xDJ3H3VpxBvsApQ05JTdUbDrwaqMJd2vsduk7zmsv1PJlzckayj608IM12oUbhfpV5KTYhHufDRqegT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCFHOnX/ZGDdXXvAOElb1G1nILlamVmVubz0RaCKpcE=;
 b=mMgKLDWzBeLKakA0I6ziPopzaJ9H77Pfm8CZKlWMJoxXzEW0ewxegctrlHVTEdq+Q8Jq+7f1kxSyG8eLAuJ5nOn/v1UWgzwnnlrBMJZkNpzFa7UkyA6cB8ZjDVPv1WmQ9WilvMZEcs6/alxaE0aQk7GhNG89djZrl9jE+nD4Fwf27s2ICBYiKqg7aHQjDeTfBYmuoUaKhYTGAupc6590MK/t5vk3Nsp+JeP5jJitm923YI31AnByBjbPBp/1HKiMCJDbVcypveQb4SVHzDvhOowEvk6PnqA01p9Y9rhaah1qJsYTlahwxWAXZ5TUyUc3H19nBv4vuKpoKGIzlG6gPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:05:49 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:49 +0000
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
	Yixun Lan <dlan@kernel.org>
Subject: [PATCH v8 phy-next 07/31] phy: spacemit: include missing <linux/phy/phy.h>
Date: Tue,  5 May 2026 13:04:59 +0300
Message-Id: <20260505100523.1922388-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 1132fc51-52af-41f4-c2c9-08deaa8de1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RrQcOmDgQRyzQeRzDOUlWoBQzbub6z/kpR1Fa3+qfgSpn7UkqhAzD4Ly3ANg/JwANKkP7KrfGrO8Li6cYW/vZv/9l47wUzoZwxRdfb0Ve/ae/mXcH7BrEJU4X2f8AaB6ozNs4rEeag8xn9OF+ld68nrmNo44JhV6dC2uNO/9Zr6EuN3vpw7wgzbQ8hufEf9eds5yhSM8FtDn5XeZXP/OUyhC+M0M2KBuhaep/KIzXKx70EyDeyN2dZyQyYL65ZaRvEUMCB28WtWTorBA8eNL8wbodU3alLwSnHtNBfMazpUlT4CRvU2GB258gUET8Jz+hooM85Whcd5psaR6jCubbq3+fw/bQS96IkaoOolnjSwZVezowcLqMCwkvfRcmIHao4ppWJT4KLPHoOuI24RxIXl7S34HqXfP3FEoWeLvlx596RptukIincDXxSGGDzxsV24TKbcilFubzOyYeyNBlBmrNkqg6CauBQxcCD39oX5ebqsO0DRMYYbRVQt/K/vjBEkff67aqz5R5GVF4JaBQ0zdwEJ5UseexVmE1kylweD375i9r/MDpwwgD9+V3ShOUitjifytNpo46PVlRIauSpEuLqfOSgAVymKOoIBdUY2Re23wDySEHRGGdHUY6LkAogMHMH65CaUNUBQjaUHO/FKqlsaz52kzgjU077/qpxRIBJeLgEXx8vd2kSrGn5HH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z+O7MOiiDAfkzZ6UUgKl9QgZMc5V9+tqL/u3JOMDI+7u8Z2gJ/n4f8KG/S3t?=
 =?us-ascii?Q?370HgJ5cY/IIG8sFjXLFv7qQPCT2KTwDPvEHCT85zLsCa1I1KgLT6jt34RQ3?=
 =?us-ascii?Q?307fpih1BIB1IpMULeA0Np5SfOHAgG2ilIrX9qAEN9f3VXM5xLT0hru0Wh3I?=
 =?us-ascii?Q?zKSbJYV5C4EoGUIt48IokXV9FE1wiQHnfMSmAfZhHEqKGh3AUVT+Gce695/M?=
 =?us-ascii?Q?+r0okBXC9ObGQm/yj8G/6lU/MJM8DunziHHs7BaY/qdDHuzleT2B42O6QhZT?=
 =?us-ascii?Q?TVq5BsuH4oA5TJ1T+flooMFxMfcsk+qmXjQJjawdpdMH1uRInY2sKvSROhb1?=
 =?us-ascii?Q?gVgRm1MV2qYbWVj3pwr9VYHsrTUWuHDmPrzmQMkeT2TCaP4ABEEqyILsJ9Lc?=
 =?us-ascii?Q?2GxVIbKlsWHSZrfYD8hZB4LhTB9QHcc1j55357qBKu05XH7Y4C2qgGni57CU?=
 =?us-ascii?Q?d/bwq9ZrKOWvEfxTO7KB1CffywMbk5KdaZqksiaQCPn0IJ8b0EBKshDnyXgx?=
 =?us-ascii?Q?Fg4dcG4F6ZS+XZJW82NyX3/0/ASJ3Rm7elJFfpZO/Q3/BQAp0zxoQIocpM4Q?=
 =?us-ascii?Q?+fNgf41eAeLl0TXMcqzK+YGFPKYA1JrvTtX9ucNS3CCMD7ip+6hCwr+YXJga?=
 =?us-ascii?Q?hUYPDLLFOdWtu7rtUjmOgym0aFGebWGHeNz3veaJZgTqKauSwVxUaueHyYql?=
 =?us-ascii?Q?EFDzbnQclCCmYG8g8RnnC+SzWog2Dtm8kq8Wyr/oLTFz6H/EIZBZGhJefdUZ?=
 =?us-ascii?Q?uHjb0st8zJsLPBNM/Xi2sWT8mbWWzcZypyyCAmeBh9CJAeQVNWOUMxZQKACA?=
 =?us-ascii?Q?QvP1K2BeHWht25rmLapCR8wTFwiOOOZcfGsubgUYUttdcmrXjJ8by0QL5Iqs?=
 =?us-ascii?Q?RD0vApJBEn0unCP4Ssb5lDv2OtxNfEl+ZGy0SA6e4MnwMEZslGorV6kpYhcf?=
 =?us-ascii?Q?koKNl/lwmVzFmHkckVjRvFI3/ayJgnYvY71BmLqOGUFdWUvgPzJhE37FjPED?=
 =?us-ascii?Q?syRzp/KzMtiZIipIO4+zZapjvIY+TZKyMGFXhaU8Snj2Zus6PJhtqMPnPRI9?=
 =?us-ascii?Q?466M7lA5Aeg6LxAEwrMWZZ/+PskAoysqY9Dv8Ngac/zJNSKnqmSFhS97yMtx?=
 =?us-ascii?Q?79MFj4nB3oez+V7rWPO0oQw683QdDWNrU9XdmJsWfjuQVytHC3K947HSx378?=
 =?us-ascii?Q?CXKIrnvsoNomTWMTrjGjDSLjPhfPIY9ID2eYQ9k2maputtNY76wxti285hSz?=
 =?us-ascii?Q?ujm+sI28M9LOTrVtSa5OpIdW73rDfDViwag1ZprcgWpsqkR554lU43a/S3o0?=
 =?us-ascii?Q?NsgiT5IqcYmoy5eyE7fo8JJEdOAMLtWaXh7ZmR0M1W7tmLjWdwIZ7Dwl7+Ux?=
 =?us-ascii?Q?4WpEiZqfYtjY7Xb64HWkfQikvjh7iI+OH5kVylAtRzEpXllk/KZyBT6aUMoI?=
 =?us-ascii?Q?I5BSRe5YhwjPf9CSXC+ut2lmVsD7w6ExPC98D3Sv3WjedZyD3iXabGhvEeZM?=
 =?us-ascii?Q?flNfDT3Cij5fqekot4iqucfYxPPGbVJJ7ZYnAj2CyFZIR0v3yLwJyixGUqZV?=
 =?us-ascii?Q?661G4v96QfV9Khfz6gTnUR+2sKDg0ULFWjREhzmHEU3iVFK/Z9Puma5d3QK5?=
 =?us-ascii?Q?R7rLPZ5IKju4uGubahcHKcl1eGbKlmZgkWaicOp/AR/O1ZPi+DIq+NpGKFWE?=
 =?us-ascii?Q?RM3JEFaUkBwz/ySjKqWCqN7hVAFLTwYsDCa3VlAzg4F3qzBPkIS4duGiISvX?=
 =?us-ascii?Q?ITCVx+ynOQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1132fc51-52af-41f4-c2c9-08deaa8de1d7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:49.1486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asK/20NMOsXsO3zI3Xbs86uNcrBHFGxOK/DRYIvrN9jab0SFRvkbDptwLQYZKpYnQSw5paI4w/8X/sn+CyRbsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: DE0864CAFEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7496-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

This driver relies on a transitive inclusion of the PHY API header
through the USB headers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Yixun Lan <dlan@kernel.org>
---
Cc: Yixun Lan <dlan@kernel.org>

v5->v8: none
v4->v5: collect tag
v1->v4: none
---
 drivers/phy/spacemit/phy-k1-usb2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/spacemit/phy-k1-usb2.c b/drivers/phy/spacemit/phy-k1-usb2.c
index 9215d0b223b2..01af310d6683 100644
--- a/drivers/phy/spacemit/phy-k1-usb2.c
+++ b/drivers/phy/spacemit/phy-k1-usb2.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/iopoll.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/usb/of.h>
-- 
2.34.1


