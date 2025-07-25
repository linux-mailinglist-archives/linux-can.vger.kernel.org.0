Return-Path: <linux-can+bounces-4134-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE74B11EAE
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142D93B00A5
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF472EACEA;
	Fri, 25 Jul 2025 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="MukTNxar"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2125.outbound.protection.outlook.com [40.107.21.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9A91D555;
	Fri, 25 Jul 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446906; cv=fail; b=YnbspvMGbbAczgBeuy9jUFfMfaBHy3yj2lf8FtUcQElA1AzMoZCcfkE44u4s/HF4QZshtxPj1m2ocw6cBFss0POlqCkfwUI87M4XcgCF3qom07eVneS6hRJrYZAU41PuEwX1/uk8FZvS2MwHV0NXvd8Fa3njdBqvJP/vfUBb1eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446906; c=relaxed/simple;
	bh=Qk4eWxF2RjA0tSblx3aNl3P6qm/PA6mG8r6q8X9RIYw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ponJseV/jAa9xlCno1yjHgU/kf+WOLOBIrjFXVt2TPA0RiAPc6o6sG0s4RPpLgZX4gQGRDMdz8rglJE7tCV7MMrKirRlcvyZBeCeEKeKrlgoszTL4+Gx+O38npTRVG+D5DFOV8G7ojThr37NQpwbPVHfRX1nyciA9Iqkhp1B2+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=MukTNxar; arc=fail smtp.client-ip=40.107.21.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHfXMuVlYgJwNkhxHLn98H9ZT92zTtHf63BdiuPCmG13YdWb6K2BwdR/x1/t251iGQ23+YyXqTdXvh8yKxaoNA3hxcn8L57bdFV2t7NlOk/v0+SaPV05rD4jKOd222x1ZNIbZCFrQ68TVMPL2XWCO7u4gxpjLr55ngIWsTg5FGAo6eoSSh1khD4SaOk3wKXQrZwk1NjL/ofi2AWd6BwLN05JPbtL1jaqUmncvnyNUe+9moSsyDZUrX2gamn0sP5HaGVBegvd/AHhi7XY+nGnTj/v4heu9anhhIQwHRMo9IfvK5Qa1UHHG2vExHHpg88tntVUz++Gpega9ACmOimrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVGViEOdTzmrSz/Np0E2V0HVGc0f0h2PZoZ2lUXbvZY=;
 b=RSGlmiA0dOJgorFSxjnbqJKC6LSmNsbjpFgVfaN/oYnbSCZVeVUA1Okaf5X6NFFheVxOzjhZcmAtk1NIJE9r/btQMEl3tHXG0ZHJYwvDzEsmyRrmutB8dKjY99SHyVLUJuZ6LkxnXPe5e9LZO4ZjtU9Nb0Mc255ExaT54DfRmpHVljcnBM1LvbugXFHC84WtT0CE+FDB/YuDEswgTVcXPZecgAcMWG+DP9bTXGQkmkd/gtYUqDK/H1aQ1szc4OCSpVTA84CvsW31c6vdlqvHWCTZkg/7fw1F91bBodooUE7Rs5Sp3DN8mgDRtbM7fIC03nSXzY2bURUQE7fjP/Z5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVGViEOdTzmrSz/Np0E2V0HVGc0f0h2PZoZ2lUXbvZY=;
 b=MukTNxarLFLyK6YpSTXEISsYPgffYMPXZaFAL3th/fSh4vQtsdBU451ly2XJpVKsLqZYSARYsZ0mSE+zkeg+2R23qixlqV1SkzOSGBug33e69xcbOjm1JexY4YkvYGnL+zbYRllNtswZjEuXNERktTvR85Zjq1ov5kV1IAYIYhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DBAP193MB0892.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 12:35:01 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:01 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 00/11] can: kvaser_usb: Simplify identification of physical CAN interfaces
Date: Fri, 25 Jul 2025 14:34:41 +0200
Message-ID: <20250725123452.41-1-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DBAP193MB0892:EE_
X-MS-Office365-Filtering-Correlation-Id: eeeb4391-7c27-43ab-b3b4-08ddcb77ac5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S+BAS9zfGpFpueeEj9DuFiHdX8W9me8ZUijgFywi2GP88Vt4CzFHmDxEMYrR?=
 =?us-ascii?Q?yBHEI/SIOhPviT+YlxqhqvklgUaeQFdraZafZYREQS4on/x9WVTTBi4+KwEZ?=
 =?us-ascii?Q?iEwg1LjZulTUEK+CqLrT0ExbhdVvOfkSyGpPaQNiofwFfaQFZw7LTCKn0W8Q?=
 =?us-ascii?Q?BoWQ7uF4Wy/iPjG5kHmiz7fjrpYzKMLh7F+igcZ7SAt4MuButNTjURjRAN/p?=
 =?us-ascii?Q?HTCcvn+lUiTFDNHE7Ab+XZvTfgkmTN2Nbg+rTqKipv1PQcuGSCDycIhDuMTr?=
 =?us-ascii?Q?c/K0mE19fLP+8acFN6dcoE6O5vbir4Wpw/t83I+WskRSz1kMw5v0yCJ2QY51?=
 =?us-ascii?Q?cKO7wjM48qwTNjshOFTFNe64CZG9jK7soWIqABvWE0vgyflSExJjPp/E59El?=
 =?us-ascii?Q?eCQ3LXg1mzTyBlGHK3AWy0JmxW0MfPm+jRboTb8KZyFKilVLx28ti0oC3lji?=
 =?us-ascii?Q?lvIW9oRmX1uDsgONssAyx4I4lLjLlD9jgERokijZQF396YunLbSzgfN1HR2n?=
 =?us-ascii?Q?u9s01QVwslplyNwXiNKFsF0SIrNeayQp/a+V5sOQ0RBIPxsm6s0jrxFRSyhr?=
 =?us-ascii?Q?gWY/jCnYwGIPqJVqvYT9/qsqfSIamPtdkDgQGrjnIokB5J9V1jA2lmwRpufX?=
 =?us-ascii?Q?V1zjtyKEYoJk908iZbkC6NcrXsJ7oO4g3bnHMDiEnXwGruP185OjJnhmW77c?=
 =?us-ascii?Q?i0HAmtE+H98pHuzZz+j9Qhu/3KvV+VL2MvBlZjwrvSrHVYVs8wSntbS7hFUX?=
 =?us-ascii?Q?5ZpQDYS2TiAWtfPnS4m/YY8rN2CfOsd8/yqWAgGBfLQYwA287uPXOHTEoB5q?=
 =?us-ascii?Q?Nx0hxJFOf0pqAzWi15Zjk90AHBMU5vWscuxH8Pz5soe7qV69aRtQr+sNy0O8?=
 =?us-ascii?Q?3TbJ3RZTRDiKOR3hbXZLhl4XTDE7rs2DyBjHMlKtVIZ4Pq5NIu4B8bkycxLC?=
 =?us-ascii?Q?3oJntS4iUaOVo7LNm7hemdlP99OFIq4O+gJhJiVKTD8GtS22QiOJZg12y6Wv?=
 =?us-ascii?Q?VPfVfyNgdoFRN0Wf5IYQiJM7vfBxtvOrkq0VC7D1p6MIwEP9B5GIsuxbuNd0?=
 =?us-ascii?Q?vdKQBtqYgyqdDJOJNgjwIBPx31155jZ9KnwXVxbxexX+Hiidc166FSLJ95EQ?=
 =?us-ascii?Q?hr1MRTmyeLEiEppDpsAmzTk/jJTLKdvss1wpkt8kTHrTAb1Z185kQaPftOqb?=
 =?us-ascii?Q?aibJ2mb4Lvvn9ppdDsiRLD2byPrGBofa1eOUyHSGAvn2n29n1fx+b6E9Q2zH?=
 =?us-ascii?Q?AQ8pgGQH15z22uwV8cb4IfEo931lYIzKS3r0ABRZnl88jGiQsyizGuIOopak?=
 =?us-ascii?Q?Ku2FDXF1XMqSMJvhHgdKUhlpZWY1dt1TgD1WX+uFzO7jUUYfSO/ecLrY2S0G?=
 =?us-ascii?Q?TqV8/iR+pZImjtB4VDxnMwkWC1hugj6y37Fd6dK9jGLnFjQdTKuRquxFPkWV?=
 =?us-ascii?Q?ClMax3KSJts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ubKRw3Tlab3AWC9BLg/hilozOesli9VNFKYz28Dqr8iQSnrN6nCvvvg8ARgH?=
 =?us-ascii?Q?kRsmQSFJLWaCygz5mIBRw/C+H2VGamxNDsTqsC8vZZRCYTeSelol5Ej+859h?=
 =?us-ascii?Q?PTAujW8pMP59NZSIP+o+lNhVtgOLmuCC6cqHVTWo3nw7tlW2OHlO0PXfn6+d?=
 =?us-ascii?Q?TyJmmy2qjrPGbp43yyX40GzchZlHbyT9buYsO1jmZaYdtpIOceDZN6rAxOhk?=
 =?us-ascii?Q?KG5A+9twsMbKZAS+ZKXzLnzD5cmBWUe3jdCKU2OjFklwehlrWUds/HHofvAY?=
 =?us-ascii?Q?/NF3vaPOZ/QuL5GezvbXzkrXV7SO5GwwmaHuhdOhRx5Bjvi5wt/A2gE+9yIl?=
 =?us-ascii?Q?qF5dwnu5ozj45GBoa+ggqjri2WcKhdmid9k/A+CfL625u1t2at18aZ76iMc3?=
 =?us-ascii?Q?hvlawNEZxCq4ydIBS0Yv3v6tNMbMMaTCfux3me3aDt8ZOimV8tUvyud1ItoY?=
 =?us-ascii?Q?mVoFiNYXhij7y78lZaRi4GbxynggKog6x//WTVtirneXjm0nppFcwO9Mm1pV?=
 =?us-ascii?Q?oKUHtcbF/kRqa17dGDYe9xuPF5t3ebpGTfmji+rtX7iGoarURFBiaVDZ3ARg?=
 =?us-ascii?Q?MIwu5VZCyJSv3Jyu+QrfGt7JR+ShInMT4VdfxIE5O+1/8IQXNPVs3RzmigNl?=
 =?us-ascii?Q?wGRI19JOlQ+Qj7mAqSU9ZnG7Ucfy2Ecglq4SDGnVVEHshYkPMSzwj6eWkGFP?=
 =?us-ascii?Q?pEohozE+Jmc9fJj8bRcyuSAsbnzMVN7qXUbRuVgYsdcMlDgeU8zTPtDH0qNx?=
 =?us-ascii?Q?ShALMYVYfQA86jxHaa/WuTkFOWZhZ4CIS0Sh3UqF2cidtrqlq+eaKMGR8KYR?=
 =?us-ascii?Q?BQqi/YLN3mwQGCx4LuT/pV8bIT4GqrQSX9JyzZl36FbrQn1FMVY8kpJ01d9u?=
 =?us-ascii?Q?2yrDU/3lmIV1xRj75Q3OeoLbRxK2NRGgWle9wmfwrkZxxOxYqHs0GUPRjtDn?=
 =?us-ascii?Q?hzQ33YbQyPc6SkaU4EImSCpjuRyhSsihZ4n4KCdiipUrjpqqztiHn/ExbptR?=
 =?us-ascii?Q?M9j9nu/BaeXpV5arY39Pgtq6x0e2fHrPagydb/xO6pm/iMbsrGq+44O296iw?=
 =?us-ascii?Q?m57vpMMAUbvcMzKUD2GKOtOYvyFPH4+Yr+H95zfhoGNcNPmHHm56YV65ibf7?=
 =?us-ascii?Q?4PDZvsGo/mjWB8DRqsVlQg2b0ltzIraiXwJ+IMSHWPvEpq8lQPbglOymMOqD?=
 =?us-ascii?Q?8LuVssP5c/AVbKAAHEfLP0IVVd7aRgbbCJQjzpt03AcdmVYe9q1lagXrGONt?=
 =?us-ascii?Q?CALrlONhhz1jkEALOyd0JVWTr62LLB4tiuWo6C/AvbmImeI/AuheVucwZ4o2?=
 =?us-ascii?Q?n2SO8oA1A3x64IBfY7D93ttqbPZvrR/dvWLC65m0SWDStxnvCM9D2a0UAl0n?=
 =?us-ascii?Q?MzZCjV6XqVDubzD5koVJvfhX9OZ1HhSvIVTJD8t0ntyy6pFy2jaIUK15TlVv?=
 =?us-ascii?Q?XzxfGXG4LrzJ2U/IKqZ2bUXGK6zAhsyH25vBxOxpO6MoRSokSfgXvshKu1gU?=
 =?us-ascii?Q?n7OX8VjI5mh/7VFupoP9sDXdXAtrY/WQvBu79MkGMD83Z3snav93BX4FrO46?=
 =?us-ascii?Q?519cPfpp12+qYd2YrIW8kAnnMMoz2wBskzurMDyReCvnNCCySZvB1muHVBr6?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeeb4391-7c27-43ab-b3b4-08ddcb77ac5f
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:01.2100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiEoyEtiMI1OJIEZBp7NXt/zoYSFI+Gaf2ecCjFluSnEMMxNYx2PX3iZxbZyio6IejvSup6GL5sNVa+apdFO4YqVrKGiwsZCbAq2L6rs2UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB0892

This patch series simplifies the process of identifying which network
interface (can0..canX) corresponds to which physical CAN channel on
Kvaser USB based CAN interfaces.

Note that this patch series is based on [1]
"can: kvaser_pciefd: Simplify identification of physical CAN interfaces"

Changes in v3:
  - Fix GCC compiler array warning (-Warray-bounds)
  - Fix transient Sparse warning
  - Add tag Reviewed-by Vincent Mailhol

Changes in v2:
  - New patch with devlink documentation
  - New patch assigning netdev.dev_port
  - Formatting and refactoring

[1] https://lore.kernel.org/linux-can/20250725123230.8-1-extja@kvaser.com

Jimmy Assarsson (11):
  can: kvaser_usb: Add support to control CAN LEDs on device
  can: kvaser_usb: Add support for ethtool set_phys_id()
  can: kvaser_usb: Assign netdev.dev_port based on device channel index
  can: kvaser_usb: Add intermediate variables
  can: kvaser_usb: Move comment regarding max_tx_urbs
  can: kvaser_usb: Store the different firmware version components in a
    struct
  can: kvaser_usb: Store additional device information
  can: kvaser_usb: Add devlink support
  can: kvaser_usb: Expose device information via devlink info_get()
  can: kvaser_usb: Add devlink port support
  Documentation: devlink: add devlink documentation for the kvaser_usb
    driver

 Documentation/networking/devlink/index.rst    |   1 +
 .../networking/devlink/kvaser_usb.rst         |  33 +++++
 drivers/net/can/usb/Kconfig                   |   1 +
 drivers/net/can/usb/kvaser_usb/Makefile       |   2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  33 ++++-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 139 +++++++++++++-----
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   |  87 +++++++++++
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  65 +++++++-
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |  75 +++++++++-
 9 files changed, 388 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/networking/devlink/kvaser_usb.rst
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c

-- 
2.49.0


