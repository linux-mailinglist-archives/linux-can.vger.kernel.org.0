Return-Path: <linux-can+bounces-7566-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFmCC2yK/WnWfgAAu9opvQ
	(envelope-from <linux-can+bounces-7566-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:02:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9534F2B92
	for <lists+linux-can@lfdr.de>; Fri, 08 May 2026 09:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05D8F300F783
	for <lists+linux-can@lfdr.de>; Fri,  8 May 2026 07:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC04375ACF;
	Fri,  8 May 2026 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="gCXcRzRJ"
X-Original-To: linux-can@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021092.outbound.protection.outlook.com [52.101.76.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E01F418F;
	Fri,  8 May 2026 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223706; cv=fail; b=mTTqbDC0o/XeYOLbK+CpFNRKvzUI1dhCrCPeH0RfGRkpi0zOKBpgkNVN+clNO5Lfurvdhi9V+aJEg/s5UOlh/n/o6k1Vcn2buJEi2T8jDt7R6sW1XkzSReZBhoQ4fp44dRUSOISgbYUn7aor26ydXEeoUvFI2gE62QY/3uFZt9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223706; c=relaxed/simple;
	bh=9CyR0DT/N7PqV9h6K3XHEcN7eOp1HULpOQhHBrCM0AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N6tN/oRpD+DrS3R7qEfnuzrE5kI/4rSJLuJRzQhMkcSPPiuLLd57JsBHsRHx2Yune/f4SOzVKrWtti+TjmtAYyzL+nz5JTJn433jiIs8cyqA/6TL9srf3s3sS1DFv/J04h6NJfTb6/GdyrMkec0RIeZvnIbKNZSeXihWh9oZGcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=gCXcRzRJ; arc=fail smtp.client-ip=52.101.76.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daf9mN2exuD9cNmnG0KQsppYA10eSSEypbP4jugtC2jeRrY0+Xhr0zOVabcPb6Ev+rqlT4PCZ6or/WXJur7CYWzmWMrhxbbnE2sZIYcwwkYV+P2X5cm2PzPzJc3GcnYaW/+HyI/aqkMqqQA8LVo2RPYw9wwsG/f/p+tzVfjziwOJmfx0dFVnWRiLNo/SB1ix7z7RgsWt6nYFCciCRLAMoeqTl2feiFcPV0RhWWwa8EAMAdVHU/fh9XdtAwfTLrY1CCayn+vHMMQGimdrp94aHUKIFwsg983aKfJkS5d6Tbk+ZezdZol9UHxRkD5x+OdS5Kaq88hN/wdBW5Vxa9JbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxJH45HiYzU06/vJimChCxNkU0THpCD8z0Uafz800Co=;
 b=D4olil3OePt9U/dr4sO2CltwZJIwl/yuxSMIMRhPyYcSsqrSpUmcc9W006Eg9BJErLY7nJ5o+g2s9csjPXLpczQzmYUAP09nSp8fAX06qeFJXwrLv5aZg/wkih+3EVTL9YZCTh9yRcUTRxrpPM6uc3VPHz9u6i7g/DwoUD4O0uZEIXT8TyjHLHfjEfKag/20ACTUfJq1G7VAxirW77WvGqSIlLYv5Bg9+iMmv4dpqgVW4JiiiQaJr1Zi2LQlCY1bYu7nYi6Lhqi17Lkn6SWxr2ls13aZEKRpFE9JMppJgnmKW9UidJsVNa0LodHA4v9FxU2KlFg2tYJOQcEfmq/aiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxJH45HiYzU06/vJimChCxNkU0THpCD8z0Uafz800Co=;
 b=gCXcRzRJ2MgHLSgyAixVzE9lQ74LnPj5ZeyW0ix0VUnMbMqOBeG6s4uvLYUJNYcz10Pmbps/HtcpkXuGr1pTRJaamPGxx+eYtHZb4vETsmsaRsR130TRgQxx0dXigVRjiUkbpyWMTvsYHOtz1kl1qx1N19FIzaTJWo6u36OmOV3fI9u67y4FQ+p8xsU7kdQGAL1CVOuEgf3AM51wPJKO5Q6o2rKyk5pCwKq7HQA4gd99MYTsZmUxqus39UsMjG/5gK+/btmeiOzf/8mdWSM3/XqZVSd9JGNrGef66m3wD25OKcyTS/6b40GejfFOOTFf1jP+JbHx+EWI+JOwQhD9GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:188::6)
 by GVYP280MB0889.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:35 +0000
Received: from GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e]) by GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 ([fe80::a74c:fd98:dc12:8d1e%6]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 07:01:34 +0000
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>,
	Daniel Hellstrom <daniel@gaisler.com>
Subject: [PATCH v7 06/15] can: grcan: Simplify timing configuration
Date: Fri,  8 May 2026 09:01:12 +0200
Message-ID: <20260508070121.6918-7-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508070121.6918-1-arun.muthusamy@gaisler.com>
References: <20260508070121.6918-1-arun.muthusamy@gaisler.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023A0B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::212) To GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:188::6)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV3P280MB1530:EE_|GVYP280MB0889:EE_
X-MS-Office365-Filtering-Correlation-Id: 07175b52-32c4-416b-9bf5-08deaccfa44e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hCJwncR5Mi4EpKnh5wFJdDveAk/gMKF0m8EVxom40swF2FmfhExb9OVRAO3W3Dlra7pcaJz0qMwjUNa5h9Oan+ir53XD7fp75Mx//WbWw4654qG1KG2C17hmHEisjzsXxHAyzzm/7Ncr6++USEp4iyZV4jdOekAivKAMkRGXxYygecxJ9AavoI56Hukn4stm7v6wKZiWEwqCu6dylYWUsCrGqQ8ZYoXctAD2u1E97JOOete7DutQtnhZccO6esiPzRFS3UTNBNbruxbTt9vNwtQuF0zedvOXYHGWMPm/m7G2W97dJNg4HMK4+nhFqKEdoZnRaXtZLp2FWYcuO0x9PCNlA0dPI6rYJUxroVOKAxR2yA0DdJMrMeIM2UUuY+VMw0WBJg1w+n6J1+/2JVEOTJaQ3ntZZ1rC+oD0QOqCpKP9FDxXK7hWxj0P3UqIOAS5YbGLsE3p2h5MP6NggRiPpSC+ZTjr5iz7dIocI1e42DoGhjUXtm/8Gifad8CuYoJDior3j26beqNn2YERnwGOg1XO+GkS7H91Ok5Dvf6RXm5kb83MXi2tWbL6RYpFwPDV3MVH+ay8C4B1Jg+Ay/x7K2JbXIxfvujlaLM6oQM5oZgZAFSElC290+By0CgESOOJADuI6OQVNaEZHXj5MtOLC1jCKkCOxyIw9eiMLQ7C+IoQSY0X0O4MKgcc8On7AnbDsAh3FYqeDJcnONYL5sG8BCENI2Mg99zBFEIQmaPDnzqWuE8tIG2XlKdah8rTjAX8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ETKEelaugLeolQ2rXs5W1kyyGIBEHRI1L6qMsD5AB5Qvrrq0xj/7dIWwZnXN?=
 =?us-ascii?Q?8X95Fo+qeKgyrqSTLLMzTy46CT8wvQjaXQPhZO6wAWw2TBE3IneOByYl1enC?=
 =?us-ascii?Q?K6h5MRa7f52EeXEaOwS9lLGdNZLf961fHn1Ie+sysHpbwpiCBxCoX+QXij/K?=
 =?us-ascii?Q?cfAtdIeDWNT7Q4sgVFrbV0ArTF3+VadLmRUmLIPvU8wdCS5Y82CN3Oya5FoE?=
 =?us-ascii?Q?zo9Zl0Us2l3eGVvUdRnSHN0nKFrmVn1LODnGtX5N4qeA6u8l820hM9hPGQZU?=
 =?us-ascii?Q?vHdHIEe6OE8idhVG4m76wHUXMsBi3r1FDbmZMq6OjepKBq9eZU3f0/8K0WIT?=
 =?us-ascii?Q?chXh2TjfkbMl2ka3Vp+EQnNthPrrUTkdYn+PUni1EIJ6FahgdMEZUeK6Xox7?=
 =?us-ascii?Q?04449qCDdH+wgiFsL7CdnSpnyE9pmO/JESdvKUzRosVcFBqWm6Y+k5xWuQls?=
 =?us-ascii?Q?HJ7SAgNzcBXHWB7ayCG+r2IZwxA/FePz6uYFTBeZDuUqnaoP77fBiuX1Ot8t?=
 =?us-ascii?Q?6tQ5V1CWAsGZNE/wDuuLdboBjSdd8OZzS2wrq8fS5ttSiNW0H/hKFUuWWZbb?=
 =?us-ascii?Q?JLEsh69IOoMW+WVRpzyOYsvxFFgJDbmJk4Xnqn0rJDeBPWLaOr06KpFd0xMo?=
 =?us-ascii?Q?kzwmLAaNelrosdFvKbpBvsCcLcJXH5Y+2IO4miFFQ4OCKTex7UBHgjsE8gqN?=
 =?us-ascii?Q?NzLaFjOMI2Y3D75VEwMNGdVriKrUXrLbs1Q6nN/E6BUN2Io5mtwCDdG3DIpY?=
 =?us-ascii?Q?BzF0Tf5f877ZVaMdOVG7csrJcA1eQdn8g6LaaxNKKLHw0GvNikRkefMyjOAU?=
 =?us-ascii?Q?1/aTRODzgyUPyaRvhYTOZAJCJddvAYs+h6VpxImekr/NCeWRFkJ+Ykio4lWt?=
 =?us-ascii?Q?blFMasxBaWzs/MOMxicrcYU9KgkDW2LJwtL58uEIecBgdBz5LO5794xdwP8z?=
 =?us-ascii?Q?IEhNCMt5B2TSrCsqFl49I79PYODsTDJw5GXK59+xGjCyUHHe27Hvk+Oq3Z2e?=
 =?us-ascii?Q?F/DQvlpwpWRdhdyNHD7mUoxCdH1jbqGReBv9gYGNJYPIo+cNoMHnRpNOKEWU?=
 =?us-ascii?Q?xig/adYZzC0afDZGN83FHyp650X4DjJO8MDuKGFIXoEghdhqUyiMy2qRKynd?=
 =?us-ascii?Q?mIKSu6y5LgTr+7bLo5xsrVMRSYJ8/IDpLmX8ApoayqU7EdOqwqnZ5Of/E9vu?=
 =?us-ascii?Q?nZYDESoyWYuggXiFj7WX3XsoTdLXp1MAQu/P3qbF28a7qoqxEkVrIYIPS48U?=
 =?us-ascii?Q?2+TLiSbHPnUnHfNpudl+hmmOyR+g4M4UzV0nG7zQgflD2DYKo2Xc1tfUcy8Q?=
 =?us-ascii?Q?rVZr3UMYxkjr29V1VqpvqqLt0h/lOm04aJ8Rl+2Ay3b5khak/CfOnNdInSFZ?=
 =?us-ascii?Q?SVB1cE1t/szlRYbPrq0NnFNZBl83X3DZhXmF09ZsoO3pqOWyMV/ousRuM2YC?=
 =?us-ascii?Q?vqVKhx6yqFr1ZbvtQeaeDb6NBPD3UucdYElC7DNUBZy1Mw9/ZeGCWMRx28Bq?=
 =?us-ascii?Q?swrKHGDiz+NNvr53LpkGhFa+j3pcqnkvFHGOSzSt/dqeMwNVxdxvTSejAmmD?=
 =?us-ascii?Q?b2AI9Z1lH/dC80brQF/v2muSNeISo8YVRBatEdlbQcW6YJ8G6K3W/J6Mtrbb?=
 =?us-ascii?Q?cvY67NKCqO/6B0xMfntHQ5lZIyApy3zvQQ12HZ8Yx7QwA455Py2bwA+DXGOs?=
 =?us-ascii?Q?J/JFd7O0mHcRWiHlzesZR1D0e/z7s5vP3PPvm/I8I+PAmI/Pr/RzH+qz+IU5?=
 =?us-ascii?Q?GnRzT+GeyA6jOm3QD10Hs5F1S+SHFMw=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07175b52-32c4-416b-9bf5-08deaccfa44e
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB1530.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:01:34.9264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4HfJ/biQ5K8p/YomLDtdy3D+WOC2RgMRgRRjbjQWEG30sH+ZL7yrFj37wS4W+wluFv5kGRD4rMUnqj+LJv8lVMkwCUyT6NODq4JgvX0B6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0889
X-Rspamd-Queue-Id: 2F9534F2B92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gaisler.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gaisler.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7566-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:email,gaisler.com:mid,gaisler.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Remove redundant error checks and use FIELD_PREP for bit timing
assignments to simplify the timing configuration

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 8d7bde1c006f..8ba21d94e87d 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -396,41 +396,26 @@ static const struct can_bittiming_const grcan_bittiming_const = {
 static int grcan_set_bittiming(struct net_device *dev)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
-	struct grcan_registers __iomem *regs = priv->regs;
-	struct can_bittiming *bt = &priv->can.bittiming;
-	u32 timing = 0;
+	struct grcan_registers __iomem *regs;
 	int bpr, rsj, ps1, ps2, scaler;
+	struct can_bittiming *bt;
+	u32 timing = 0;
 
-	/* Should never happen - function will not be called when
-	 * device is up
-	 */
-	if (grcan_read_bits(&regs->ctrl, GRCAN_CTRL_ENABLE))
-		return -EBUSY;
+	regs = priv->regs;
+	bt = &priv->can.bittiming;
 
 	bpr = 0; /* Note bpr and brp are different concepts */
 	rsj = bt->sjw;
 	ps1 = (bt->prop_seg + bt->phase_seg1) - 1; /* tseg1 - 1 */
 	ps2 = bt->phase_seg2;
-	scaler = (bt->brp - 1);
-	netdev_dbg(dev, "Request for BPR=%d, RSJ=%d, PS1=%d, PS2=%d, SCALER=%d",
-		   bpr, rsj, ps1, ps2, scaler);
-	if (!(ps1 > ps2)) {
-		netdev_err(dev, "PS1 > PS2 must hold: PS1=%d, PS2=%d\n",
-			   ps1, ps2);
-		return -EINVAL;
-	}
-	if (!(ps2 >= rsj)) {
-		netdev_err(dev, "PS2 >= RSJ must hold: PS2=%d, RSJ=%d\n",
-			   ps2, rsj);
-		return -EINVAL;
-	}
-
-	timing |= (bpr << GRCAN_CONF_BPR_BIT) & GRCAN_CONF_BPR;
-	timing |= (rsj << GRCAN_CONF_RSJ_BIT) & GRCAN_CONF_RSJ;
-	timing |= (ps1 << GRCAN_CONF_PS1_BIT) & GRCAN_CONF_PS1;
-	timing |= (ps2 << GRCAN_CONF_PS2_BIT) & GRCAN_CONF_PS2;
-	timing |= (scaler << GRCAN_CONF_SCALER_BIT) & GRCAN_CONF_SCALER;
-	netdev_info(dev, "setting timing=0x%x\n", timing);
+	scaler = bt->brp - 1;
+
+	timing |= FIELD_PREP(GRCAN_CONF_BPR, bpr);
+	timing |= FIELD_PREP(GRCAN_CONF_RSJ, rsj);
+	timing |= FIELD_PREP(GRCAN_CONF_PS1, ps1);
+	timing |= FIELD_PREP(GRCAN_CONF_PS2, ps2);
+	timing |= FIELD_PREP(GRCAN_CONF_SCALER, scaler);
+	netdev_dbg(dev, "setting timing=0x%x\n", timing);
 	grcan_write_bits(&regs->conf, timing, GRCAN_CONF_TIMING);
 
 	return 0;
-- 
2.51.0


