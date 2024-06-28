Return-Path: <linux-can+bounces-867-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D132391C6E9
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843FE284A1A
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DEA76C61;
	Fri, 28 Jun 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="XYdiLKcm"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2111.outbound.protection.outlook.com [40.107.104.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5602770F5
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604550; cv=fail; b=YcFmd3Z9LjwuMWWhqrwVe206sE3KTVlZJJIvfARYworZqNjOQ8JQiwwnHUkVxE7+MIP2NraCbNmnODvKZmBzkrD3kfzM+3JIDRXCSQIv1Qnmgh85JnvKl/MfXDHDm3jEJOKnQdkTljfkv2sVchG/FzQ9gOEpOlqXemKJnGsPg58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604550; c=relaxed/simple;
	bh=LYUilhj15nSCphaTPr7KH1Q9HI2lGgMF6l7lPWF91iY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=alhAJ2q7+qFr5+kqU8n0a9VhQDlfNped2oidVm3DqwxkTZjTCzJwefTNqbQgiANVdB0xhy3A3S8gFSIbE6/yjWQxfnAHkPwopB6q25cErEAdoGQLZabfWn4M8+hIQZdlHTgn1+c3E761ric+zMtiOXTib4l7D696ZXHeyWFWdpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=XYdiLKcm; arc=fail smtp.client-ip=40.107.104.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJMPtqQU6fv/DIPAeXnyKnCV6kfJf1X0wu0D/BbqKHXR998PnhJ4cfira6OH1QGEbxDlusFQJ1G5rIQQIqZ4Pedzz+sB230VbyTzI3tV00j69jtbhsIz1bAcXr0s9o4BfJiijmwXO6h9vKopMd/UUuTugRRKsVMo5h8U1dfwcVC4S5Y9kmL9LGghzSwijLgC713AdlMVj8s2Xu/BRNrL0s1Ihh1lZ9//r5cQ5mEA1fKONs5elwFOLooHsVWoH+dhEvpTC894XNcHOS2hNgKZw06uaqAcxCrPb3E0BQ2bzvj2PoT9EP8BG56VGYLy4UFNb07sLS9vZhoXXO08ltm+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0I84Ng4iCgcloLqt0XXrLXT5vZjtFyrZ9o2K73KO2c=;
 b=fbZjgBC+NmfHTrA8YowVkEEhFmxe8WdAURzW+BOKq9d2ggw+dprdeBAN/vHPBu7FCa72eRcfWRwRWWDgz9mYstwbWnTPeWz9HevYd0NNzq9ZXbH4hsbF7DF7A4OyM6Y/cv/YXv6uIrITNlRUKXVpaDx6solSGai65grrYdcTsqhmGwkw17hLz4kJ9X5Z7fdnHZRW7jBxXPoc0pq9TKS8PTrRP6Fd4bs6H1PL1Du4v6PiRrVK3i83TvnhsaccanGyCLdiMMVIAbdarhL6IH43EZP4JJ1Z6R7B2A/UwHBicZml2u0RRZkYYfyoI4SidrroBbTQZgNeKOuYExg5RnHYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0I84Ng4iCgcloLqt0XXrLXT5vZjtFyrZ9o2K73KO2c=;
 b=XYdiLKcmyaI8/7d8rowtBzzhP0jJqG0075i1J4FLqyXOvH+Lc/M+i1Jvaq1UVklwzJumkdxFHWH1QSlySWv54P/eWBxgIv7ifs5PQ1gSmedMdaahFMH1vuDmXWwl+8XaxP5HOoLtiNa7OJmMSdTvGY6lFPzSAYrBoFUjpFPvJdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:41 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:41 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 00/15] can: kvaser_usb: Add hardware timestamp support to all devices
Date: Fri, 28 Jun 2024 21:54:59 +0200
Message-ID: <20240628195514.316895-1-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM9P193MB1142:EE_
X-MS-Office365-Filtering-Correlation-Id: 500cb870-b908-4f22-b6e5-08dc97ac4a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aocjCBNMfkimzzqJ5cz7ZD6ZDsRvxKoNartx1xk6BN2f3X8My1x3CEzewQUy?=
 =?us-ascii?Q?V5p1GTnpr6fPZupxx6sihp6zYvyoqpBJoWKi1vb4DGa8akrJu6+wqCoKSv1O?=
 =?us-ascii?Q?s3hQ+meac+fPbOiKuH+FJcdvWFRCmZr5T/7DloS3fHR/6gMHmbBKLrbYiQUy?=
 =?us-ascii?Q?/8KK4SGdznT+PPjWJldxdn2XzP0/PBKzIjyoLbQAXftL6Cdnl6yT4ofladJ/?=
 =?us-ascii?Q?OR2+mZaafFY4iUIQeilC/0exS3coXv9yu4Q2KvO+Iirer6SyLK3hbPGvpKXZ?=
 =?us-ascii?Q?HRRY0S/hrAkefMSNSWrv0NCH6NEyfnYPJo78kpeuARCxvfEGEqNYrckce4yQ?=
 =?us-ascii?Q?VGWyslzX48H7fV+NHgW2zQXz7COj5gHzjrgste6/6ji3cKHQoUTtTaTJEU75?=
 =?us-ascii?Q?gtXREbBcLvWWvgTUFx5QVmlIcbTyev0b0nSwreQecggXeRSk9yK2P6fT5Zuz?=
 =?us-ascii?Q?6+fxwym605KuP7J6iEtSXmZtl8j7pwTuet7stSEX+0ia5ZEqsSc50pf28YlW?=
 =?us-ascii?Q?Bf5Gkrl5SsAUXJ6GS9NGmls5oi9KFUWjytdZcmFpHaLorsTCa7xV2RfEOQUi?=
 =?us-ascii?Q?MMoKPX16B2YYNGYQSpk8TqGZKjdN8dY+xN4UhrXoItRDOU+2YVnWogJz1PN+?=
 =?us-ascii?Q?M4a228QNFgXZ9WO9GS24+sxDVkLmgE/vbpyPLb9N5Cp9VL5Wvg2l4D4okAjg?=
 =?us-ascii?Q?OMLVmVBksMYERMOiux1kwltkMYpWuaSsWWnW3zvLmrV4NyuBZLOVTv47Yoz4?=
 =?us-ascii?Q?ztNhpfSmNI5r+aO7h5Ys9SwbP+cPRI7gVj4c5Ybgd9G2P0i80AVa/OudFVL9?=
 =?us-ascii?Q?AmxYwmAOx9EDF3QuK5cuJVT5hhTjuL1tKCY+70pN1hDLxGL6PXBJI0FAbBEN?=
 =?us-ascii?Q?jDRNl0zTUryORuC29pC6n87ogLjXFBDjQJv6KZjZ2bLcW63lmfq6o0TlV+Vi?=
 =?us-ascii?Q?Us86zDmIPpemHM55dRrcZWVjX2JvBWN4JHJrEF45t9S/eaC/nzyFn6vbE01j?=
 =?us-ascii?Q?dizEu7uXmvt3vLxujBJMhsqbeQCmFtTKoR4QtZMGYNtdTcjz3OSmJdBNBF6h?=
 =?us-ascii?Q?aSRdIgfDbC6eEyU3cRE0oe3tw5IXUqccHO5/hC1gv3iDcV6mlxQPUSARvyBA?=
 =?us-ascii?Q?yJWxfbaWhyu/RQSr4I0S9hbH9f5N4tUQZ2nDSqxR2PymoISDL3GJVlXC66jb?=
 =?us-ascii?Q?Jd6YCVtQ03m3w8Nfx1HVtitCqq+SFTSmZTiGjaHaFxx2ChoiU0Rl5g/hYdJP?=
 =?us-ascii?Q?E8gbGy6ZxKV9HgI9QevR+1DjqV4VWEbt5ZaPYnCGUQlLz1OM4eQyEk6cahez?=
 =?us-ascii?Q?2IY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7qF7j9u/sPenTSerXKMKBwLdzpdeFzJ4jcZNsY34zLjgwvq1p/wuCTWvaRtY?=
 =?us-ascii?Q?Yf3D2VTW5MHyxTz/6x8YTa4jcCcPtpEJ55SKrtjv/ZUQj2gcTDcBFZW2vs9f?=
 =?us-ascii?Q?WzYdTRnaUq9jrpXg/pDamiCo1fE7dNsqQWDGlPg3dKS4j7Zuo+Lo91uQcc/S?=
 =?us-ascii?Q?hBWqykZDjbRowCO7ZrHQWzydqbihGhSoEpf+sS0i983bPELH3OiVsjE5RLbh?=
 =?us-ascii?Q?ydOB/jbFSZ9LiGz6XNump8E/2HcDhshUL8LCHNf/thvRj3PMEDSlLzDu6eT5?=
 =?us-ascii?Q?uZuHloikzKhkvsdltujU64YbrMiLmBjnfGLMLtWU+8vKoNCtOHP/TPywz0g+?=
 =?us-ascii?Q?1UCPCa84fMf7E7uCucW4ZSCmZfZW6pjiRSUFU30J/Vh4snBnM6w2x+4dbnzk?=
 =?us-ascii?Q?NPHoqJlNQOOCeP58orite7jifDtNlVai69zDO8LrB2VT2VHDMvnPJt78qN1z?=
 =?us-ascii?Q?aUd+jkxBbRHWQlPjwP/BrsXBYYb1qSRIo7IXinRwM6P7GX2rCmEfVJa5FrBW?=
 =?us-ascii?Q?N6GMmL2L6tdcJWw0V841w08v4ZcN+FKvW2t92ctdrA5d4YsR0Z9Kr92bHXp3?=
 =?us-ascii?Q?/Yzn8NtmmhdaDzVhnloXkpSqKqEtuAH43501ApqW+x5XysIQr1y7Da8giV4C?=
 =?us-ascii?Q?tqddf90eC9+Mc9bcrcUkreW5PLQU3W+x2hxZiVM/RqWXIp020GYsMlPtME9K?=
 =?us-ascii?Q?ih7+6y/pVF/LyHZDTrN+LPEgZVAmqeUThUFCcbdhvxT6hBYc651qptK0paeU?=
 =?us-ascii?Q?0WNub4xaMaDGU9ji8HCja6ZUAgVnXTsNSxqdTWQWCe0k70Z9vYxLO5klCBhE?=
 =?us-ascii?Q?8kTKNseFTLegzkECqxlSkseanfGWAV5ydGeVB7kJSQ3kLn9NZXH0cDKKDm9Y?=
 =?us-ascii?Q?R31IwcnZe+WSJcivx4DPmzFgzivfnR1vzHIYnvod8IeShZd1RH5tXvkwUkf8?=
 =?us-ascii?Q?HFSPqPYkjqfgoUHBduwYYjRg7t896uMDpK91fwbxqjxMU359k3qtT76uvpGI?=
 =?us-ascii?Q?K28O+AbK60QaJT/kywCgOJQ/YgZw7wfOH0guC7RzN/61YJGy4dVhHYFQIyqk?=
 =?us-ascii?Q?57YmmU3yug4URQQG8n+h5Cv0Wlb1frMar7bm+7iZESXxzAWI1kTyf0u5j1SA?=
 =?us-ascii?Q?dHhw6sYYJP8rkK2y+XDbw0pO1YdzILv1GxcNnspWgSluevw8KYueKuNFs6o3?=
 =?us-ascii?Q?cNx3d0Tvi8B7p1nN1Xg5o5Btun11qYRdVLHeLJ9vCo6pEeLJ6f48uD97rbZr?=
 =?us-ascii?Q?JAIGRnoC4jO0XJttBsEK/ZUSWzMog5aStTpv/P8KgOxmlTiWlikJc2r6gN7d?=
 =?us-ascii?Q?PRJT3ZfnFR5KvDxruCnEjjtSY/qZKjIk8KeIo4cuSlmj7oUh2X/OKQRrb/by?=
 =?us-ascii?Q?wxZPh5QjY5bafBaifORjMzFrfBD9StWBR5rDnRuHyqlnZ05hA1mV2z/kXKuR?=
 =?us-ascii?Q?kSZpgVSdni3RmevqgqFbySs+DWgF7Huz5CoRFcercdmUmHyh4aChAJvWj2kN?=
 =?us-ascii?Q?ZVPWIqnONOTdFMZ01f/fwuYLruNPWlF8DPbF8N9ZUtk4iTZHHkPrK0XXVnsv?=
 =?us-ascii?Q?FVfbKoZThbyXWDnrpz+2jv1F1uiUYCWqvGAJbj/a?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500cb870-b908-4f22-b6e5-08dc97ac4a39
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:41.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzuZU0ao025+E+QdzDPxGGAFENI6ssFIRBR2WIPDzjtjcK+hB8clpzat0ztd5uUZHZ5O3kdvM5EXnv9T8Cmo6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

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

Jimmy Assarsson (15):
  can: kvaser_usb: hydra: kvaser_usb_hydra_ktime_from_rx_cmd: Drop {rx_}
    in function name
  can: kvaser_usb: hydra: Add struct for Tx ACK commands
  can: kvaser_usb: hydra: Set hardware timestamp on transmitted packets
  can: kvaser_usb: Add function kvaser_usb_ticks_to_ktime()
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

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  10 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  21 +---
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  39 ++++--
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 113 +++++++++++++++---
 4 files changed, 137 insertions(+), 46 deletions(-)

-- 
2.45.2


