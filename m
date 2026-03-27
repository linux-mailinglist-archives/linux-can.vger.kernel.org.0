Return-Path: <linux-can+bounces-7278-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF/iJzzTxmlzPAUAu9opvQ
	(envelope-from <linux-can+bounces-7278-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:58:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7A8349830
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F12A230B68FF
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954CF39D6C9;
	Fri, 27 Mar 2026 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lTv9BMyg"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24DE396B9B;
	Fri, 27 Mar 2026 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637348; cv=fail; b=B/+t4bxB/548zOTBBLzuWFSJyubEbbwR2poByHDYjo6h4/22MLqi3sHYXg7mAEOCXk3vj7qjSe6aSuAYKmdVSwppEboL+8QpGAIQRM6x4UOLGKAcrRJs5sUBrIladpXv2cMR+5HqT7viqq9BFXr2bvEWAT5OObCcQeTm1tcO3CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637348; c=relaxed/simple;
	bh=yWu7uuuHULUSp+20Dei2NjEcFIGY5BDwgOfeZTWCHD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igeQb4A31lNQ4u9IbtPZGaupAzNJYQLECvsOKLeGCPWHxjV6fv/o2PI76QaDxajnRJAcqSj78y2m7XrP1irAkraW77lxkGGzO9s1w0H2s6oX77hhwNU3V+6lc8ZmGaUgf9d8G7kkewUiuEz67DqBXSkS0uJJwn5rubMEhOTPpsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lTv9BMyg; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAP+RmPi+8qLYYmEfqhFdiAnAbiPfKeOHinikM/+lDkY0/E8tOMdogB7z4ae+/kI+3fmnoW7kjzHIP0kJNr+wW+EEszgEX6HhigPd3k4aF558N+RkqeIZoB+d1dq+Aqd6oy2l4rxvhZblT0TTzkdnh8aXtxtHjNA1sFUhDsVpdaIVX6XgOBwd//ik4ppMBr45GcEhf5bhvNUA7HF63I4nT1XdAI5VpXMhI8eYVseQnlefxEr8j8yR0QtqVicQ3HxarnPEDConuOmTgzFAS6aTxWs7tOuBZ9hA6iKYIyp/sLpqnoYHWbXvQyktC4shX9mEEItvGKVrHoWbhbMqtNlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJHQIdxatGSBOKq1fCo05grOTfGAB4Wg90ZlPx2X9IM=;
 b=Ivk1Vj7mBJAdhAjp9oA7WPvUL0k+LeByOlDfDTi6PDm73XyB2qqdOz0IvVJqyeQ7lpthD5U/XIPIRfqH00em7c6DRS/y6yBRWCz0GUmFO3l5VNIfux0V+xJVvsL8E67Zn0E84A/k/bkalAv74tL3jDFudLKKlMIZNcv17+uz8eWSJ5M7FVDA2OyEzyr1kOaA8kSlnS2AASnRTBsCicuDiryo9/L1Zkf7Bctm4M21+k/Qb8RLPbvGFB7e/GBs+M+HC42YK1TMT100Y89jsgxA2aOTejD9UTkQeAKFtQH+3Jp8V+x3szGE/ML+dSJfMrE3ZM8M5vGll4qybuevQwn98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJHQIdxatGSBOKq1fCo05grOTfGAB4Wg90ZlPx2X9IM=;
 b=lTv9BMygZZaB762kAs5DcQdsvGaPV5uKA3B0VwwNh1X9X5ocJUfpoa++G+9saTLIU+QN9Cgg9CGA3+y7rXQwXciYJaqtY4usq6pAWB95nS9z0hmoOlx7zsppPh6+bWeXL1yEP3MS/gmXz6WkMyIlJLWq49/rk1B+OSlmBj2ARDjRc6y0wM/FBAvoVGhLuHQ0YIeIzwTUjUuYQ2Hmh+eKmS+3iZcfmT9jW3BF5SajmAmr/ZVH/wFHEtxghfHkElgRgjMWvdayZ0/5M9FhlraWpJAdP9cIReJfugYrV8kHR3p/3uvZYVt/fNKUZjptOjJnKwyFIAngRvpCNTJg/dWnuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:49:01 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:49:00 +0000
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	JC Kuo <jckuo@nvidia.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v6 phy-next 13/28] usb: host: tegra: avoid direct dereference of phy->dev.of_node
Date: Fri, 27 Mar 2026 20:46:51 +0200
Message-ID: <20260327184706.1600329-14-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI6PEPF0000022D.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8e7) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bb4a42-f2cc-41b2-105b-08de8c3182bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xY1l7aFTeNUm7FNH9tDLJygXQPn4VZ2bLR96AaSj4B6kfsQA6Tk/v1/MlqeRe0MYb+H9NMbc0byBHwUaNc1pPXL0QmGlT6vhE9chhdO4dbYzmFyU38OKlJSsxtkFksX/vGDuu+w0yeyCZUhsEq/+jq1ZY/0oO/wrXuEn/hJlYHCNUCufqvT0xKe4eN141zXEm5+37kH8+fD+S/k9dnZaqn/zvPA6CA/oF3g8E8c/+O8k/0AkSDQu6U6YfM8mRPmmtmE3/VBP++IoNPJMma7HxyDpBwqe1T1seb77qN2O+wn2owYkXSXTTUrhiM37NHbRKFAGk7Fm04nuF1J+WoGTcTXxZ9zKL2DJw8yiW5jcnALpDOXZhnx/JPIYm970KwHIpGuZvl4uWoW4wPi+nB2TzR3DjrJINVNRi3hB+LeuoTMwGNRuNYGjFS2ebc+fQDyqawUfqxtsAM/yuur2P+Re/N45tNt2Q49GALCCLQONn+gEcYJkPJ+1wcAg81tOdR1Zohq8BdH64a8ifNTY6rf+Qn5K9SFdmtvfCSXdRu37fq1OrHxPQ4l0b0fZgPhWcjkaodjkdfNPV9JyyiRrW9AC4uRntKr3jQc1vfLqBo9C5qP9KQwGYsQqNm3g+CT/E4iZGIcgDPBYEcFZWFjGQ6QiMGOZ6SAFIxIieq/yDOzsi30+fcDbbzYHs/UY+ZyGR2ezX98ObR9BHIoejixiFEAN5JbU45dbOd08pTWraMgAcig=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3kuVTH5isJjtXFcjLfHmUPHZVYTJwe0pdRhYSCLbJLoF8eHWx2xjGcih42l6?=
 =?us-ascii?Q?IXUSivaw1PXH6wPwb1gIxIIanvrKSkXpFRdoRk5qm5ZXGvX0JOoaX64ZZ/ph?=
 =?us-ascii?Q?dW1wGBb/5h3eAGXO8bgorJnSA2AxacH+MquXXb0PWlPo8PowOxRrknq224ok?=
 =?us-ascii?Q?ZChuPShV23YIXmTKSIlffzAJF5I8ejr8Ax6U2Ax20VHWBQnUN+vHKJYUP8xH?=
 =?us-ascii?Q?8FA4dlllNDVLb8vaW1U5s5b3o9DFbKM9Lw2zpa0mFQQnX1d3EqZwhpG1neED?=
 =?us-ascii?Q?LWe8fX0m+ybmNwRer/0Uww2c6BBYFh0+c64zMWYGwiU3O2DnKnBHf5q6tk8O?=
 =?us-ascii?Q?QPBHqlVPDT42eMOi70JYVyZ/1WBVtkbl+c0aWmWaLXxjXasxUDRoEfMxUXnw?=
 =?us-ascii?Q?hkU1LqAV8XeyXhsZ5db+0HYBYmKaw2RvFA3BlL87XpBJoW9CHCv8IE0qN45Z?=
 =?us-ascii?Q?eaFF0UwY3PY/MDBSxy00evxfDXSxkz06O2y7jg+57h82ot5BCI9msGgGf3O8?=
 =?us-ascii?Q?FAkmNdWjHkvAUCEv5aS/vIcrDfs3jw5gWBtxFfY6KeXdJORb0hV3Z2JJ8trX?=
 =?us-ascii?Q?mmHq4PWdrhH4/O5zCPX7TnpD68ut6XKe4JMVjvvom/y6zTLdLCmBVfcOPP8/?=
 =?us-ascii?Q?1gJGEIakvJrrSCaw9zOdd/o0qX1C9JHYsP2OhtaFBxDpJ5JNjng/84KOnqPO?=
 =?us-ascii?Q?48J3DhkP/zF3Fip2tTQZOdBIzSrxuwVoweSv6OFLvPpCm71FupAcxWr7bqRp?=
 =?us-ascii?Q?3NE1LbBecy+SoRpoiZKT3IzjQr27sADXX8j1/BMZEr+3hw52MgBozVHxNcfq?=
 =?us-ascii?Q?WwtwG0+BsouzWge440kOTKlnubq7QDvdJMjpNqmEaHFoEOisXUVeVHwjBHLG?=
 =?us-ascii?Q?qIuOrIfWrd5xJPH/BGQLFgjwt3+D5wrSKlNNwVfV81giBlPIGI07A+JQPxGX?=
 =?us-ascii?Q?/NDlENru9gHG6Hb+rU2Mzsjz57HK//3T4sCvk81Dy6FwGL13vuh5qKYTi2P6?=
 =?us-ascii?Q?WEK0KunJFdnUKQ2RajS02DSGcTzfxyK60zJYRseSsLdxVhU+HvKy8wE9HkrQ?=
 =?us-ascii?Q?DdzUwVZUWB99svPtpD181nY9et0fki/3aGuoSvY5YJVXs9EfafHtIzNC/88t?=
 =?us-ascii?Q?UPecvon1D8eIKOKtd2EYNMNbG1uYOxZl1W6w0afurrw5deWTfECe6DVHFqIb?=
 =?us-ascii?Q?5agdkZjcrzLwohTSnTC4xYQxt40P9BvdE9KWioqwSL/KazDqQODoYBJ46lbV?=
 =?us-ascii?Q?KAvTDn/5XPaDmdqwbh0TumLTW4+jcgkMlXeG24bmaMIunRttX3HkyyJuVejF?=
 =?us-ascii?Q?hD34LbxTLYeMhWVkxdQBVHCyiDxQo9LsMDhudLOtQaTACb/pH8f5NP5SF4HL?=
 =?us-ascii?Q?U0ztVnU3PEuQWSGj5FlWuWk72NXGu5UAK74cm4RODOIkJBUML6eyS8F5DJmI?=
 =?us-ascii?Q?HmTA0N/BoPCqM+Bif5qSjx8rW3QPoJLUBNd/M1Af0pVeP9EiribIEHCVDpZL?=
 =?us-ascii?Q?JjTYWW1BC+cHRt4inhkvW2qouk/CMyhHrhD7PJPEt+pdxbuPME9j5/7MB2Tn?=
 =?us-ascii?Q?zI8zEsbn+iuIpoWVxhhKxF7kpDRZ5d8mXJaYiGpOBV+MT8O+80CMlt1w3Kga?=
 =?us-ascii?Q?OLpR5A1/iojyiqHGQI7wMgIDQ5mqSVLKZF3mbl7btpPZR1W90mdYEES7Pvro?=
 =?us-ascii?Q?k2qtJabp8L1USkSHa3+IG0ZhnHlTvGrZ/JVAPM+sXP9HdgV9eGP/2YpPhTs4?=
 =?us-ascii?Q?OFWfMaMwUJmq1V2QIJbdXnXp5Hm6Iezp18/EJbub0/7g9WjuwJZg1PglVfHe?=
X-MS-Exchange-AntiSpam-MessageData-1: ROMaaScYYHgBAsZW9q3mwm6eTzy+XK3/iAY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bb4a42-f2cc-41b2-105b-08de8c3182bb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:49:00.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6W2X22ZCBkBcPzVVWy6sr4wwLQeAQ+NSrZJT7tcOv/BRPDGGvDFuY7HTi2S5JcgDppHcFE9sCgw03mZNAZpgA==
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
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,linuxfoundation.org,nvidia.com,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7278-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,linaro];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 2E7A8349830
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A piece of context which seems relevant here is that the USB subsystem
is transitioning from struct usb_phy to struct phy (belonging to the
Generic PHY subsystem). Commit 1a229d8690a0 ("Revert "usb: phy: add usb
phy notify port status API"") seems to confirm that this is the case.

In the transition process, some PHY provider drivers register themselves
as both Generic PHY and USB PHY in an attempt to bridge the API gap.
Such is the case with drivers/phy/tegra/xusb.c, accessed here by the
Tegra USB host driver. This USB host expects the PHY device behind the
Generic PHY to also be a USB PHY, and calls
devm_usb_get_phy_by_node(phy->dev.of_node).

The Generic PHY exposes no API to get the OF node from a PHY device, so
the Tegra USB host driver gets it directly. However, "struct phy" will
be made an opaque pointer, to avoid misuse, so this will no longer be
possible.

Considering the fact that the Generic PHY/USB PHY duality is a
transitional state, I am deliberately not planning to make the life of
this driver any easier by providing a helper to get to the OF node
somehow. Instead, implement a parallel lookup path through which the
Tegra USB host driver can continue to get to the OF node provided by the
padctl component, using the 'phys' phandle.

Secondly (minor issue) the driver uses the phy->dev.of_node again to
print using dev_dbg() that a "remote wake" was detected. Just print the
index at which the PHY appears inside the driver's tegra->phys[] array
instead.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: JC Kuo <jckuo@nvidia.com>
Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>

v5->v6: none
v4->v5: patch is new
---
 drivers/usb/host/xhci-tegra.c | 42 ++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 3f6aa2440b05..46fee219e09a 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1495,6 +1495,7 @@ static int tegra_xhci_id_notify(struct notifier_block *nb,
 
 static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
 {
+	struct device_node *np = dev_of_node(tegra->dev);
 	unsigned int i;
 
 	tegra->usbphy = devm_kcalloc(tegra->dev, tegra->num_usb_phys,
@@ -1508,23 +1509,33 @@ static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
 	tegra->otg_usb3_port = -EINVAL;
 
 	for (i = 0; i < tegra->num_usb_phys; i++) {
-		struct phy *phy = tegra_xusb_get_phy(tegra, "usb2", i);
+		struct of_phandle_args args;
+		struct usb_phy *usbphy;
+		int index, err;
+		char prop[8];
 
-		if (!phy)
+		snprintf(prop, sizeof(prop), "usb2-%d", i);
+
+		/*
+		 * usb-phy is optional, continue if it's not available.
+		 */
+		index = of_property_match_string(np, "phy-names", prop);
+		if (index < 0)
 			continue;
 
-		tegra->usbphy[i] = devm_usb_get_phy_by_node(tegra->dev,
-							phy->dev.of_node,
-							&tegra->id_nb);
-		if (!IS_ERR(tegra->usbphy[i])) {
-			dev_dbg(tegra->dev, "usbphy-%d registered", i);
-			otg_set_host(tegra->usbphy[i]->otg, &tegra->hcd->self);
-		} else {
-			/*
-			 * usb-phy is optional, continue if its not available.
-			 */
-			tegra->usbphy[i] = NULL;
-		}
+		err = of_parse_phandle_with_args(np, "phys", "#phy-cells",
+						 index, &args);
+		if (err)
+			continue;
+
+		usbphy = devm_usb_get_phy_by_node(tegra->dev, args.np,
+						  &tegra->id_nb);
+		if (IS_ERR(usbphy))
+			continue;
+
+		tegra->usbphy[i] = usbphy;
+		dev_dbg(tegra->dev, "usbphy-%d registered", i);
+		otg_set_host(tegra->usbphy[i]->otg, &tegra->hcd->self);
 	}
 
 	return 0;
@@ -2172,8 +2183,7 @@ static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
 			continue;
 
 		if (tegra_xusb_padctl_remote_wake_detected(padctl, tegra->phys[i]))
-			dev_dbg(tegra->dev, "%pOF remote wake detected\n",
-				tegra->phys[i]->dev.of_node);
+			dev_dbg(tegra->dev, "PHY %d remote wake detected\n", i);
 
 		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);
 	}
-- 
2.43.0


