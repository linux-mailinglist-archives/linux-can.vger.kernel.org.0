Return-Path: <linux-can+bounces-921-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E472391E495
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B02F281452
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71D22C6A3;
	Mon,  1 Jul 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="kIdEwt7I"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2128.outbound.protection.outlook.com [40.107.105.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363C16D4CB
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849008; cv=fail; b=afXSMQRoWZBuZWeKDZHIGxgoY/knQleBItQBrzxixoIvlH5+N8OJNxIRGdl02k8yFEl5J+5G/h3/naO9+v8QOBZorrW2+ZK+wIqRpYsCFqwRCNVrhAfHydlMUHuzh0/5N1K92C3xvb0ySuvUwsYmK7kgvpVrKpkNqqCu7E1TmdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849008; c=relaxed/simple;
	bh=VCMSM3togmNu7xJqjwGKRC+Wc1t2c6zZ0+Gk83whl9o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T+5nB1tbxxer7JMuswq1Z01vc/tpSOMNX1yinrQ8ZYrqrkEAeIqFaMi7WqORCYvJuRzL5p77DEBfjzQo4en4ctWNgLbjk7zYoQiYkYzHvxajFE+qdft3JZGU1Mw0rT3xp2u+pyoNGjk/tCrGqgE7Aps388MNnIoJ+gBFZ2H1zM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=kIdEwt7I; arc=fail smtp.client-ip=40.107.105.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqiQojXEdxZLXZf4z0RrtYbbDesScd3SuBoCVwuBp1+H/TQZ0IHtBU+Tn8LhKgjMLbRGnTUFd+hk0kzT270T2EvGP/uxkXuAtOxYnXos3l+E+sdOWE+whhJhZuqa3DicqeQwUbdUEykcH644wuoMxPLytN4nQlDZmIhDRBhK4HlhjVvjPubps/Oi69a9LsP+QWV+4DcBxU5NYK5UlZGJgaMXyI/aaPLfSSK4anTlJHfRYpIg2hy7Ey/JKNI8QgUKulEf8aQr9bAYL1qz+tFBOQCjI5ymvjoDHrcApbw2xYDwvWgE3KAsO9R5MlzdF+HSA1CVC+zx8t+f1U/rXxrj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSEbz8QSQ+oMimFIfBh6TDqO7K0TOxInfzM3216zBOM=;
 b=cgCB73AHssTSnImV6iZXOxmgWufLqxBgScUOZ1FLNOc02+fG/0Y7Lq0DtADnvaeyKqug6IwTmuT8az548a5BzoEORyGIRFDdbzZoHMBCFRQ5g+GqHdcis5vo9kzK6oX+qE06U1U6qGijzqISix6gG/PrRXaFg93pxcRsmOl/42k7DU1CkglEFmREiOVklanDpH3cbprLn/9BmY9AgtjM/P93Bi2PZMtOAOx64HqCBM/p7Xro97370Nhkc4sfkQtEheeyirQOvJ+yqoEO9k0eOrzrNvXNKns4WBNyvUCjy0LBHQzysiww1u+Yiy8LOP4YbJ++ZFEuk3MGvOkKuBAh/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSEbz8QSQ+oMimFIfBh6TDqO7K0TOxInfzM3216zBOM=;
 b=kIdEwt7IKo6b9sWuf0FWZUIVusZB54dBt+C72t6rW6XybBFa1kiZR43j91E6fFSZ4OCT8neTHMNkuJxZjHNnDNXq+n372ZFo19cqeWroQZ/fh0LoKY3WFEkoM7uOugo9hw94fsPnl5d1o1mldh/pdwTktW6+lba2AtTjocCKJdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:49:58 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:49:58 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-next v2 00/15] can: kvaser_usb: Add hardware timestamp support to all devices
Date: Mon,  1 Jul 2024 17:49:21 +0200
Message-ID: <20240701154936.92633-1-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0519:EE_
X-MS-Office365-Filtering-Correlation-Id: b4740519-1cab-4db7-4d79-08dc99e5758a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KslqLKx91BGq5JXvjv2eLR5BFjeb1CiOPvw/PA9NcV2kSK5zzCAmrpYVoZXa?=
 =?us-ascii?Q?axFHm27F9FmYDKjGUScQflVGv1+rg34tpyGEs4yc7jiVjYZN0ZyjjR1yezJE?=
 =?us-ascii?Q?MAd8/27Lzm20P2jxFSiBGTxPSrUr168AftEr1uRaw/I4VKHbmTtV4tCbA3M5?=
 =?us-ascii?Q?/YFNzcHlHFOK2SHxScmKWkJ0aq54uaFCpq9snSJ+6hoef5FYoxXN71U15WQs?=
 =?us-ascii?Q?tASCdf3r3nj5IKoXNaxrngF+sSqz0E0kPk2i+JEM56jnfNApozz8fYzKy8jk?=
 =?us-ascii?Q?NYSBuVnH+B1+d5oTN5xDxNMmH4VLHBgux8C6l+UkIPeIIXqqje8E4GHrZ15M?=
 =?us-ascii?Q?kfc59YcS4TOnBLE6Psehkb04yBT2e5U3nqQkpBYo+B8ujcB42tp2WcoeuBKZ?=
 =?us-ascii?Q?dkDnfLDqIO+KT4ExKR0k0w2XcJ7p7kayU/sFqW6hTSye5cjJqAAd0nhHnNb4?=
 =?us-ascii?Q?ptyeJj8M+CzbUcToeThrmvkkVbNHmVJvdrYXUyLd6Pe4jB0a7sGuMhmNbxeA?=
 =?us-ascii?Q?OMxZs5llpMjZqdLnrR2qV+WLUAEFnobYXjftcCPK4Gecj1vPPHKEJERiUi1P?=
 =?us-ascii?Q?aCwVYZchAbaIAVgdFfSBfqoqr7wrANJfLM7MgkZ7r9Knr8UZ5ElwlMwljDpG?=
 =?us-ascii?Q?ZYv8Zrk2TlMrm0UE742HBFclyVEkf4V0YiUW4CtiTZMXpgtTanOWuzk/yd7y?=
 =?us-ascii?Q?srLXXhI8IUWIoLih4yYuSn9kKiFbmnkNMqgkis0otFCxw1v7ezNHZzd9N/bD?=
 =?us-ascii?Q?QS/ZRZwBDOuwRyYDNLpwSbGuX/i7SElurJVWidU7/4vTXjF59Xuy4P8mrk6j?=
 =?us-ascii?Q?bOlQHSftff3SmTFDU+b8+PTkrzUpCbec2wAGTCPDWoqDXEjEr15rCOq2A298?=
 =?us-ascii?Q?6LLdGLbsvJmIL59tnOT0cXG/4m4H20XfDNiqtcqwdUjsIdLVPe0xJd9ssuCy?=
 =?us-ascii?Q?8N7LOm+Wzux3OcGOiU+AqGTRqNYteQkg3BQ87qp0h2G2GfPnzg0MCMfK+yBe?=
 =?us-ascii?Q?p5FLTG4qLJoj0YGhwJgkvmbJ6Z/p0EhyLHXAM6nAq71ydWqmRjXDXt9oOn06?=
 =?us-ascii?Q?ihWA7mlkls4A10RiX4c7zsGKypPNY7xkI8YS1fArRnedffKOfBmVH42+umA9?=
 =?us-ascii?Q?GAmzIyaUSopuynL6R1N8VbY9Ta6+OkiUFnWWgerAarijxydwf+2rtwMSJAhU?=
 =?us-ascii?Q?QWucTkW9To/ehVxLrBAUHLFxMzkXWjPjf7no205uXZM4aqTbA1Bw8O0uYUM0?=
 =?us-ascii?Q?ZKIWRdbk6PudWb9pyPPJqXSnPnUaCPvsVmI/oRx98cfGbFhFOqHbAqym0aO9?=
 =?us-ascii?Q?8b0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dg8sTzHwA1gj344sKRM0jePGUn5N2OkVcjBHDQbZLv/o+vBRwcXt6CQro1xo?=
 =?us-ascii?Q?rgIDDp15KPTR7lb3BcY55yVBARnHZfKyi3GI4+gUCjJMk/L7Tzm0vLzGwL+y?=
 =?us-ascii?Q?1LGjWPim0wOzNRwvf5WIBMO8DkzRmn+UforSkweRgkzD7vXk7WkmAbqWa1Bl?=
 =?us-ascii?Q?ARuT+TteROpjHMgioLlpmNVaUJjgxkDkgDORdhbjJTVG9qZ/sT35LD0X/5jl?=
 =?us-ascii?Q?iSX6zWQKuWV26tgSN5Lwforo7TGeBj7ZISjNW9yoSkNnS/95SEffR9qXVyIc?=
 =?us-ascii?Q?0LEsGpP01sJiGIloMWELd0JYFGSmvlQNXfzDAjGFty8RkGXJzqa5S68c+xxr?=
 =?us-ascii?Q?7PaWaG9bWwrMJ+a65S8nF//xr8qk8xzdH7d7edXFGY4CACiFrDib3Q9VQhfK?=
 =?us-ascii?Q?rblY7nBr+MAP2vzrQ0N3ohzB2HuUPFitAbXlEtr/qZKsPrN8vmpRkoNS/ZcG?=
 =?us-ascii?Q?1mUUoYUkAd+AQouwGXi0P5qqQLh6/qwQ/U2gRN7HdR8ZqRMPtjQTDK25pST8?=
 =?us-ascii?Q?ZPfSNz1WvruDMswG/IWuV9h75AQt9RGhEbIbx6xqqC8ftpAG9aSdm3a9Fmb4?=
 =?us-ascii?Q?kuVlqYOGdhsxNjqHYI0h4dkwS1PBsWVrPgN4GpFoDrWRdlfrPCGuByuBTLnm?=
 =?us-ascii?Q?UwDgGE+ReyV4k04Cno48s0HC698Km9TY8c9PyoXlM+8bPLc/kedOjYqLfeAN?=
 =?us-ascii?Q?4BT6ca5KpBWStvY7N2rnKC8T1qrFpnCHsu/+4Xn6r520X4vMmu5sgmoVl6sm?=
 =?us-ascii?Q?FiF0FE8UoHgxdPrGxZtB+iFLhBs1Y45980Vg7KJeHilVJ30RnKJwVQXLaocq?=
 =?us-ascii?Q?m2Fu6TBT2q0ydlmSaZdXhN17ce2YFP8hnJq8LjEgbgWlLvpFuwkg7RmHij9J?=
 =?us-ascii?Q?tOw1lEZB7Qk+l5Vx0gmv5OPtty5+nAoTGEN3SJWCuqNxuLnxVHK6N+KeuJHg?=
 =?us-ascii?Q?2EGRHwU5rVd9rYfe6Z8y690oSoMHWDHx6snelGAnsRSBUGnd8kdzF94ifLX+?=
 =?us-ascii?Q?vPlvjW7K73s+PwDEI30qXNY7SbcYVN9VSC2K8AZj9TUUO5+Pv1uFuQ7g8GQL?=
 =?us-ascii?Q?G84+siFhqHe+ioVxD+VsLeWuCrfaf4tzCAz9I2lbiLvOEp0Fn6S4XMGtmNNG?=
 =?us-ascii?Q?+fzPMhtu7UMmKMjLA8oky67FR5VW6a9Q5++HzctVy7nAddFZOX2oiLSm6GjG?=
 =?us-ascii?Q?2qNoZMAdL0iRyPwc6mx+eSSMNvsyfUotneMnBv24nhCaRMn5hb1uHiiQGVw1?=
 =?us-ascii?Q?EajfjxhXzZxJD2IrjNY5dyIhlboHtCIppZpv1qL4eclf1Fu5XzT+LYJLqyjW?=
 =?us-ascii?Q?TYopP05DkNFq8LLlfg8+0R+wxjGa0fHsDEVqJ/k351WP+NNqFwNx29c/yrtC?=
 =?us-ascii?Q?cfaCcgNGdBbmnY7ooZ2r0p7KIAxNwUJVVbFoAzTKiyLrHDertzWhSifENKD/?=
 =?us-ascii?Q?XthNeuHp73rgl9dq+nCtpFp5nqsA+OFYGeP44ke13zG7UeV3HFOihrvk7UbT?=
 =?us-ascii?Q?O1WG2XFB2y6YcRj9ZQf3PJgSvllLzoXLpuuGOjTsDP3n6HU0GNTWTD+wjcvi?=
 =?us-ascii?Q?+g69N7bZ1JvaHEaj7NHcXuzUqokUuHIVG718fRLH?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4740519-1cab-4db7-4d79-08dc99e5758a
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:49:58.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqWAl6OLzgj+G0HJi/MVfv466VDF5qXLcJFHviF73oqs4T4LZys75RXIBop0Jr99uE3WvDamyu1+jQUH32gNkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

From: Jimmy Assarsson <jimmyassarsson@gmail.com>

This patch series add hardware timestamp support to all devices supported
by the kvaser_usb driver.

The first patches resolves a known issue; "Hardware timestamps are not set
for CAN Tx frames". I can't remember why this wasn't implemented in the
first version of the hydra driver.

Followed by, hardware timestamp support for leaf and usbcan based devices.

The final patches are removing code used for selecting the correct ethtool
and netdev ops.

Note: This patch series depends on patch
"can: kvaser_usb: Explicitly initialize family in leafimx..." [1].

[1] https://lore.kernel.org/linux-can/20240628194529.312968-1-extja@kvaser.com

Changes in v2:
- Replaced patch 3/15
  can: kvaser_usb: Add function kvaser_usb_ticks_to_ktime()
  with a new patch
  can: kvaser_usb: Add helper functions to convert device timestamp into ktime
  and put it first in this series
- Resolved Vincent MAILHOL's review comments regarding duplicated code when converting timestamps [2] [3]
- As pointed out by Vincent MAILHOL [4], the clock overflow commands is not
  dispatched in this patch
  moved code from 10/15
  can: kvaser_usb: leaf: Add structs for Tx ACK and clock overflow commands
  to 11/15
  can: kvaser_usb: leaf: Store MSB of timestamp
  where it's actually used

[2] https://lore.kernel.org/linux-can/CAMZ6RqKSa-6KjvgfmN9eL7A=A65gMkYsRrnaF41Azhsc45FA2Q@mail.gmail.com/
[3] https://lore.kernel.org/linux-can/CAMZ6Rq+Xd7+th=dKV+vrqzRtS+GY-xq2UziH1CURcQ3HxEXMqQ@mail.gmail.com/
[4] https://lore.kernel.org/linux-can/CAMZ6RqKqJX6eqogS2598BFm-AN1uOBbBGL+MkoJtR=-z379Q=w@mail.gmail.com/

Jimmy Assarsson (15):
  can: kvaser_usb: Add helper functions to convert device timestamp into
    ktime
  can: kvaser_usb: hydra: kvaser_usb_hydra_ktime_from_rx_cmd: Drop {rx_}
    in function name
  can: kvaser_usb: hydra: Add struct for Tx ACK commands
  can: kvaser_usb: hydra: Set hardware timestamp on transmitted packets
  can: kvaser_usb: leaf: Add struct for Tx ACK commands
  can: kvaser_usb: leaf: Assign correct timestamp_freq for
    kvaser_usb_leaf_imx_dev_cfg_{16,24,32}mhz
  can: kvaser_usb: leaf: Replace kvaser_usb_leaf_m32c_dev_cfg with
    kvaser_usb_leaf_m32c_dev_cfg_{16,24,32}mhz
  can: kvaser_usb: leaf: kvaser_usb_leaf_tx_acknowledge: Rename local
    variable
  can: kvaser_usb: leaf: Add hardware timestamp support to leaf based
    devices
  can: kvaser_usb: leaf: Add structs for Tx ACK and clock overflow
    commands
  can: kvaser_usb: leaf: Store MSB of timestamp
  can: kvaser_usb: leaf: Add hardware timestamp support to usbcan
    devices
  can: kvaser_usb: Remove KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP
  can: kvaser_usb: Remove struct variables
    kvaser_usb_{ethtool,netdev}_ops
  can: kvaser_usb: Rename kvaser_usb_{ethtool,netdev}_ops_hwts to
    kvaser_usb_{ethtool,netdev}_ops

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  26 +++-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  21 +---
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  41 +++++--
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 114 +++++++++++++++---
 4 files changed, 153 insertions(+), 49 deletions(-)

-- 
2.45.2


