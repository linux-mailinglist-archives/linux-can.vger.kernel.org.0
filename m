Return-Path: <linux-can+bounces-4974-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F9B9B0F4
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 19:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4D919C28B8
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 17:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644EC315D4D;
	Wed, 24 Sep 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="tMJJ7HG/"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021082.outbound.protection.outlook.com [40.107.130.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC585260;
	Wed, 24 Sep 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735044; cv=fail; b=ulOgD/ZODM9VtboEpBWH7pStx5SQkID8EZE5PVLUMoAtizQFmuxS3i1PoZEeB/Qg1+4E4UBNS3Ayk906vQjn3MK47z71TLNz/DisOO78YcPfsXpY0uAJ7j6yKXCS+k60pG7ap0kAOWIfxAeS/BZhoVZHxUrEQ8cOYU99rajx9iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735044; c=relaxed/simple;
	bh=c/9T1spz1+OQHD7gQyFSEvITVFp5gnl0Sxk7zQbeg10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bkF2mAVsm9alwePIyMQypG1hYamRldDiaJhZiJ5IqX8yC1HhnF9gf1Z/a6xntuQAAN2YKMf3pa6GIYc/MZs7G+ApyQaZFgIML3lR0I+qH1xBlUpvcKxjlXAsRdqh104J/tzt9NZ6YK11StuM/ouagqzCBGCuAy5Z5BfWgFjiNDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=tMJJ7HG/; arc=fail smtp.client-ip=40.107.130.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjFEXqgEmKaDm2LWGQCr5ianhKyeaDtWvDeJxrRxJypz+ks2nXjA6DUPsJ7EtLJecVtyZZGyqeSHUY4/kCuJvlbt2atXkZa9+w43Nt1urdyOZAZgRZr9hZOTyoz9cJ9ub9fgzOBA8me7A5bdBOCcN0Q9JHTnHM2l5ybulnGlhTOSYYNFSpGqT2c/6SAnGKzdAbEDxSd1wxZZGRqnFA85edfA9ZcgwDF5WUJ/kmOhvJl61sGTPTCVTCQTTvaWfY2eGJGUF2yxUFckSqc1igy++fD/2/vPfqfdbkv30VDaIby931gs1sCvd/bnx/jyQm2I1lUJtgQVu7EtoH7ZH24g2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zy3NiaT3CZjYPSD+tr7fxUEhS0qCcE8u6q4pCW0jC4=;
 b=VOQfMwpyqz28DAIZTL4F5VcqqOa85oWrqRSgzat8GudFjyTMAwjNfel8LsmoXaJ7TxwSaoiG3zbqH6lR+7KOgH3ClfSopfnw0HgzbHKr+53+vnoIWb+jSNEfsuJ0ewRKxUclJzTzYzBXFLxxQ9AAbmv7K75v8YK2/pjQ7tck3RypkkYRJWet9UOpbhP5Bwu+0I8dJKYe9oZcBC1vdvAMjUSF8frXYaDZ0rh1hiI+0y4LREvRy4zF4kyR2r6NhVwFe7TAm1m02DfxdspUM4eDtrGakyrrdaes62p+IRYYEnqG+vIEupVDvHDtfcrhHGquYrj683hVBJWgUtG9I9nBHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zy3NiaT3CZjYPSD+tr7fxUEhS0qCcE8u6q4pCW0jC4=;
 b=tMJJ7HG/Y4aKA/BzPnH5kAXFI3yAR1xqaI94Fvv0zU4kWQEgozgM1shIWiYErmYchc+0Q3gmLVGshJoRy9qX8CviCeOTdycRN9zV9mLSowS90oNFi31VdV+pylI6ixz9ZGkGEogd/uneKOlUYnOAA92coOJZ5fAVJPKXSWmvJ6k=
Received: from AS4P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::17)
 by AS8PR03MB9217.eurprd03.prod.outlook.com (2603:10a6:20b:5b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 17:30:37 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5de:cafe::9) by AS4P190CA0005.outlook.office365.com
 (2603:10a6:20b:5de::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 17:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 17:30:36
 +0000
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id DC7BA7C1635;
	Wed, 24 Sep 2025 19:30:35 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id D10A12E25AE; Wed, 24 Sep 2025 19:30:35 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Frank Jungclaus <frank.jungclaus@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	socketcan@esd.eu
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Simon Horman <horms@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 0/3]  can: esd_usb: Fixes 
Date: Wed, 24 Sep 2025 19:30:32 +0200
Message-Id: <20250924173035.4148131-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|AS8PR03MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7139452b-f633-48b1-e12a-08ddfb90129a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|19092799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z00rVjV0NzNCaGEvN2hNVXpXVGpqbERoNXpSR2x1WmxoZTJHK0x4OEE2ZEp0?=
 =?utf-8?B?UEtzeGJxRFdmdjRCT2J3aVFORHdXYTF3c2ZROG1NdFR0Q2NEb3pheGYvOTlV?=
 =?utf-8?B?Zk1Mb3NEMkpBdjhkOCtCNkliMS83VXZJN0VtMHNhVjc2VHVMT0o5VGxnUG8x?=
 =?utf-8?B?cmtOUzcrWjF5ckJJNkZZcjQ0S0h0NTkzb3E4Uk8raExscEF0UllCdkZXYm1t?=
 =?utf-8?B?cXRZcThzS0hna0M0SytXUVNDQlB2OTZKdGh5NWtVTEU4dm9mL0ZBMjVvNFFZ?=
 =?utf-8?B?VGJqTTN6N05FWWxOOW10TUtvMmNoajdPMGFPb1ZYbkhjMitXRzBXUHlqSkFs?=
 =?utf-8?B?YlZpWDJoMFlkbDd4NlREeEZ0d2xqQ0FVYVFIMlVBSmw2SkFITzRzdXVYeTJZ?=
 =?utf-8?B?MER1OTFZckc0TEx0RVZLdThjb1JxZkE2UEpISTd0THkwakVUNTZqQjd6YlpJ?=
 =?utf-8?B?UkNWbWZseHQ2MlA4UENLQmsxSmJSa2ZERmlSd0JXMVcwd25EMXFzRE4xbU5G?=
 =?utf-8?B?MTJidURRZHRrdDdXaXoyRWtYblcwcUUwTlhoVzJKNXorQ2x2RVkvUHVOV1Fy?=
 =?utf-8?B?K1NxWHI3dy9LSDB1NlYvOW1odDM4T0duTG0xYUM5NEdDWk11Tm9mcWIwaDNE?=
 =?utf-8?B?elQyYm1tSDFwdmx3N0JpUGlBNDZSVFpSMmNIc3lLWkdENEFYT2JzYUJTZDFP?=
 =?utf-8?B?WDJLUDlyd3duUldFV1QvK01HRlZTQ3dYWEp1Rm9ZQnhDMEgza0xlYWdtaEQv?=
 =?utf-8?B?YmF2Z0RzUkU0c21qc3pIaTBteXVVdldKcGF2eitIYW4rNUY1VWtFZVliS2FE?=
 =?utf-8?B?YmIvRWwrclFvbHA0VzJMajZJeUdETDhnT055TG16eGZqSVRhM2RqT21pQVdV?=
 =?utf-8?B?ODdzRFlyR2pyM0FINWd4Q3NJNjJ3S2JXeXZhMmxLS2lQdENGNHB2SHNjTmw5?=
 =?utf-8?B?UjYySk81NEFVbjVxVnpyYnk1RmM5SGVSb1dFWHh2cEphbWJvcnJqeEhBRElE?=
 =?utf-8?B?Ky95SzVqbms5bzJxT0V6MjJjRi83aW5ENXI2cElYYlJ4aHZmQnFPU2RUQ3dJ?=
 =?utf-8?B?Q3l2dUFaTVIxWlVNZW5qR2xWVDcvNUpVM2QzRXdRckhjSUI2K3pQZExaVjNw?=
 =?utf-8?B?VjV0dXB4c0JqWXdTRnkxZTl0eXFkczNzcEJYdXhLQWpoL216a292V2plbjlR?=
 =?utf-8?B?a1RYdDdhd1Zad3pRKzdJZHBKbjM1VzNzbEFKL2xSNEZ2Vzk5dDBBMUZDNmJu?=
 =?utf-8?B?L3Y1VHF5bktqMmNNN08wWVhxUUVBUDJ0eVVFN3FJRXhCZGQyT2ova1lSVDRv?=
 =?utf-8?B?MzlSY1RnM2VzcHViQ3B0Ylh2Um5xSUNadktlaGtuZmJrTEpqbG1EVVNsc1Nk?=
 =?utf-8?B?RUw5cFVjUkl6N1ZhQ2NzR2ZWRVpnR3J2d29WY1RSVFlTaTgvMlhzSG5PNDYz?=
 =?utf-8?B?a1o0UDRlZGhpaDMyRnFyVVo3dUwwY0J6Umd0bjByUENVdm16R2JzOGsxZXF4?=
 =?utf-8?B?N0Rad0JHZTdoOTZNZjNpVnZMM3dKQ2I3dTBYa2E0dC83Wm1KODl2Q3NHK1pV?=
 =?utf-8?B?TkRFbkJocUkzR2U3MDljekxoTm5kejAzRmVFVHR2anRBUkFjWEgxNGJqMkpD?=
 =?utf-8?B?WWRRTkszcmdYMTFSc2pjVWZaMzl1RjI4M3lsTkdBTFhEVmFvZHNWd3M0a09m?=
 =?utf-8?B?KzRxb2FuZU0yL1hLUU5oektuMmdHb0lGYXhUMWhBbU9BdE1kWUY3dWdsSXAz?=
 =?utf-8?B?cjVFdzZ0RTlTWUROYUZycWNtdnoyN2s3eVhDVTZDa3JiNVJKWHZHSlBRVTMv?=
 =?utf-8?B?eUFRLzRjSEExeE5RRGRFRzlRVUkydTBTOTAwQUowMk8zYVpGK2dDMG01Ujls?=
 =?utf-8?B?ZjgvM1N5WENaaGQzVkY0Vk9RVEVGYXJyOGxkZWNjWUgzSkpoYlhKYjJXbDFn?=
 =?utf-8?B?OE5DNkZYTXlqM0JjSlNOaERaUDhZTDYvTUdTQWJHSW9YYkxSRG52Mlk2Nmd4?=
 =?utf-8?B?UjRncXdKOE53PT0=?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(19092799006)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 17:30:36.1625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7139452b-f633-48b1-e12a-08ddfb90129a
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9217

This was originally a patch series of 5 patches that is split
into two series, removing the forth and fifth patch. I keep
increasing the reroll count from the original series.

The first patch fixes a condition where the esd_usb CAN driver
may not detect connected CAN-USB devices correctly after a
reboot. This patch was already presented on the list before
starting this series and changes due to that feedback are
integrated.

References:
https://lore.kernel.org/linux-can/d7fd564775351ea8a60a6ada83a0368a99ea6b19.camel@esd.eu/

The second patch fixes situations where the the handling of TX
context objects for each sent CAN frame could go out of sync
with the acknowledged or erroneous TX jobs and then lose free
TX context objects. This could lead to the driver incapable of
sending frames.

The third patch adds TX FIFO watermark to eliminate occasional
error messages and significantly reduce the number of calls to
netif_start_queue() and netif_stop_queue().


Previous versions:
 v1: https://lore.kernel.org/linux-can/20250811210611.3233202-1-stefan.maetje@esd.eu/
 v2: https://lore.kernel.org/linux-can/20250821143422.3567029-1-stefan.maetje@esd.eu/

Changes in v3:
  - Split the patch series of 5 patches in two keeping only the
    first three with fixes in this series.
  - Rebased to linux-can.
  - Take the patches from the pull request "can 2025-09-22" to preserve 
    reworded commit messages.
    References:
    https://lore.kernel.org/linux-can/20250922100913.392916-1-mkl@pengutronix.de/
  - In the second patch use net_ratelimit() to rate limit a changed
    netdev_warn() message.

Changes in v2:
  - Withdraw "can: esd_usb: Fix possible calls to kfree() with NULL".
  - Reworked now first patch:
    - Functions esd_usb_req_version() and esd_usb_recv_version()
      now allocate their own transfer buffers.
    - Check whether the announced message size fits into received
      data block.
  - Second patch: Added a Fixes tag
  - Third patch: Added a Fixes tag
  - Forth patch:
    - Convert all occurrences of error status prints to use
      "ERR_PTR(err)" instead of printing the decimal value
      of "err".
    - Rename retval to err in esd_usb_read_bulk_callback() to
      make the naming of error status variables consistent
      with all other functions.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
Stefan Mätje (3):
  can: esd_usb: Fix not detecting version reply in probe routine
  can: esd_usb: Fix handling of TX context objects
  can: esd_usb: Add watermark handling for TX jobs

 drivers/net/can/usb/esd_usb.c | 175 +++++++++++++++++++++++++---------
 1 file changed, 129 insertions(+), 46 deletions(-)


base-commit: c443be70aaee42c2d1d251e0329e0a69dd96ae54
-- 
2.34.1


