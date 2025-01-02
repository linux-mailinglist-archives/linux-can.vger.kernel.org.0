Return-Path: <linux-can+bounces-2528-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C68A000C1
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 22:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B2B162A58
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 21:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB56C1B425A;
	Thu,  2 Jan 2025 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="ReTPVQ3b"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2127.outbound.protection.outlook.com [40.107.21.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA951B0F0B
	for <linux-can@vger.kernel.org>; Thu,  2 Jan 2025 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853804; cv=fail; b=NzjJo9kRhQaiOGkGhQgwtOquAc0vY+TO59B+xF+fnIIO6AjeAgAZg9r61e32WTeIKboVeHBWPW4fz5VRG/19bO3N0L3LccaDfPFQbWE42YfIlqr2Gx/dsVQP1Sw69SsieVFQo+YBN16euBU6SX57K2zCSBPhTEyGpUIT3G5nAgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853804; c=relaxed/simple;
	bh=DVM5f7sG5i8O4c0N06Zm2lR35UsvkwVqTseB2ONeYuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iF35qp2XgQNLfOOarAJ0mBdbJu9ploaT+ub5/pQle9eAyTm23P1bJyHzWG/TiKGX90dNeV9fTfwVucRVQmGfMDt0h6FMyVJvQ3Tp7Lazw6ZKCSwSzdb1iCBMDRnnw7hF4zl5KnKS3Q5+nwzlAujANleCH8AHhoVHxmH4Gctuv6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=ReTPVQ3b; arc=fail smtp.client-ip=40.107.21.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHR2bl6KUUYqILLia+Yt7383T+AuUJgiCtARZ45qITYxJm4fqzWemrY1SpbFGYk6lmQn7HvnjPvcimp/JEeQj1wDL8U1xjS3RYA8ZdWorZi+LGtJ3jziSahRqgZJjLxm1eGyaIJscThZ4wWQnWtXSIDI1mHefeEQKcQYH6rLem/pPqhRYl/v+X3/pj5sfXFgZR90O79q/K0V1nwBiOsvdB12PKa5D0zhuRjJd4bDi9qqoj+ucyObZh7lgHVLeydxU4ePtfrPT6/+PjMQ2wkCRKwLQjN6NHykQKwmftHBjpBpPCS8+dUYcC0jHgu2Dlai9cyMoFsenbmB7X4iTk1Phg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UKES9sH5tV9GYFuWpaxOnsdNodcjIey0sUOatFjvbU=;
 b=FHwx4v7YXlWjhIpYdHPrl24TVTPlgJLC3NsaWvEYZkQT9jkysQhtiAm7q/IuU1UkuVaGrYHi6OerJl0GWyNIj2BSyDOs7UEJ3XxjGqYw8deHJ1aCSpHK2XUsdjYIy4VRRkhlPmSQuLpr8G8Ttd8fBT8jFmDnQvBPCq7/dSzGZCiIwS4V0KuZYsi8QwXhHnp2iRJfXFIpFig1sWIUhxVf9iHBc8V8nbQKTfEzG6/jFfG9VuA5vsGOoACVPRpJU5P7Sq8KuTEAuUOc0XjZZ0TM0t4qoI0d/FmWX6JJvRyt8JXL2T5YNnWDcd7CcjSEqSgY3jn4lxD6vJ/jNPNnqYIZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UKES9sH5tV9GYFuWpaxOnsdNodcjIey0sUOatFjvbU=;
 b=ReTPVQ3bznMWEaLbt6pg43u3Cl2GXBJyxGOB61tr7fZkpwOa0Ntfc/RpX0+VVRZIqZ1y9zCU5tIPfcHgBjzZh13jHAK+psTabhlslhNlw1KPSHnn9CChJ3M9C2fv7BwJUzC3zhy805RQ2meCV+D7Co+O/c/R6/5BpboAU6371PI=
Received: from PAZP264CA0028.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:122::15)
 by DU0PR03MB9447.eurprd03.prod.outlook.com (2603:10a6:10:41b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 21:36:32 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:102:122:cafe::7e) by PAZP264CA0028.outlook.office365.com
 (2603:10a6:102:122::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Thu,
 2 Jan 2025 21:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server id 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 21:36:32
 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 11F557C1635;
	Thu,  2 Jan 2025 22:36:32 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 0600B2E8034; Thu,  2 Jan 2025 22:36:32 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Robert Nawrath <mbro1689@gmail.com>
Subject: [RFC PATCH 0/1] iproute2: iplink_can: introduce support for FD-COMMON-BRP
Date: Thu,  2 Jan 2025 22:36:30 +0100
Message-Id: <20250102213631.765503-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019C:EE_|DU0PR03MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7176e2-0fcf-41ff-0168-08dd2b75867d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHJLQUduSE41bUE5dldldHZDWG8vMlQ5MzN6RUl5UFhqU2dFbFFJdWJrSVBj?=
 =?utf-8?B?VUJ6bGhoeHBuUkc4YkNmdjczSzNGd042YVIydUFMZ0pCUjZDb3loYklCeXFR?=
 =?utf-8?B?LzRKOEtIaVhEQUNmWGFYY1JOZFpML2xaVGQ3WFNEY21tWnhsS1JZMmt1NzVu?=
 =?utf-8?B?UDArVElNRlExcWRsbit2SmlRby9kalNNNjhBYlgyY1dIaE5kY1phV2k1eWts?=
 =?utf-8?B?dlI2bVJac0xIT1pCWXhxQXViTEVhUzZHUitoZUVwUGJOSlliWGhFbzh5ZVl1?=
 =?utf-8?B?ZjlzVVMrUTljOXIwem4xVzIzQzFEcmlqWEFDNUxuTkszN0xmL1hpVE5nTjJF?=
 =?utf-8?B?aWNRVnNvc09NWi9VaXFRVStJOVRWL2tpbmdpNUxKMnUwbHVDTWRsd2Z1Z0s1?=
 =?utf-8?B?OGx6WjJySXJ2bGtKTHdZS05vSlVUUUtNdzJVdDdJU3ZsR2ZQb0pUa05ZLzhN?=
 =?utf-8?B?WlVRWGNuTWpsUFF5R1N0cU4zekxqS0pzVkdQRmwwcDdiclVNMDU2VmtIYThB?=
 =?utf-8?B?Z2YzYW5USGREU2ZXZCtBa2NlK25yS3RjdW9lOGJRTmc5Q1M2eVhZWU9FTFlw?=
 =?utf-8?B?bklORGQzL3lIRnNteWpJVHdJRm1IOGx4dC9aMVpnaE5pQWtqZXJjK1BXMmVo?=
 =?utf-8?B?YmxNNExsZjZxZW5PaWZJM2piRGs2TmhPR2Q5U21EejU0QUhxbXFHSE1uM2Nh?=
 =?utf-8?B?Yy9HWGRJQUpYODl6Y3FKaVRhaXVxSkhJbmF4c1RZQWlOcHcvVGFkeHJjMDBS?=
 =?utf-8?B?MmQybzhScFJxRXlxSkFPY1BQemxxOUtlMW45MXVTazVPb2p6ZERqcE1DUld4?=
 =?utf-8?B?UVN6U0FSckkvdC9xOS9XVDcxYW84M3lkdGNYdkxodW56TkIwQ1R3d29TOE83?=
 =?utf-8?B?a0JjendRY3ljYWZiV0U2YzRJdHI1L2owS3Y1MHh6cXNaWjVsa0cwR21xWnl1?=
 =?utf-8?B?emtqSDh3YU1kZ0JsUmZVdHlOb2ZqYjIycS9nVlc5aTdCQU5QeUlIOFZiTFo3?=
 =?utf-8?B?bnNlaE1ON0p4MW5BOXZsOWF1ZnJLbnBKam80SFllSVFsbnUrdjc2Wm9tb1hS?=
 =?utf-8?B?YVJhQTRDRU1CUGFzbGwvb2VjdU5hNDZzQ2NIMXUraW82QUxlYWh0U01peGFL?=
 =?utf-8?B?UFlqaG13dWFybW1zYUM3QnVEVEVQcVFQRzMwMnVidmhPVXVhMi8vMldPN2R2?=
 =?utf-8?B?cUY0eWc1ZGRHdVhndlUzQTB4LzNPTFdkV2NqdjVOWVRrQXF1akhkSm91S2Fk?=
 =?utf-8?B?ZVFGK2xPcCsyWkJqV05MNktGRWRxZTdFVTVqY3E3cW5Sc2VtNlZiMnh4RFBB?=
 =?utf-8?B?U2Mva3JMU0xzcUxlelEyZ04vOVRraUZXWmtOQmV2YitIdGd5V1gzdXJ3M1BB?=
 =?utf-8?B?T0VKelM2aVluQUtpZmpxUUZTMmZmMys4RTd3aTUwOU1UNXk3MCtVck9lRzU2?=
 =?utf-8?B?eGo0c3FHYTNFRTNDZ0xPT0svcXdodUdDVVBTZFl0dmE1WE9EeHVWN29veWlq?=
 =?utf-8?B?OTFHZ2ExRkZqZWlteWtaeTFlL0tjSXg5WGl3Tkh6MFc5K2I4U3lKL3c0alMw?=
 =?utf-8?B?NHdKMmw1Szc2Snk3UDljWWNrREl6SWxGaFB5QVJwekEwMWtEQ0tNYkZrNmJD?=
 =?utf-8?B?QnlZbytuSFM0YWFPYXlBQ2xLa3gvSTZTQjJvcXBnK2tPV3lxYWpPNy9BZ0dh?=
 =?utf-8?B?VkF5MTRxU0lCRUQ3S1h4RWRMOUFMQkxCK1hsbjB3RGljLy8zd3NFeTBKTEdK?=
 =?utf-8?B?TmZpRithclo5bGNsWVJlQzFEWXZJc28rRytxdmJEQk11Tkp0R29LbFJkTXZX?=
 =?utf-8?B?bjlwSWNJNFVvSzg0cUN1WjFoTzg0VEgzZmRGcmxvRFFqS3lyMUhJWDVOMEll?=
 =?utf-8?B?eXRKczRkRlBsZmxaUHVtVFlEWmUvdHo3U3BrSlovdVdJOStrT2JaQmgvVklN?=
 =?utf-8?B?WDgxTG5VS0JhTEtvd3RrWnhvUDQ1bWdQYXAyU01XNjdMSXI5aDk0RmxDc3gr?=
 =?utf-8?Q?HKahEaSvO0JvzimeglErQL1X7obkWU=3D?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 21:36:32.3360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7176e2-0fcf-41ff-0168-08dd2b75867d
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9447

This is a follow-up patch for the patchset published as

https://lore.kernel.org/linux-can/20250102185821.670839-1-stefan.maetje@esd.eu/

and supports setting the new CAN_CTRLMODE_FD_COMMON_BRP to
test that patchset.

This patch introduces the support for a new control mode for CAN
named "fd-common-brp" to tell the kernel to use a common BRP for
the nominal and data bitrate of a CAN interface.


Stefan Mätje (1):
  iplink_can: add CAN FD support for FD-COMMON-BRP

 include/uapi/linux/can/netlink.h | 7 ++++---
 ip/iplink_can.c                  | 6 ++++++
 2 files changed, 10 insertions(+), 3 deletions(-)


base-commit: 19514606dce31e85039b3b19d538e576824a03f5
-- 
2.34.1


