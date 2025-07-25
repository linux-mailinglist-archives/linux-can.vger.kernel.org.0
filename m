Return-Path: <linux-can+bounces-4123-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8B8B11E96
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9339CAA6E06
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39552EB5DC;
	Fri, 25 Jul 2025 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="cWQ3oOyy"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2103.outbound.protection.outlook.com [40.107.247.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418D23F40A;
	Fri, 25 Jul 2025 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446771; cv=fail; b=CKd2pdZsaA++dLe4k4piMaydxJNSsSPERMJtZTxlrE2ORgMadFPDpqSGGpvjuKCcLZe1MJD7sMLkboJ0+Its8HRyMLmNnM9pClKcryd35kn+kg5ANedq69YXKnV+IIaPA97DDzgL2uKSjtM1HcWUJvK6GrXoULjsXQ15z0cjCIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446771; c=relaxed/simple;
	bh=MOkYsH7OC9LJWAtDpnnNVLagzjRX/NS9xjiwXl7w4q0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ji6J6P36As2qRAzEVwIofCd3c3LiaPhnsGoHb/VQXpk+VHpB0t0fvMBFEti3RAghoGQhYcE7tPyQjjnljPkRXScEOllNFTt+lvlnBLRaEUmNsMMKzW9rg91lWgL5Sb69zctrK3jmhL8n99FK/HN5FqzY1m++31bvfnvsfzmaXlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=cWQ3oOyy; arc=fail smtp.client-ip=40.107.247.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTl1KSj+YOAMzTsyyd3cq4xWZP0rwLZt0d/zwWIQhl4kb3r+sFY+pQqNU5UifE7SU0OgSbi6fHzITh0683RKSVT2whwoxoHyyK8augHwPvAhGLRiLsmn8gMAGFLaRVzqDI/n0/OaWyRu4/gF1eL1uUFgOFSJgIbVVY3/+LDthnXh2mn32SFENEVb8d2KqKaPYZieJImi6cYZbbZxIQdVpAoprKhH+AQ4lPB2NKHp8n4iurLa8MLmBH1f2NF+qYJsiRsse8eO/Ubnov3laRMOsDBwGP/r2mZhetc9GzcxCYycF6YdSjswzgwPW6EaiUXWwmB/MWfOxu8l9jfL1IHHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBcwxnvUUx0jj4e6dSUkmLrZ5UcjUsOeMfbJDQ6DvOk=;
 b=tmKKAOyw8xfY7yBgT0ZFpPZOFliKBQN0qtLB0fea0kv2wpTyDfO5RHAFLlbL3elv2/eMOvtKFgllX7z61MGqVWDRNfQd8YLeJcmCNTFtbTZ/idxrE4rEHQ9oBuO7x3udB56vEyvSVTFOhrKi6qEbNSUw/fdiWP7Ugdx2ZmV+l3xsrEke5O7rAZoOi8EmVnmKxpzKAb6zXXvwvPFdQf1hnP1zBm9ErZ8WRTfgeaEZSZhOKmk8LQmTh+GlHIUrIH1a4EaG0lzPoIXhCKmldnXaM0KjKMHM9NbVYiRXWCEoE9TvlV5ASt6m5eyEScxImJpuReNKRxy9FRGwjTLPLFtGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBcwxnvUUx0jj4e6dSUkmLrZ5UcjUsOeMfbJDQ6DvOk=;
 b=cWQ3oOyys2LLAyhdBhCaD6uhJuzElw+o1UC4fpMkJvHERtom2BJzTbJsFh0kfjOnOkyP4L1RyNopY8Gn+qcXAaa74OsZKKv5DvfT6yGkm+iUnoGvcy0ZMboJ50SnPvZwNc62FCZgEQevlTbQ+pzSc7yC3ft6WfBkN2LN0pkBD+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by PAXP193MB1376.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 12:32:45 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:32:45 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 00/10] can: kvaser_pciefd: Simplify identification of physical CAN interfaces
Date: Fri, 25 Jul 2025 14:32:20 +0200
Message-ID: <20250725123230.8-1-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|PAXP193MB1376:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b55f4c-d82d-4a98-74be-08ddcb775b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dxWLdKUkNRnSLk6h0Eu1niJv3yPN5n3l9IrJGq0mLoJOCBRAzYuIajnbIS1k?=
 =?us-ascii?Q?OZxov9lm8V64MW/lNDJNQbFjwtmJf9dj2nnMSoVa31MTWgbRh+QdqzLfiFPu?=
 =?us-ascii?Q?wDlxf8Exgax9N7W7/Q7WMaSsjTf4oeIzs72OGhfC4NPCWzpknZefSh8GMepm?=
 =?us-ascii?Q?FmczwQ2hG+uWLeGJgWkTnZEAkl9rEUPxGmlD9MAvPbdAAyXPDyqnpa0fVlpZ?=
 =?us-ascii?Q?R/xOu3MOWb4m/nCi0Keg3ucAmWBrctMZxwSgyRUokNbZT5C8ohIS3xLK63Tu?=
 =?us-ascii?Q?OO1S6cgTHw2Y/ggz4qwvl1dw4XnLCmoHSz2/kdZ8abUPmV7QCc982oUx6DWg?=
 =?us-ascii?Q?E6aYCJ09xFWay6bXXxXCe2RHY6YSMtdiyfpQH1kqgfGR74yI3pRMSKM4nR4m?=
 =?us-ascii?Q?sDOB4NT0Rch2OpITzjSgewkGT57wVN7DnSRqcglEzgHeTz9ADfB5AuYHxIjc?=
 =?us-ascii?Q?4X6s7arCx+illvcyYbR8r0GRz8lv7NeM9ZAhrs8tnJJXyGpW6+nn/coL3iQR?=
 =?us-ascii?Q?07p3XO0f/AFGN8B8C0hBKIyfQx4zDhuW+hdhrkgDOa8wrneXtaynHKkufKvH?=
 =?us-ascii?Q?5b6vFRUljlur7ZdWa1RoM2xgSmlFEy51aW6ssfA2/+VsVFlHP6WGe1jfaCiF?=
 =?us-ascii?Q?vwbDzU3ayo5YFuul/i0e0+MqIGmBPHweTQCGkooh+wwJDCluZ3Tt7h6LFdpw?=
 =?us-ascii?Q?zStQPwG5KHrMhv+v4m6kjlTW4FvSTUx1Yz2cTPCUIVw8oOTtl38UmIUa3h6t?=
 =?us-ascii?Q?JCxiCYZnYraxV8jW9cuFfhzsrwwmW7bLd+ZrkshQlBc7PLl0TKwN5mcUV8+h?=
 =?us-ascii?Q?ht7uQXvgnK9NZyFlMMubNy1SHYkz8pPe1Ltywtnj2xKtx1f8a4mrLdRX6gvP?=
 =?us-ascii?Q?Z7KgagCo1+su0xk4cueU9NKU1etz35UB/gCCTvdtc0aRyJJM2Hs6XUWyg1SO?=
 =?us-ascii?Q?HsJl39XZPrZ03kHpSHjg5mL1duhFIKTm4BN8YP++lRXhvFOvKahW8WNCSYbM?=
 =?us-ascii?Q?i7ZJl9ziOj2369wp7xb9E4sjCM3oKV6IfdkQOIep0Vr+ZgYwpQeF6R5G/YSQ?=
 =?us-ascii?Q?e7vpVJ1s4BYyz3UF1NvLovoQyBafCmk1NKx4Kh2Z5PUQ+AsZLvr2SxXykIAt?=
 =?us-ascii?Q?xE0jWbRr96XvSJgnrHMhZCNpeOklLIXm0JygbFXR+vBn5jZmn/PravEPReZ4?=
 =?us-ascii?Q?2Sa08T8erjOhC56KMJxiWKKCDhxHYvMpvUgNcnEaUvtleuNy68Lv3YxP1zht?=
 =?us-ascii?Q?1wkeu8qKPRUjNTGCv5cgwa9iU0XQkjy7rXnLouI16+hKFJ3ZbB+uXin6UDHl?=
 =?us-ascii?Q?ffvcBkpPi9bpcwUO93hOl69AmYlvKRzyilVY7TKwAZn7Oh9UTJqKUqFidhtt?=
 =?us-ascii?Q?hicR0JecEvTHB7kp7JjT+EugbqpcSpOuyUKjK0N+pAcTkb8ypy9SakaX5w70?=
 =?us-ascii?Q?r7XVWqCjhzw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?imeyxET9dwlYrmpmA5bRrTcR4WVSTcVNhBxSiVoZuLhxAy5r/E6uUMkBT2Yi?=
 =?us-ascii?Q?xEVzxW+o+heYYakhfL+As9lEf85mJ322YBoVpAggrZ9+A2kVPuynGYeSdoDQ?=
 =?us-ascii?Q?AxCqtRIxyF0Wn0WpcQOfDeIil7/c1+duawS1c7zY4nAGu38sx6qzo9n/IPRM?=
 =?us-ascii?Q?qZXaMnofeArg0GCxdYHYc3N6MwyyE0+wnFh/k2QUZBOboWFetJ9rt98GDhXP?=
 =?us-ascii?Q?vbmMu1EpZOwofNT11SJU4lgI5cjn61U+HmsMY2iovfW8S7uZfcFB5goK0rRg?=
 =?us-ascii?Q?bXX0kMjIwuMrO1LeMQ4Jt3Wk1yqAJABaZhj50VCbu+qNLCPK/pm9ilQjrxt0?=
 =?us-ascii?Q?zjaR7KK3A4WUCEE36traa3wa/l6yEcTFBJSn4Bw9rjkIPeldDJ+zeK59Xz0i?=
 =?us-ascii?Q?H4R7hZvRJngtYG9iU4YL3pJsuh0rJjuJvXMzDg3nqcdKxpPYSw2xiXRjQR9B?=
 =?us-ascii?Q?I9kn7JiYy/rasN1JjbwD9dU/Mv32Bx2bLf8FirpQu9mQPaSIsDkBfRwEYbd+?=
 =?us-ascii?Q?hjUpW5NXv4dUIYSNL3wjEdpfaVOVZFQ4QOcLswqDtIKDxLGsfOIij2yfpYAD?=
 =?us-ascii?Q?ak2FhdLtyOEB9A2717L0yWhacKDk818mzG1Jqx3a+9snaPRhjhsjpgyKKWr5?=
 =?us-ascii?Q?TaM5xbF55/vO23zP1lMhsSl3Ela+XwWS/rs43lVP+Ujpw+5mzbDzgLoVRsqD?=
 =?us-ascii?Q?hUi5zdxqpDRLLdAQEkwZJoIWaul9UH+CJyj6HM6Q9DPW89OyS8NEh4iMjVsd?=
 =?us-ascii?Q?s8Ivr+MKg20zmWzX+Zkq1ZKOoIqjDF/9QiNnIzlkM7xlgr+OnMyB57XDpsJU?=
 =?us-ascii?Q?6e5nsplQEF4IunrJjTx7U3UGLOSyBi7Ctbwu0jfG4Eag0Dk0L1meWxo3UOwm?=
 =?us-ascii?Q?y2FPQVpQAQ72FXb7D+FmsPJjHiBVTRL5P9bi9KH1Lj2aIE2Iwn9358FXLxMr?=
 =?us-ascii?Q?/kyfvYXydAYt/qBUlmk6kwiWzPDH6NkJtrNkXh9lCBhdUFgNkAHuDJhMr9Qf?=
 =?us-ascii?Q?NuyzHtKW07xUMX1w+gqXTnnX4PLRkXGGX3STrFmPJenp0VOpW0wAfBrx39p+?=
 =?us-ascii?Q?7dwVFi1AOv/7mw6PmZ+ldavNGBv2DLclIjzQ5Yo18VaLvTscezhKFnKmOk0b?=
 =?us-ascii?Q?NtDsV4v5xaJm+tKdCb+Xkwy24gQJv34B+JAzT4KMAVItZPvMMj9fSdpHzwoY?=
 =?us-ascii?Q?cGXWcse0J1B/IeNJnsibpxV/NrMM3q7wPvkvB21DkxcvFpar4G30mAs51N3A?=
 =?us-ascii?Q?Cdex9zrnySEZj4LwvW9xFwNwjxQMroDvVE6tbSHzR/R9b0MUL28rmTklnkTO?=
 =?us-ascii?Q?Yf8UthMb3gHkPFq4V5gdppX9wKpyMebdq5gc6w6hlTdK2WnbeVKodMnxXjkv?=
 =?us-ascii?Q?zXRBBD/YJi9bLfmJoc63UKJ88VWxTyn1V1Riajgst0Mgcj3PJKLt5ju4TfsM?=
 =?us-ascii?Q?1qq5Gfkq5llQ5fQktFg4IN/1x8M+9a7eDEMpW9Cvo/1faVZdpTN79NX+5yus?=
 =?us-ascii?Q?53hkC3FxO2tBR3J93hWfu0l6TW2ZCBPnxt0suWI3rKhH2JrJ6Tc9Dds6HDcK?=
 =?us-ascii?Q?7Fmue2EoQjThmAuC2hGShKuQcfSmQTZLBGwfuWskuEwUkNUXnc9uMS5hl5cy?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b55f4c-d82d-4a98-74be-08ddcb775b42
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:32:45.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmPb2AV2CK9GPyERd9z4qdTL+U6Q2ESRwNl8/KqF7YUY8zKyBaxjUuH4bhI3h0mI91qmICPn9Xc27HZQwzfZnIsz/PrFkrcOLGKfHRRES0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1376

This patch series simplifies the process of identifying which network
interface (can0..canX) corresponds to which physical CAN channel on
Kvaser PCIe based CAN interfaces.

Changes in v4:
  - Fix transient Sparse warning
  - Add tag Reviewed-by Vincent Mailhol

Changes in v3:
  - Fixed typo; kvaser_pcied -> kvaser_pciefd in documentation patch

Changes in v2:
  - Replace use of netdev.dev_id with netdev.dev_port
  - Formatting and refactoring
  - New patch with devlink documentation

Jimmy Assarsson (10):
  can: kvaser_pciefd: Add support to control CAN LEDs on device
  can: kvaser_pciefd: Add support for ethtool set_phys_id()
  can: kvaser_pciefd: Add intermediate variable for device struct in
    probe()
  can: kvaser_pciefd: Store the different firmware version components in
    a struct
  can: kvaser_pciefd: Store device channel index
  can: kvaser_pciefd: Split driver into C-file and header-file.
  can: kvaser_pciefd: Add devlink support
  can: kvaser_pciefd: Expose device firmware version via devlink
    info_get()
  can: kvaser_pciefd: Add devlink port support
  Documentation: devlink: add devlink documentation for the
    kvaser_pciefd driver

 Documentation/networking/devlink/index.rst    |   1 +
 .../networking/devlink/kvaser_pciefd.rst      |  24 +++
 drivers/net/can/Kconfig                       |   1 +
 drivers/net/can/Makefile                      |   2 +-
 drivers/net/can/kvaser_pciefd/Makefile        |   3 +
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h |  96 ++++++++++++
 .../kvaser_pciefd_core.c}                     | 144 +++++++++---------
 .../can/kvaser_pciefd/kvaser_pciefd_devlink.c |  60 ++++++++
 8 files changed, 257 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/networking/devlink/kvaser_pciefd.rst
 create mode 100644 drivers/net/can/kvaser_pciefd/Makefile
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
 rename drivers/net/can/{kvaser_pciefd.c => kvaser_pciefd/kvaser_pciefd_core.c} (96%)
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c

-- 
2.49.0


