Return-Path: <linux-can+bounces-4100-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66517B10626
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A9F5A2834
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336A22857EC;
	Thu, 24 Jul 2025 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Dg4obijD"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2104.outbound.protection.outlook.com [40.107.105.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B150283FEF;
	Thu, 24 Jul 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349133; cv=fail; b=L8t2FAXBeEuEbT9kWXdqPsw27z2kSPk85JFa/6jpYIoUIOYY/SMQ+AzPdlkC4iKE7oZ9OaBz6CeIGJDtQhXKVVXv4ioKLO/KqHo3Yd/W1IxfHPnrOLApQnX5RySN9wLYQxopFV5RkUekk2h3FbvYaf8aQy5S/yD7Cmdz4OwZI5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349133; c=relaxed/simple;
	bh=4HHIULxuEDrW2H2V5CZCnU91zelIrxVBPo07GTVIhyk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cyJ0tFaTObCjNRL6tSc2IMH7rucH9ApPHTUsKPX9B5UB1Xdjpdfwi9cxTrzFyjgH0VM6V3lU/6aS0MnhlFDNSXd5TLx+2N1G7WUin94eJuHkHWIK5oQ3t8uNAYwJ3DzMxXmDCOeTHSyBoIpWPJvOQ3VKAwDv7srtu/5ampi99qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Dg4obijD; arc=fail smtp.client-ip=40.107.105.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKqefeK84cu5WLz760zQsUCigSfcVe986BD/NlZeenoFiHaV1jS4kzSVx20QGnou/7E9AoPSjnLJy3cP5IPrgeXTX4x8HT3C7JaK5dPvb9tKCYUTzNHWE4LRlsvNAKmZE8ccM3WBf6PBGKqjmy/v3jscl44hUE6hFSq8Ke8T9ACxsKtIE8RQqf+GY24UPfrZWf18RVWK3gtZJmBX2Y0CVCfhPjbEqHytgv1ZI+LigB2SSYfPZmOR2zTl7qPQJPoOO5zwpKczwvdPAAk6VnZIThs0vagRBlDE+eICq2wiqakl4j3fwpgp8GNpbsCKbHcGPRYrB+r2CKD2IYwMCMX97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3eF3qHH9dgJ0PZeTwqK09D8vQxU7q6uAEZ9MSmQoL0=;
 b=Xv0rVYmXlqfaAVnMfHnN3xQNl5EpR5EUOuZbYkbxU8Te5D4k0XdF06fd9pVC/w9TIk5Qft9qVRNh+I6aAlAQEf2brlSUcJh3FE4v04DIMTq8AC0YZ1xsVOZYXeqHQhHm5XXGjudfiSroVitanhm228sQUIGBc3JUivisQQojTETlohwD7afkQ3DKKH03yBn71vdfOrabqL3Sh95Ec1EMj4yMljNbDy/xygqi8v6sv6sfXZzgUNR5mWwGaTq5iTesjOuVnE/I/S0WXkyx0zoGRoU3CrYJB4UqkZMAUZXBJHy6m9HGzW6ZtbG+SADYe8HCZKoEx+DBDf9HgvesFpPe4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3eF3qHH9dgJ0PZeTwqK09D8vQxU7q6uAEZ9MSmQoL0=;
 b=Dg4obijDm+VSdAQPJ7HyIjjaOlEWD7nVjl0WkaBhPF2f9DdkV/qeISEoI3o/XlfJJVxLbMLBNOI9hFm8g80fiSEZ8XFW1BeomKdKMjIZusidB6JMdcki4SPSb4YX5/uwNKH6QBQWFzGnFiRkNRgW6mzbJ9sCofQ4b+FvCZucXkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB9P193MB1433.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 09:25:22 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:25:22 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 00/11] can: kvaser_usb: Simplify identification of physical CAN interfaces
Date: Thu, 24 Jul 2025 11:24:54 +0200
Message-ID: <20250724092505.8-1-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB9P193MB1433:EE_
X-MS-Office365-Filtering-Correlation-Id: 5615a937-aa02-4e63-bb18-08ddca94037c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sOv1SU8TTfBEYc2ZK5XU+jrQUXvb7wHHf0lDHIYaSSedE2JCTFkU0+1KvEL5?=
 =?us-ascii?Q?66EWRiQ5sss69d+TObgBpZHTkGnGRtEDDHeNATmrp8TBzOPVL3LZ78xj1Xhg?=
 =?us-ascii?Q?zRmp4Sz4J2CYNCHPyISBVIBNH3Pa9vgYknw5D8WABAR9Bc/4zcOHyu/TdM/q?=
 =?us-ascii?Q?bxi9GNtNNeM9354qNohpj9W0blK1HSdooyBGd9PNKw0XiyUkg1h33Aa9+Y3Y?=
 =?us-ascii?Q?f9hci1ZBJyQX1VWoOM9kC7NhJXTbw4MytebvR9ePjLtBpz09sx0e1286rTCb?=
 =?us-ascii?Q?sttY3SzvDL8SNCjaJdkRcZKv6MWVPl+YRsNyuduJTBxvM2PHlW7fsd81xK8w?=
 =?us-ascii?Q?8r3ACJctIfh/e2/HUOf40IdPV2IoAgVoYF+OkJu0HWYkj3kCNg41YbHVvVTc?=
 =?us-ascii?Q?Cm7TpEbQOmlMNjqYjmriQqAm4jpEB/JhtqSYDBICA5IdJbNyMYCC0yOhN2PJ?=
 =?us-ascii?Q?ZCnwiZJ6flCVcPeUwGXEskunPo+DdtZ7M7F2O+qIs6rWdcpDiKpG0ncA6ww6?=
 =?us-ascii?Q?Xm4XNvvez+dn1LRUbe016bzZhcfKfVLG2apF2HXgSRW3gV5g5qJZMiQShsZW?=
 =?us-ascii?Q?A5tx7+/EuugvBYhdiWRX+xVYy5PgKiPqBbtBEB2a06931uSLpqRz/b29Bes2?=
 =?us-ascii?Q?9w6lQJBzzwPVU9cuzvBW9i+I37+YZt31XQeNjI9pth4Jg1YIogDNnrEbxmBt?=
 =?us-ascii?Q?NEHW9AkM4TGG8uRUKiC7p2ehvT1x60+hEhT/BPdaZeWtgILA2qq8IoMVB94V?=
 =?us-ascii?Q?cg9oouWe1IqBaYkG0cFnsYTgpAmAkEse6Z/TDSVreUtyYOGLFlOR9GiGbmMH?=
 =?us-ascii?Q?r/7iMmXrJGzxrdR3Cy7axWopZHvmbsHt7fvSNaaIqdWfQq2aU7D6KpilQNwe?=
 =?us-ascii?Q?KDs6vpECPI9G89p33Fn3tgzW08oX/wamvm2jXDWDR4QBPraYTSHzuwF4h3to?=
 =?us-ascii?Q?2g33SO+1yLbphsTSeNKKLr0AoCckMl6S/3SMP1p/q6HTz1vTGZZFfXqpg1TY?=
 =?us-ascii?Q?KcrOryLM86WtA06OP4gpjTrBJV3rGZxoG6Mr5GU63WPp4X0jZ1eNsEJbZlfW?=
 =?us-ascii?Q?IxQqEVNg0hKzFV3TKPuyxrrfvaA7s/GeqWT68+c+HsQqCYxrb/FzPu2fmtW5?=
 =?us-ascii?Q?Xqx0rzIbujezDbvj09QCSKTxpDMbpvFb7N18mb1BZrELf2JmFRPwJjIBIcO+?=
 =?us-ascii?Q?p7wWKVgRCFpP+IZP6OEQ0iO0B1fcOHLFyaEOjyB6uGx+aafOahVj8SKIVdQJ?=
 =?us-ascii?Q?7HXmK1KHaREJy8sP5iC5lDKzdGFFi4ZD/rpGBvnTIMJ6bhtJr78qoGe8Eoui?=
 =?us-ascii?Q?YIWB/6LTHR3x6WTCXugaRz7nbe0f0bXIcwfn8lgDxW61xXyWA2EQywpOBW9l?=
 =?us-ascii?Q?+hkeCi158+WKB+6ffCpGsvXx+5O6d/l4pbQJXj3ngd6rJ/v6mYw+nsPVURhi?=
 =?us-ascii?Q?M1Akm0UvZJg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fAlyXhBsnU7lPY2m2DkVHXmLFMKqUcxCfmDllsc3F1wde3vVeKnO37lfzaCi?=
 =?us-ascii?Q?8kbxe+jwV7zCNb7/sPWSQp/wVwpLQmBdyPvlKRqcFmSobAUqJYdxiE+4ZHO9?=
 =?us-ascii?Q?F3lfKKYyoQexwhpIYtkYoZPbjJxDS6zxv0NR8j/6GpNV+1egh63iL6qt+zs1?=
 =?us-ascii?Q?cMEIFPmp6pyEAiJnoefIkvtElNBINRWoHoT+KyRTB9itnzowI3pTN0uzv9kO?=
 =?us-ascii?Q?s3CrUB6vpu/kHSXO2Eqgg/Z5Fr2gP3Z78mBvpgcn9BYGFmq90rg5dARhuDh6?=
 =?us-ascii?Q?qBBLkQu7XXL2y1Fc1G1JgIjsN5A1LH588jzAvI4RiUxYVMM5wcpju3oBtzzi?=
 =?us-ascii?Q?QpbIkWDUc2MsGrMjL/5CQvAUJyOJlOD6d8NNh4aEQgJSXFc1y8nJ1RIHQUNm?=
 =?us-ascii?Q?zpEE5u1N406rEG9Odkhx+Ge/6SCnU30ovp5t05/RujW5GbQ+p8bhO/wrTJBn?=
 =?us-ascii?Q?dQeX/Q2HnfMMY2I+wlXjWmuAQps2/98ZsEJdwqYxHCyS1hlGw4yapBcQt+mI?=
 =?us-ascii?Q?pWumrW/LnVFl6vF6WkR/t7yM4uQ63y9F2caGh8S9b2GS1kn1cDitptfrdLM1?=
 =?us-ascii?Q?UjnvDqPw70XQbWchVe3N0KkswZjsHDs55asR8y8j/o5uektm77+8rChEIndT?=
 =?us-ascii?Q?NvaCG1pWDSoG6AV4InL+aOH9FrGnsiNcP/ydFvuaswYBtjxx7I4LXCw19QXy?=
 =?us-ascii?Q?ym/kFaqc3uvA83IKzzm6cAvwybBv7OQpLpK5ugCPZUxb3vj/A/ce3u5pNTso?=
 =?us-ascii?Q?c6gd8z6/dLcyjg2wVzMUnBBcoZv3gj1+0vym69RmDibsYYe20Zoigctr1S3r?=
 =?us-ascii?Q?lv1pMYoGGjiVHBk/7NQ0UZyAAnVLQI6KsMd2GWhrLbCpDI9YitH09E77RT/b?=
 =?us-ascii?Q?kWm02SrPzg8Rqa/duoW807c0otFmRVC4JD47hs4Fs6HHtBBxJnJxn9I+JBTl?=
 =?us-ascii?Q?SfT2DFUU8TO1A9KoboWyEFw9Qc2RM6eAE1vgX8Gt/FZ/Znt4NYRe0sWI1/bQ?=
 =?us-ascii?Q?keKk3cWxy8zxiKwtFMR/D+fU40Ff17mrLjiduThsK83Cr8O9KShFGlbMjpGE?=
 =?us-ascii?Q?VIsMEFJcN1K6JYtCE1auhonDLRkCLcQ0JxAbDjzhm/dNYlI0mfZ+9OukwtTH?=
 =?us-ascii?Q?WImykD5Mj7xH7eMqHEo8CBAPUe9kYr8exKFMj+7zVC/iz5lIXE82Ukoau+2T?=
 =?us-ascii?Q?d7jDKRGEvAT6HghTCYwaaP78Nzc0xB9PbqdvB+kxY0hatezSYMtEaAapubG1?=
 =?us-ascii?Q?zIdhXkjbY9A6ijEy18sqQZi3ZE93dDmynZW/O1lydNACz2BX2pF0mS7KyRqV?=
 =?us-ascii?Q?41i85buq5dnLJthk7iLHP1vd+pFADa1YHGMoWHYV1W03AAOYDZeKqITz26BE?=
 =?us-ascii?Q?9pRO48SYWG0zfLJRnOT7ekjPGT/9wgLbTbCvOnWOxdI8R/8EhbyYBNkmv5ix?=
 =?us-ascii?Q?oen37hD75H+E81dBNT4a2iYqD9hrOISItWKB9UmJ8aw4Fqav3cegCk4ScbUk?=
 =?us-ascii?Q?IKQC0MPOaQlI1Vp33N0Q30obnlhob0Fn2D6nwEe48jOJOfzmOcMXUde9RzAh?=
 =?us-ascii?Q?vircwwkbbfY7UuFbW9ddP/Anrlty8NkujuMcpsu74PVWT7/fvCEXdlhOeGvv?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5615a937-aa02-4e63-bb18-08ddca94037c
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:22.3551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWJ6gU/2v8C5/hAwnuIC7l0f+1C75NswJT6JjJhecW4lcfGaX/mB2rWLS81HXA1DwH7VSPua2iXht5w3KA703lGf5xEv5pWgwJjodV8qVJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1433

This patch series simplifies the process of identifying which network
interface (can0..canX) corresponds to which physical CAN channel on
Kvaser USB based CAN interfaces.

Changes in v2:
  - New patch with devlink documentation
  - New patch assigning netdev.dev_port
  - Formatting and refactoring

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
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   |  88 +++++++++++
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c |  63 +++++++-
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |  75 +++++++++-
 9 files changed, 387 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/networking/devlink/kvaser_usb.rst
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c

-- 
2.49.0


