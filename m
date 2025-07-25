Return-Path: <linux-can+bounces-4133-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37AB11EAC
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820D67BBC73
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B832ED857;
	Fri, 25 Jul 2025 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="QWbdHLmv"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2103.outbound.protection.outlook.com [40.107.247.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7845B2D0267;
	Fri, 25 Jul 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446783; cv=fail; b=O7gPLSMVhXTT+AF+XfxtxZ78ecPLn1rSsXtmOjp2GdZIdzgbe02mj2c/C/Y2Twn0BZz1qSoBrjNdBapj9jf4rRo6i1K9FMDPX+OPrp1PJLX2deDf/q7Th9ZWlCcQ9hMBEK3SJx8SO5uPUIsHoO1De8aqbTMxO5eI+pqukrK37ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446783; c=relaxed/simple;
	bh=yWymjMvay09B114OjIy/b9tU4YKczlaB37Eb9HsRwSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7uEEggoujqF1pnaRd0rJF1276Jj6QYawrXmSxw1VuerGuw8jB8jF9Xz5iSaoxifzmbaQNe1KaQ8/1oJbv7ijTm2xQeDviQuJ+3ie7onzkVExanpQQKLVHTD8q5NKX6LRY4aX5TwSeybc6gyOW3PBDYcIHqR09JEDqhopdI/SIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=QWbdHLmv; arc=fail smtp.client-ip=40.107.247.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4unuIcMXdvfzCBJnJg+7GtNAO0qUtx6UR+oYiokuKHBmiE3cPzopjAXB72Td7Bt4J5FDNNwPSKtH2OBEuE9MCW2UoKI9nJ50VmBGxzecw5v7+7r8+oZJV/TSnMMsVVFJcOainFMOpE5N7KfXnmBshnjytZX3YO+3yVYNnGNAiuIfBH/0lpiWHY9saVooMqyKA2Fr09hytzgZLZcoPyORgdSK/hfsUY0/VZW79Cy0bL4Qswq3Y/Co965d1muO9dOiF/HlmzTzVY/uvryvR4pyCcdzoNIGQsQOHm+1ueUdodibnTGLYLIFqcJVoJpYdO0A7VZaeJQfesxkowCuZtgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmAfdrbVPaKhd95FyD+CXocMeSd8InfymYdoeIxkR4M=;
 b=oitOZzSF32XX78oVD8fhWbVZ9CxJwNupi6n/mQ62/LbH8GNZabN8mXlNXBrVnVZGO4WbpvjjnA8F68QCZX/QXzAarCayHuqN1D/MmqNbMfM3BTf1zXyXZ/KE0bYZ5x/9FFklFPs5nyqgswWgWWqzsB5KkJP2n6o2oYtbnnXGm4dlnJSQ73bo+UVVTTBQbKxSRXMBfoqHTJHJvcbEQqg72/i6LXXnwoyCL/saguu7wUefI+v2ngBcRfZsoI3udU587jtaVQWiLib4uGYJ24B2lEDkhZOL0jDvPQeIndB/sf7vcuLHsunRrF5jbkZRuRY4p3BOqgvSuvsp+Uu8qM6tuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmAfdrbVPaKhd95FyD+CXocMeSd8InfymYdoeIxkR4M=;
 b=QWbdHLmv2nrzkh9kgRBUksgLEoRXdhLNbR1yPBPxx6EV5JBMvqzt6uX1uX3C2eFOBKJCPEMiLiNcaWMup2yMyMt/f+1WZqF9++OwoT6T6Nym0iUcpJG48q/r+GUYJL9NMvzEBL8qouaseeIMddQnzZgCeynN3QJUR9dIYGIJ6Fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by PAXP193MB1376.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 12:32:50 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:32:50 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 09/10] can: kvaser_pciefd: Add devlink port support
Date: Fri, 25 Jul 2025 14:32:29 +0200
Message-ID: <20250725123230.8-10-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123230.8-1-extja@kvaser.com>
References: <20250725123230.8-1-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 249f3190-c670-425f-93ad-08ddcb775e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ewrKGUCTwmkQBsjHbkOYQhotoyG3jOZaKSlVyIuEheVjbhowIKO31pULYD8P?=
 =?us-ascii?Q?yjUFc7gmKHd1zS1AsU7+OvPlFCTnOI8+ob9NWBCoJGbD1yc2esLDibYAMQFj?=
 =?us-ascii?Q?M3LnmiC2aAZe0dGqDdZydJowJpkGf5xoXhsU+3E7WUJYr2h1X7y7rBr6Kq21?=
 =?us-ascii?Q?1DN0KlDpJVlJvghdDh1zHg+NtW1tcQgMdJhlgnvrpPjB1wuDZP5TCtblMHGk?=
 =?us-ascii?Q?FujdqmexThdwBOSSpDEHU6gmRzMXaGVo7cD9/LJP0/lBopFCTogSv4VTkx3z?=
 =?us-ascii?Q?7/zELi+85lC4XdabEj0Gpg7l2CDmYfsChWpndhXq46Ub3WH328C1y1PIhkj4?=
 =?us-ascii?Q?AMiatNCEjKYTDqOunGGctfaa43HTZ5JGMkBaHZhMzsY1517IXTehG5Xwh2BY?=
 =?us-ascii?Q?9zf7HKhSHEJKNAqNwqc70xC4jVnSz2OCe+hj9zpj3nOuVQXI/PEsPl1a5Op6?=
 =?us-ascii?Q?gyEB8U6H9CADrbAu2v1g4/mxyeY9BPaA7s8hqTIhgH1ics0xh60ScDMWN2Fh?=
 =?us-ascii?Q?vceZrHb9Ls7thPT9dAi/4N2icGYhQIZJG2ky+JlXFvSUdCbOvfJqVUXglymE?=
 =?us-ascii?Q?diuN0p70OCrMwesYNwo09/uEcm4VFU8YvOOskTdHI+geMTMQJy7M0YBtaPaE?=
 =?us-ascii?Q?hZLTz75sHcqHkixz4QA47kj5moL5Te4veds0BNFF7EGRPeI9tm2LiTN4v9Am?=
 =?us-ascii?Q?rA3NK+MjJjo9s7SRh4S5yfeHPtc+KnLxwJ7gMcJut7ET0jjidjvxUye3Qfah?=
 =?us-ascii?Q?QTG8w1c8lajHo6Vn3ES6WozxYyRZuEkVfWAzlVS0K4Tea4aAOR6WDlCVdes5?=
 =?us-ascii?Q?Xh6gc7eLn92VZgkDA7wAyATfCVH0UaYxzHzAAunCqWsBnrReWTyZqmlq+kHh?=
 =?us-ascii?Q?YjWK021wqPTI8KkIm8ZFosHsW2PiUw1Z8hYWCXcDAyI9YXVj9Me57L0gW/hA?=
 =?us-ascii?Q?90Uc6a535g7vKuCsWUfDze/qLDErJ9HLFepEFfOMQaUfqtu1Mecg2y1ULqla?=
 =?us-ascii?Q?YemG7jkj/olNb6kkb8/ZZXYEaIfih7ZbpB3KdcHki8aJS1NWpwKjK3GFSeYW?=
 =?us-ascii?Q?pdCBwnNqUXmNSFRRMvaXt51XiijEDSLhNK5IZDmMhBgPtlXI7uB3Iz7BI+Le?=
 =?us-ascii?Q?KqN+wcN2yYy3qzdmSt6lxK31UigKBwDTEV8kyUoAiWxL2DMZWPUBVn0YtiZ/?=
 =?us-ascii?Q?tAQm0isDgKY3jGVr8GqwmhCwcmX70GQPeBZoWF5H+PSyAnCZqpMMAKrZXzDs?=
 =?us-ascii?Q?M2awfFQvB8rF/I5rDB9G6EJECp7lRtoCbiQQ2beqZSqyk9vFArHhUV1Sl+lL?=
 =?us-ascii?Q?K3Qg96TCZ5QnYxlmOsJJdeCF8Lu2y8QAlGVRdr/vmorCdJZHF7HfNW4dRQLt?=
 =?us-ascii?Q?Kg7PAwk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UpW03HoJs+AwWZdJ90h4xQ9t+DmbUuOCHogPWogN5xj79XYpk2bMQai7GMBw?=
 =?us-ascii?Q?/WjtR+RN9AFhdAjTHX4YJRVUuAlSrAjT1aBQkYimzsMGmeEKN1EX98WXw84V?=
 =?us-ascii?Q?l4suv2eA5r+Y3cb3TBSTDz6buQuhn2fyKs+CDm01JVEf3BXu8h/XArTt5kzX?=
 =?us-ascii?Q?c9RhYSNhUoRB9KW8UHWIknhIMheGYDy8URKvkvvgGb80uMuHF0ZeWGwbwQJZ?=
 =?us-ascii?Q?NP8mshne0rfQzScv8LY26RmWWbcdE34NbKBJqrCVqyt2Kdunvwa1D7irEOIF?=
 =?us-ascii?Q?85i/xWiM2XMJh1DyMtGhPAbCcCUh8326989St56kkxJvg3FIXNmoC9+8GKbF?=
 =?us-ascii?Q?Ph9MROxANMHPNE1nDUIkwYsDm8O6vgFDi2M2TqQXUXBrX2U0pEW8XNMaT7cC?=
 =?us-ascii?Q?bLo4MCeV3T/mwll+xFn9vgdVnBzEp3MKlS1mQAik0hhwjibcBrelrkOaGsU2?=
 =?us-ascii?Q?U8oh0rEbyCUASUU3UOwhNlzl0ZjixYJtXdBhk4hfZzfM8FEofEsRN5m005yv?=
 =?us-ascii?Q?TcV3Y82KkgpyyVoAbBiouKUpGrP0A45Hd2Kz7TvcX03DNM8MlpzYeeJ8d8Ja?=
 =?us-ascii?Q?8LD40ECU6fIEx9y358qso3JhUAYNJkwCQanDExp3QijfPTdMIU9hcmBa/hxO?=
 =?us-ascii?Q?9ZN6+ePxfEGIJhQ1CqruHUk+Us5WONjjc4NfiDrockrewcak6xla/5JfF3jj?=
 =?us-ascii?Q?wI2n7/7DjCrKIL01WCG5rZ2TMydeZonolRE43uJucI1nmJeM2m3hmsgiGGLT?=
 =?us-ascii?Q?cHGjNQ2z27j+stP/WY/fqSRJEBL05AcKiiwEcZMIoASTeNo+YSo8bxcuZ9C2?=
 =?us-ascii?Q?Ji2qL3A4qW6Hf7NOHHsQkO1D0JchVSqYdVTxcmBi/htrBq4EmAH1qZlUK+Cw?=
 =?us-ascii?Q?oS8Y6aWpyNBpjySf2bFkLHotaytmisZbvKr8RqY3AY4l45BWJrcYVfJmMATT?=
 =?us-ascii?Q?0F1bWvr5+rJrGq/aLovIPFTRHKpbHXQZ6YxYjfv3YPHHJspB5P+d06p62st7?=
 =?us-ascii?Q?QK2uib/d8x3uvjUjoPfnL69wlMgbUsrwITWzNuSUsmX6PP016qopYWuTBRVN?=
 =?us-ascii?Q?0liKQ0mpo9S/IZynmjsygFEI3DI/Hsa3vsQPeyXwDiwy0g2doeeCpoqa9ljc?=
 =?us-ascii?Q?bYDOCOaPWxycuVJh53Nvn4bGqyD8diwPXjIK2ApwOMDvErYWwosQcm6boEwj?=
 =?us-ascii?Q?Y/s28jkxErrTsWphuwSJKbpmHsRBicZAkemHb7gLap55wdb350WYECF1HWWi?=
 =?us-ascii?Q?81Do4s4tKJRX/gB1lrR7cB0C+APza+/kUA1YUZcweKU33Rd4pW+OPwHCs1yF?=
 =?us-ascii?Q?JmJfB5c0FZnWKMTbqFelSRATqTqNw0s35x+8u0xfFpQAp5mR2JDekF7UR54Q?=
 =?us-ascii?Q?efs1PDF6Gz2PtgNJxkOYb5SI5STOFrSFt0QpD/2s3xiM9TKIY1WKRkULVjiR?=
 =?us-ascii?Q?JOyhvg+4SQ3uC/QkqgIV2/mpiV7Qmg7AfX3cY+r2VrC4lD9gyQpWLd612jA2?=
 =?us-ascii?Q?mq/qq0b+6jR75PRjOuD5BzYslTm4kPOHQDzeQVsqEJPdZoyAfxPl6cJ5o1bw?=
 =?us-ascii?Q?3hed8gjiFecu0S4CZR+4JlFBFitEaSZNZJKxkfsJ+4bNIg/1S/+0hLr1fgsb?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249f3190-c670-425f-93ad-08ddcb775e45
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:32:50.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GzlZxDAt3s0w670YgYgb9la3NCr7gG39HTpahWPL184SuDETWzj/BISA2vYFdDAsGXwapd2nQfsRM71YhbJ+/EB01vbZI4f9JHlr5LUzy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1376

Register each CAN channel of the device as an devlink physical port.
This makes it easier to get device information for a given network
interface (i.e. can2).

Example output:
  $ devlink dev
  pci/0000:07:00.0
  pci/0000:08:00.0
  pci/0000:09:00.0

  $ devlink port
  pci/0000:07:00.0/0: type eth netdev can0 flavour physical port 0 splittable false
  pci/0000:07:00.0/1: type eth netdev can1 flavour physical port 1 splittable false
  pci/0000:07:00.0/2: type eth netdev can2 flavour physical port 2 splittable false
  pci/0000:07:00.0/3: type eth netdev can3 flavour physical port 3 splittable false
  pci/0000:08:00.0/0: type eth netdev can4 flavour physical port 0 splittable false
  pci/0000:08:00.0/1: type eth netdev can5 flavour physical port 1 splittable false
  pci/0000:09:00.0/0: type eth netdev can6 flavour physical port 0 splittable false
  pci/0000:09:00.0/1: type eth netdev can7 flavour physical port 1 splittable false
  pci/0000:09:00.0/2: type eth netdev can8 flavour physical port 2 splittable false
  pci/0000:09:00.0/3: type eth netdev can9 flavour physical port 3 splittable false

  $ devlink port show can2
  pci/0000:07:00.0/2: type eth netdev can2 flavour physical port 2 splittable false

  $ devlink dev info
  pci/0000:07:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 1.3.75
  pci/0000:08:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 2.4.29
  pci/0000:09:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 1.3.72

  $  sudo ethtool -i can2
  driver: kvaser_pciefd
  version: 6.8.0-40-generic
  firmware-version: 1.3.75
  expansion-rom-version:
  bus-info: 0000:07:00.0
  supports-statistics: no
  supports-test: no
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: no

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v4:
  - Add tag Reviewed-by Vincent Mailhol

Changes in v2:
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]
  - Replace netdev.dev_id with netdev.dev_port, to reflect changes in
    previous patch.

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5

 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h |  4 +++
 .../can/kvaser_pciefd/kvaser_pciefd_core.c    |  8 ++++++
 .../can/kvaser_pciefd/kvaser_pciefd_devlink.c | 25 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
index 34ba393d6093..08c9ddc1ee85 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
@@ -59,6 +59,7 @@ struct kvaser_pciefd_fw_version {
 
 struct kvaser_pciefd_can {
 	struct can_priv can;
+	struct devlink_port devlink_port;
 	struct kvaser_pciefd *kv_pcie;
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
@@ -89,4 +90,7 @@ struct kvaser_pciefd {
 };
 
 extern const struct devlink_ops kvaser_pciefd_devlink_ops;
+
+int kvaser_pciefd_devlink_port_register(struct kvaser_pciefd_can *can);
+void kvaser_pciefd_devlink_port_unregister(struct kvaser_pciefd_can *can);
 #endif /* _KVASER_PCIEFD_H */
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index 60c72ab0a5d8..86584ce7bbfa 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -943,6 +943,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		struct net_device *netdev;
 		struct kvaser_pciefd_can *can;
 		u32 status, tx_nr_packets_max;
+		int ret;
 
 		netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
 				      roundup_pow_of_two(KVASER_PCIEFD_CAN_TX_MAX_COUNT));
@@ -1013,6 +1014,11 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 
 		pcie->can[i] = can;
 		kvaser_pciefd_pwm_start(can);
+		ret = kvaser_pciefd_devlink_port_register(can);
+		if (ret) {
+			dev_err(&pcie->pci->dev, "Failed to register devlink port\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1732,6 +1738,7 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 		if (can) {
 			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 			kvaser_pciefd_pwm_stop(can);
+			kvaser_pciefd_devlink_port_unregister(can);
 			free_candev(can->can.dev);
 		}
 	}
@@ -1874,6 +1881,7 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 		unregister_candev(can->can.dev);
 		timer_delete(&can->bec_poll_timer);
 		kvaser_pciefd_pwm_stop(can);
+		kvaser_pciefd_devlink_port_unregister(can);
 	}
 
 	kvaser_pciefd_disable_irq_srcs(pcie);
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
index 1fbb40dbbb7a..1d61a8b0eeba 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
@@ -5,6 +5,7 @@
  */
 #include "kvaser_pciefd.h"
 
+#include <linux/netdevice.h>
 #include <net/devlink.h>
 
 static int kvaser_pciefd_devlink_info_get(struct devlink *devlink,
@@ -33,3 +34,27 @@ static int kvaser_pciefd_devlink_info_get(struct devlink *devlink,
 const struct devlink_ops kvaser_pciefd_devlink_ops = {
 	.info_get = kvaser_pciefd_devlink_info_get,
 };
+
+int kvaser_pciefd_devlink_port_register(struct kvaser_pciefd_can *can)
+{
+	int ret;
+	struct devlink_port_attrs attrs = {
+		.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL,
+		.phys.port_number = can->can.dev->dev_port,
+	};
+	devlink_port_attrs_set(&can->devlink_port, &attrs);
+
+	ret = devlink_port_register(priv_to_devlink(can->kv_pcie),
+				    &can->devlink_port, can->can.dev->dev_port);
+	if (ret)
+		return ret;
+
+	SET_NETDEV_DEVLINK_PORT(can->can.dev, &can->devlink_port);
+
+	return 0;
+}
+
+void kvaser_pciefd_devlink_port_unregister(struct kvaser_pciefd_can *can)
+{
+	devlink_port_unregister(&can->devlink_port);
+}
-- 
2.49.0


