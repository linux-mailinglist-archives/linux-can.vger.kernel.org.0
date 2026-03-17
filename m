Return-Path: <linux-can+bounces-7120-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFWPApXfuWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7120-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:11:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E61F62B3D4B
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8427A3067DBA
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6E406262;
	Tue, 17 Mar 2026 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P5QiiM0S"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE53FB07B;
	Tue, 17 Mar 2026 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788771; cv=fail; b=Ho0Z29pVyfRZEfyYQG53DPXDCac7uU4ZMAnT4vh7/j/Y2wkAj67ADi3RnvcqFer7fQ54WG5KxSqGDNSJq0yFA4ZmHXLZchl56BQNTbJMuDpjgQO2r96dJDsPyCe9nRaJHMQ1d6yuyKzNZOZWWXxvytA+Tb1sacn0bOZfnQLUKPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788771; c=relaxed/simple;
	bh=Vmai2AjavLjrB9Rdq9Sy6gufoegPLmEKkVUQHvu1PqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LyFqoBSEkeuw7iAaDrx8k5/VrZdpiwRXtksNVL/8xDpYeWsJRei+PCG9mkZaphaH6JIpwuu6WFt3uvOemSK8MwGtkKB6M+UWiDZzTqGK0Kc2oDfw/6jaQ3KxxwJNvlfr4+SeLnw4rzRtJYfz27iq/SHLwFIO+QXBpUNvPaSmVIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P5QiiM0S; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaC2Vzml4VP0tykLwqGp39dczyyH0fPizDRcbWQQ9cO0iDqL3m7ll+j4TBNGFMgkjAwdNMSBeyVi4bl2c/8mH1eSYM/ARhpCJzdtRc6Zkf5KxKovKJ0DCnqy6gVnfTyYYjIC29UhuVGOLbM2OPh2ZyC4MJsAGSb9pxkC4cZtN+UmH7FJq7dD/ndNPj0E8rbtYJPvHbFdKPAe/81mMOrU9svxaQOwtSOE19DZSTRzh+ByJfj/speDbsQBHn1Ekapejgmu9Efh14aCh/HkRKZ2NJWlLEZdoEyQkX534hgYpfUSHkwS+7WceR9PKmI4toYFa+mz6dcC0+oGZCclV8JcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgOUK2cb9U1xh2T9B/M6HgXaPd2kg3L9ntlXQ0KqoUQ=;
 b=nMHeEUzg9J87CvrLwQbnlPOxY4Fz2UTTdLFTrT3A1gLq3hStM66RWST4VV1KJTfedHl9XAP16Ls4p1BoZbrc7Ni7+BKaaA6HbQcMWxl41XCChcFqu0a79dSVIpDLcOrHuUhYhRAi0up7xAdtJnm6iK0WEH8hrvNqILu1emyEgCpDy2VP1jViZ8Rq6zA3mbab7HL0QWp1w0bYEDiSSisO8SZfne0H9NmmRqrSr3ojnt/XTnDMh7Ut5j9eC7whPjrMLELCHWX3HM42RqyVhTz7kvov1ZaX/LGzAJKA9+r6Q2m/9EwPQmB8vYa8XiEE2AWbSn4ppWnbdbYW2OET/3Gr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgOUK2cb9U1xh2T9B/M6HgXaPd2kg3L9ntlXQ0KqoUQ=;
 b=P5QiiM0SA3BNJ6aElixB9ca7JAG8Wnw4JFAvguwVcmVlDFazzIAgzyAly1nUqZ4uApn+WzxSqzsl4c+qVDcyyYOH66CkcOcNUis0Uf0tr+GKnqkWqqZSRyikjySxpJi3z45C6MQ8O3GD/pUIKdRSS/TZLxf1F8pFKv5REHq6eBBNqfiBqoClXipLb1nMRyrMFFq3szxmmkrNk51Vp1ZhfdVgKg+rOlXeJC9KnKLg1xfCl9pbPIli1fkauXKPdQppaZDPugt1di0BuTdOjzXVcKfICVorjI9n2W1Q3oLffupcPlqRZ1mqLsOiF6g/vMbExsUNWqnz9dktmab4GUlZIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:49 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:49 +0000
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
	Linus Walleij <linusw@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 phy-next 19/24] pinctrl: tegra-xusb: include PHY provider header
Date: Wed, 18 Mar 2026 01:04:55 +0200
Message-ID: <20260317230500.2056077-20-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::29) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 28004b77-ece2-4f32-47ae-08de8479bad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HsxDQ+ANiiTBJEGOlBnxvINCykQ+pCX58MRYPwx1QqToZmxcYwQIVjv5B5HtUDQ9Wog0ruYj4RwUCzyGczLhn9WaATEsglw+CnvHJLEpRMVJ6w7NLCLPafR5ch7z0H+A2o3bNZaf9rI1Bv2bq3tb7pJCDQdSlcTIx4vy3TibiqFG9iIMtDHEGw9q+dlkXNrsg4lqj5avkczQIEzu+1L+TSTWPK/q7Q9eo+mtyOH1vWr0iUnVrQbQRrKjod7Wk1Nd3kF/945eksbjQiyIFobHME53DYLwa/q1lylhAU70ZCnIR5aBpeZ0/ZpZwF/iaAssd7jS4kM6VdIPfsGB5qx3Gu+ytzmoLfDJpsTJIiecnV9TMIIz7A71FFESlnMiH9FqrCbqfzGUdTyOtyoky1bodHEPSJXKrC1rr/f4pBpag5D1uPJx6JHJLZiS5y8gyQK7bbhWcvRnFDxBByr8JADZkeWFrkZP+DkWkPFROvfCJmfvKcoUZPXgTGPLxx/GoS3eAGLIeh2xZ3CeNqdJ/GHjAcw0nbcfBCOhVjDwAtFboZm0PMRHwKd99DnLBh/xTYGEbw2ouTcOjY6lQ/LSZZpbCx1ul7dwHh8IiSouNUXUAxNzNNq8AJhCepsIPXCekb9cLZVc6CcgL5aPGq8eGJVIbmIut3JYDeQkR0QAosOO7Btvj9A48HIjf3bPomHwV9kHfo+eKtDJbd6JXnDLs0dblsGB32aN1BotKR1IfGXuMbw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tIUwRt/1wdaxToEfGy0pZkdn3T3X1zvmXhY0YD7oAoAc4Gty4uXN4QqPOInu?=
 =?us-ascii?Q?1pJp0cKwVxJUBPIWKmhzKt2qzPMzfpjGIQ4kr08bzODT9nVax730U/ZbWiY6?=
 =?us-ascii?Q?xhf+pBkQNlc7lplbzGtGc/TdIKp8hUc75FH39kY1xVTqqo0LYKs5aK6Jha9Z?=
 =?us-ascii?Q?dbHlrgB58bRoi3Q6FA1pl49ivoAWHC8JhoM/26Wl0vjFGIIMCeLU/62OLzZ9?=
 =?us-ascii?Q?7c5+QvTzaS/fgl+XNHE2IUqz6K+LVaq9iuxSSZEhVKERqEA3WkHcu/R/IAlO?=
 =?us-ascii?Q?CzZOc5OWiZBF3VfmQIxZVAE+YhzyVx7lM8+3cVhvd02JeMZsI4hJdGS91laq?=
 =?us-ascii?Q?ZWmB0/c3uPXvP+3LrUdpwG8w09PGSceiuBzek+5yWxafjk+1/Bcqzoaow3Li?=
 =?us-ascii?Q?GEblh03b6i+I/YsiSmx/90F5DVFJ9gxULx4W6D1ZHHeH0G/UTW/7zl+IJGlq?=
 =?us-ascii?Q?UChaK99ZCGLL0v+5nmsfBCceV8zmagTQSKIMhn9ladSD9jxM4NITuqN4ZyDT?=
 =?us-ascii?Q?F76YToG0f6BsKu2SkAPmUbzvC/bTzW9qAa8KwL5HnzbQRFPB5jbJ2tMyz7SE?=
 =?us-ascii?Q?uGf6hQVL+t5Sxpvj5ZyTi68wUk4/nbnwVMQsgDq844RgaDOK++4hGLutAIl2?=
 =?us-ascii?Q?v5HZlTLFQpCXaXo3cwwGQBFcEojCI5kttL6AMNRrIl+UbP4P96mC1pUNsQR4?=
 =?us-ascii?Q?womg8OxuCSsVsz6WSVKDUtFCZOm0uTwp1pOuX98cCG+2QQ2SOiscfxhq+cgK?=
 =?us-ascii?Q?v5n2MnPcCEFzjD+LQwUChIEUjMZJFG1WyNDO7zMZOMH4OWNzWaeAVmUDCYtx?=
 =?us-ascii?Q?IlqfDqGhVSgpNHpyo9IYDK5ev1JWTyAWtoayltVzKjFh2IxMkq5NpKdHuRoW?=
 =?us-ascii?Q?q2gT69qARvfcKlgs1PhaRXEKD5WwymzWNUX4rZ+69BvB5JcxsPugdivGGoSV?=
 =?us-ascii?Q?69BXdul9AHqx2j3yBjZcwGBCmhglZT4evnWzldzdotBwuPxaW8A+7Cbb2wHR?=
 =?us-ascii?Q?+Aj3LMCFoSg8r1WcA59t6wL+mXLonui39lFQN2QYYLcAPKp/0DaxRImwagkf?=
 =?us-ascii?Q?19JCxYNOjG1Dgby2uqpraZYeoDpePIevaNHCf13zqyKGm6+l9V24GU1AQuXn?=
 =?us-ascii?Q?IWjkYwNrnRDaq7WgWrPBL0ZRs/0zpe1yIxL0aDuC8YkUcaHvkPPRPKVSgbC2?=
 =?us-ascii?Q?mHQtpSy0IWkvJ4sQEyMDPpM1n4TSSud7LqwqBvgjkMdaoZLoEWkE5+nffC51?=
 =?us-ascii?Q?Iskh3kedMNxrnjXMKIneYM3cu18dXyfFdKdnrHqEPisXmclzr/HBJ6PScy/M?=
 =?us-ascii?Q?9uzpCUybZisd4hbmZ4gh+QrYe/6xqTE71+HK5xO6PrmFS16IV6+yPo1IJICW?=
 =?us-ascii?Q?qYXM/kDgM+PKvlyjWvDGqSf5hGbLWLRHy6PgXwbFcjBONurvuz5f/CMPOb1N?=
 =?us-ascii?Q?J1Pyf4BDX/fF/4LB5qjt9lmlJXPKab/1d14fIg/HjMqpHO71hwsJu4cS/5sg?=
 =?us-ascii?Q?0DTYCQR79qPS5MUA5T426H2mHXLAA+EI9ME5VT26Fwq4Q6/OTGEfD+vGv1px?=
 =?us-ascii?Q?tur9duRu8MulC8QUFHmCbqqAPChNnpQBH+ASQwnpxA+jxixkjBE+TNNCxIq1?=
 =?us-ascii?Q?GATNZ0Xsfiel78ynQwuUTwU/9qWQ5aw4Yb+gPjye/HZpgm+3ZPGaf6BSVBEW?=
 =?us-ascii?Q?jOGHdqWtiLCc+YyGQ8FX5LKgtSk6kGcBGE7hkN1vkuOsiAJO4Lc6yVrEc8MB?=
 =?us-ascii?Q?lDHdwEHAD8CltXx+kitZGitrsmJX7u9vOuCYNlQ6KiPuqfynY7WsMtXHl05A?=
X-MS-Exchange-AntiSpam-MessageData-1: r4nJH7pF3rma2i4wdw0YhNUMlUez3h3DxaA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28004b77-ece2-4f32-47ae-08de8479bad9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:49.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLvz/BJR1vIs98GFjz6OSN1Q2hU8ewzObxdMovrJhvhKXpAJdufckfUlC9EhAJJEytQ3x63eqFKQzZcjb7rY4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,nvidia.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7120-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: E61F62B3D4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The tegra-xusb pinctrl driver is also a PHY provider (calls
devm_phy_create() for PCIe and SATA). However, according to Vinod Koul,
having PHY provider drivers outside of drivers/phy/ is discouraged,
although it would be difficult for me to address a proper movement here.

Include the private provider API header from drivers/phy/, but leave a
FIXME in place. It will have to be moved, eventually.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
Cc: Linus Walleij <linusw@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

v2->v4: none
v1->v2: collect tag
---
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
index c6a51bb21215..6b609bf685c7 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
@@ -7,7 +7,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/seq_file.h>
@@ -19,6 +18,7 @@
 
 #include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
 
+#include "../../phy/phy-provider.h" /* FIXME */
 #include "../core.h"
 #include "../pinctrl-utils.h"
 
-- 
2.43.0


