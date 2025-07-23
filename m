Return-Path: <linux-can+bounces-4035-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97176B0ED47
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568761C82DF6
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4282278E5A;
	Wed, 23 Jul 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="apd5UVrs"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E825A631
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259590; cv=fail; b=ji7kyx0Z0rKuqwcmPEh5ZM2O+AsFSQIDXtpsmRyFRPwCCXvO7t2X1pmVXLJgmjfFFvU0PrIKm5+KRH3mZjBAAbLlGrlVwEnQzXXlA8Ec2P4R5CxpKirFA2FE4S/bsG32SnOfgwM4ZpJkF9TPK3vrU/cOLiGw3/2cCRev+Gcl4/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259590; c=relaxed/simple;
	bh=fkzZOXB2JI4mXy9R44PJLke2khzE1N9+JVNO8fSqmAw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lzaCb4rqE2PtY2CPpwkw7zDJPW7e/2zfyU8ZabUH7L9xRVETBb0qKDmm8/9wedn25K3FgKQcOQkodxsnhssVU6ML6FQu5OBuOYINmUpveGlvJmidH8xI67pZIYBWH1YKsvv22ijC2PTbVnsaXLAht6ihD+/b/07ssxr1UXs1qCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=apd5UVrs; arc=fail smtp.client-ip=40.107.20.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjJt+ZTgA7YshHt/MFm3aj5o61UU5XteNBAhvykPMueQzwCher2RTLg7E5AaWY4gHgvUTgQmOFFm8NkthPA0MRUZQ+vxtZx8wlJH7ezio5zurJa39S/DKO7T7jUPXh49X1Y1BEBzqzO7tBJq/2LrZ7O8tuQWCyA/x77S7HUux3IG7lj41DT9fyBziIiuTD3qxq3a+mU3rzn4hVdbSqhub+f9qJNHrBH/Z3m54wh11dSW7A13vf8gJF2FpAtB5VkuYoEvvaeYpG8k3BW5qYPRa9HoS+fx/MpCdtptuBCdZYYIgMQva5HTrhTx8XVakoQeSejYV5HXcZ/NElfmVFcVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHrCmX/mXGw+9vFO6l9GDRb2DMVcoC/sfwp9pj8XI20=;
 b=halYLNcRC8Q2+asc9L0D2nQKcDXMJi891ZuGJHeV1tl0BUdVyirp0r6m8bWBFVX464Yf8E7RY5GpYRuAXCCTdcC2ADXOr+4Vf7dEw1Y1HsbyGvYqRFh0KhzldopFZzR++z+lbc77aUT1CsSAcdzfyenrRkAf2a18V1aw3/7AnznZc8ZUeqI7sHYR70TyzFD24qj8/CDGIaW7v749uQmh6lwq98pPJJVNxbQJyEBR7FzPVJ00dWQdTauhs4XOpGue9jFgeeRb/ye5Xr7cJRhCRzC3YMb+Y43N8O2g1npgUwZT03L/7LIaysOlx3darXfxO4WMUFdoBAqxP9Vp6is1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHrCmX/mXGw+9vFO6l9GDRb2DMVcoC/sfwp9pj8XI20=;
 b=apd5UVrs/GfH4KVEQ59CqROVYdIrbDHOjE2hPo0AHdheAIIzZO4gFL8JbVBR3u0r+dFNoQVLSZNyeGBrRQNyvbxMEYuAgubjWI6tpoUGQchx184SaLEQj7UjdWM2xSELR9c5uJayStF7p3/B28yM0gOP0IlPGa1HGJaaf2NyGw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0773.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:33:05 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:33:04 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 0/9] can: kvaser_pciefd: Simplify identification of physical CAN interfaces
Date: Wed, 23 Jul 2025 10:32:27 +0200
Message-ID: <20250723083236.9-1-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::15) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0773:EE_
X-MS-Office365-Filtering-Correlation-Id: c457a64f-2397-49c1-f0b4-08ddc9c38b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NJFbCPwwpqGtWHiFm6/Ownb1CCvztFFhKFiDp9vC28UVXKxXMerItoMCKYaH?=
 =?us-ascii?Q?ml8MIUrYZseNdg1VOMhQm2abPQh2fYlFdJPaTsLv2LclqGAMs45fNKWVaga0?=
 =?us-ascii?Q?4xOHjbWSBHZ787fTMT+kqdbfrJkybZUtpxg0qV2+53wnvK6/laf2arDLewav?=
 =?us-ascii?Q?MZOP8nlVe5ZmQ9our/95O/gDTykq6xMQ0MqTHOwtRVpkMVMTzFFgrbkdD07T?=
 =?us-ascii?Q?TFS6a/Yh1IQp1PLmIDOGtqOuzzdLTSx0RhMzoZgSjeMA62lyK0E7pNI7GfvW?=
 =?us-ascii?Q?DyVm+guSncEwAAl8FWB7scpUf/cyWEApyA3XdZhvrtpxscHW8MW6I7m16tRz?=
 =?us-ascii?Q?UDj4dgfx1i383SuTi0TpNZkuKAm0dNmY96RjwghbNSm846dT/DdctJCCzpwg?=
 =?us-ascii?Q?uy3LnTlIEOl2krsf8tXFFrt0XZnpmWRJLjASp8FNFiyTGNH376Wc+WgwmtKy?=
 =?us-ascii?Q?uhA3ZE7UVuMhnqVpKTBeGkHEn/HLaZNughoBOg+DTdPom6XXBWrBaY3jPKYq?=
 =?us-ascii?Q?u2ruE+wb/uj0EZIJb0sKRbgd4gPkKtSrhF921wG9UDNJ1oHjh10Q9K1llC1l?=
 =?us-ascii?Q?WtPollg2FYrQZyYC5fNUrWxvKbnZAEEoO0YvYnjwiFd9jigzE/XB5nuKIGtu?=
 =?us-ascii?Q?8KigWhN7u+L6VWLmt9neV12IMFStPlOnwtnvuQ4G8W/7CeuGMw0FbVCjof7l?=
 =?us-ascii?Q?vxw/yqk48RLF1NkCFvBo9XYBt8Z63cQDgSq0ypkFyhHvoY1vy+hdL8miArm3?=
 =?us-ascii?Q?tkRgHKTtfOQrszw2Fih9tnh9MYCqQ2gbMxl2PCoAZehFJoDCWAHAtAKrJf1n?=
 =?us-ascii?Q?WfJdWmJSa/4F85OYe+aEDGKjGhf+TIlVfhBr3AGgAirFj5QJFoJT18F3rTbZ?=
 =?us-ascii?Q?6Jew5owXoQSxsXj069ROb4vfDihdrzMEgxDKGFr+Np5dYbAQOGsm6FRQdfc8?=
 =?us-ascii?Q?AsZuRsCPJVlSXYRmnWPkl6SPTeNS7WOGFFp5s6w7p/l+z1Z8F6y0nMQH6Lx/?=
 =?us-ascii?Q?c6t1LY6yi+0jO80WXvZCVMU/UBX/6ScR9qGXJkuAfSfN6EpXhLreajEPTtf/?=
 =?us-ascii?Q?2zxDm3XaF+3EJa2cput1Dj6Luy5ts4XuzKLwotIdixCEkoSN0sX10zpKIbS1?=
 =?us-ascii?Q?AgNiV8ZkDoC0R9k+tPEaN66ZVd+AFP5MeAt5JsU7R7wjy3b3ACL0HN4NC2vo?=
 =?us-ascii?Q?ECpKU0bXrRV95PeP4Jr8gZh7FwTgQWOb6QcaIZ6c4kiCRaceYQdHY016voma?=
 =?us-ascii?Q?A/fUPbfBZbGEo87njDxa+3sq6G57r18NecwHl1ZcNTB6CON5e0UIfBGrF4vw?=
 =?us-ascii?Q?UCc3e2BsB8kX5Yb/iHTbobVnMFVM5JV/tV0j8kawK/Jw35lJVEr6JG2t205M?=
 =?us-ascii?Q?thy9N3gK3eMlnFrwsFAmNox0sG2+e2U4z0TYT6/yaF92jGyC1OPeVhf1SuNT?=
 =?us-ascii?Q?IZJNm83sChg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vXIogAFZqFFi/55n5KIpFOys3TSPpO4UKX5A0lDJ2C/CJo4pMbKNKLt0AMWc?=
 =?us-ascii?Q?D5yBl2HuGdJyGzGpWuu0n8I/D9sU3hNMNHkV4LexZsTf77gVyXQDT/2K+zz3?=
 =?us-ascii?Q?LNEGpG4Irqk2bqz5X1yEb5rMHJGm2k1cnmME7IOeo4mMtlCRBWBFqB9uXsfN?=
 =?us-ascii?Q?71Y3aMRkQgyjOI7ksM8ubgSyrDkAWaygDvwU/d7Lf2hgd5xuP9E6JB8f3Z3r?=
 =?us-ascii?Q?LjmBsIv/d1u2UydfTnPYrUlisrB+xzYXXNYWbxtIMYkANHdi/N1gFxmIRt9b?=
 =?us-ascii?Q?6lk0IsyUYToCFXR9oJ3NQ9CtBWjYFmwp4dXqawpLTLZdYql7pYMEQr9XCgU9?=
 =?us-ascii?Q?/PUxY/dLHmTDlLNRRvh9gNcngk7JgwI/8KxGSrvBkDaJ4O5+8P5AyOjuMYBd?=
 =?us-ascii?Q?EjDBUIL1QFTLQ60IwWbYIJSqchJDiJUZ2AiIbIadpsG/mkJ6uTxA5HZrxGNM?=
 =?us-ascii?Q?7js4IYA9knXnj4NY/q+e3NfB7yYFRMbZORsQCofSop25vqjxkQy+JReKf4jg?=
 =?us-ascii?Q?0kiM7aauZDrTmeMFaFbyevlkdgyJWOuLZ7+Ik7p1DFHfhIZXYR5NbF5pe+iC?=
 =?us-ascii?Q?FwBgjZsFGoXAJEJQcLSeBsR2HCDxrwqwJ8zysKc2/YJ24ym+JeUw8QSWqVqO?=
 =?us-ascii?Q?8rYR6f2QoFzFcjIfLaNMFNePL3YyovK+ozElcd4tzj4uFzjvUbd29RlAk5bk?=
 =?us-ascii?Q?kZE2+uAz4NmkpoYYxp0ti3+bWpT71Oi5XoBIPnBLT1VgsNBsn2Cqh2IwQIBw?=
 =?us-ascii?Q?fYi862TrTxrwbM0NQ6Vx7YSoMyTAdUw0Mc2XtrLYCmjeXlbk8uduGe86Csjc?=
 =?us-ascii?Q?Uh/KvC+vMWCERj3mbusllTO9nIgQCkG0JjhyhZWZnnBK+P+sM7Yuwy6wwsvF?=
 =?us-ascii?Q?9Ip52rBBpFAXFyzqkUhZRLnfqxSv74xr6YqxkZEsqzdwtjD+iJc58g98abKf?=
 =?us-ascii?Q?6IMqCx0wZSVRXMLxhJYW+DzRcDjs5pCqW87HEd/SmHpEsIcJgyE7dzZGZTII?=
 =?us-ascii?Q?DNX04U3nDoxE9lNmlK2sBWQltDJuANn8/XBCV/2VUoOLEnK/Yv6ncTUNE2oS?=
 =?us-ascii?Q?PyRdj33QYdK4Qetd7GU1useIYg/k5y312U8OY7TOyBuYChB5h64FlYxEn/uH?=
 =?us-ascii?Q?Lq3DwbJdjZDD035X+vPtLj9ZYaAzuBo92K2hPZGd4UaQql3v7z7XeytIDu0K?=
 =?us-ascii?Q?LM/0ItnaM4/wbBzzmrp991+R+u3J6uS/ETvLiM3oicfYSWLlSto8yhXqXDSR?=
 =?us-ascii?Q?YerGbnRDvRK2zhu+rteeNiZQ3IxK37Ih1MKT8A+QFnPIV3UiTAexcJCCwVQo?=
 =?us-ascii?Q?iHBopgAfR/LzCRY4G+gj7dKIu/PdvKpupmwAL/vQ+939bSgWzVn5YsYMBVdY?=
 =?us-ascii?Q?9yNzO8E2DyuewIbAKWA5Akk40xcuwMKvCLuNQcrM+teVminmpjeWb6ZYXScZ?=
 =?us-ascii?Q?maV4cPCu4LhDjSKWWlVkHRFVH9D9Cf5VoiST1IQhjMa8XoC8XGNuwpm0DyMS?=
 =?us-ascii?Q?mehCD80iTHVlmoI/jcjgGgum4tE5Lxu+HVu3Mu0LrRES64va/2xmSVVZzjp0?=
 =?us-ascii?Q?b943z3DUm1egyYVitfzc+vjcn5KhPm4Z27WdiVPyRxi90LLUMipFy38QIqaB?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c457a64f-2397-49c1-f0b4-08ddc9c38b21
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:33:04.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THl3KF4lhZJio5II90dCL+brdPmzRn4ftK5RRqqwGjlD5nD7czGt4Mfuo7UHL/IIsp1YwPRYwrP8WzUTf1SIQHDgjV46Pg2XyJ0+VZSvhAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0773

This patch series simplifies the process of identifying which network
interface (can0..canX) corresponds to which physical CAN channel on
Kvaser PCIe based CAN interfaces.

Jimmy Assarsson (9):
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

 drivers/net/can/Kconfig                       |   1 +
 drivers/net/can/Makefile                      |   2 +-
 drivers/net/can/kvaser_pciefd/Makefile        |   3 +
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h |  96 +++++++++++
 .../kvaser_pciefd_core.c}                     | 150 +++++++++---------
 .../can/kvaser_pciefd/kvaser_pciefd_devlink.c |  61 +++++++
 6 files changed, 239 insertions(+), 74 deletions(-)
 create mode 100644 drivers/net/can/kvaser_pciefd/Makefile
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
 rename drivers/net/can/{kvaser_pciefd.c => kvaser_pciefd/kvaser_pciefd_core.c} (96%)
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c

-- 
2.49.0


