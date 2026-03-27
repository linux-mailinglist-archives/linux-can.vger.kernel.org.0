Return-Path: <linux-can+bounces-7292-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p1bfEmfXxmkoPQUAu9opvQ
	(envelope-from <linux-can+bounces-7292-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:15:51 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D922D349FD5
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3CEF30F57D1
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14926426681;
	Fri, 27 Mar 2026 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vf4Mbm3d"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A37425CD4;
	Fri, 27 Mar 2026 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637381; cv=fail; b=GFlqyV8DlN2Tf5qO8KN+5BRN4h40FU277EiP3cIubdQvcCf8XamSp81ZXxPlORxWp05UrWbToWxiEqwGHjKOqwReakHn5PFLYGtaBHU3kjCuRsnaK9wvO34FkeIFzfmEYzw4hZQCSuWmhPF09YoZXOkiu8RLpa6TlRWwog52MkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637381; c=relaxed/simple;
	bh=MnlbCG0OLlyCzqSRNmMHg0PFt5RKRuOIj48olE/KNwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5MNI1o6KiDt/hKbLh58pJt1SUlKDvcmZCL9IPXC8f1fzDRDMCsup3cCIbx+dr8thz0TiJn2v3nNbRiNj8uNTyLnaJ/CNv0VDpXz0dDXrjRJnvqjZEpxFFyTyZOK3kRZRQ5zMTYDdTh+2xyvSjPrfC76xCBzBTtzp9g5aSb0/ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vf4Mbm3d; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKs32a3i+fFzRkA5xLfsMOzMYgIoxiyq+iwrTF/30dS/uhjdJm07ZAEUyEjbBdez6jXno/enep8eRQp2wl+6P7hKYgyn/7Vgm4GPm1PKmqYVfDCPQqG83s7giKTSmtGx+vyRlyZui+EHmxUVdxjb1DDqyKEihLwfvZbIbEVyXRlqJ7Yr36aoiliwQpC6WWOKqkf+J9J7ZDBZKXN6DOVuh4uyXLSKfVzzdOmffHDFFTuV+2rVFLy2nXyV1wOOVuSodmuZwmBv9XrfAFdAvQC3LqNEMirkYp3MqeqN3oEJnakQ1z5Coa10TvvADB/xVkLtfNLThTxusKrPaaXJu/HSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6YLB59yEUozRKSB5wfvoZ6SQRoJKGcm8rGRNjkvWpk=;
 b=Nh1ODDUQ/SJcrp5Naz1M9N5v41frolLCrNMdkFIIfm5Iq7Td6hkfJumqiUjUMLQlxMw39jM+1PTxrLdrdLiqEtCrW+cH5ff3a9CN+HmTGo1O5AEsurXhKBiDeWEf/jRnvvdY3ofdkZiGOKCdV1EHM4r4JTvwzelqRys6fCUJbf7dU/VoMFQsmkT/wZtORwX71FpcpArmozK0IF/OtY0e1vRPbh9ALK2fVfzB3xOnvKodLiCFJGp8JL0VyEjwIgrkFzxJ9yGSAJ1Ygl43zixWgy+0qYfFeAAJHFo2ppJ2bLSGEGnD0qr+eEnsfwfIoZXXKVMIVcmNzyR7cRrX78KymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6YLB59yEUozRKSB5wfvoZ6SQRoJKGcm8rGRNjkvWpk=;
 b=Vf4Mbm3dxxzCtgPwzs+lDoDor61q7dCeX3Nl/UtNoPwx96S1rQOpSfIr1hjCgfa11xrNTQcaNX118kbvylLoXnz1CkokFijvdkbbKEc2e5Hqp/pXKgPZhtupRK0MnsesRvDo5zi+h6npg0jNgXWQmQbAokJIfxRQhtgL6KJEvZ3up6TNxbC0T5jWQ+vrageS2N95HZuN371QrCgY1zXNBJ7OxJrRtoOHoFZEOsxUSzGGk2GUTrKKzObNwmqXgfHeSQpc98CZ2ktrkXT+KYnX8VGzOEK6HQZvkz+U4oc5yEJOLdMIozjMecX86ylF3c3xxYD4amA8KDqJvV0ttTVScg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:49:35 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:49:35 +0000
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
	Joe Perches <joe@perches.com>
Subject: [PATCH v6 phy-next 28/28] MAINTAINERS: add regexes for linux-phy
Date: Fri, 27 Mar 2026 20:47:06 +0200
Message-ID: <20260327184706.1600329-29-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 353e3908-c84b-4157-f849-08de8c31973d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ydTOf1SGTAS1FWtyl9c7P2YIbPAn5oQMlU+K7n6Uga73Z4/Gv1DyNIanD0Kbl3ONSjL2F/fWZ2aAjZDnIlGe+YgxZ5lyK2r1WyomV2aUo/EDm5aHN0qx1jDJ1GcFphrFRwAXTIjBaCztJNwgVhQOCUa6JgezZPgdLzImuTh9Gs8sybxU8Rrn8SlNZSEdGVlzU+Ljs9U/nbCREnzGAoOmafBsKhH2lugFn6gUpY/DMGM5t94GOlRR6SD4aIgfXbe6O9mIKdkkEDrVVEMwbM8L2bQjACoJ5kvz5GCVy8GqJ+qCGKvNDOZisXpKpNPL7XgKiDFiJxo6eE4CrMXNHBGP69fkE74yxW26y96EmmELh2YlIa8vdMnISijFMrOIiK3TzMqKJM412U9Y0OgSQcOgVf5OJ5uJe/Pjjb8x5SQeNBWaEJ4auPgW1Lcu9cV9k+KhbEBWGbnGomfy1sJWoq5R5M+hB7AjZ4tiBIAtmOI0pGBQ5eJjE0SLPkXkFXd/+CxluH2ZFJoiQ4yyK5NEH2kDAaqT/a/q1lejAk2LQp3XaRzqss0VuVrjh00bheQQTqSHtfsJAl9gp8NCC11UIwuV52aF3O7oG1qp7ziy+E1wltKBnItOlYthu24HCHh4qnxBpHbRO4ZZyCE5anyfzk9qRazL+65ppBHhgbnIe4tadf1vLeOudCAgePbRchw3sLSdg8cWBSujk/AX8eKB2L8Q2crZfy1d6dYsOABFVlkDdSUCXWwqi1atY2A2Ez6pLpwi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xpnaNZu1DUNaWQ+wEsT1zO3elMNz1C0fPo47+SqSRe/3zp4+c8IhCHQhrDEe?=
 =?us-ascii?Q?/j24itgT9r41eF9GA8ZFQ2ACC9iADcp4oedejH31OT7oQhTuMKMQC1AUKAPe?=
 =?us-ascii?Q?OI/6bdKiZGh5sVGMwyX/Q78WOho4m3iZ52hvRn4wVomP8F/tq1fKFGJoqsaY?=
 =?us-ascii?Q?17eMLcxsqeFyOG1TWjVJYImKV6OdOMzF0snIZjPKdIGVkR0QaE84znrsK6s2?=
 =?us-ascii?Q?Uv5Dw8nVrJphMvxMAWEbwEls8Gviicvy9DSMnW38OtcAkRhMJi5GlJMJcxoU?=
 =?us-ascii?Q?2gcJG6AyZcpyJyTh8WWoNl2ong8tBRF6ng40xfR7StUf/+3uCqgeQYREUDbL?=
 =?us-ascii?Q?lykSDqQo+ewkBXocPPCG2k503fwodUbyudbrkMoNwQh/s2bIh8c0Co+y8S5A?=
 =?us-ascii?Q?LChyFkZQGwQXCgtSP7Pa3UyKuRKtB7aypS9sXXELYC8ogFA5qvaVjl720+uA?=
 =?us-ascii?Q?e10XXc7RiJQyPcqE3tFqO5M8vkhOchaeJ/BxX3J2xGhCpSMvudbTETpATT1Q?=
 =?us-ascii?Q?e6wjfMF+wnJNynRa7bq4wbeNRsn1FD5uaDVGIaj0pc+uzuA75uxUO3wVjjWK?=
 =?us-ascii?Q?V9uK81rPJXabE+/Nqy9ATxh4hdAUHO7vLcrpCX028F+pfBqyv4peUX4HKfMe?=
 =?us-ascii?Q?CV2s5wr5PDEr59mBGg9UOhRLPlTksC/t5GZY38/81OJSHAhzThivWdrLdQDS?=
 =?us-ascii?Q?xlE/hTwD0OxI5hKI+ZJzsxMiFYhMl97mjOVJi+/XuKoFzHzSBA+Yoc8PH3w0?=
 =?us-ascii?Q?CQZt8jI8qTWzzXiqASiDL5uZjU10ZaVpaikc+8RBq/10WOOhcyVlu507eaBY?=
 =?us-ascii?Q?SltyNnZKJY3Ak11Vi/3DNHYZce3MDJ4OC8X2vUphEBvFWTcFwRUSnUCzLcax?=
 =?us-ascii?Q?3iHOrlEn6Id4UNIdHabE9aeujd9Q131h9h1A7vkzjxmVsvb88CkWEZrc06DO?=
 =?us-ascii?Q?K5qNn5mtFs6sjniu4LDKJTT5ukkdICxaeKjzbWMJo9pK86Gktp7QLHbGPICE?=
 =?us-ascii?Q?rmPXDXA2VA2fYA0/P8PnqVMgoJoN9zUnkWbJh0wdZIVJ2aFEirNiKD+vPYZm?=
 =?us-ascii?Q?Im2SypkG9bIu7o/lltvKuieU4lit8YL9Gf6JlRMJnRjGrF9bjQ63XQE6MZe+?=
 =?us-ascii?Q?bG+We9uALUKjKmqpa4Uzixymu80nrikC/+Pm7UVpSmR7Mbu2oqDPQZ5uYMtq?=
 =?us-ascii?Q?00DdosOgdoTHhfOu6eGhvFiA4DoLnUVlvFSjqGSpulMSxN5kZf/+E6fuubL4?=
 =?us-ascii?Q?AV+I3rH/y3aPuDHrpeyQKVK/5pTZQDPdY+AZs+fxp1m22GLQzaOUZybRjL9X?=
 =?us-ascii?Q?tJJffawVzhlN0Zip4kQUdmijO1xBZyh3eXKCI58gZK35/uxz8EuSwQIGWBUW?=
 =?us-ascii?Q?rAS6VNz0/maP54A2pDIldLQ/0dL1AvfCwUzvNUZd2Z7M5W+ASoccGSxQj7Z/?=
 =?us-ascii?Q?o/jQLfguhZfGy3KPdo78CSJJkRm4IVNDKL6WdD4vWtJVJPkcN2pwSm1NHpgL?=
 =?us-ascii?Q?NPeesnCkHOBd4mrtvrzjd3dhmOoxnPuscBqMa65ErZKaAqZdYH982PKs2AW0?=
 =?us-ascii?Q?86Cbfs7rdz0I7QxFfbiBHEG7xDylttyxQJcFq0p29/H4Z5ziTGCAo7BUBM14?=
 =?us-ascii?Q?8ikpsnLTE3yl5/hUSciHej3/vqfBeL5X294o4EvHisnbbc3JzGxxa6328Emn?=
 =?us-ascii?Q?nr/THyzLdzeSyp0ZROYQpURVFpk2CbqhiHS5TUDMMdwd4U7SBHoYxHg6o1aq?=
 =?us-ascii?Q?aH/pUoiatyKGfVFRThags21H3vhBPfN0RoIeGF/YffQSTMi+TA1zztCZyzAt?=
X-MS-Exchange-AntiSpam-MessageData-1: /arFIErIpDNrT+O+JmWiMjJWd2nnXgTWY88=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353e3908-c84b-4157-f849-08de8c31973d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:49:35.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5ozXCmubQ/lXDDesm5xUZPpTlop5cE/f3BFjhpr5Kfvn8N96i8H0TOx1DIpdwWgyT4vOlC6PtGkSskPiTqokQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
X-Spamd-Result: default: False [9.84 / 15.00];
	URIBL_BLACK(7.50)[perches.com:email];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7292-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[nxp.com:s=selector1];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	NEURAL_HAM(-0.00)[-0.986];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sang-engineering.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,perches.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D922D349FD5
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Some pragmatic shortcuts are being taken by PHY consumer driver authors,
which put a burden on the framework. A lot of these can be caught during
review.

Make sure the linux-phy list is copied on as many keywords that regexes
can reasonably catch.

Some considerations that led to this solution and not a simpler one:
- Consumers may be located anywhere, and their file naming provides no
  indication whatsoever that they are PHY API consumers.
- The network PHY API has similarly sounding API: phy_start(),
  phy_connect(), etc. Similarly, matching on "phy" would hit
  phys_addr_t, "cryptography", etc.
- The header files themselves need attention to avoid matching on
  include/linux/phy.h (network PHY), include/linux/usb/phy.h,
  drivers/net/vendor/device/phy.h, etc.
- At least for a transitional period, I suppose developers will still
  try to add PHY providers outside the subsystem (which is discouraged).

So I used \b to try to match on actual word boundaries and I went for
listing all markers of PHY API use as they may appear in patch contexts.

Bit rot is a valid concern. I will add a test to the build automation
that newly introduced struct and function names in include/linux/phy.h,
include/linux/phy-props.h and drivers/phy/phy-provider.h are matched by
the MAINTAINERS entry K: patterns.

The keyword patterns were written with great help from Joe Perches
<joe@perches.com>.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Joe Perches <joe@perches.com>

v3->v6: none
v2->v3:
- escape forward slash in linux/phy/phy.h in regex pattern:
  https://lore.kernel.org/linux-phy/9fd14d166e860f26febfbc9061a6dcae6a166961.camel@perches.com/
v1->v2:
- split into multiple regex patterns
- use matching-only (insted of capturing) regex patterns
- adjust commit message to reflect the Q&A from v1
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..cd920f14abde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10713,6 +10713,17 @@ F:	Documentation/devicetree/bindings/phy/
 F:	drivers/phy/
 F:	include/dt-bindings/phy/
 F:	include/linux/phy/
+K:	(?:linux\/phy\/phy\.h|phy-props\.h|phy-provider\.h)
+K:	\b(?:__)?(?:devm_)?(?:of_)?phy_(?:create|destroy|provider_(?:un)?register)\b
+K:	\bphy_(?:create|remove)_lookup\b
+K:	\bphy_(?:get|set)_drvdata\b
+K:	\b(?:devm_)?(?:of_)?phy_(?:optional_)?(?:get|put)(?:_by_index)?\b
+K:	\bphy_pm_runtime_(?:get|put)(?:_sync)?\b
+K:	\bphy_(?:init|exit|power_(?:on|off))\b
+K:	\bphy_(?:get|set)_(?:mode(?:_ext)?|media|speed|bus_width|max_link_rate)\b
+K:	\bphy_(?:reset|configure|validate|calibrate)\b
+K:	\bphy_notify_(?:connect|disconnect|state)\b
+K:	\bstruct\s+phy(?:_ops|_attrs|_lookup|_provider)?\b
 
 GENERIC PINCTRL I2C DEMULTIPLEXER DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
-- 
2.43.0


