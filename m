Return-Path: <linux-can+bounces-4195-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60889B216F1
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 23:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EF77AD698
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 21:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330FE2E2F19;
	Mon, 11 Aug 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="dEtEEFxk"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023098.outbound.protection.outlook.com [52.101.72.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4812E2EE6;
	Mon, 11 Aug 2025 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946378; cv=fail; b=YGiMe+UGjkPjkoM/hKWErZpbRZE2Sy4uhjR2TR3JzA1lURTUyIpN9WHehTu/Doov7jq+entjHnGU7zX+AIDOiUHxs+4dDtBfeb3bJaw3uYbU51hOtUNjo6EzH6V0hbIs8VsRZ35lk2Ipnzl240LhY60rdgNMSQiOV/0ocEPVr6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946378; c=relaxed/simple;
	bh=rXoW9lRShRag9XOG8wcBlL83FMvZaW8edsrEyaf4BWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LYpYCwBZH3MD+P8YaTGoSA+KO3o2UoYMcuFXmCMi0obfWNS24S3P3zizYy9KoT6aTF0y1UQjWc1aQgx0jGM4u7s45UpgfrKQUJ8j+2gKXPGKRhz/nvnZpBxKt+yE4x4cq5Q1udIZa/zCUwadInYiQpD+2jVl68zOcgbQFrBHTyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=dEtEEFxk; arc=fail smtp.client-ip=52.101.72.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFMh+Yh4RntOK54hs1URXJ1XAfkZXA8zf/r4iAysSrK/PrkseluOUL/w1aVzfKi3i6Wdxdh9VdW7QpsIyWYyaNt7XAKMXfkVZx7qTSHgvkRHAE9Aaq4Y3KIV19uBigmMwWMTFbka2rXaRx/HCBhlPlMKfdxDPXWC/9bydGfwZES1p2wkbiDAFLKA7z1wCBM7gx9gYqqvMzkItetz8jD17WYJE+jx7usag8AEaUEzQy94McKpaKlBZ1mn3NXVFC+WIpB2CpbMstzRamROqY3AuPNfN/SBqi2kuuWxnPMlh28AdezVRaJqxRmgngI+I2xgW2PKjYdNW1wX6XH18+AtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQvqQj324FbgFTyfSk7SRQsvzcKTYAqvlUZ4oZ6aYvE=;
 b=B+9sOLlmM/deVOt/PJ2ZN+3g/a2bIFZCzo/4pnXgIPetdPBGqCzwv8lZgngNlmqCN5zA02BXjobdcxi/JbiXZ/+BwGNUI4XfJ3ZGJZp4e37h7FPtirZ6qd8+KK1YaP7vxXETAeRuqZcFfpupLjjUARuxoV3K28g0Vq2ZpgyPpzFDJzhT4ZWkaCXmmOr2Itxrb2p+ry+dLLHy64aJJLITb3oNxIK4Jm750iJbaAtVHAz0I4g3jy0RweeLq9qApdD7XHH3D0itxiO+wRPob5HT1HHz/zvil/XegUc2QSvv3HCEjMYhIgnydoYepz34YjOsVXGkb2VTbOhL1YHu6D4JIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQvqQj324FbgFTyfSk7SRQsvzcKTYAqvlUZ4oZ6aYvE=;
 b=dEtEEFxksXBmLwatPXqcXI1ZaJOHVdeO2BLk07oukhCcH7j6/beHauDb1SiYD+8M5oP1Wmw76jM+d/+kjzVnFIHgGxeIwgTOSXO2sgzDQqx9HeR+2nsKujcmwwWOLJ+qs5VCwWHeoIqBLm4PGVsoQTy79q1LNofUV2Ugd7MdQg8=
Received: from DUZPR01CA0289.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::20) by AM9PR03MB7947.eurprd03.prod.outlook.com
 (2603:10a6:20b:43a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 21:06:12 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::ba) by DUZPR01CA0289.outlook.office365.com
 (2603:10a6:10:4b7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 21:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server id 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025
 21:06:12 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id EB7AB7C162E;
	Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id E19B72EC1DC; Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org,
	socketcan@esd.eu
Cc: Simon Horman <horms@kernel.org>,
	Olivier Sobrie <olivier@sobrie.be>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	netdev@vger.kernel.org
Subject: [PATCH 0/6] can: esd_usb: Fixes and improvements
Date: Mon, 11 Aug 2025 23:06:05 +0200
Message-Id: <20250811210611.3233202-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|AM9PR03MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: d65f2a7f-d1a1-4c17-d433-08ddd91ae6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|19092799006|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2J5d2V2RndGcklxWlRtVng4NnFHUkxOdENzOEF6OXc1NVVBZHRKQUxtanJF?=
 =?utf-8?B?a2dWUkd0eGYwdVRGSDJqRWRCVDNGdUpZMFFHNmMxNTVSWVlkazE1aWgwdXNM?=
 =?utf-8?B?bFRNL0htbVZFdFlEdURNeXV2NWkzQm5IWWhKWG1tM3hOdHBVU0pPQi95SW9t?=
 =?utf-8?B?Zi9NL2pJZjc2UTY4Si9YMXhrdVNVNzdEbkprZXBLNksxaDdVa1NOVTRvMzQy?=
 =?utf-8?B?RnNNVFpjWFFHRHZHMWI1N2dZNGpLWjBvdUZxK0tFRWFHakdhRURXZXAyejZv?=
 =?utf-8?B?UjJ3NWp0S05KcUlueUNqNFE1Ri9IOWFaZzB4S2lPQ09Hajdpd2Q5WVR0ZXZ3?=
 =?utf-8?B?QVhuM0hseU5TQ1h2UXBBK0ZRZWFxRy9iV2ppUTBPSE1jdGZpNFhtN2ZhT1Vr?=
 =?utf-8?B?cHlPdXFUK0IxRVFsVCsvNnFDZE9xS3d1QWh1WFNMUFJ6cXdYVExjSEh6RFJQ?=
 =?utf-8?B?N3Z2TEY1K01FakJFZFpDTGRSSjBGZjRHT1NYNGtwK3ZSQzFwNXAwNHlKYSs4?=
 =?utf-8?B?R0lwb0E2YndrdFFFQnkyV1JkOWQzcnpsZHZyUjJaMDVRK3cvYnoyeTJqMmw0?=
 =?utf-8?B?c01nTjlSSWVVYlRzNVV2V0RvVmhaa3BQQndIRmJMR2xTMGtGeGpFQVlFejJa?=
 =?utf-8?B?RnhjUEhQdXpjTGdLWUZzUGtRaVhZajl6S3I2bGRoSDdwbkJpOXFlcEIrOFho?=
 =?utf-8?B?clM3akFOMjE3T3VNMGFHYy8vYmtFbUhFRy84RSt0VEZTNGY3a2Q1blM5KzF0?=
 =?utf-8?B?eEVBNUIxRHVXWXJaUE1tajlZOGJ2bCtCaG5sUWZMRVgxWWl5NkJCbzk5RkUz?=
 =?utf-8?B?eXRLVVAyU1dURUhkVDR1blJFTmc4OC9sVkZkZ3kvQ0Rrd1ByMXNpNmtDL0Jn?=
 =?utf-8?B?VDEyaDhOazloaHgyQWk2QmVaaWlEcUY1dTdzbmtIN2RqN2tIcUwva0QvZHVz?=
 =?utf-8?B?SFc2UXhROE9IT2RHZmZsN3BOVkcvUXlaaDRyaVJIWHhvWENzdkZoZjl2OUtl?=
 =?utf-8?B?NlUzZkg2TTFhWXJZeklDR0txRG9TSFdyL0tHMU1OSnFaTEl0Wmg4K3VVYVUx?=
 =?utf-8?B?dklWRTh6VnFPWm9tNkxUb0ozQmRWRHFSaURjbUcwSmw5eWhYREM1QWhueGJ1?=
 =?utf-8?B?NlhacUZJNDhBTUgrQmdtN1BzYWhkYnpSYVh4eGdkMXRFeFFQOWppUk9yUHJp?=
 =?utf-8?B?d3JzRjViZEtKMUIwNzgvcG5KUURUZjF4ZmEyOE5oaTNQZ0F6ZWtoNldBU0tG?=
 =?utf-8?B?ZnplQTFiVVJaTHgyYmR3d2J3Z244V3ZrR0h6OVY2VFk3anVPVkl4K04xV1BL?=
 =?utf-8?B?WVBTSmE1L3loTDhMakZucHBtZ0h0aTNlaXlRdzdNMjBObmtEcUJueGQyUnBM?=
 =?utf-8?B?R1NtL2l3Wk1hVDhlT2V5cFgrSDJZSTVsc2krQUxpR3NWQStINzdmSUJoVXNk?=
 =?utf-8?B?aHN2RUxzQTd3RHgzQmhReEV5eUVrRmZhZ0ZzQ1J6ZG5sVUtVYWk1cDB4TkRz?=
 =?utf-8?B?ZFE4S0Q2a2R5dkRqMmFRVlpaRFdKL2tUR0RwbEVGck83WUl2b0N1M0Fjb2gv?=
 =?utf-8?B?OEtxb05LRlQzbnRzMkNCbjhtbjhZdDVUWGVIeGc1RXMvWEN0bmpTcmE5bVdT?=
 =?utf-8?B?UHlwaHhiOEgrcjFDS3NMRDd2SURQZHZ0KzZlZ09YRDh1bnBiZ3VWdEdaWU5W?=
 =?utf-8?B?R2llWVVVMkxKNUFnN2hGWnFrcGxzd2srQTVndjR5UzlXandzaEZxZUNSeEI1?=
 =?utf-8?B?cFJPejgwUCtpTWttNlVwOXdXZFVWdlJCNUg4MFFQME5QdndhRmZuRmZ4OEZO?=
 =?utf-8?B?azkyYUZxWmZKTTEzbTRaMDlkWDdaN1RzNFRpT2VRVGNMdmV3cEhtNk90RmNG?=
 =?utf-8?B?OGdyTk5OZGhzdDlFaVZwRXRFaXV3ZUVUTU9XTGJNa1lxcWVDRzJrRWpnTUF2?=
 =?utf-8?B?QmJmNlFKUEJ0MUZCTTNFWXFtWHVwT1V3eW1ScUNmaUpkTGl5QVJxOEEzcHVi?=
 =?utf-8?B?c3VEWUtCR2V3PT0=?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(19092799006)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:06:12.2174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65f2a7f-d1a1-4c17-d433-08ddd91ae6ed
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7947

The second patch fixes a condition where the esd_usb CAN driver
may not detect connected CAN-USB devices correctly after a
reboot. This patch was already presented on the list and changes
due to that feedback are integrated.

References:
https://lore.kernel.org/linux-can/d7fd564775351ea8a60a6ada83a0368a99ea6b19.camel@esd.eu/#r

The first patch is only a prerequisite for the second one that
simply avoids calling kfree() with NULL pointers.

The third patch fixes situations where the the handling of TX
context objects for each sent CAN frame could go out of sync
with the acknowledged or erroneous TX jobs and then lose free
TX context objects. This could lead to the driver incapable of
sending frames.

The forth patch adds TX FIFO watermark to eliminate occasional
error messages and significantly reduce the number of calls to
netif_start_queue() and netif_stop_queue().

The fifth patch makes some error messages also print the error
code to achieve a higher significance. Removes also a duplicate
message and makes the register / unregister messages symmetric.

The sixth patch avoids confusing error messages when
disconnecting CAN-USB devices.

Stefan Mätje (6):
  can: esd_usb: Fix possible calls to kfree() with NULL
  can: esd_usb: Fix not detecting version reply in probe routine
  can: esd_usb: Fix handling of TX context objects
  can: esd_usb: Add watermark handling for TX jobs
  can: esd_usb: Rework display of error messages
  can: esd_usb: Avoid errors triggered from USB disconnect

 drivers/net/can/usb/esd_usb.c | 213 +++++++++++++++++++++++++---------
 1 file changed, 156 insertions(+), 57 deletions(-)


base-commit: 0e6639c8505d70e821bc27f951a0ff6303f10d4d
-- 
2.34.1


