Return-Path: <linux-can+bounces-4046-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DF3B0ED58
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4740B169122
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9206279DB6;
	Wed, 23 Jul 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="DxeihGCC"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2106.outbound.protection.outlook.com [40.107.103.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3FD27603B
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259739; cv=fail; b=LPnCuC5e9CqBMiB6rxHr0JH4KrH8qtltsNPKWikzthYZC7XANeF6RRr0jnK98heWqAF/heH2QZ4Fimyk+NYrFWsAJWt8MuOqSJ0MHM7u9hQyKxNhLHNjIFBWadVFYRWVOmx9mFJoYTDJ2+qgZm+CGy8SH7xy4qaZqDLCT8PTXd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259739; c=relaxed/simple;
	bh=PPefr/xc9esG8Zrcg79zaUm65CjuWsN6i3KY3Ujm880=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GKwizxvbxYrubI81l4kveY/a89ItrL9WvI85A9kePIuA5boCC3Mx2uoeohU7H7wrozSmDbVXm4LV8HK0w8XkQGaLf9xQbktKkqW8bMlZqrCaXOkPelf0SNiWyhSP9Qgddlxg8jZncEZJwm+9nJHUq4DHxX7WxcJ5KOla9e1eOu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=DxeihGCC; arc=fail smtp.client-ip=40.107.103.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGqvjWCcHkhLsUxCxQ3OClHsLGzhNn/o6djqWU0QU2+0th2El2N4sWLnbJ7Ww7vSOdd5mOJFXmQwPPhaJOl7l1PszGIGkI2odD3934n5/jCV/i1p0VYxoGXMTQmJbldPTayzqR/yjUJ3v6EV67nwrrgGiteTeLAZSAdncereqOYFWn0zwaSv0ryQS2/G3pnGprviKaoO34ABVsNp0obsw6xr+cX6uxCIJMW1sqMHEd1HcVPkJv6upukPEuDsmS26UO84I3meezQYq9FtpfL/GnZYYP10MVPzNsuQ+SvR/pyb5mJjpLUz42ynL+2AtF9p/AfW1ZZP1XeUfDokDo/r4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djhIu4oN6iegJM1paOm/g9Me2fHXvfA5FfYAhNWGhKA=;
 b=bEtzTOimhcFtL03BKBjCoc+PgNOQxPe4aqdmpcy3ySlq9zXoEN1kqmm7KLV4CVIYlr+ohdp24I38+3dZxWHM9/IXvXeqQYrDdAqrwHqLJ0wXVww37dGJIBAi8WSXrmp/TFSoXeFJncQ55oZTTQ+Z0iD5UUo7eBcpZXL2VRtLlrZDzxqYTbfzy4i90bffxvLdP6keqVccH99/XuZPLcF+oJiIONhEdvdXfgaUoePtkyer8aFyC4MvmO71PEnykZL5C8toXFtYdu+NgOR1xWCw6MSnNQjacmeT4IENSCN+0OCbMsCkXBcI5P+CJgKoCqDK3VhYsCuk0QJG1fe0vpXx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djhIu4oN6iegJM1paOm/g9Me2fHXvfA5FfYAhNWGhKA=;
 b=DxeihGCCwgPQ48x2B3yHUF6+QqsuAWytm0vjbWbG7mETxgE9C2ljqJ+JRxlQb1qmcQqMoomtfJ647qwmTekO/ix0XfnfFB5sp0M5LuAZhFAeUD29dQ/ZuvLg2SM7Z/k/SJtZ2WuPpLQwmniPj0ej4QGJTgtSxNilo1HfWnpAc/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU2P193MB2018.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:35:30 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:35:30 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 0/9] can: kvaser_usb: Simplify identification of physical CAN interfaces
Date: Wed, 23 Jul 2025 10:34:59 +0200
Message-ID: <20250723083508.40-1-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
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
X-MS-Office365-Filtering-Correlation-Id: 3c0d44d8-58d8-4665-aa68-08ddc9c3e1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZjuRggxDKahfeM0o3R6UcfbCcp8xR+MWM+KyXhls3KwjLZhwnb+pmZ7mUaf?=
 =?us-ascii?Q?RDOvi/a8mTVK/MWZf7YstKNKQuAnznQsOLQ57uSfq3PE2zQXNi5626TeHysg?=
 =?us-ascii?Q?R4AU1Fp7iwD/6N2x+WxTXdWtuxjHn4PZXyk0wdtAZF3ZqPmxmi4VU+inEs07?=
 =?us-ascii?Q?KbCGg1narYFun3FT79YdG4ovWizJQFqJZighKkAC/5pXBRduoVVZV1+KfvLO?=
 =?us-ascii?Q?uvREVV3Tqq91iB/vMwOYM5lCDANm1jb+vg7QVs0fZVhPgb9DWqv7c7eN9NLT?=
 =?us-ascii?Q?7dsPUEoOcYN77y8NBrfOkn+NbldRrvVF5BRA1efhG7+wXooFDerAQTOf7SbO?=
 =?us-ascii?Q?v0o/C1yKeHDg3StFY2h01qGUbYJ1mDWrwPACG6KIjq+kYViEq2+vxRRuXIsP?=
 =?us-ascii?Q?dnopjpzUFqBGyVGiHGT++QfZE+10dZH2gonqQ1MwHjzxLjLm9vz3YemSqNOD?=
 =?us-ascii?Q?KbOGe2ptX/CyBD9N41NdWmn87C8esgemAkAJqbDyNW94iJfclsF0EUGm8EEd?=
 =?us-ascii?Q?q6xQXTIdHHVKDVhakrT8W/WgheATlrCTQaoqGMBgRlP8BzqfIzqxrX6MX2OW?=
 =?us-ascii?Q?dSUlneOxQZayHbeF8wCoZxlDGNfhUCyP4HZdnBND/ce4J77FQU+YW8wcunuZ?=
 =?us-ascii?Q?tJ5HEtYDSTXp6mwAqZ1G6yydbo4/K71WdHwV1YRUFJjpJWrseisqTUquH/MR?=
 =?us-ascii?Q?pijJl0SsdFVnDoML8qEJ1hi3whOtGbn1TAM1G+0oslUfp3CzMCH9x4LQTNgg?=
 =?us-ascii?Q?GB9brn77dGm2NvbMTXY8sFLcjsqPzypIR+cFtTW+6cT8vTPy+/2vkUb22RGh?=
 =?us-ascii?Q?/IsORoXP5L3Geb+l/7TGKFSrICbwr6yjspFFr9KALACeh/YQdkYgz1vTfpca?=
 =?us-ascii?Q?3DdmVUidUAwIHK5FyiLiauBkRvXfVllQ1gk+w76wq19UdI9Bf/BJ/fy5L+5F?=
 =?us-ascii?Q?NFQ1Ojz+GUi5iynLmss3P6NJ050cxymn0a4MXIz3QFZVd3d80yTjkFdRyXJs?=
 =?us-ascii?Q?mqsmUszV9LqkmhV60tGKACYLg+2wZx8krY+jy5L6ej7d1/6xYSmChakC2XX/?=
 =?us-ascii?Q?vBQbJdDKGX1aXmWgVAmoCn3+hz2pHQYYtCnTW5PmB4EqFKyrQPxqFvDGSlgl?=
 =?us-ascii?Q?WQl99VpJGO10MUMiL1LOy7Gcbt2QJLRROfpWFwFjtTR4oBiPwmPU/hlEmtvI?=
 =?us-ascii?Q?vvWWC3hC2A6jsh6tf8INkqEuCwfbxO/yyeEBrAuPIJgNa7mjMJXNs3HqriiL?=
 =?us-ascii?Q?vhMNgfuRBql3cKx3+qqBnuGUpRz/lKKVXiS1MVVyaYq+bfIEVcS1n/I12ao+?=
 =?us-ascii?Q?eDTfMp/MX7xU3Io5TGha6Q/bnSLVSzyF5JYMwEkO2viALC5ZfWbWcZIE2G4C?=
 =?us-ascii?Q?cQxhIL1r7zfbjlTyOcSx/0SaibgfWcGmsGrlS/UiXNeRmT/NfPZcUl2D7rob?=
 =?us-ascii?Q?9rVsL+BkIRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Jy2T51fpseixggKUh4BXX6zEqkGvJqzdTkXmFk7VK336UoQ8htkVIYb8Pv7?=
 =?us-ascii?Q?oXV4ZOA8TwD+fp1dcteBJmiTgEDzdHYIG8zqw3IEJeWu0K6dfORZ5BWqvtD5?=
 =?us-ascii?Q?I8t7vC+vsU/Kw0NsnW/aW5Az3cquRTAGMwdmXNnncMd38M98pG1ylUjgbRVC?=
 =?us-ascii?Q?eLJfJ+twALQEAMLezTpCi73BJrIRNSYX59j8fo8W0Np4lPHh4x+HUJ5LWXPV?=
 =?us-ascii?Q?ArPBkA5qiErv18qdIZ7S63zTwE1QPfIXJDaSUf9y2JRerZdFSSPHjtEx3fik?=
 =?us-ascii?Q?HRiqLriidv0ocZFPJ4TGWBekohPBV8M7f6eVoypCJ5MkYL4zCKjU+ULyuGha?=
 =?us-ascii?Q?D3BC6rE51PsVz4cEkdRiAlXXnFV9kRrI29wbXWfu6dVQrLPSiI/iajUASIWS?=
 =?us-ascii?Q?QU2BMI5wHsolm8VFqfWgyfSFIumUzQZkd0rEqxRqjFWIKww80WL+zsuRa3GW?=
 =?us-ascii?Q?qD6XtqVeyNB5ol/UdE5Fuv1N5WQd5sEsycRPuM/gJ4DPGo2cprLi+JGSgveh?=
 =?us-ascii?Q?lXdFPtUTdyZY22AcgpsPpW24bZqblByOeh1qn4GKlRHB3/JaaiaiD6/S8CZl?=
 =?us-ascii?Q?2ohHXhLjbkrIF4I6mqJOvBZRTyxewGQZUL++W6mRGD1vlCwhwfXPNPevakah?=
 =?us-ascii?Q?I0RCyGQx0J54OUdeifYjnoY0H543Ggz2DsfTr34TaDRmkT6THS9Ae6iQTx31?=
 =?us-ascii?Q?sS9RDcDX3oBIHLtw6kGBh7VnRcZu/oGZaY+PBCtRQGUOXgBzysy/mRIgRc8K?=
 =?us-ascii?Q?HW9H65jQNd/rEd6cgWF4PZMddWX5HuNl2mOCFaznxtJ7pNwmgpEjCC/7UUkq?=
 =?us-ascii?Q?sMpMyp/3ntvsxMmkyceX4QEOxUj/8n0HoH7s9rGRhWQnuo2HdhZ49PnNWTgo?=
 =?us-ascii?Q?MQLyPHURduuzbioxPQ2C34JX98CqPqmWDQ0i0Hvm2ip6isGQNxCfvunz/esn?=
 =?us-ascii?Q?GmO7P8bQ6QVrQvoHr+yCaFrMHhGj2iMiP2ogH47ffKZU2bNz5lh33VRcVC90?=
 =?us-ascii?Q?av+3sqDZ7YndEbF8ChIMp95UwpCSEgatXc6OmCaWT1lP0KT7IgFs+MGiblbk?=
 =?us-ascii?Q?pavUN1/hXqJbT9SycW9aqaE4+8OAE2Rma+KCL6G2/uSxD7Fv8Yrv5sQVXqAR?=
 =?us-ascii?Q?St2EHHG1GXxQ08NdjyOfUpopY4xi6xwrYNbpR/2XWCB5aNiLcwOwwxzRBakU?=
 =?us-ascii?Q?EGSV/jbHCmkJTY7IFhjPyf479DuSlh7gO1vAh7GJdjxlj+g7IaCU2ngDSkjB?=
 =?us-ascii?Q?4Q6myGC1R2Tn9qheL95qvUzqVqsqZ3d5Mch1zhK29UxXKOT6Rm0F3PEeG/Ap?=
 =?us-ascii?Q?SQHH2pDLyDWtfhO4ymhfwcxItLJBjVJw7dhLGQN4HFba6PFP8i5LWjuC+3Qe?=
 =?us-ascii?Q?+sTe9j4oy8QwY/0cqOOQH6JDMM09XZHbH5+8AZ3xZaakC0CQLlwSK54eWREO?=
 =?us-ascii?Q?vwmn8L42ZGqhu9a0T/4mqTfZ56/uqABSdKXj7oQFQdyHtq846F1z0QzbBlIJ?=
 =?us-ascii?Q?+LlQ1HwOwHWbbfcfe34oQIYbqG1Lxz6R9FG7F4ndAMng8esRIzwy2MSpKIF3?=
 =?us-ascii?Q?bN3+bnKK+J5hNYZ0YXjBAVjBi/Mq5ZyHUzN7kon5i8UaJgXO88MRyouvA4eR?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0d44d8-58d8-4665-aa68-08ddc9c3e1c2
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:35:30.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+eh6FUZth9KR8G6m2RObtjJhpNmGDgWytyN9H+vlUVPEiN6OAcW3aIlnmQ5KamFgokOGIT3HzZ58DicEIiql0KXVt/nszUFtC8EGLc4n3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2018

This patch series simplifies the process of identifying which network
interface (can0..canX) corresponds to which physical CAN channel on
Kvaser USB based CAN interfaces.

Jimmy Assarsson (9):
  can: kvaser_usb: Add support to control CAN LEDs on device
  can: kvaser_usb: Add support for ethtool set_phys_id()
  can: kvaser_usb: Add intermediate variables
  can: kvaser_usb: Move comment regarding max_tx_urbs
  can: kvaser_usb: Store the different firmware version components in a
    struct
  can: kvaser_usb: Store additional device information
  can: kvaser_usb: Add devlink support
  can: kvaser_usb: Expose device information via devlink info_get()
  can: kvaser_usb: Add devlink port support

 drivers/net/can/usb/Kconfig                   |   1 +
 drivers/net/can/usb/kvaser_usb/Makefile       |   2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  33 +++-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 144 +++++++++++++-----
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   |  88 +++++++++++
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  63 +++++++-
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |  75 ++++++++-
 7 files changed, 359 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c

-- 
2.49.0


