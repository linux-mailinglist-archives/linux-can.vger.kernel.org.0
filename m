Return-Path: <linux-can+bounces-4052-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A312B0ED5F
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 582C07B0938
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43BF272E57;
	Wed, 23 Jul 2025 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="S0JESKCM"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2106.outbound.protection.outlook.com [40.107.103.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A162E27F01B
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259746; cv=fail; b=io8UTpWBSEULMWSbJbPHrmAdFCh5enRkIG91md3zGybTUsnc9yADPMbfPAURJbOqt2KDrngFXQ4dowwBdVbfFX5I3gTRrOjKy5j5VBDjBSip7DcieTx5aUieLz37+vFVLoRbConTUMk4Vzwyi5D4zrbmVMqkqPM19hoRk42mIlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259746; c=relaxed/simple;
	bh=PsUuUnCEl/ZxgJwRihK5kxI665ifKsw2ZYxCG0mqtes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nx0jUK0AJEM94ntUbKW1skPaGJui4uWr/tfBoSopoGazyf+8Iyoz6JUBYlmln4USfNnwSnd4Xm8fByf0cPWoHQMgwqXEGX1aGksKYYAInqlJlzqQjvKc0rqsC1xYsRO7DyW672XnqIMXa3p6UL1jyep841DrAD+tNsBhdbtZKD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=S0JESKCM; arc=fail smtp.client-ip=40.107.103.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiGXZwK5KKCq2xioAT3KgaPlra/fK1GRi7EXL2bHQxMOVgDMqbx79JhVoyxP19RNr8ANh0CsL2g1Lw8SCE3phfZoq5ziH9OEddum2vHwnj6Ofu1/Oow1C+KFPNQtYjlPGPmAgfX++KKXtpZeHXaY9rQgUAL2OVX2UmuOBua0VcmCqU5E2rNsj9h8EiCNfcRO6sJ6kw+12hYpV+BxsQ3077X0X0BBIaqKn932lulgsVSzv6XepmATsqDDBkz5PvDkRglhxsFk6BIDEcITU0mB18M+JwCIydBbTB18RlN9I+wdUqQbjMaT8XhRZ77wZRAeZQFXVV8BKkcpoChBkkV9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0lBv0ptSOaFjVzeVhqTbk6yUMpn3/IIqQqROe1D1Mc=;
 b=mYVP2uTaeL5UWUuaNK77gAyX+Nrjq2KP+elm/I9V6zEtRK7+8hNfaPJm8p9G8kzziRx+o3b9WKPW3HZuAwEUgUrQD5kFiy591Owsyl6TOhjXwEtpV5pw/vwwvIJ7aemOlcJEorPJWlso712tAhF7c9gV9lYKsThlM4UiMIJx5Pm3h0vwGxWFYz5Sujnwxsvaxp1bcoc8ZISQWzeKun22ANOUmf4XQ675OpIGrysAr0H/RwVFFgVClTgVxPa6A5D2ysQ479csXbfmSBgC1aHIJsoNuuQCk4JC380bQqvJix6VEscl7MG9VKQ5i97sYpHZB/ljaLnwebcwOApRq1SS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0lBv0ptSOaFjVzeVhqTbk6yUMpn3/IIqQqROe1D1Mc=;
 b=S0JESKCMYJlTgFTIoe6isdVWRFRFYEB9l6BPpDo6kxbWYaPacSmZaBNxA4OVkXTcNMuxu16jWm5lp59gEKLA/rqmMd03vIwigBF4sAyXrXqPsPP13cGwx/ZzegOKmEtlC9g06OHZxfnD2+E+ffj07m7QPs76rGwqZLFg9mQ1PT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU2P193MB2018.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:35:34 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:35:34 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 7/9] can: kvaser_usb: Add devlink support
Date: Wed, 23 Jul 2025 10:35:06 +0200
Message-ID: <20250723083508.40-8-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083508.40-1-extja@kvaser.com>
References: <20250723083508.40-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DU2P193MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db02797-3fcc-40ca-c3eb-08ddc9c3e473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lytm0a35hyI/UAuH0dM3HXD39S6ddW1VYFqXhXWSr7PLXu1icpUY9bP0XAfU?=
 =?us-ascii?Q?tZKUrBfNjSj4G4r8LqDcPxGBVXo+HwLuzaimBRXLkhV6sk5Guqc5rnSq6NjT?=
 =?us-ascii?Q?TpIQq8Dyp6mqt5Rtg/YGLa5U/VrsK58sEw2rY5JpJ5FwF4Hlv4ieFpS2BhqM?=
 =?us-ascii?Q?QR0LV1VyHWP1z5B+NJ3SFU6dZmsRwggmf/IWpylWCy8zclYtWLe4KJxn7ttn?=
 =?us-ascii?Q?EOwV4m+oFPsp34U/NcDEciRNmqeR8IEls8VpiKe1ulHV9TY6FTI4KhIIm5vN?=
 =?us-ascii?Q?e/x+tLE45p13ibSWzpjS63wd62hIfRuwmH/WevacX6fYq8uzIxeWoX5rht0L?=
 =?us-ascii?Q?giryU6bq+2Id8zbuf1aqaEUkP1CT45CVabtj1mYv73RIMbPYk4imNhDqUpYL?=
 =?us-ascii?Q?Efjj/P3npoyp/XNaeF1UCgGASQOZWWZkBcar2A2LZvGIxGeGes6tKOzD26Ih?=
 =?us-ascii?Q?62UJzd9eOtLb2iH+vICfDcZXOpGZ0YBInF5WhbiJtZKGgt5sn46PwCL9Kxjk?=
 =?us-ascii?Q?CVQD1SmZKEFoBGIYNbXNtvUJ3CnDqQxmuC7CkDY/O3fEaWGkAgYguX3LYXS4?=
 =?us-ascii?Q?d66nwCmdRaUhKZtmUxMs+ZzswcgkUnEu8GBN1z+tdL2yBCHi4Qjmvmmn9D6a?=
 =?us-ascii?Q?mZdxSWc7AAo7BPfWgQ7PvfX/ln0mKTH3IoLnbmb2o+AGsPKZ+YzZx6yL7ePz?=
 =?us-ascii?Q?c0Z5yCRScuCyWYlKtxANB3/uz6CFdsHaCLRYl6h1i7haTNYuHUfYfIsZHYB4?=
 =?us-ascii?Q?yydj60XbaUhyFBs7pCzXrdDmsRuf6y+A4j01GFchCF6NPVsAr7pxM45zi8fi?=
 =?us-ascii?Q?A4CCIaRy5rqOxFK8hbTyvV0zKbRexZLHoMPIYYGAquFSPiL4MG1CRYbgU/Iv?=
 =?us-ascii?Q?sZoTWeAfSqSkzBTSrjTr2HnB08jJdUK5V/uE6A3kOLETf/PbqiZ7GjBsAM+6?=
 =?us-ascii?Q?69i48guo3hHd+ZyK1m+N+6UN8D1jZPKRasPZRR6SE5H/AYRGlUy4pVIkfy4Y?=
 =?us-ascii?Q?K5XS9IqQ1aLBF2jhLb9bFYAP5V9Bw+RwAdddnMsJoNh/1qfGLtzTz6GqbFBC?=
 =?us-ascii?Q?TYDrMktOQGqsbA6jxLNWVaAP/l6Di7hjx4SQEgDOv+7EokCRUvnYQ1hcp3YM?=
 =?us-ascii?Q?XnzelXld2bbV12nQYCJ5vzMQok9Xz3urCGIBk8LGo+r80ctAxFG0/PZaeO79?=
 =?us-ascii?Q?76tzA+V/CvIsm20WMfg0mSZ6MiQJIUOMkfenivoAzBWJWQKuigJrrJW3khyh?=
 =?us-ascii?Q?inEq+kxVFnHydx9MiJyyRuXr+ICfIQTSwF58TefEvnK04+GCsyUd98RTFWRM?=
 =?us-ascii?Q?t8G9dHip3YxXsEpfESx9oEEkR7B3Y5oyQh++l8NL7D8Ni8oFmq32hsKtFrVc?=
 =?us-ascii?Q?QodjHVq4ireR1t7XmbdcNs1TxT1vtjbRq6FuaJ1efBn7u/5Nyc6n1K7YNtsL?=
 =?us-ascii?Q?rDJmIy3IQOs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JFiGbTlw5Bzx+bKK+rhwNP17Ytl90vMWPPCfrewx78Ng9Rbm6zsR7QPkcr1I?=
 =?us-ascii?Q?J8gtJXlX2nFZOyj74ffwvRGxkyj7kegBscVzmp40Nt4gpPbR5anhx2Ep4mlM?=
 =?us-ascii?Q?goGrtf33XUtEeZVOD2KXbqfXNDeyiPwM4zT6U6Trk4/Zyc9q2owI74IzjL5b?=
 =?us-ascii?Q?9Yn0UjkruXJCRg35QFvz91xFSydGbZPod2RBnWyV5B1WvJvrjioZYRky9kbp?=
 =?us-ascii?Q?jtZEufCyRfJrJ3MFYSRk3D1NxyTRQF0gI+x3xlfCFsEIkGk1N6t6MUN/GPNu?=
 =?us-ascii?Q?q/TR2YBwbOpW+S9SLqGcJ3Lj8HvBPyc1RHQJXsr3WL0uVF1ro/kmtUL9HpPJ?=
 =?us-ascii?Q?UF15M28X9trU7mm9q+tViUFcW+tv2OsOtZZae17CtKIDpGhhzETha/yo+oHn?=
 =?us-ascii?Q?TB2qXBv4/KuVAPT0EAeb9Nvvo+6uQo7T/OMURDzGBqwZlTvFP6CE8bQvT9V0?=
 =?us-ascii?Q?LOrhOik7JtulsmlpFUB1fHiR4tXsRxHxzQ1BCqwRsLP5P6NR1jwZh3O5ktmx?=
 =?us-ascii?Q?RYZbRy36I7HXnjbrWEmyOWUaEn2hovxbXdulx6r4UocPK9C5ePSJJovD1mWh?=
 =?us-ascii?Q?BdP3DtgJl3T5Ij4Q8pVelfrm3GKUHhSO7jfL2gkgAZt4ArnUAQRQ/P4ycxaI?=
 =?us-ascii?Q?Fx/IvC67xfMeJQXmKBvvLRJdjFsgYLIBG3tqm+71iOg3PoHkTARiFryP9u1v?=
 =?us-ascii?Q?uAu4vvSZPnV17lILGHQ3vQKUxeXrXHQkSGgxzaZxCGA+0f4vq3L8KGJ3zzKd?=
 =?us-ascii?Q?DNpzIwYBpEjQ5WjMuVBsJ/Uo70tLW8Dq8h+d16GDJBQ1RsGkbndQWcfr6wQx?=
 =?us-ascii?Q?X2++lfmfT1VseEJr/rDQqeQ0Jf3yJ0BMigF0es3kdJAUSGnwT381jXtGeB4b?=
 =?us-ascii?Q?G1wo2E3TOlButp0ou2gkV4A/1z9LU0p+qyuDjXqPndVFOGdbBT7ui0WGaUfw?=
 =?us-ascii?Q?5DBQYeaiid9vVn/aN0l1n5UxxD/CbAHyLsZASDWoFoaC2D1Ost1BLzh6vXlc?=
 =?us-ascii?Q?5i7h7EG8BlGdD/L1uISnbKRmREFkA2vBp3LhmZMDdqYrupOmK9Up2nN7PaQJ?=
 =?us-ascii?Q?Vymj+X29lZ3lGiDDO4lfU5guaXSkDHRQCasd2rfG6dnBq/ZXseNOib3/12do?=
 =?us-ascii?Q?1AEh6FM68ZjgcxpsycWwbrKbzj6DiKrm6yYosDaarGk5SrbZRpXCIxXbgOUQ?=
 =?us-ascii?Q?zSscVECZv1pXRdZ+VGuXKhVNwMEvTQAYhRhCRsCJfBeV7MMt7I3DQeHHLY6y?=
 =?us-ascii?Q?jnqzw5PVGPfiU7PUtaFxUTxwYTdKjmuwF066IfY1/j3vrPHQYXGVTYus9UJd?=
 =?us-ascii?Q?1lEvao54iKVscKMs0rKwOWDanqN2gE5NjToHpg47Ln4iRiMovedG8F0SnUWw?=
 =?us-ascii?Q?I785YzthLtb5YHjacMy9YSMGPRvoYvbGJRRY+JzZxzrUZ9fWdtjyH8jswnuG?=
 =?us-ascii?Q?j0jCdptQ3vD9BbBL9CFnIbdKhI4cwNhpCmSC3E6JvwSFLbw5wMNsb4pOP04u?=
 =?us-ascii?Q?U4UOkx5y8j/BNxyqLv9s2pUIwnhaFOFpkol+PtxfOXlUbYvRHLEkZIe8GFE8?=
 =?us-ascii?Q?OuL4ZgAw3s5G3g1nqt6KiH7Tx/Ad7r7fLS2TGGgm96CLPpD+Hjy8e3xSGZr6?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db02797-3fcc-40ca-c3eb-08ddc9c3e473
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:35:34.7148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsTX9zF0rrIFrM94R1CGc9aiJU8zitT11pyQHYxhMqJETgjUtjpAv6NgtayIYrWc7WIvf2JGCz9+QD+cRCjqd494S6TXqORP6nyxAq/BWW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2018

Add devlink support at device level.

Example output:
$ devlink dev
usb/1-1.3:1.0

$ devlink dev info
usb/1-1.3:1.0:
  driver kvaser_usb

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/Kconfig                   |  1 +
 drivers/net/can/usb/kvaser_usb/Makefile       |  2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  3 +
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 72 ++++++++++++-------
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 10 +++
 5 files changed, 62 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 9dae0c71a2e1..a7547a83120e 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -66,6 +66,7 @@ config CAN_GS_USB
 
 config CAN_KVASER_USB
 	tristate "Kvaser CAN/USB interface"
+	select NET_DEVLINK
 	help
 	  This driver adds support for Kvaser CAN/USB devices like Kvaser
 	  Leaf Light, Kvaser USBcan II and Kvaser Memorator Pro 5xHS.
diff --git a/drivers/net/can/usb/kvaser_usb/Makefile b/drivers/net/can/usb/kvaser_usb/Makefile
index cf260044f0b9..41b4a11555aa 100644
--- a/drivers/net/can/usb/kvaser_usb/Makefile
+++ b/drivers/net/can/usb/kvaser_usb/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
-kvaser_usb-y = kvaser_usb_core.o kvaser_usb_leaf.o kvaser_usb_hydra.o
+kvaser_usb-y = kvaser_usb_core.o kvaser_usb_devlink.o kvaser_usb_leaf.o kvaser_usb_hydra.o
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 35c2cf3d4486..d5f913ac9b44 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/usb.h>
+#include <net/devlink.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -226,6 +227,8 @@ struct kvaser_usb_dev_cfg {
 extern const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops;
 extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
 
+extern const struct devlink_ops kvaser_usb_devlink_ops;
+
 void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
 
 int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 68f23cd61ec6..d93b9460c683 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -916,6 +916,7 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 			    const struct usb_device_id *id)
 {
 	struct kvaser_usb *dev;
+	struct devlink *devlink;
 	int err;
 	int i;
 	const struct kvaser_usb_driver_info *driver_info;
@@ -925,17 +926,20 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	if (!driver_info)
 		return -ENODEV;
 
-	dev = devm_kzalloc(&intf->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev)
+	devlink = devlink_alloc(&kvaser_usb_devlink_ops, sizeof(*dev), &intf->dev);
+	if (!devlink)
 		return -ENOMEM;
 
+	dev = devlink_priv(devlink);
 	dev->intf = intf;
 	dev->driver_info = driver_info;
 	ops = driver_info->ops;
 
 	err = ops->dev_setup_endpoints(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err, "Cannot get usb endpoint(s)");
+	if (err) {
+		dev_err_probe(&intf->dev, err, "Cannot get usb endpoint(s)");
+		goto free_devlink;
+	}
 
 	dev->udev = interface_to_usbdev(intf);
 
@@ -946,24 +950,32 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	dev->card_data.ctrlmode_supported = 0;
 	dev->card_data.capabilities = 0;
 	err = ops->dev_init_card(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err,
-				     "Failed to initialize card\n");
+	if (err) {
+		dev_err_probe(&intf->dev, err,
+			      "Failed to initialize card\n");
+		goto free_devlink;
+	}
 
 	err = ops->dev_get_software_info(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err,
-				     "Cannot get software info\n");
+	if (err) {
+		dev_err_probe(&intf->dev, err,
+			      "Cannot get software info\n");
+		goto free_devlink;
+	}
 
 	if (ops->dev_get_software_details) {
 		err = ops->dev_get_software_details(dev);
-		if (err)
-			return dev_err_probe(&intf->dev, err,
-					     "Cannot get software details\n");
+		if (err) {
+			dev_err_probe(&intf->dev, err,
+				      "Cannot get software details\n");
+			goto free_devlink;
+		}
 	}
 
-	if (WARN_ON(!dev->cfg))
-		return -ENODEV;
+	if (WARN_ON(!dev->cfg)) {
+		err = -ENODEV;
+		goto free_devlink;
+	}
 
 	dev_dbg(&intf->dev, "Firmware version: %u.%u.%u\n",
 		dev->fw_version.major,
@@ -973,28 +985,36 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	dev_dbg(&intf->dev, "Max outstanding tx = %d URBs\n", dev->max_tx_urbs);
 
 	err = ops->dev_get_card_info(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err,
-				     "Cannot get card info\n");
+	if (err) {
+		dev_err_probe(&intf->dev, err,
+			      "Cannot get card info\n");
+		goto free_devlink;
+	}
 
 	if (ops->dev_get_capabilities) {
 		err = ops->dev_get_capabilities(dev);
 		if (err) {
-			kvaser_usb_remove_interfaces(dev);
-			return dev_err_probe(&intf->dev, err,
-					     "Cannot get capabilities\n");
+			dev_err_probe(&intf->dev, err,
+				      "Cannot get capabilities\n");
+			goto remove_interfaces;
 		}
 	}
 
 	for (i = 0; i < dev->nchannels; i++) {
 		err = kvaser_usb_init_one(dev, i);
-		if (err) {
-			kvaser_usb_remove_interfaces(dev);
-			return err;
-		}
+		if (err)
+			goto remove_interfaces;
 	}
+	devlink_register(devlink);
 
 	return 0;
+
+remove_interfaces:
+	kvaser_usb_remove_interfaces(dev);
+free_devlink:
+	devlink_free(devlink);
+
+	return err;
 }
 
 static void kvaser_usb_disconnect(struct usb_interface *intf)
@@ -1007,6 +1027,8 @@ static void kvaser_usb_disconnect(struct usb_interface *intf)
 		return;
 
 	kvaser_usb_remove_interfaces(dev);
+	devlink_unregister(priv_to_devlink(dev));
+	devlink_free(priv_to_devlink(dev));
 }
 
 static struct usb_driver kvaser_usb_driver = {
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
new file mode 100644
index 000000000000..9a3a8966a0a1
--- /dev/null
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* kvaser_usb devlink functions
+ *
+ * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
+ */
+
+#include <net/devlink.h>
+
+const struct devlink_ops kvaser_usb_devlink_ops = {
+};
-- 
2.49.0


