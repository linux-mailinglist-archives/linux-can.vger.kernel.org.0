Return-Path: <linux-can+bounces-7447-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CqkOH4782mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7447-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:22:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E77F4A1EB5
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 286823080431
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D0D42E01A;
	Thu, 30 Apr 2026 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N+VMwdVZ"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3353FD15C;
	Thu, 30 Apr 2026 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547263; cv=fail; b=FZ2Kb9D9g81DX2Wm3OLIZCkUwi9S1ZnC1H60psbS56uuhWKfbE3NR+n2qz8QVza6KQN6uYFR0s5iDE89EpIrBFrjFUoNJjXpBA69JvcsD4YmjEikK9j+KoqIsWTi+WwH6i9lmeruVDwDNJpgetdRFwemm+hxvGjZSV5h7WTmUoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547263; c=relaxed/simple;
	bh=tC1sRpep2bEa9K3lfyC9FDUcSsG+XwcxEZGIn/djSR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qj5UsgYKmAF17CeR5Qotk2eqg37X9SQdwpHxkvEeqCIfUkuklmxmwyTXtLu0jGFZrealXq6+tfZAVkLBostnNl0ls9g6wwlp1yfa7eDIunXyixf5qPwhS93F9lmPdvVWxeLp3daSk1hmRlhXYp1OXn9kgxm5dYizf0n/0ACGGYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N+VMwdVZ; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgWt710FmdXjSxH75fCbF5pKvgkfmME/YXmy7JVYLfMUgvnNAzAXa5rY3arbD2EZr6tdCRz2dg9zFuxgEmthfqaI6+hZ8zFlgBWLnzbkOdqsLaLKoiS04uCOZUooo4yZceT15FT/dbRsT6rywGgEvND3nTjxVq3kvCwi50Q4dDjIx3Exw70Ee2HhdbrDZD3DRbmjv7Sz+iz31/6+4IcOMtNkP3hOUxYDib6dalf/JN5p8rw1jl7xVfPnXX2wOEFSqH8BSU5ltY8xcyCGc3/2F28T3uIiGvNgkewZUTL0GOqnmD8qUUMzVxFVEwo7ppsu/uX3KYpD3DI2NlLYvUtpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLZf45iS4YakI5dPxIF9jeShkzkLs7+kVsb8jXpGlRQ=;
 b=xEKzEvw9Ht2xzLhgq93Ali4BnN/BgFDwlmSjNWcrNQKy+YtnveKAf6Bh36j2ZHMgPk3MZXEme31+8nX+I9GqnjdhYtmz/I2II8P4TIhdnWYaNe0zB8hyXMoGLoEp+Os4ePGxMP4/OnWcz9xpOkCAH7pdlLe1T7KZz4Pavj1W9HV7T3PxWR+AKJC80fHKWIdUP6/OAeF/qAvQhXjFQVxp3KdhaucyZUzICWJO8SIbcdYdmLGOSkdKZHjW3h+i94BoEgM0Jgn7sTgv9bWkWJFwF/ITYaPOtQSXo5cDFr/c2Q8/ffC+aWHYF1zU1Tw370B4HLgbDjtE+ZGGkZTUxtIwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLZf45iS4YakI5dPxIF9jeShkzkLs7+kVsb8jXpGlRQ=;
 b=N+VMwdVZJ5hMTTPbwFxIFSPLCJQhYfPHhuR66xnMFhMGljygvhUXOwYztk8ZJupjOG4AJDvbqxu6JIxRvAIbtR76jXSqRYC/90JC6Yg+uZ2tknLVz3wGcUgI8yDNNWuaQo3Q3g8efVTaJGQX6YnUM90H85V8YYe85aXuMwppA5HoIozDvjpV8r+I6Uc+a/Jeb9DpccbpQOebXawYNaUFHV+PqpIrvFL+PRJSfMf8e++nCkokC5yuDVqDEkg8iPQ/WOg47d9rXb6OUux/0aAouZ91HjLdWyd5fgvv2XyG+hbjh8OnPjCmRK68Ib6lA3ApqF5+TUyyoKRiF4vf1khO5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:07:27 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:26 +0000
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
Subject: [PATCH v7 phy-next 17/27] phy: introduce phy_get_max_link_rate() helper for consumers
Date: Thu, 30 Apr 2026 14:06:42 +0300
Message-Id: <20260430110652.558622-18-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c45e7a-d7da-4eb9-c8f9-08dea6a8a9ce
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 VH+UI0OB8OaJ0d72RDddUxUnREWFIeX+Ej5z+ox2Kgoeon+FpDugxWfLCFcexXv1n/xl5FHvyPsRQQ+5XBt3n8eyRohIqraIfLsaGMR5g+0urqTEA88V2dPm6FuDyHVk526S+zNPvOfzNWZAYyY98Gl5Vh3Cg7YcsGNJbe5lllIi8SdlsSsL47qZL2KLEj5OzELVNHY0MwqFBgYWXvhGlGOohvOUSUgjwBncvuGpBKUWyUTy1Zo1fLwFDjgbnIR9xbbfbmiYK5ls42995/h51eAWiSPW4Zfd+13RwMjN5dchU9AdD9TxkLvBkBnMof7VfhTVGbACGB60VeTYPRAj2Jy5Cn72+jlvhNslmWpiXSZz/OGVLxXz3mumupN6I43Tu/cvf1e6u+iyIKvTjJHGbu5znKwzUEdF34ZlLS6i3yXgmEA3meb80EiSpzdXEO22I1JntQTcvB5uNauoDmAk+2b+EeMvADoH01gT8g8Y4qOYAMMMmY9BsaUgkQGKZmdlOsXONuF8O10zEOS5H906tCCWLgKl+qWYcUKy6uHA4Oaf/EkhF3zwAPh7TM4vooRQ8fLukt4eIhjWzgg85kNY7EhY4kfq5RHuNs2J+5YFtCPPTNWQuz/pFSBnEMGGp0p0aVGJdMZp2quUlqAS8iR71xFW2izNxFd7GJ6Osz5uxGcew84eCWYD2YUdOD8UqCQvcd/z4h7COTwrQkiFgxQ6STMAeZcqM3wENOpYgIDZTK0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?D5J2FYgiHJOlP8BlTUkufK57o8YkBCiKzILX2e4XWsG1Nii5ipMKffDOu1bz?=
 =?us-ascii?Q?8CxJX+iRl9Re+F4teofeJTCoX7rFGeC4K8V/S6m1erzayKy8GhFyaeGep7aT?=
 =?us-ascii?Q?iVqwbNTWfkGapG6KzpyRmP8JyfTohZQS56eBuucJ4hLi8XQeT1D33axpdS+4?=
 =?us-ascii?Q?lVfTWWCN/oE8gaPr9B6iIO2CStyH0C8J8sTw3RVubRkhJa/1Gl6h8ODgSgfY?=
 =?us-ascii?Q?XOLZdY2vWIp0AKMBi1YSrO4Y0eT+PQ4cTBRgIy4zq09DH1s/U4k5dnGxwh01?=
 =?us-ascii?Q?asBICts30+f3HyupLFoymxF3a1qVW2VcuqPYwFH492M0Xx8D7a2YAJ/aH63j?=
 =?us-ascii?Q?Uk1T4ffgcAG7QWxFK92QD2O2ELK0qhN19FhzGXKEuAK3Ha7lkc6oxsaoQCJK?=
 =?us-ascii?Q?079C2hWIQkr56kOU1g/A/ESOdTEmiRH3D+zI5SawETBIpp8UpenG27yawTtv?=
 =?us-ascii?Q?lmft5U734ghJkCMXzlzfjsTEc5RQaURDUTUacTwH0XpYOcB1hWLF0Z05lScj?=
 =?us-ascii?Q?bBOIaEoyhHMNRaL0lLCA3peloV30/bnsE77L+VG4D6q2sHIMItKO03rFW0Lo?=
 =?us-ascii?Q?Wul9WNDNqFquGC4f6g0rnOLbeTntEzpSJ5D5WAjDfmAeERAb5OVEeazmNoKV?=
 =?us-ascii?Q?rpp9EYAKEqr3TIFELWPSt8pWtNTWnWyMh1EqbTvLd6zcRwGv4AUpH49UcsyV?=
 =?us-ascii?Q?BAi+A0eTuOsXNKF9IosQcdkTNicJO/ngxXB/O3gpDfomME9xy5H9RmEHMo0C?=
 =?us-ascii?Q?GJfBii+v4U1VaWUVHQRzdlhY0cX8D8cDTfg4Gm0Pw8NfERleUA/rJTcGEZ8j?=
 =?us-ascii?Q?L8Gsv+F8d4zAdCJphe8NH9ARwGOUs0XLqs7ioeUOOiJFZ83NrgppFLcJkR82?=
 =?us-ascii?Q?huR8+a00Kv694d11dzFE2cg/1QuAgNReJEcBrOFTWVgppxo+hq7P56u4nvap?=
 =?us-ascii?Q?JUS+7prBpzGEkPXCKDyBr3dfX3t91WDPYZiEKMjTbSmVsIrrP4o/i2S0EJ+d?=
 =?us-ascii?Q?IDq5+B/0vgKNRIyTpoL/mb+OljZvjZhyDd0rKLEWF74j6FXPuBXdAZF6aKq/?=
 =?us-ascii?Q?OhBlGR19jFEynBoENyEhQiD9YewuvI01+9UpFMJhS2vu6pPvwiE8AlNhi6EB?=
 =?us-ascii?Q?/b1OG8iEl/SdnZzckaLt3UP8nmUAueADKYIwAttm3aVWdUE9+ykkUsWJxzho?=
 =?us-ascii?Q?G0pbfbTqTsLg09rpPYvp0cXAE2mrumH/lR18yFZfB4Fve9KobxVmKK68rt+p?=
 =?us-ascii?Q?L01xePcz0I6svvameky3RgzV7Mm5cqPMJhKvXFqfI9+JJOCb5lHztxgl2WOK?=
 =?us-ascii?Q?2SFB8d9K2kI0LsZgGcMb5rOnTf/eOIxeXKp4+GFDtqD7ooQfSQZtgB641onc?=
 =?us-ascii?Q?333UCLmQF49/IgpElDxg3uRjLzDb36pnUs83sKZxjuP7DQckh6XVfio8oELf?=
 =?us-ascii?Q?X7FyVzbKJe2lTwT1w3VqtU7mr7tKaLHbrUlEi4UEJeIq/ZqdwefloaKog+uV?=
 =?us-ascii?Q?LU4eXZuOwMaP0+0KE2FIIOsqk77BUvKBllo1r5VxF7Lkstn6O46nETDrKIw/?=
 =?us-ascii?Q?hUTGuZbb+ZR/hQnJ9WWjenxqb8ftvb7/li/49r7z3P46fPeqXwPFPlg5lrcj?=
 =?us-ascii?Q?hFKnbNSjikGuEqhNYpbcf4extry8bDDikLd8SgZaS0J0awWjW5MNM2OXPilD?=
 =?us-ascii?Q?gQIc5RQklP843XzUbte6xr1387A9n/BtaFlW3ufkgTzEkrDKAhAmQcTVlFgD?=
 =?us-ascii?Q?q6Fmrr5VPxfQsmU+fpQ+azRT60t+scyhd9nVj0EJ/kIVohHHkGgw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c45e7a-d7da-4eb9-c8f9-08dea6a8a9ce
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:26.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPbOMt4E9IwHQG4aBk9IcSFvHcpJaw3BuzcEwHQC2DmGEeVpOkPFeT5YH1kD/3dyGuUroXwsf11tNTdaJldjhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Queue-Id: 5E77F4A1EB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-7447-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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

v3->v7: none
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
index d20c0f8ad04c..87847978c1fb 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1296,7 +1296,7 @@ static u32 cdns_mhdp_get_training_interval_us(struct cdns_mhdp_device *mhdp,
 
 static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 {
-	unsigned int link_rate;
+	u32 link_rate;
 
 	/* Get source capabilities based on PHY attributes */
 
@@ -1304,7 +1304,7 @@ static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 	if (!mhdp->host.lanes_cnt)
 		mhdp->host.lanes_cnt = 4;
 
-	link_rate = mhdp->phy->attrs.max_link_rate;
+	link_rate = phy_get_max_link_rate(mhdp->phy);
 	if (!link_rate)
 		link_rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_8_1);
 	else
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 45b37885d719..137ea6679732 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -530,7 +530,7 @@ static int dw_dp_link_parse(struct dw_dp *dp, struct drm_connector *connector)
 
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
2.34.1


